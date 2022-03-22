//
//  DatabaseManager.swift
//  MessengerApp
//
//  Created by Антон Головатый on 27.02.2022.
//

import Foundation
import FirebaseDatabase
import MessageKit
import CoreLocation

/// Manager object to read and write data to real time Firebase database
final class DatabaseManager {
    
    /// Shared instance of Singleton class
    public static let shared = DatabaseManager()
    private let database = Database.database().reference()
    private init() {}
    
    /// Helper to convert email for using in Firebase database
    static func safeEmail(emailAddress: String) -> String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
    
    public enum DatabaseError: Error {
        case failedToFetch
    }

    /// Returns dictionary node at child path
    public func getDataFor(path: String, completion: @escaping (Result<Any, Error>) -> Void) {
        database.child("\(path)").observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value else {
                completion(.failure(DatabaseError.failedToFetch))
                return
            }
            completion(.success(value))
        }
    }
}

//MARK: - Account Management
extension DatabaseManager {
    /// Check if user exists for given email
    /// Parameters
    ///  - `email`:               Target email to be checked
    ///  - `completion`:    Async closure to return
    public func userExists(with email: String,
                           completion: @escaping ((Bool) -> Void)) {
        
        let safeEmail = DatabaseManager.safeEmail(emailAddress: email)
        
        database.child(safeEmail).observeSingleEvent(of: .value) { snapShot in
            guard snapShot.value as? [String: Any] != nil else {
                completion(false)
                return
            }
            
            completion(true)
        }
    }
    
    /// Inserts new user to database
    /// Parameters
    ///  - `user`:                 Target user to be added
    ///  - `completion`:    Async closure to return
    public func insertUser(with user: ChatAppUser, completion: @escaping (Bool) -> Void) {
        database.child(user.safeEmail).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
        ]) { [weak self] error, _ in
            guard let strongSelf = self else { return }
            guard error == nil else {
                print("Failed to write to database")
                completion(false)
                return
            }

            strongSelf.database.child("users").observeSingleEvent(of: .value) { snapshot in
                let newElement = [
                    "name": user.firstName + " " + user.lastName,
                    "email": user.safeEmail
                ]
                var modifiedCollection = [[String: String]]()
                
                if let usersCollection = snapshot.value as? [[String: String]] {
                    modifiedCollection = usersCollection
                    modifiedCollection.append(newElement)
                }
                else {
                    modifiedCollection = [
                        [
                            "name": user.firstName + " " + user.lastName,
                            "email": user.safeEmail
                        ]
                    ]
                }
                strongSelf.database.child("users").setValue(modifiedCollection) { error, _ in
                    guard error == nil else {
                        completion(false)
                        return
                    }
                    completion(true)
                }
            }
        }
    }
    
    /// Gets all users from database
    public func getAllUsers(completion: @escaping (Result<[[String: String]], Error>) -> Void) {
        database.child("users").observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [[String: String]] else {
                completion(.failure(DatabaseError.failedToFetch))
                return
            }
            completion(.success(value))
        }
    }
}

