//
//  ViewController.swift
//  Transitions
//
//  Created by Spencer Curtis on 1/31/19.
//  Copyright © 2019 Spencer Curtis. All rights reserved.
//

import UIKit

class StartingViewController: UIViewController, UIViewControllerTransitioningDelegate, LabelProviding {
    
    let animator = Animator()
    
 
    @IBOutlet weak var label: UILabel!
    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        //This method wants us to return an animator object that lets it know what the transition should look like.
        
        return animator
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        segue.destination.transitioningDelegate = self
        
    }
}

