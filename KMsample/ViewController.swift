//
//  ViewController.swift
//  KMsample
//
//  Created by Kirti on 25/05/21.
//

import UIKit
import Kommunicate
import ApplozicSwift
import ApplozicCore

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        Kommunicate.logoutUser { (result) in
            switch result {
            case .success(_):
                print("Logout success")
                self.dismiss(animated: true, completion: nil)
            case .failure( _):
                print("Logout failure, now registering remote notifications(if not registered)")
                if !UIApplication.shared.isRegisteredForRemoteNotifications {
                    UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
                        if granted {
                            DispatchQueue.main.async {
                                UIApplication.shared.registerForRemoteNotifications()
                            }
                        }
                        DispatchQueue.main.async {
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func launchConversation(_ sender: Any) {
        Kommunicate.createAndShowConversation(from: self, completion: {
            error in
            self.view.isUserInteractionEnabled = true
            if error != nil {
                print("Error while launching")
            } else {
            }
        })
    }


}

