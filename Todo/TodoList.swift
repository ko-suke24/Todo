//
//  TodoList.swift
//  Todo
//
//  Created by 佐藤航輔 on 2021/05/07.
//

import SwiftUI
import CoreData

struct TodoList: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TodoEntity.data, ascending: true)],
        animation: .default)
    private var todoList: FetchedResults<TodoEntity>
    let category: TodoEntity.Category
    
    private func deleteTodo(at offsets: IndexSet) {
        for index in offsets {
            let entity = todoList[index]
            viewContext.delete(entity)
            saveData()
        }
    }
    
    private func move(from source: IndexSet, to destination: Int) {
        if source.first! > destination {
            todoList[source.first!].data = todoList[destination].data - 1
            for i in destination...todoList.count - 1 {
                todoList[i].data = todoList[i].data + 1
            }
        }
        if source.first! < destination {
            todoList[source.first!].data = todoList[destination - 1].data + 1
            for i in 0...destination - 1 {
                todoList[i].data = todoList[i].data - 1
            }
        }
      saveData()
    }
        
    private func saveData() {
        try? self.viewContext.save()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(todoList, id: \.id) { todo in
                        if todo.category == self.category.rawValue {
                            NavigationLink(destination: EditTask(todo: todo))
                            {
                                TodoDetailRow(todo: todo, hideIcon: true)
                            }
                        }
                    }
                    .onDelete(perform: deleteTodo)
                    .onMove(perform: move)
                }
                .toolbar {
                    EditButton()
                }
                QuickNewTask(category: category)
            }
            .navigationTitle(category.toString())
        }
    }
}

struct TodoList_Previews: PreviewProvider {
    static let container = (UIApplication.shared.delegate as! AppDelegate)
    .persistentContainer
    static let context = container.viewContext
    
    static var previews: some View {
        // テストデータの全削除
        let request = NSBatchDeleteRequest(
            fetchRequest: NSFetchRequest(entityName: "TodoEntity"))
        try! container.persistentStoreCoordinator.execute(request,
                                                          with: context)
        
        // データを追加
        TodoEntity.create(in: context,
                          category: .ImpUrg_1st, task: "炎上プロジェクト")
        TodoEntity.create(in: context,
                          category: .ImpNUrg_2nd, task: "自己啓発")
        TodoEntity.create(in: context,
                          category: .NImpUrg_3rd, task: "意味のない会議")
        TodoEntity.create(in: context,
                          category: .NImpNUrg_4th, task: "暇つぶし")

        return TodoList(category: .ImpUrg_1st)
            .environment(\.managedObjectContext, context)
    }
}