//MARK: - Conversations Management
extension DatabaseManager {
    /// Creates a new conversation with target user email and first message sent
    /// Parameters
    ///  - `otherUserEmail`:     Target user email of new conversation
    ///  - `recepientName`:       Name of the recepient
    ///  - `firstMessage`:         First message of a new conversaton
    ///  - `completion`:              Async closure to return
    public func createNewConversation(with otherUserEmail: String,
                                      recepientName: String,
                                      firstMessage: Message,
                                      completion: @escaping (Bool) -> Void) {
        guard let currentEmail = UserDefaults.standard.value(forKey: "email") as? String,
              let userName = UserDefaults.standard.value(forKey: "name") as? String else { return }
        let safeEmail = DatabaseManager.safeEmail(emailAddress: currentEmail)
        let reference = database.child(safeEmail)
        
        reference.observeSingleEvent(of: .value) { [weak self] snapshot in
            guard var userNode = snapshot.value as? [String: Any] else {
                completion(false)
                print("User not found")
                return
            }
            let messageDate = firstMessage.sentDate
            let dateString = ChatViewController.dateFormatter.string(from: messageDate)
            let conversationId = "conversation_\(firstMessage.messageId)"
            var message = ""
            
            switch firstMessage.kind {
                
            case .text(let messageText):
                message = messageText
            default:
                break
            }
            
            let newConversationData: [String: Any] = [
                "id": conversationId,
                "other_user_email": otherUserEmail,
                "name": recepientName,
                "latest_message": [
                    "date": dateString,
                    "message": message,
                    "is_read": false
                ]
            ]
            
            let recepient_newConversationData: [String: Any] = [
                "id": conversationId,
                "other_user_email": safeEmail,
                "name": userName ,
                "latest_message": [
                    "date": dateString,
                    "message": message,
                    "is_read": false
                ]
            ]
            
            // Update recepient conversation entry
            self?.database.child("\(otherUserEmail)/conversations").observeSingleEvent(of: .value) { [weak self] snapshot in
                if var conversations = snapshot.value as? [[String: Any]] {
                    conversations.append(recepient_newConversationData)
                    self?.database.child("\(otherUserEmail)/conversations").setValue(conversations)
                }
                else {
                    self?.database.child("\(otherUserEmail)/conversations").setValue([recepient_newConversationData])
                }
            }
            
            // Update current user conversation entry
            if var conversations = userNode["conversations"] as? [[String: Any]] {
                conversations.append(newConversationData)
                userNode["conversations"] = conversations
            }
            else {
                userNode["conversations"] = [newConversationData]
            }
            
            reference.setValue(userNode) { [weak self] error, _ in
                guard error == nil else {
                    completion(false)
                    return
                }
                self?.finishCreatingConversation(name: recepientName,
                                                 conversationID: conversationId,
                                                 firstMessage: firstMessage,
                                                 completion: completion)
            }
        }
    }
    
    /// Check if conversaton exists for given email
    /// Parameters
    ///  - `targetRecepientEmail`:      Target email to be checked
    ///  - `completion`:                            Async closure to return result with conversationId if conversation exists
    public func conversationExists(with targetRecepientEmail: String,
                                    completion: @escaping (Result<String, Error>) -> Void) {
        guard let senderEmail = UserDefaults.standard.value(forKey: "email") as? String else { return  }
        let safeRecepientEmail = DatabaseManager.safeEmail(emailAddress: targetRecepientEmail)
        let safeSenderEmail = DatabaseManager.safeEmail(emailAddress: senderEmail)
        
        database.child("\(safeRecepientEmail)/conversations").observeSingleEvent(of: .value) { snapshot in
            guard let collection = snapshot.value as? [[String: Any]] else {
                completion(.failure(DatabaseError.failedToFetch))
                return
            }
            
            if let conversation = collection.first(where: {
                guard let targetSenderEmail = $0["other_user_email"] as? String else { return false }
                return safeSenderEmail == targetSenderEmail
            }) {
                guard let id = conversation["id"] as? String else {
                    completion(.failure(DatabaseError.failedToFetch))
                    return
                }
                completion(.success(id))
                return
            }
            completion(.failure(DatabaseError.failedToFetch))
            return
        }
    }
    
