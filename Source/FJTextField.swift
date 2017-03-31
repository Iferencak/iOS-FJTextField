//
//  FJTextField.swift
//
//  Created by Ivan Ferencak & Josip Jurić on 30/03/2017.
//  Copyright © 2017 foreach5. All rights reserved.
//

import UIKit

@IBDesignable class FJTextField: UITextField, UITextFieldDelegate {
    
    private var placeholderLabel:UILabel!
    
    private var lineView:UIView!
    
    private var lineSelectedView:UIView!
    
    @IBInspectable var lineHeight:Int = 1 {
        didSet {
            lineView.frame = CGRect(x: 0, y: self.frame.height - CGFloat(lineHeight), width: self.frame.width, height: CGFloat(lineHeight))
        }
    }
    
    @IBInspectable var lineColor:UIColor = UIColor.red {
        didSet {
            lineView.backgroundColor = lineColor;
            lineSelectedView.backgroundColor = lineColor;
        }
    }
    
    @IBInspectable var placeholderColor:UIColor = UIColor.lightGray {
        didSet {
            placeholderLabel.textColor = placeholderColor
        }
    }
    
    @IBInspectable var placeholderText:String="Placeholder"{
        didSet{
            placeholderLabel.text = placeholderText
        }
    }
    
    var placeholderFont:UIFont! {
        didSet{
            placeholderLabel.font = placeholderFont;
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        
        setupViews();
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    override func prepareForInterfaceBuilder() {
        setupViews()
        
        super.prepareForInterfaceBuilder()
    }
    
    func setupViews(){
        
        self.clipsToBounds = false;
        
        placeholderLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        
        placeholderLabel.textColor = placeholderColor;
        
        placeholderLabel.text = placeholderText
        placeholder = ""
        
        placeholderLabel?.font = self.font;
        
        self.delegate = self;
        self.borderStyle = .none;
        self.backgroundColor = UIColor.clear;
        
        self.addSubview(placeholderLabel!);
        
        lineView = UIView(frame: CGRect(x: 0, y: self.frame.height - CGFloat(lineHeight), width: self.frame.width, height: CGFloat(lineHeight)));
        
        
        lineView.backgroundColor = lineColor
        
        lineSelectedView = UIView(frame: CGRect(x: self.frame.width/2, y: lineView.frame.origin.y - 2, width: 0, height: 2))
        lineSelectedView.backgroundColor = lineColor;
            
        self.addSubview(lineSelectedView);
        
        self.addSubview(lineView);
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        let lineFrame = CGRect(x: 0, y: self.lineView.frame.origin.y - 1, width: self.frame.width, height: 1)
        
        if(textField.text == ""){
            let coef:CGFloat = 0.7
            
            UIView.animate(withDuration: 0.15, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                let diffX = (self.placeholderLabel?.frame.width)! - ((self.placeholderLabel?.frame.width)! * coef)
                let transX = (diffX / -2)
                
                let diffY = (self.placeholderLabel?.frame.height)! - ( (self.placeholderLabel?.frame.height)! * coef)
                let transY =  (diffY / -2) - (self.placeholderLabel?.frame.height)!/2
                
                
                self.placeholderLabel?.transform = CGAffineTransform.init(scaleX: coef, y: coef).concatenating(CGAffineTransform(translationX:  transX, y: transY))
            }, completion: nil)

        }
        
        UIView.animate(withDuration: 0.15, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.lineSelectedView.frame = lineFrame
        }, completion: nil)
        
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let lineFrame = CGRect(x: self.frame.width/2, y: self.lineView.frame.origin.y - 1, width: 0, height: 1)
        
        if(textField.text == ""){
            
            UIView.animate(withDuration: 0.15, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                self.placeholderLabel?.transform = CGAffineTransform.identity;
            }, completion: nil)
            
        }
        
        UIView.animate(withDuration: 0.15, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.lineSelectedView.frame = lineFrame
        }, completion: nil)
        
    }
    
}
