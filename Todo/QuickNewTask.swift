//
//  QuickNewTask.swift
//  Todo
//
//  Created by 佐藤航輔 on 2021/05/07.
//

import SwiftUI

struct QuickNewTask: View {
    
    let category: TodoEntity.Category
    
    @State private var newTask: String = ""
    @Environment(\.managedObjectContext) var viewContext
    
    fileprivate func addNewTask() {
        TodoEntity.create(in: self.viewContext,
                          category: self.category,
                          task: self.newTask)
        self.newTask = ""
    }
    
    fileprivate func cancelTask() {
        self.newTask = ""
    }
    
    
    var body: some View {
        
        HStack {
            TextField("新しいタスク", text: $newTask,
                      onCommit: {
                        self.newTask = ""
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                    self.addNewTask()
            }) {
                Text("追加")
            }
            Button(action: {
                    self.cancelTask()
            }) {
                Text("キャンセル")
                    .foregroundColor(.red)
            }
        }
    }
}

struct QuickNewTask_Previews: PreviewProvider {
    static let context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext
    static var previews: some View {
        QuickNewTask(category: .ImpUrg_1st)
            .environment(\.managedObjectContext, context)
    }
}
