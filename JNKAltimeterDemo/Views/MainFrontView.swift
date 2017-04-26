//
//  MainFrontView.swift
//  JNKAltimeterDemo
//
//  Created by JosephNK on 2017. 4. 27..
//  Copyright © 2017년 JosephNK. All rights reserved.
//

import UIKit

class MainFrontView: UIView {

    fileprivate lazy var flipButton: CustomButton = {
        var button = CustomButton()
        button.contentEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 10)
        button.setTitle("Show List Data", for: UIControlState.normal)
        button.setTitleColor(UIColor.black, for: UIControlState.normal)
        button.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        button.setTitleColor(UIColor.gray, for: UIControlState.disabled)
        button.borderColor = UIColor.darkGray
        button.borderHighlightedColor = UIColor.white
        button.borderDisabledColor = UIColor.gray
        button.layer.cornerRadius = 3.0
        button.layer.borderWidth = 1.0
        button.isEnabled = false
        return button
    }()
    
    fileprivate lazy var saveButton: CustomButton = {
        var button = CustomButton()
        button.contentEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 10)
        button.setTitle("Save Data", for: UIControlState.normal)
        button.setTitleColor(UIColor.black, for: UIControlState.normal)
        button.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        button.setTitleColor(UIColor.gray, for: UIControlState.disabled)
        button.borderColor = UIColor.darkGray
        button.borderHighlightedColor = UIColor.white
        button.borderDisabledColor = UIColor.gray
        button.layer.cornerRadius = 3.0
        button.layer.borderWidth = 1.0
        button.isEnabled = false
        return button
    }()
    
    fileprivate lazy var altLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 45.0, weight: UIFontWeightBold)
        label.textAlignment = .right
        label.text = "-"
        label.textColor = UIColor.black
        return label
    }()
    
    fileprivate lazy var descAltLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18.0)
        label.textAlignment = .right
        label.text = "meters of relative altitude"
        label.textColor = UIColor.darkGray
        return label
    }()
    
    fileprivate lazy var pressureLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 45.0, weight: UIFontWeightBold)
        label.textAlignment = .right
        label.text = "-"
        label.textColor = UIColor.black
        return label
    }()
    
    fileprivate lazy var descPressureLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18.0)
        label.textAlignment = .right
        label.text = "kilopascals of pressure"
        label.textColor = UIColor.darkGray
        return label
    }()
    
    fileprivate lazy var activityIndicator: UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        return indicator
    }()
    
    fileprivate lazy var altimeterSwitch: UISwitch = {
        var sw = UISwitch()
        return sw
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Setup Layout
        self.setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func addSwitchEvent(_ target: Any?, action: Selector) {
        self.altimeterSwitch.addTarget(target, action: action, for: UIControlEvents.valueChanged)
    }
    
    public func addFlipButtonEvent(_ target: Any?, action: Selector) {
        self.flipButton.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
    }
    
    public func addSaveButtonEvent(_ target: Any?, action: Selector) {
        self.saveButton.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
    }
    
    public func startIndicatorAnimating() {
        self.activityIndicator.startAnimating()
    }
    
    public func stopIndicatorAnimating() {
        self.activityIndicator.stopAnimating()
    }
    
    public func setAltitudeValue(_ text: String?) {
        self.altLabel.text = text
    }
    
    public func setPressureValue(_ text: String?) {
        self.pressureLabel.text = text
    }
    
    public func setAltimeterSwitchIsOn(_ isOn: Bool) {
        self.altimeterSwitch.isOn = isOn
    }

    public func setFlipButtonEnabled(_ isEnabled: Bool) {
        self.flipButton.isEnabled = isEnabled
    }
    
    public func setSaveButtonEnabled(_ isEnabled: Bool) {
        self.saveButton.isEnabled = isEnabled
    }
}

