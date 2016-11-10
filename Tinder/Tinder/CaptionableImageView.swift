//
//  CaptionableImageView.swift
//  Tinder
//
//  Created by DINGKaile on 11/9/16.
//  Copyright © 2016 myPersonalProjects. All rights reserved.
//

import UIKit

class CaptionableImageView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    
    
    var originalProfileImageCenter: CGPoint!
    var leftRange: CGFloat!
    var rightRange: CGFloat!
    var originalGesturePosition: CGPoint! {
        didSet {
            self.leftRange = self.originalGesturePosition.x
            self.rightRange = self.contentView.frame.width - self.originalGesturePosition.x
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubviews()
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func initSubviews() {
        let nib = UINib(nibName: "CaptionableImageView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        self.contentView.frame = self.bounds
        self.profileImage.image = UIImage(named: "ryan")
        self.addSubview(self.contentView)
    }

    @IBAction func onPanGestured(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.location(in: self.contentView)
        
        if sender.state == .began {
            self.originalProfileImageCenter = self.profileImage.center
            self.originalGesturePosition = translation
            
        } else if sender.state == .changed {
            
            if self.originalGesturePosition.y > (self.contentView.frame.height/2.0) {
                
                let diff = self.originalGesturePosition.x - translation.x
                self.profileImage.transform = CGAffineTransform(rotationAngle: diff/(self.contentView.frame.width)*CGFloat(M_PI))
            } else {
                let diff = translation.x - self.originalGesturePosition.x
                self.profileImage.transform = CGAffineTransform(rotationAngle: diff/(self.contentView.frame.width)*CGFloat(M_PI))
            }
            
            /*
            self.profileImage.center.x = self.originalProfileImageCenter.x + (translation.x - self.originalGesturePosition.x)
            */
            
        } else if sender.state == .ended {
            
            let diff = translation.x - self.originalGesturePosition.x
            if diff < -50.0 {
                UIView.animate(withDuration: 0.5, animations: {
                    self.profileImage.center.x -= self.contentView.frame.width
                    self.profileImage.alpha = 0.0
                }, completion: { (success) in
                    self.profileImage.center = self.originalProfileImageCenter
                    self.profileImage.transform = CGAffineTransform(rotationAngle: 0.0)
                    self.profileImage.alpha = 1.0
                })
            } else if diff > 50.0 {
                UIView.animate(withDuration: 0.5, animations: { 
                    self.profileImage.center.x += self.contentView.frame.width
                    self.profileImage.alpha = 0.0
                }, completion: { (success) in
                    self.profileImage.center = self.originalProfileImageCenter
                    self.profileImage.transform = CGAffineTransform(rotationAngle: 0.0)
                    self.profileImage.alpha = 1.0
                })
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.profileImage.transform = CGAffineTransform(rotationAngle: 0.0)
                })
            }
            
        }
        
    }
    
    
    @IBAction func onTapGesture(_ sender: UITapGestureRecognizer) {
        
        
        
        
        
    }
    
    
    
    
}
