//
//  UIView + Extension.swift
//  VapingApp
//
//  Created by iOSayed on 16/12/2022.
//

import Foundation
import UIKit


extension UIView {
    //MARK:- Create cornerReduis , border and color with @IBInspectable
    
    @IBInspectable var cornerRaduis : CGFloat {
        get {
           
            return self.cornerRaduis
        }
        set {
             self.clipsToBounds = true
            return self.layer.cornerRadius = newValue
        }
        
    }
    @IBInspectable var border : CGFloat  {
        get {
            return self.border
        }
        set {
            return  self.layer.borderWidth = newValue
        }
        
    }
    
    @IBInspectable var borderColor : UIColor? {
        get{
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else{
                return layer.borderColor = nil
            }
            
        }
        
    }
    @IBInspectable var Shadow : CGFloat  {
        get {
            return self.Shadow
        }
        set {
            return  self.layer.shadowRadius = newValue
        }
        
    }
    @IBInspectable var shadowColor : UIColor? {
           get{
               if let color = layer.shadowColor {
                   return UIColor(cgColor: color)
               }
               return nil
           }
           set {
               if let color = newValue {
                   layer.shadowColor = color.cgColor
               } else{
                   return layer.shadowColor = nil
               }
               
           }
           
       }
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
 
}

