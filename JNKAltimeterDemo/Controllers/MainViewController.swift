//
//  MainViewController.swift
//  JNKAltimeterDemo
//
//  Created by JosephNK on 2017. 4. 27..
//  Copyright © 2017년 JosephNK. All rights reserved.
//

import UIKit
import CoreMotion

class MainViewController: UIViewController {
    
    lazy var altimeter = CMAltimeter()
    
    fileprivate var currentAltitude: Float = 0.0
    fileprivate var currentPressure: Float = 0.0
    
    lazy var mainView: MainView = {
        var view = MainView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        // Setup Layout
        self.setupLayout()
        
        //
        self.mainView.frontView.addSwitchEvent(self, action: #selector(switchDidChange(_:)))
        self.mainView.frontView.addFlipButtonEvent(self, action: #selector(frontFilpButtonClicked(_:)))
        self.mainView.frontView.addSaveButtonEvent(self, action: #selector(frontSaveButtonClicked(_:)))
        self.mainView.backView.addFlipButtonEvent(self, action: #selector(backFilpButtonClicked(_:)))
        self.mainView.backView.addClearButtonEvent(self, action: #selector(backClearButtonClicked(_:)))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func switchDidChange(_ sender: UISwitch) {
        if (sender.isOn == true) {
            self.startAltimeter()
        }else {
            self.stopAltimeter()
        }
    }
    
    func frontFilpButtonClicked(_ sender: UIButton) {
        self.mainView.flipCardAnimation()
    }
    
    func frontSaveButtonClicked(_ sender: UIButton) {
        let dataModel = AltimeterModel(relativeAltitude: NSNumber(floatLiteral: Double(self.currentAltitude)), pressure: NSNumber(floatLiteral: Double(self.currentPressure)))
        
        if var dataModels = self.mainView.backView.dataModels {
            dataModels.append(dataModel)
            self.mainView.backView.dataModels = dataModels
        }else {
            let dataModels: [AltimeterModel] = [
                dataModel
            ]
            self.mainView.backView.dataModels = dataModels
        }
        
        self.mainView.backView.reloadDataTableView()
    }
    
    func backFilpButtonClicked(_ sender: UIButton) {
        self.mainView.flipCardAnimation()
    }
    
    func backClearButtonClicked(_ sender: UIButton) {
        self.mainView.backView.dataModels = []
        self.mainView.backView.reloadDataTableView()
    }
    
    func startAltimeter() {
        
        print("Started relative altitude updates.")
        
        // Check if altimeter feature is available
        if (CMAltimeter.isRelativeAltitudeAvailable()) {
            
            self.mainView.frontView.startIndicatorAnimating()
            self.mainView.frontView.setFlipButtonEnabled(true)
            self.mainView.frontView.setSaveButtonEnabled(true)
            
            // Start altimeter updates, add it to the main queue
            self.altimeter.startRelativeAltitudeUpdates(to: OperationQueue.main, withHandler: { (altitudeData:CMAltitudeData?, error:Error?) in
                if (error != nil) {
                    self.mainView.frontView.setAltimeterSwitchIsOn(false)
                    self.stopAltimeter()
                    
                    let alertController = UIAlertController(title: "Error",
                                                            message: error!.localizedDescription,
                                                            preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }else {
                    let altitude = altitudeData!.relativeAltitude.floatValue    // Relative altitude in meters
                    let pressure = altitudeData!.pressure.floatValue            // Pressure in kilopascals
                    
                    self.currentAltitude = altitude
                    self.currentPressure = pressure
                    
                    // Update labels, truncate float to two decimal points
                    self.mainView.frontView.setAltitudeValue(String(format: "%.02f", altitude))
                    self.mainView.frontView.setPressureValue(String(format: "%.02f", pressure))
                }
            })
            
        }else {
            
            self.mainView.frontView.stopIndicatorAnimating()
            self.mainView.frontView.setFlipButtonEnabled(false)
            self.mainView.frontView.setSaveButtonEnabled(false)
            
            let alertController = UIAlertController(title: "Error",
                                                    message: "Barometer not available on this device.",
                                                    preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                (result : UIAlertAction) -> Void in
                print("OK")
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
        
    }
    
    func stopAltimeter() {
        //
        self.mainView.frontView.setFlipButtonEnabled(false)
        self.mainView.frontView.setSaveButtonEnabled(false)
        
        // Reset labels
        self.mainView.frontView.setAltitudeValue("-")
        self.mainView.frontView.setPressureValue("-")
        
        self.altimeter.stopRelativeAltitudeUpdates() // Stop updates
        
        self.mainView.frontView.stopIndicatorAnimating()
        
        print("Stopped relative altitude updates.")
    }

}

extension MainViewController {
    fileprivate func setupLayout() {
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(mainView)
        
        //---------------------
        // Layout Constraint
        //---------------------
        self.view.addConstraints([NSLayoutConstraint(item: mainView, attribute: .top,
                                                     relatedBy: .equal,
                                                     toItem: self.topLayoutGuide, attribute: .top,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: mainView, attribute: .left,
                                                     relatedBy: .equal,
                                                     toItem: self.view, attribute: .left,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: mainView, attribute: .right,
                                                     relatedBy: .equal,
                                                     toItem: self.view, attribute: .right,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: mainView, attribute: .bottom,
                                                     relatedBy: .equal,
                                                     toItem: self.view, attribute: .bottom,
                                                     multiplier: 1.0,
                                                     constant: 0.0)])
    }
}
