//
//  Animator.swift
//  Transitions
//
//  Created by Nelson Gonzalez on 5/23/19.
//  Copyright © 2019 Spencer Curtis. All rights reserved.
//

import UIKit

class Animator: NSObject, UIViewControllerAnimatedTransitioning {  //conforms to NSObjectProtocol
    
    //How long should the transition be
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    //What do you want the transition to look like. Implement it.
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //You can do what ever animation you want in here to perform your transition
        
        // Grab the "to" and "from" VC, so we can know the frame of each's label.
        
        guard let fromVC = transitionContext.viewController(forKey: .from) as? LabelProviding, let toVC = transitionContext.viewController(forKey: .to) as? LabelProviding, let toView = transitionContext.view(forKey: .to) else { return }
        
        //We need toView to drop toViews alpha to zero and during animation bring it back to 1
        
        
        //This is the view that we put any transitionary views like a third label in. This exists in between VC
        let containerView = transitionContext.containerView
        //Add the toView to the container view so we can animate it.
        containerView.addSubview(toView)
        
        let toViewEndFrame = transitionContext.finalFrame(for: toVC)//Where our view will end up
        toView.frame = toViewEndFrame
        
        //since we want to fade the toView (red views) in during the transition we need to set its alpha to 0
        
        toView.alpha = 0
        
        
        //figure out where the 3rd (transitionin label) should start before and end up after the transition
        
        let fromLabel = fromVC.label!
        let toLabel = toVC.label!
        
        
        toView.layoutIfNeeded()//We need to call this so we sure the label on the toView is on the right place
        
        
        //ask for their location/frame
        
        let transitionLabelInitialFrame = containerView.convert(fromLabel.bounds, from: fromLabel)
        
        let transitionlabelEndFrame = containerView.convert(toLabel.bounds, from: toLabel)
        
        //Set up the transition label to look the same as the labels on each VC and start at the same place.
        
        let transitionLabel = UILabel(frame: transitionLabelInitialFrame)
        
        //We need to make sure it looks the same
        
        transitionLabel.text = fromLabel.text
        transitionLabel.font = fromLabel.font
        transitionLabel.textColor = fromLabel.textColor
        
        //Add to container view so it shows on the screen
        
        containerView.addSubview(transitionLabel)
        
        //perform the animation to move the label from initial frame to the end frame and also animate the alpha of the toView
        
       
        
        //Perform Animation
        
        let animationDuration = self.transitionDuration(using: transitionContext)
        //Hide the "real" labels so they arent seen during the transition
        toLabel.alpha = 0
        fromLabel.alpha = 0
        
        UIView.animate(withDuration: animationDuration, animations: {
            transitionLabel.frame = transitionlabelEndFrame//Animtae label up to the other labels location
            transitionLabel.textColor = toLabel.textColor
            toView.alpha = 1 //Fade-in effect
        }) { (_) in
            //Need to reset the views to their original state and remove the transition label.
            
            transitionLabel.removeFromSuperview()
            toLabel.alpha = 1
            fromLabel.alpha = 1
            
            //We need to say that the transition was successful or not
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }   
}
