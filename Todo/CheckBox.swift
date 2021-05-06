//
//  CheckBox.swift
//  Todo
//
//  Created by 佐藤航輔 on 2021/05/06.
//

import SwiftUI

struct CheckBox: View {
    @Binding var checked: Bool = true
    var body: some View {
        Image(systemName: checked ? "checkmark.circle" : "circle")
            .onTapGesture {
                self.checked.toggle()
            }
    }
}

struct CheckBox_Previews: PreviewProvider {
    static var previews: some View {
        CheckBox()
    }
}
