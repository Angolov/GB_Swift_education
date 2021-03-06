//
//  ProfileViewController.swift
//  MessengerApp
//
//  Created by Антон Головатый on 25.02.2022.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import SDWebImage

//MARK: - ProfileViewController class declaration
/// Controller that shows user's profile
final class ProfileViewController: UIViewController {
    
    //MARK: - UI elements
    @IBOutlet var tableView: UITableView!
    
    //MARK: - Properties
    var data = [ProfileViewModel]()

    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViewData()
        setupTableView()
    }
    
    //MARK: - Private methods
    private func setupTableViewData() {
        let name = UserDefaults.standard.value(forKey: "name") as? String ?? "No Name"
        let email = UserDefaults.standard.value(forKey: "email") as? String ?? "No Email"
        data.append(ProfileViewModel(viewModelType: .info,
                                     title: "Name: \(name)",
                                     handler: nil))
        data.append(ProfileViewModel(viewModelType: .info,
                                     title: "Email: \(email)",
                                     handler: nil))
        data.append(ProfileViewModel(viewModelType: .logout,
                                     title: "Log Out",
                                     handler: { [weak self] in
            guard let strongSelf = self else { return }
            
            let actionSheet = UIAlertController(title: "",
                                          message: "",
                                          preferredStyle: .actionSheet)
            actionSheet.addAction(UIAlertAction(title: "Log Out",
                                          style: .destructive,
                                          handler: { _ in strongSelf.logOutHandler() }))
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            strongSelf.present(actionSheet, animated: true, completion: nil)
        }))
    }
    
    private func logOutHandler() {
        UserDefaults.standard.set(nil, forKey: "email")
        UserDefaults.standard.set(nil, forKey: "name")
        
        GIDSignIn.sharedInstance()?.signOut()
        
        do {
            try FirebaseAuth.Auth.auth().signOut()
            
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            
            let appearence = UINavigationBarAppearance()
            appearence.backgroundColor = .secondarySystemBackground
            nav.navigationBar.compactAppearance = appearence
            nav.navigationBar.standardAppearance = appearence
            nav.navigationBar.scrollEdgeAppearance = appearence
            nav.navigationBar.compactScrollEdgeAppearance = appearence
            
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true, completion: nil)
        }
        catch {
            print("Failed to log out.")
        }
    }
    
    private func setupTableView() {
        tableView.register(ProfileTableViewCell.self,
                           forCellReuseIdentifier: ProfileTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = createTableHeader()
    }
    
    private func createTableHeader() -> UIView? {
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else { return nil }
        let safeEmail = DatabaseManager.safeEmail(emailAddress: email)
        let filename = safeEmail + "_profile_picture.png"
        
        let path = "images/" + filename
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: 300))
        headerView.backgroundColor = .link
        
        let imageView = UIImageView(frame: CGRect(x: (view.width - 150) / 2, y: 75, width: 150, height: 150))
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 3
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageView.width / 2
        
        headerView.addSubview(imageView)
        
        StorageManager.shared.downloadURL(for: path) { result in
            switch result {
            case .success(let url):
                imageView.sd_setImage(with: url, completed: nil)
            case .failure(let error):
                print("Failed to get download url: \(error)")
            }
        }
        
        return headerView
    }
}

//MARK: - ProfileViewController extension for UITableViewDelegate, UITableViewDataSource
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier,
                                                       for: indexPath) as? ProfileTableViewCell else { return UITableViewCell() }
        let viewModel = data[indexPath.row]
        cell.setup(with: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        data[indexPath.row].handler?()
    }
}