    /// Fetches and returns all conversations for the user with passed in email
    /// Parameters
    ///  - `email`:               Target user email
    ///  - `completion`:    Async closure to return result with conversations
    public func getAllConversations(for email: String,
                                    completion: @escaping (Result<[Conversation], Error>) -> Void) {
        database.child("\(email)/conversations").observe(.value) { snapshot in
            guard let value = snapshot.value as? [[String: Any]] else {
                completion(.failure(DatabaseError.failedToFetch))
                return
            }
            
            let conversations: [Conversation] = value.compactMap { dictionary in
                guard let conversationId = dictionary["id"] as? String,
                      let name = dictionary["name"] as? String,
                      let otherUserEmail = dictionary["other_user_email"] as? String,
                      let latestMessage = dictionary["latest_message"] as? [String: Any],
                      let date = latestMessage["date"] as? String,
                      let message = latestMessage["message"] as? String,
                      let isRead = latestMessage["is_read"] as? Bool else {
                          return nil
                      }
                
                let latestMessageObject = LatestMessage(date: date,
                                                        text: message,
                                                        isRead: isRead)
                return Conversation(id: conversationId,
                                    name: name,
                                    otherUserEmail: otherUserEmail,
                                    latestMessage: latestMessageObject)
            }
            
            completion(.success(conversations))
        }
    }
    
    /// Gets all messages for a given conversation
    /// Parameters
    ///  - `id`:                     Target conversation ID
    ///  - `completion`:    Async closure to return result with messages
    public func getAllMessagesForConversation(with id: String,
                                              completion: @escaping (Result<[Message], Error>) -> Void) {
        database.child("\(id)/messages").observe(.value) { snapshot in
            guard let value = snapshot.value as? [[String: Any]] else {
                completion(.failure(DatabaseError.failedToFetch))
                return
            }
            
            let messages: [Message] = value.compactMap { dictionary in
                guard let name = dictionary["name"] as? String,
                      let isRead = dictionary["is_read"] as? Bool,
                      let messageId = dictionary["id"] as? String,
                      let content = dictionary["content"] as? String,
                      let senderEmail = dictionary["sender_email"] as? String,
                      let dateString = dictionary["date"] as? String,
                      let type = dictionary["type"] as? String,
                      let date = ChatViewController.dateFormatter.date(from: dateString) else {
                          return nil
                      }
                
                var kind: MessageKind?
                
                if type == "photo" {
                    guard let imageUrl = URL(string: content),
                          let placeholder = UIImage(systemName: "plus") else { return nil }
                    let media = Media (url: imageUrl,
                                       image: nil,
                                       placeholderImage: placeholder,
                                       size: CGSize(width: 300, height: 300))
                    kind = .photo(media)
                }
                else if type == "video" {
                    guard let videoUrl = URL(string: content),
                          let placeholder = UIImage(named: "video_placeholder") else { return nil }
                    let media = Media (url: videoUrl,
                                       image: nil,
                                       placeholderImage: placeholder,
                                       size: CGSize(width: 300, height: 300))
                    kind = .video(media)
                }
                else if type == "location" {
                    let locationComponents = content.components(separatedBy: ",")
                    guard let longitude = Double(locationComponents[0]),
                          let latitude = Double(locationComponents[1]) else { return nil}
                    
                    let location = Location(location: CLLocation(latitude: latitude, longitude: longitude),
                                            size: CGSize(width: 300, height: 300))
                    kind = .location(location)
                }
                else {
                    kind = .text(content)
                }
                
                guard let finalKind = kind else { return nil }
                
                let sender = Sender(photoURL: "",
                                    senderId: senderEmail,
                                    displayName: name)
                
                return Message(sender: sender,
                               messageId: messageId,
                               sentDate: date,
                               kind: finalKind)
            }
            
            completion(.success(messages))
        }
    }
    
    /// Deletes a given conversation
    /// Parameters
    ///  - `conversationId`:   Target conversation ID
    ///  - `completion`:            Async closure to return
    public func deleteConversation(conversationId: String, completion: @escaping (Bool) -> Void) {
        guard let currentUserEmail = UserDefaults.standard.value(forKey: "email") as? String else { return }
        let safeEmail = DatabaseManager.safeEmail(emailAddress: currentUserEmail)
        
        print("Deleting conversation with id: \(conversationId)")
        
        let reference = database.child("\(safeEmail)/conversations")
        reference.observeSingleEvent(of: .value) { [weak self] snapshot in
            if var conversations = snapshot.value as? [[String: Any]] {
                guard let strongSelf = self else { return }
                var positionToRemove = 0
                positionToRemove = strongSelf.getConversationAndIndex(for: conversationId, in: conversations).1
                
                conversations.remove(at: positionToRemove)
                
                reference.setValue(conversations) { error, _ in
                    guard error == nil else {
                        completion(false)
                        print("Failed to write new conversation array")
                        return
                    }
                    print("Deleted conversation: \(conversationId)")
                    completion(true)
                }
            }
        }
    }
}

