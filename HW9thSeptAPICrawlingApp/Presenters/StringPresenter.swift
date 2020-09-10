//
//  StringPresenter.swift
//  HW9thSeptAPICrawlingApp
//
//  Created by The App Experts on 10/09/2020.
//  Copyright © 2020 The App Experts. All rights reserved.
//

class StringPresenter: Presenters {
    
    var stringValue = ""
    
    func presenterName() -> String {
        return "I am String"
    }
    
    func presenterValue() -> String {
        return stringValue
    }
    
    func builderAndDelegate() -> BuilderProtocol {
        return StringBuilder(stringValue: self.stringValue, delegate: self)
    }
}

extension StringPresenter: StringBuilderDelegate {
    func updateValue(with value: String) {
        self.stringValue = value
    }
}
