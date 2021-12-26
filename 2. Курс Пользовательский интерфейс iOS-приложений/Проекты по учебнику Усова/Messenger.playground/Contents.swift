import Foundation

//MARK: - MessageProtocol declaration
protocol MessageProtocol {
    
    var text: String? { get set }
    var image: Data? { get set }
    var audio: Data? { get set }
    var video: Data? { get set }
    var sendDate: Date { get set }
    var senderID: UInt { get set }
     
}

//MARK: - Message struct declaration
struct Message: MessageProtocol {
    
    //MARK: - Public properties
    var text: String?
    var image: Data?
    var audio: Data?
    var video: Data?
    var sendDate: Date
    var senderID: UInt
    
}

//MARK: - MessengerProtocol declaration
protocol MessengerProtocol {
    
    var messages: [MessageProtocol] { get set }
    var statisticDelegate: StatisticDelegate? { get set }
    var dataSource: MessengerDataSourceProtocol? { get set }
    
    init()
    func receive(message: MessageProtocol)
    func send(message: MessageProtocol)
}

//MARK: - StatisticDelegate declaration
protocol StatisticDelegate: AnyObject {
    
    func handle(message: MessageProtocol)
}

//MARK: - StatisticManager class declaration
class StatisticManager: StatisticDelegate {
    
    func handle(message: MessageProtocol) {
        
        print("обработка сообщения от User # \(message.senderID) завершена")
    }
}

//MARK: - Messenger struct declaration
class Messenger: MessengerProtocol {
    
    //MARK: - Public properties
    var messages: [MessageProtocol]
    weak var statisticDelegate: StatisticDelegate?
    weak var dataSource: MessengerDataSourceProtocol? {
        didSet {
            if let source = dataSource {
                messages = source.getMessages()
            }
        }
    }
    
    //MARK: - Initializer
    required init() {
        
        messages = []
    }
    
    //MARK: - Public methods
    func receive(message: MessageProtocol) {
        statisticDelegate?.handle(message: message)
        messages.append(message)
    }
    func send(message: MessageProtocol) {
        statisticDelegate?.handle(message: message)
        messages.append(message)
    }
}

//MARK: - Messenger extension for StatisticDelegate
extension Messenger: StatisticDelegate {
    
    func handle(message: MessageProtocol) {
        
        print("обработка сообщения от User # \(message.senderID) завершена")
    }
}

//MARK: - Messenger extension for MessengerDataSourceProtocol
extension Messenger: MessengerDataSourceProtocol {
    
    func getMessages() -> [MessageProtocol] {
        return [Message(text: "Как дела?", sendDate: Date(), senderID: 2)]
    }
}

//MARK: - MessengerDataSourceProtocol declaration
protocol MessengerDataSourceProtocol: AnyObject {
    
    func getMessages() -> [MessageProtocol]
}

var messenger = Messenger()
messenger.statisticDelegate = messenger.self

messenger.dataSource = messenger.self
messenger.messages.count // 1

messenger.send(message: Message(text: "Привет!", sendDate: Date(), senderID: 1))
messenger.messages.count // 1
(messenger.statisticDelegate as! Messenger).messages.count // 1
