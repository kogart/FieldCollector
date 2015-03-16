//  ViewController.swift
//  FieldCollector
//
//  Created by Sebastian Ruth on 12/03/15.
//  Copyright (c) 2015 Sebastian Ruth, Marcus Thorelius. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    var button = UIButton.buttonWithType(UIButtonType.System) as UIButton
    var buttonMail = UIButton.buttonWithType(UIButtonType.System) as UIButton
    var buttonDel = UIButton.buttonWithType(UIButtonType.System) as UIButton
    var txtField: UITextField = UITextField()
    var text: String = ""
    var text2: String = ""
    var delCheck = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg1024.png")!)
        
        txtField.frame = CGRectMake(65, 350, 637, 151)
        txtField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7)
        txtField.textAlignment = .Center
        txtField.keyboardType = UIKeyboardType.EmailAddress
        txtField.font = txtField.font.fontWithSize(40)
        txtField.autocapitalizationType = UITextAutocapitalizationType.None
        self.view.addSubview(txtField)
        
        
        button.frame = CGRectMake(65, 550, 637, 151)
        button.backgroundColor = UIColor(patternImage: UIImage(named: "button_orange.png")!)
        button.addTarget(self, action: "buttonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
        
        
        buttonMail.frame = CGRectMake(400, 900, 136, 103)
        buttonMail.backgroundColor = UIColor(patternImage: UIImage(named: "button_mail.png")!)
        buttonMail.addTarget(self, action: "showMail:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(buttonMail)
        
        
        buttonDel.frame = CGRectMake(571, 900, 136, 103)
        buttonDel.backgroundColor = UIColor(patternImage: UIImage(named: "button_delete.png")!)
        buttonDel.addTarget(self, action: "delMail:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(buttonDel)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func buttonPressed(sender:UIButton!)
    {
        var validmail = false
        delCheck = true
        
        button.backgroundColor = UIColor(patternImage: UIImage(named: "button_pressed.png")!)
        let file = "list.txt"
        let string = txtField.text
        
        for Character in txtField.text{
            if Character == "@"
            {
                validmail = true
            }
        }
        
        
        if validmail
        {
            
            if let dirs : [String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String] {
                let dir = dirs[0] //documents directory
                let path = dir.stringByAppendingPathComponent(file);
                text = text + txtField.text + ", "
                
                //writing
                text.writeToFile(path, atomically: false, encoding: NSUTF8StringEncoding, error: nil);
                
                txtField.text = ""
                
                //reading
                text2 = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil)!
            }
            
        } else {
            txtField.text = "Felaktig email-adress. Ej sparad."
        }
        button.backgroundColor = UIColor(patternImage: UIImage(named: "button_orange.png")!)
    }
    
    
    func showMail(sender:UIButton!) {
        UIPasteboard.generalPasteboard().string = text2
        txtField.text = "Kopiering lyckades."
    }
    
    
    func delMail(sender:UIButton!) {
        if delCheck {
            txtField.text = "Vill du ta bort alla adresser?"
            delCheck = false
        } else {
            text2 = ""
            txtField.text = "Adresser borttagna."
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}