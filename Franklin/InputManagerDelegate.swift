//
//  InputManagerType.swift
//  Franklin
//
//  Created by Sergio Puleri on 3/6/17.
//  Copyright © 2017 Franklin. All rights reserved.
//

import Foundation

protocol InputManagerDelegate {
    func left()
    func right()
    func down()
    func up()
    func unsure()
    
    func setIsReadyForInput(isReady: Bool)
}
