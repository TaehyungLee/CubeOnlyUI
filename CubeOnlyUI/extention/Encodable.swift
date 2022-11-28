//
//  Encodable.swift
//  CubeOnlyUI
//
//  Created by Taehyung Lee on 2022/11/28.
//

import Foundation

extension Encodable {
    
    var toDictionary : [String: Any]? {
        guard let object = try? JSONEncoder().encode(self) else { return nil }
        guard let dictionary = try? JSONSerialization.jsonObject(with: object, options: []) as? [String:Any] else { return nil }
        return dictionary
    }
    
    
}
