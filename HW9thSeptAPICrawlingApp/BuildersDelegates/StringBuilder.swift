//
//  StringBuilder.swift
//  HW9thSeptAPICrawlingApp
//
//  Created by The App Experts on 10/09/2020.
//  Copyright © 2020 The App Experts. All rights reserved.
//

import UIKit

protocol StringBuilderDelegate {
    func updateValue(with value: String)
}

class StringBuilder: BuilderProtocol {
    
    private let stringValue:String
    private let delegate: StringBuilderDelegate?
    
    init(stringValue: String, delegate: StringBuilderDelegate) {
        self.stringValue = stringValue
        self.delegate = delegate
    }
    func build() -> UIView {
        let textView = UITextView()
        textView.text = self.stringValue
        return textView
    }
    
}