extension MainFrontView {
    fileprivate func setupLayout() {
        self.backgroundColor = UIColor.clear
        
        flipButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        altLabel.translatesAutoresizingMaskIntoConstraints = false
        descAltLabel.translatesAutoresizingMaskIntoConstraints = false
        pressureLabel.translatesAutoresizingMaskIntoConstraints = false
        descPressureLabel.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        altimeterSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(flipButton)
        self.addSubview(saveButton)
        self.addSubview(altLabel)
        self.addSubview(descAltLabel)
        self.addSubview(pressureLabel)
        self.addSubview(descPressureLabel)
        self.addSubview(activityIndicator)
        self.addSubview(altimeterSwitch)
        
        //---------------------
        // Layout Constraint
        //---------------------
        self.addConstraints([NSLayoutConstraint(item: flipButton, attribute: .top,
                                                relatedBy: .equal,
                                                toItem: self, attribute: .top,
                                                multiplier: 1.0,
                                                constant: 25.0),
                             NSLayoutConstraint(item: flipButton, attribute: .left,
                                                relatedBy: .equal,
                                                toItem: self, attribute: .left,
                                                multiplier: 1.0,
                                                constant: 10.0)])
        
        self.addConstraints([NSLayoutConstraint(item: saveButton, attribute: .top,
                                                relatedBy: .equal,
                                                toItem: self, attribute: .top,
                                                multiplier: 1.0,
                                                constant: 25.0),
                             NSLayoutConstraint(item: saveButton, attribute: .right,
                                                relatedBy: .equal,
                                                toItem: self, attribute: .right,
                                                multiplier: 1.0,
                                                constant: -10.0)])
        
        self.addConstraints([NSLayoutConstraint(item: altLabel, attribute: .top,
                                                relatedBy: .equal,
                                                toItem: self, attribute: .top,
                                                multiplier: 1.0,
                                                constant: 100.0),
                             NSLayoutConstraint(item: altLabel, attribute: .right,
                                                relatedBy: .equal,
                                                toItem: self, attribute: .right,
                                                multiplier: 1.0,
                                                constant: -20.0)])
        
        self.addConstraints([NSLayoutConstraint(item: descAltLabel, attribute: .top,
                                                relatedBy: .equal,
                                                toItem: self.altLabel, attribute: .bottom,
                                                multiplier: 1.0,
                                                constant: 0.0),
                             NSLayoutConstraint(item: descAltLabel, attribute: .right,
                                                relatedBy: .equal,
                                                toItem: self.altLabel, attribute: .right,
                                                multiplier: 1.0,
                                                constant: 0.0)])
        
        self.addConstraints([NSLayoutConstraint(item: pressureLabel, attribute: .top,
                                                relatedBy: .equal,
                                                toItem: self.descAltLabel, attribute: .bottom,
                                                multiplier: 1.0,
                                                constant: 30.0),
                             NSLayoutConstraint(item: pressureLabel, attribute: .right,
                                                relatedBy: .equal,
                                                toItem: self.altLabel, attribute: .right,
                                                multiplier: 1.0,
                                                constant: 0.0)])
        
        self.addConstraints([NSLayoutConstraint(item: descPressureLabel, attribute: .top,
                                                relatedBy: .equal,
                                                toItem: self.pressureLabel, attribute: .bottom,
                                                multiplier: 1.0,
                                                constant: 0.0),
                             NSLayoutConstraint(item: descPressureLabel, attribute: .right,
                                                relatedBy: .equal,
                                                toItem: self.altLabel, attribute: .right,
                                                multiplier: 1.0,
                                                constant: 0.0)])
        
        self.addConstraints([NSLayoutConstraint(item: activityIndicator, attribute: .centerX,
                                                relatedBy: .equal,
                                                toItem: self, attribute: .centerX,
                                                multiplier: 1.0,
                                                constant: 0.0),
                             NSLayoutConstraint(item: activityIndicator, attribute: .bottom,
                                                relatedBy: .equal,
                                                toItem: self.altimeterSwitch, attribute: .top,
                                                multiplier: 1.0,
                                                constant: -20.0)])
        
        self.addConstraints([NSLayoutConstraint(item: altimeterSwitch, attribute: .centerX,
                                                relatedBy: .equal,
                                                toItem: self, attribute: .centerX,
                                                multiplier: 1.0,
                                                constant: 0.0),
                             NSLayoutConstraint(item: altimeterSwitch, attribute: .bottom,
                                                relatedBy: .equal,
                                                toItem: self, attribute: .bottom,
                                                multiplier: 1.0,
                                                constant: -40.0)])
    }
}
