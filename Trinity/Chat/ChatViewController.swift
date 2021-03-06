//
//  ChatViewController.swift
//  Trinity
//
//  Created by Fiza Rasool on 18/05/20.
//  Copyright © 2020 Fiza Rasool. All rights reserved.
//

import UIKit
import Firebase


class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    let db = Firestore.firestore()
    
    var messageArray : [Message] = [Message]()
    
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        messageTableView.delegate = self
        messageTableView.dataSource = self
        
        messageTextfield.delegate = self
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        messageTableView.addGestureRecognizer(tapGesture)
        
        messageTableView.register(UINib(nibName : "MessageCell", bundle : nil) , forCellReuseIdentifier: "customMessageCell")
        
        configureTableview()
        retreiveMessages()
        
        messageTableView.separatorStyle = .none
        
    }
    
    //MARK: - TableView DataSource Methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        
        cell.messageBody.text = messageArray[indexPath.row].body
        cell.senderUsername.text = messageArray[indexPath.row].sender
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messageArray.count
    }
    
    @objc func tableViewTapped() {
        messageTextfield.endEditing(true)
    }
    
    func configureTableview() {
        messageTableView.rowHeight = UITableView.automaticDimension
        messageTableView.estimatedRowHeight = 120.0
    }
    
    
    //MARK:- TextField Delegate Methods
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        UIView.animate(withDuration: 1) {
            self.heightConstraint.constant = 308.0
            self.view.layoutIfNeeded()
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 1) {
            self.heightConstraint.constant = 50.0
            self.view.layoutIfNeeded()
        }
        
    }
    
    
    //MARK: - Send & Recieve from Firebase
    
    @IBAction func sendPressed(_ sender: AnyObject) {
        
        messageTextfield.endEditing(true)
        
        messageTextfield.isEnabled = false
        sendButton.isEnabled = false
        
        //let messagesDB = Database.database().reference().child("Messages")
        
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection("messages").addDocument(data: ["sender" : messageSender, "body" : messageBody, "dateField" : Date().timeIntervalSince1970]) { (error) in
                if let e = error {
                    print("There was an issue saving data into firestore, \(e)")
                } else {
                    print("Message saved successfully!")
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                    }
                    
                }
            }
            
        }
        
            self.messageTextfield.isEnabled = true
            self.sendButton.isEnabled = true
            self.messageTextfield.text = ""
    }
    
    func retreiveMessages() {
        
        db.collection("messages").order(by: "dateField").addSnapshotListener { (querySnapshot, error) in
            
            self.messageArray = []
            if let e = error {
                print("There was an issue retrieving messages!: \(e)")
            } else {
                if let snapshotDocumemts = querySnapshot?.documents {
                    for doc in snapshotDocumemts {
                        let data = doc.data()
                        if let msgSender = data["sender"] as? String, let messageBody = data["body"] as? String {
                            let newMessage = Message(sender: msgSender, body: messageBody)
                            self.messageArray.append(newMessage)
                            
                            DispatchQueue.main.async {
                                self.messageTableView.reloadData()
                                let indexPath = IndexPath(row: self.messageArray.count - 1, section: 0)
                                self.messageTableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                            
                        }
                    }
                }
            }
        }
    }
    
}

