//
//  Add to Button.swift
//  Todo
//
//  Created by 佐藤航輔 on 2021/05/12.
//

import SwiftUI

struct Add_to_Button: View {
    
    var category: TodoEntity.Category
    @State var numberOfTasks = 0
    @State var showList = false
    @Environment(\.managedObjectContext) var viewContext
    @State var addNewtask = false
    
    fileprivate func update() {
        self.numberOfTasks = TodoEntity.count(in: self.viewContext,
                                              category: self.category)
    }
    
    var body: some View {
        
        Button(action: {
            self.addNewtask = true
        }) {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .scaledToFill()
                .frame(width: 30, height: 45)
        }.sheet(isPresented: $addNewtask, onDismiss: {self.update()}) {
            NewTask(category: self.category.rawValue)
                .environment(\.managedObjectContext, self.viewContext)
        }
    }
}

struct Add_to_Button_Previews: PreviewProvider {
    static let context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext
    static var previews: some View {
        VStack {
            Add_to_Button(category: .ImpUrg_1st)
                
        }.environment(\.managedObjectContext, context)
    }
}
