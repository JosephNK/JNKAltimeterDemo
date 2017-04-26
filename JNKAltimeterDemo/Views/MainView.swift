//
//  MainView.swift
//  JNKAltimeterDemo
//
//  Created by JosephNK on 2017. 4. 27..
//  Copyright © 2017년 JosephNK. All rights reserved.
//

import UIKit

class MainView: UIView {
    
    fileprivate var cardViews: (frontView: UIView, backView: UIView)?
    
    lazy var frontView: MainFrontView = {
        var view = MainFrontView()
        return view
    }()
    
    lazy var backView: MainBackView = {
        var view = MainBackView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Setup Layout
        self.setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func flipCardAnimation() {
        var transitionOptions: UIViewAnimationOptions = UIViewAnimationOptions.transitionFlipFromLeft
        
        if (frontView.superview != nil) {
            self.cardViews = (frontView: backView, backView: frontView)
            transitionOptions = UIViewAnimationOptions.transitionFlipFromLeft
        }else{
            self.cardViews = (frontView: frontView, backView: backView)
            transitionOptions = UIViewAnimationOptions.transitionFlipFromRight
        }
        
        UIView.transition(with: self, duration: 0.5, options: transitionOptions, animations: {
            self.cardViews!.backView.removeFromSuperview()
            self.addSubViewWithLayout(view: self.cardViews!.frontView)
        }, completion: { finished in
            
        })
    }
}

extension MainView {
    fileprivate func setupLayout() {
        self.cardViews = (frontView: frontView, backView: backView)
        if (backView.superview != nil) {
            self.cardViews!.backView.removeFromSuperview()
        }
        self.addSubViewWithLayout(view: frontView)
    }
    
    fileprivate func addSubViewWithLayout(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(view)
        
        //---------------------
        // Layout Constraint
        //---------------------
        self.addConstraints([NSLayoutConstraint(item: view, attribute: .top,
                                                relatedBy: .equal,
                                                toItem: self, attribute: .top,
                                                multiplier: 1.0,
                                                constant: 0.0),
                             NSLayoutConstraint(item: view, attribute: .left,
                                                relatedBy: .equal,
                                                toItem: self, attribute: .left,
                                                multiplier: 1.0,
                                                constant: 0.0),
                             NSLayoutConstraint(item: view, attribute: .right,
                                                relatedBy: .equal,
                                                toItem: self, attribute: .right,
                                                multiplier: 1.0,
                                                constant: 0.0),
                             NSLayoutConstraint(item: view, attribute: .bottom,
                                                relatedBy: .equal,
                                                toItem: self, attribute: .bottom,
                                                multiplier: 1.0,
                                                constant: 0.0)])
    }
}