//MARK: - Sending Messages
extension DatabaseManager {
    /// Sends a message with target conversation and message
    /// Parameters
    ///  - `conversation`:        Target conversation ID
    ///  - `otherUserEmail`:    Recepient email
    ///  - `name`:                          Recepient name
    ///  - `newMessage`:             New message to be sent
    ///  - `completion`:             Async closure to return
    public func sendMessage(to conversation: String,
                            otherUserEmail: String,
                            name: String,
                            newMessage: Message,
                            completion: @escaping (Bool) -> Void) {
        guard let myEmail = UserDefaults.standard.value(forKey: "email") as? String else {
            completion(false)
            return
        }
        
        database.child("\(conversation)/messages").observeSingleEvent(of: .value) { [weak self] snapshot in
            guard let strongSelf = self else { return }
            guard var currentMessages = snapshot.value as? [[String: Any]]
            else {
                completion(false)
                return
            }
            
            let messageDate = newMessage.sentDate
            let dateString = ChatViewController.dateFormatter.string(from: messageDate)
            let userSafeEmail = DatabaseManager.safeEmail(emailAddress: myEmail)
            let recepientSafeEmail = DatabaseManager.safeEmail(emailAddress: otherUserEmail)
            let message = strongSelf.getMessageContent(from: newMessage)
            
            let newMessageEntry: [String: Any] = [
                "id": newMessage.messageId,
                "type": newMessage.kind.messageKindString,
                "content": message,
                "date": dateString,
                "sender_email": userSafeEmail,
                "is_read": false,
                "name": name
            ]
            
            currentMessages.append(newMessageEntry)
            
            strongSelf.database.child("\(conversation)/messages").setValue(currentMessages) { error, _ in
                guard error == nil else {
                    completion(false)
                    return
                }
                
                //update conversation database for sender
                strongSelf.updateConversationInDatabase(conversation,
                                                        withMessage: message,
                                                        dateString: dateString,
                                                        senderName: name,
                                                        userSafeEmail: userSafeEmail,
                                                        recepientSafeEmail: recepientSafeEmail,
                                                        completion: completion) {
                    
                    guard let currentName = UserDefaults.standard.value(forKey: "name") as? String else { return }
                    //update conversation database for recepient
                    strongSelf.updateConversationInDatabase(conversation,
                                                            withMessage: message,
                                                            dateString: dateString,
                                                            senderName: currentName,
                                                            userSafeEmail: recepientSafeEmail,
                                                            recepientSafeEmail: userSafeEmail,
                                                            completion: completion) {
                        completion(true)
                    }
                }
            }
        }
    }
}

