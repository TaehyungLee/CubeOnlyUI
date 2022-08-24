//
//  KeychainStorage.swift
//  CubeOnlyUI
//
//  Created by Taehyung Lee on 2022/08/24.
//

import Foundation
import SwiftUI
import KeychainAccess


@propertyWrapper
struct KeychainStorage: DynamicProperty {
    let key: String
    @State private var value: String
    init(wrappedValue: String = "", _ key: String) {
        self.key = key
        let initialValue = (try? Keychain().get(key)) ?? wrappedValue
        self._value = State<String>(initialValue: initialValue)
    }
    var wrappedValue: String {
        get  { value }
        
        nonmutating set {
            value = newValue
            do {
                try Keychain().set(value, key: key)
            } catch let error {
                fatalError("\(error)")
            }
        }
    }
    var projectedValue: Binding<String> {
        Binding(get: { wrappedValue }, set: { wrappedValue = $0 })
    }
}

@propertyWrapper
struct KeychainCodableStorage<T: Codable>: DynamicProperty {
    typealias Value = T
    let key: String
    @State private var value: Value?
    
    init(wrappedValue: Value? = nil, _ key: String) {
        self.key = key
        var initialValue = wrappedValue
        do {
            try Keychain().get(key) {
                attributes in
                if let attributes = attributes, let data = attributes.data {
                    do {
                        let decoded = try JSONDecoder().decode(Value.self, from: data)
                        initialValue = decoded
                    } catch let error {
                        fatalError("\(error)")
                    }
                }
            }
        }
        catch let error {
            fatalError("\(error)")
        }
        self._value = State<Value?>(initialValue: initialValue)
    }
    
    var wrappedValue: Value? {
        get  { value }
        
        nonmutating set {
            value = newValue
            do {
                if (value == nil) {
                    Keychain()[key] = nil
                } else {
                    let encoded = try JSONEncoder().encode(value)
                    try Keychain().set(encoded, key: key)
                }
            } catch let error {
                fatalError("\(error)")
            }
        }
    }
    
    var projectedValue: Binding<Value?> {
        Binding(get: { wrappedValue }, set: { wrappedValue = $0 })
    }
}
