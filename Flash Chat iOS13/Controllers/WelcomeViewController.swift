//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: CLTypingLabel!
    //@IBOutlet weak var titleLabel: UILabel!
    override func viewWillAppear(_ animated: Bool) {//and it should be before the viewDidLoad
        super.viewWillAppear(animated)//we did this coz we inherit from UIViewController so we have to use super anyway. //coz we override....it's a good habit.
        navigationController?.isNavigationBarHidden=true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden=false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text=K.appName
      /*  titleLabel.text=""
        var index=0.0
        let titleText="⚡️FlashChat"
        for letter in titleText{
            Timer.scheduledTimer(withTimeInterval: 0.1*index, repeats: false) { (timer) in
                self.titleLabel.text?.append(letter)
            }
            index+=1
        }*/
    }
    

}