//MARK: - Private methods
extension DatabaseManager {
    /// Saves new conversation to database after creation
    /// Parameters
    ///  - `name`:                           Recepient name
    ///  - `conversationID`:     Conversation ID
    ///  - `firstMessage`:         First message of a new conversation
    ///  - `completion`:              Async closure to return
    private func finishCreatingConversation(name: String,
                                            conversationID: String,
                                            firstMessage: Message,
                                            completion: @escaping (Bool) -> Void) {
        guard let currentUserEmail = UserDefaults.standard.value(forKey: "email") as? String else {
            completion(false)
            return
        }
        let safeEmail = DatabaseManager.safeEmail(emailAddress: currentUserEmail)
        let messageDate = firstMessage.sentDate
        let dateString = ChatViewController.dateFormatter.string(from: messageDate)
        
        var message = ""
        
        switch firstMessage.kind {
        case .text(let messageText):
            message = messageText
        default:
            break
        }
        
        let collectionMessage: [String: Any] = [
            "id": firstMessage.messageId,
            "type": firstMessage.kind.messageKindString,
            "content": message,
            "date": dateString,
            "sender_email": safeEmail,
            "is_read": false,
            "name": name
        ]
        
        let value: [String: Any] = [
            "messages": [
                collectionMessage
            ]
        ]
        
        database.child(conversationID).setValue(value) { error, _ in
            guard error == nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    /// Updates conversation in the database after message was sent
    /// Parameters
    ///  - `conversation`:                      Target conversation ID
    ///  - `withMessage`:                         Last message of the conversation
    ///  - `dateString`:                           Date of the last message
    ///  - `senderName`:                           Sender name
    ///  - `userSafeEmail`:                    User safe email
    ///  - `recepientSafeEmail`:         Recepient safe email
    ///  - `completion`:                           Async closure to return
    ///  - `handler`:                                  Async handler to use after all is done
    private func updateConversationInDatabase(_ conversation: String,
                                              withMessage message: String,
                                              dateString: String,
                                              senderName: String,
                                              userSafeEmail: String,
                                              recepientSafeEmail: String,
                                              completion: @escaping (Bool) -> Void,
                                              handler: @escaping () -> Void) {
        database.child("\(userSafeEmail)/conversations").observeSingleEvent(of: .value) { [weak self] snapshot in
            guard let strongSelf = self else { return }
            let updatedValue: [String: Any] = [
                "date": dateString,
                "message": message,
                "is_read": false
            ]
            let newConversationData: [String: Any] = [
                "id": conversation,
                "other_user_email": recepientSafeEmail,
                "name": senderName,
                "latest_message": updatedValue
            ]
            var databaseEntryConverstion = [[String: Any]]()

            if var currentUserConversations = snapshot.value as? [[String: Any]] {
                var targetConversation: [String: Any]?
                var position = 0
                (targetConversation, position) = strongSelf.getConversationAndIndex(for: conversation,
                                                                                    in: currentUserConversations)
                if var targetConversation = targetConversation {
                    targetConversation["latest_message"] = updatedValue
                    currentUserConversations[position] = targetConversation
                }
                else {
                    currentUserConversations.append(newConversationData)
                }
                databaseEntryConverstion = currentUserConversations
            }
            else {
                databaseEntryConverstion = [newConversationData]
            }

            strongSelf.database.child("\(userSafeEmail)/conversations").setValue(databaseEntryConverstion) { error, _ in
                guard error == nil else {
                    completion(false)
                    return
                }
                handler()
            }
        }
    }
    
    /// Returns target conversation and its index
    /// Parameters
    ///  - `conversation`:     Target conversation ID
    ///  - `conversations`:   Array of conversations
    private func getConversationAndIndex(for conversation: String,
                                         in conversations: [[String: Any]]) -> ([String: Any]?, Int) {
        var targetConversation: [String: Any]?
        var position = 0
        
        for conversationDictionary in conversations {
            if let currentId = conversationDictionary["id"] as? String,
               currentId == conversation {
                targetConversation = conversationDictionary
                break
            }
            position += 1
        }
        
        return (targetConversation, position)
    }
    
    /// Returns messages content as a String
    /// Parameters
    ///  - `message`:   Target message
    private func getMessageContent(from message: Message) -> String {
        var messageContent = ""
        
        switch message.kind {
        case .text(let messageText):
            messageContent = messageText
        case .photo(let media):
            if let targetUrlString = media.url?.absoluteString {
                messageContent = targetUrlString
            }
        case .video(let media):
            if let targetUrlString = media.url?.absoluteString {
                messageContent = targetUrlString
            }
        case .location(let locationData):
            let location = locationData.location
            messageContent = "\(location.coordinate.longitude),\(location.coordinate.latitude)"
        default:
            break
        }
        
        return messageContent
    }
}
