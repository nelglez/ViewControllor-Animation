//
//  RedViewController.swift
//  Transitions
//
//  Created by Spencer Curtis on 1/31/19.
//  Copyright © 2019 Spencer Curtis. All rights reserved.
//

import UIKit

class RedViewController: UIViewController, UIViewControllerTransitioningDelegate, LabelProviding {
    
    
    @IBOutlet weak var label: UILabel!
    
    let animator = Animator()
    //This is in charge of controlling how far the transition has gona based on a percentage from 0-1
    var interactionController: UIPercentDrivenInteractiveTransition?
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animator
    }
    
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactionController
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func pan(_ sender: UIPanGestureRecognizer) {
        
        switch sender.state {
        case .began:
            //Setup the interaction controller and begin dismissing the VC
            interactionController = UIPercentDrivenInteractiveTransition()
            dismiss(sender)
        case .changed:
            //Get the translation and compare that with some other value and come uo with a percent that the transition should go to
            
            let translation = sender.translation(in: view)
            //print(translation)
            
            let percentageComplete = abs(translation.y / view.frame.height)
            
            interactionController?.update(percentageComplete)
            
        case . ended:
            //Will get called after you light your finger from the screen
            
            let velocity = sender.velocity(in: view).y
            
            if velocity > 500 {
                //Finish the transition regardless of the percentage complete,.
                interactionController?.finish()
            } else {
                //the transition will revert back to before it happened.
                interactionController?.cancel()
            }
            
        default:
            break
        }
        
    }
    
    @IBAction func dismiss(_ sender: Any) {
        transitioningDelegate = self
        dismiss(animated: true, completion: nil)
    }
}
