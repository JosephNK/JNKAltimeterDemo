//
//  MainBackView.swift
//  JNKAltimeterDemo
//
//  Created by JosephNK on 2017. 4. 27..
//  Copyright © 2017년 JosephNK. All rights reserved.
//

import UIKit

class MainBackView: UIView {

    var dataModels: [AltimeterModel]?
    
    fileprivate let cellId = "HistoryTableViewCell"
    
    fileprivate lazy var flipButton: CustomButton = {
        var button = CustomButton()
        button.contentEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 10)
        button.setTitle("Hide List Data", for: UIControlState.normal)
        button.setTitleColor(UIColor.black, for: UIControlState.normal)
        button.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        button.setTitleColor(UIColor.gray, for: UIControlState.disabled)
        button.borderColor = UIColor.darkGray
        button.borderHighlightedColor = UIColor.white
        button.borderDisabledColor = UIColor.gray
        button.layer.cornerRadius = 3.0
        button.layer.borderWidth = 1.0
        return button
    }()
    
    fileprivate lazy var clearButton: CustomButton = {
        var button = CustomButton()
        button.contentEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 10)
        button.setTitle("Clear Data", for: UIControlState.normal)
        button.setTitleColor(UIColor.black, for: UIControlState.normal)
        button.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        button.setTitleColor(UIColor.gray, for: UIControlState.disabled)
        button.borderColor = UIColor.darkGray
        button.borderHighlightedColor = UIColor.white
        button.borderDisabledColor = UIColor.gray
        button.layer.cornerRadius = 3.0
        button.layer.borderWidth = 1.0
        return button
    }()
    
    fileprivate lazy var tableView: HistoryTableView = {
        var view = HistoryTableView(frame: CGRect.zero, style: UITableViewStyle.grouped)
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Setup Layout
        self.setupLayout()
        
        //
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: self.cellId)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func addFlipButtonEvent(_ target: Any?, action: Selector) {
        self.flipButton.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
    }
    
    public func addClearButtonEvent(_ target: Any?, action: Selector) {
        self.clearButton.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
    }

    public func reloadDataTableView() {
        self.tableView.reloadData()
    }
}

extension MainBackView {
    fileprivate func setupLayout() {
        self.backgroundColor = UIColor.clear
        
        flipButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(flipButton)
        self.addSubview(clearButton)
        self.addSubview(tableView)
        
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
        
        self.addConstraints([NSLayoutConstraint(item: clearButton, attribute: .top,
                                                relatedBy: .equal,
                                                toItem: self, attribute: .top,
                                                multiplier: 1.0,
                                                constant: 25.0),
                             NSLayoutConstraint(item: clearButton, attribute: .right,
                                                relatedBy: .equal,
                                                toItem: self, attribute: .right,
                                                multiplier: 1.0,
                                                constant: -10.0)])
        
        self.addConstraints([NSLayoutConstraint(item: tableView, attribute: .top,
                                                relatedBy: .equal,
                                                toItem: self.flipButton, attribute: .bottom,
                                                multiplier: 1.0,
                                                constant: 0.0),
                             NSLayoutConstraint(item: tableView, attribute: .left,
                                                relatedBy: .equal,
                                                toItem: self, attribute: .left,
                                                multiplier: 1.0,
                                                constant: 0.0),
                             NSLayoutConstraint(item: tableView, attribute: .right,
                                                relatedBy: .equal,
                                                toItem: self, attribute: .right,
                                                multiplier: 1.0,
                                                constant: 0.0),
                             NSLayoutConstraint(item: tableView, attribute: .bottom,
                                                relatedBy: .equal,
                                                toItem: self, attribute: .bottom,
                                                multiplier: 1.0,
                                                constant: 0.0)])
    }
}

extension MainBackView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataModels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId, for: indexPath) as! HistoryTableViewCell
        cell.dataModel = self.dataModels?[indexPath.row]
        return cell
    }
}

class HistoryTableView: UITableView {
    override public init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        setupViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        
    }
    
    func setupViews() {
        self.backgroundColor = UIColor.clear
    }
}

class HistoryTableViewCell: UITableViewCell {
    var dataModel: AltimeterModel? {
        didSet {
            if let altitude = dataModel?.relativeAltitude?.floatValue, let pressure = dataModel?.pressure?.floatValue {
                let result = String(format: "Altitude Change: %.02f meters\nPressure: %.02f kilopascals", altitude, pressure)
                self.titleLabel.text = result
            }
        }
    }
    
    fileprivate lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0, weight: UIFontWeightThin)
        label.textAlignment = .right
        label.text = ""
        label.textColor = UIColor.black
        label.numberOfLines = 0
        return label
    }()
    
    override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        
    }
    
    open func setupViews() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(titleLabel)
        
        //---------------------
        // Layout Constraint
        //---------------------
        self.contentView.addConstraints([NSLayoutConstraint(item: titleLabel, attribute: .top,
                                                            relatedBy: .equal,
                                                            toItem: self.contentView, attribute: .top,
                                                            multiplier: 1.0,
                                                            constant: 10.0),
                                         NSLayoutConstraint(item: titleLabel, attribute: .left,
                                                            relatedBy: .equal,
                                                            toItem: self.contentView, attribute: .left,
                                                            multiplier: 1.0,
                                                            constant: 10.0),
                                         NSLayoutConstraint(item: titleLabel, attribute: .right,
                                                            relatedBy: .equal,
                                                            toItem: self.contentView, attribute: .right,
                                                            multiplier: 1.0,
                                                            constant: -10.0),
                                         NSLayoutConstraint(item: titleLabel, attribute: .bottom,
                                                            relatedBy: .equal,
                                                            toItem: self.contentView, attribute: .bottom,
                                                            multiplier: 1.0,
                                                            constant: -10.0)])
    }
}
