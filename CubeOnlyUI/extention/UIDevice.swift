//
//  UIDevice.swift
//  CubeOnlyUI
//
//  Created by Taehyung Lee on 2022/12/12.
//

import SwiftUI
extension UIDevice {
    public var isiPhone: Bool {
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone {
            return true
        }
        return false
    }
    public var isiPad: Bool {
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
            return true
        }
        return false
    }
}
