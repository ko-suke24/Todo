//
//  UIApplication+Extension.swift
//  Todo
//
//  Created by 佐藤航輔 on 2021/05/10.
//

import SwiftUI

extension UIApplication {
    func closeKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder),
                   to: nil,
                   from: nil,
                   for: nil)
    }
}
