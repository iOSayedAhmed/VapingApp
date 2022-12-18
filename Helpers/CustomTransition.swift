//
//  CustomTransition.swift
//  VapingApp
//
//  Created by iOSayed on 18/12/2022.
//

import Foundation
import UIKit

class CustomTransition : NSObject {
    
    let animationDuration = 0.8
    var presenting = true
    var originFrame = CGRect.zero
    
}
extension CustomTransition : UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //add our animation
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        let fromView = transitionContext.view(forKey: .from)!
        let destenationView = presenting ? toView : fromView
        let initialFrame = presenting ? originFrame : destenationView.frame
        let finalFrame = presenting ? destenationView.frame : originFrame
        
        let xScaleFactor = presenting ? initialFrame.width / finalFrame.width : finalFrame.width / initialFrame.width
        let yScaleFactor = presenting ? initialFrame.height / finalFrame.height : finalFrame.height / initialFrame.height
        
       let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        if presenting {
            destenationView.transform = scaleTransform
            destenationView.center = CGPoint(x: initialFrame.midX, y: initialFrame.midY)
            destenationView.clipsToBounds = true
        }
        
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(destenationView)
        
        UIView.animate(withDuration: animationDuration, animations: {
            destenationView.transform = self.presenting ? .identity : scaleTransform
            destenationView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
        }){(_) in
            transitionContext.completeTransition(true)
        }
    }
    
    
//
}
