//
//  CheckBox.swift
//  Todo
//
//  Created by 佐藤航輔 on 2021/05/06.
//

import SwiftUI

struct CheckBox<Label>: View where Label: View {
    @Binding var checked: Bool
    
    private var label: ()-> Label
    
    public init(checked: Binding<Bool>,
                @ViewBuilder label: @escaping () -> Label) {
        self._checked = checked
        self.label = label
    }
    
    var body: some View {
        HStack {
            Image(systemName: checked ? "checkmark.circle" : "circle")
                .resizable()
                .frame(width: 20, height: 20)
                .onTapGesture {
                    self.checked.toggle()
            }
            label()
        }
    }
}

struct CheckBox_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CheckBox(checked: .constant(true)) {
                Text("牛乳を買う")
            }
            CheckBox(checked: .constant(false)) {
                Text("牛乳を買う")
            }
        }
    }
}
