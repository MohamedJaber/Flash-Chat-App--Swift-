//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    let db=Firestore.firestore()
    var messages:[Message]=[Message(sender: "mo@gmail.com", body: "Hi"), Message(sender: "amr@gmail.com", body: "Hi"), Message(sender: "mo@gmail.com", body: "What's up?")]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)//to register it
        //tableView.delegate=self
        tableView.dataSource=self
        title=K.appName
        navigationItem.hidesBackButton=true //to disappear the back item.
        loadMessages()
    }
    
    func loadMessages(){
        messages=[]//this to clear the silly message i wrote up
        db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener { (querySnapshot, error) in //we used order to arrange the messages and by default is ascending
            self.messages=[]//this cos when i write anything new it'll reappear the old ones two times so i have to clear the things out
            if let e = error {
                print("there is an error of retrieving data, \(e)")
            }else{
                if let snapshotDocuments=querySnapshot?.documents{
                    for doc in snapshotDocuments{
                        let data=doc.data()
                        if let messageSender=data[K.FStore.senderField] as? String, let messageBody=data[K.FStore.bodyField] as? String {
                            let newMessage=Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                            DispatchQueue.main.async {//when u fetch any data do that till not make your app freeze
                                self.tableView.reloadData()
                                let indexPath=IndexPath(row: self.messages.count-1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                        
                    }
                }
            }
        }
    }
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody=messageTextfield.text, let messageSender=Auth.auth().currentUser?.email{
            db.collection(K.FStore.collectionName).addDocument(data: [K.FStore.senderField: messageSender, K.FStore.bodyField: messageBody,K.FStore.dateField: Date().timeIntervalSince1970]) { (error) in
                if let e=error{
                    print("there is an issue in saving, \(e)")
                }else{
                    print("successful")
                    DispatchQueue.main.async {//coz we are in closure
                        self.messageTextfield.text=""
                    }
                }
            }
        }
    }
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do{
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        }catch let signOutError as NSError{
            print("Error signing out: %@",signOutError)
        }
    }
}

extension ChatViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message=messages[indexPath.row]
        let cell=tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell //on order to use Xib cell
        cell.labelFromXib.text=message.body
        //This is a message from the current user.
        if message.sender==Auth.auth().currentUser?.email{
            cell.leftImageView.isHidden=true
            cell.rightImageView.isHidden=false
            cell.messageBubble.backgroundColor=UIColor(named: K.BrandColors.lightPurple)
            cell.labelFromXib.textColor=UIColor(named: K.BrandColors.purple)
        }
        //From another sender
        else{
            cell.leftImageView.isHidden=false
            cell.rightImageView.isHidden=true
            cell.messageBubble.backgroundColor=UIColor(named: K.BrandColors.purple)
            cell.labelFromXib.textColor=UIColor(named: K.BrandColors.lightPurple)
        }
       
        return cell
    }
    
    
}
/*
extension ChatViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}*/
