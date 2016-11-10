//
//  CardsViewController.swift
//  Tinder
//
//  Created by DINGKaile on 11/9/16.
//  Copyright © 2016 myPersonalProjects. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    @IBOutlet weak var customView: CaptionableImageView!
    var isPresenting: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTapGesture(_ sender: UITapGestureRecognizer) {
        let profileView = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        
        profileView.modalPresentationStyle = UIModalPresentationStyle.custom
        profileView.transitioningDelegate = self
        
        self.present(profileView, animated: true, completion: nil)
        
    }

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.isPresenting = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.isPresenting = false
        return self
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        print("animating transition")
        
        let containerView = transitionContext.containerView
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        
        if (self.isPresenting) {
            containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0.0
            UIView.animate(withDuration: 0.5, animations: { 
                toViewController.view.alpha = 1.0
            }, completion: { (success) in
                transitionContext.completeTransition(true)
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: { 
                fromViewController.view.alpha = 0.0
            }, completion: { (success) in
                transitionContext.completeTransition(true)
                fromViewController.view.removeFromSuperview()
            })
        }
        
        
    }
    
}

