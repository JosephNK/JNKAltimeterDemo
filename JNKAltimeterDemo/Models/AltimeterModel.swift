//
//  AltimeterModel.swift
//  JNKAltimeterDemo
//
//  Created by JosephNK on 2017. 4. 27..
//  Copyright © 2017년 JosephNK. All rights reserved.
//

import UIKit

class AltimeterModel: NSObject {
    var relativeAltitude: NSNumber?
    var pressure: NSNumber?
    
    init(relativeAltitude: NSNumber?, pressure: NSNumber?) {
        self.relativeAltitude = relativeAltitude
        self.pressure = pressure
        
        super.init()
    }
    
    convenience override init() {
        self.init(relativeAltitude: nil, pressure: nil)
    }
}
