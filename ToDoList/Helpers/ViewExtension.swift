//
//  SectionExtend.swift
//  ToDoList
//
//  Created by LEO on 19.08.2024.
//

import UIKit

private var sectionKey: UInt8 = 0

extension UIButton {
    public var section: Int {
        get {
            return objc_getAssociatedObject(self, &sectionKey) as? Int ?? 0
        }
        set {
            objc_setAssociatedObject(self, &sectionKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

extension UITextField {
    public var section: Int {
        get {
            return objc_getAssociatedObject(self, &sectionKey) as? Int ?? 0
        }
        set {
            objc_setAssociatedObject(self, &sectionKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

extension UIPickerView {
    var section: Int {
        get {
            return objc_getAssociatedObject(self, &sectionKey) as? Int ?? 0
        }
        set {
            objc_setAssociatedObject(self, &sectionKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
