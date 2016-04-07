//
//  WaitingView.swift
//  userableUITable
//
//  Created by PouriyaHB on 4/4/15.
//  Copyright (c) 2015 Nill. All rights reserved.
//

import UIKit

class WaitingView: UIView {

    override init(frame: CGRect) {
        super.init(frame : frame)
        
        self.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0.5)
        self.clipsToBounds = true

        let waitingAnimationView    :   UIView  =   UIView(frame: CGRectMake(center.x, center.y, 1, 1))
        waitingAnimationView.center = center
        waitingAnimationView.backgroundColor = UIColor.whiteColor()
        waitingAnimationView.layer.cornerRadius = 4
        
        
        self.addSubview(waitingAnimationView)

        
        UIView.animateWithDuration( 0.1, delay: 0  , options: UIViewAnimationOptions.CurveLinear , animations: {
            
           //waiting view boyutu ayarlanacak.
            waitingAnimationView.frame  =   CGRectMake( self.center.x - 110  , self.center.y - 25 , 225, 50)
            
            
            
            }, completion: { finished in
                
                let waitingActivityIndicatorView    :   UIActivityIndicatorView =   UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray )
                waitingActivityIndicatorView.center = CGPointMake( 2 * waitingActivityIndicatorView.frame.height, waitingAnimationView.frame.height / 2)
                waitingActivityIndicatorView.color = UIColor.blueColor()
                waitingActivityIndicatorView.startAnimating()
                
                let waitingTextLabelView        :   UILabel =  UILabel(frame: CGRectMake(waitingActivityIndicatorView.frame.width * 3 , 0, waitingAnimationView.frame.width/2, waitingAnimationView.frame.height))
                
                waitingTextLabelView.backgroundColor    =   UIColor.clearColor()
                waitingTextLabelView.textColor          =   UIColor.lightGrayColor()
                waitingTextLabelView.text               =   "Lütfen bekleyin..."
                waitingTextLabelView.font               =   UIFont(name: waitingTextLabelView.font.fontName , size: 12   )
                waitingAnimationView.addSubview(waitingActivityIndicatorView)
                waitingAnimationView.addSubview(waitingTextLabelView)
                
                
                
        })

        
        
    
    }

   required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }

}
