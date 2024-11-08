//
//  Picker.swift
//  testDevCrystals
//
//  Created by Aaron Ploetz on 11/3/24.
//

import UIKit

enum Picker {
    enum Source: String {
        case library, camera
    }
    
    static func checkPermissions() -> Bool {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            return true
        } else {
            return false
        }
    }
}
