//
//  PinServiceLayer.swift
//  Pinterest
//
//  Created by Marquavious on 10/23/17.
//  Copyright © 2017 Marquavious Draggon. All rights reserved.
//

import Foundation
import SwiftyJSON

struct PinServiceLayer {
    
    typealias GrabPinsCompletion = (Error?,[Pin]) -> ()
    
    static func grabPins(completion: @escaping GrabPinsCompletion) {
        
        var tempArray = [Pin]()
        
        if let path = Bundle.main.path(forResource: "pins_formatted", ofType: "json") {
            
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let jsonResult = JSON(data)
                for jsonData in jsonResult.arrayValue {
                    if let pin = Pin(jsonData) { // If it passes the failiable init
                        tempArray.append(pin)
                    }
                }
                return completion(nil, tempArray)
            } catch {
               return completion(NSError(), [])
            }
        }
    }
}
