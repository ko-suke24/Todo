//
//  ContentView.swift
//  Todo
//
//  Created by 佐藤航輔 on 2021/05/06.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            TaskToday()
                .frame(width: 330, height: 230)
                .padding(EdgeInsets(top: 30, leading: 10, bottom: 0, trailing: 10))
            Spacer()
            VStack(spacing: 5) {
                HStack(spacing: 0) {
                    CategoryView(category: .ImpUrg_1st)
                    Spacer()
                    CategoryView(category: .ImpNUrg_2nd)
                }
                Spacer()
                HStack(spacing: 0) {
                    CategoryView(category: .NImpUrg_3rd)
                    Spacer()
                    CategoryView(category: .NImpNUrg_4th)
                }
            }.frame(width: 300, height: 250)
            .padding(EdgeInsets(top: 50, leading: 30, bottom: 0, trailing: 30))
            Spacer()
            HStack {
                Spacer()
                Add_to_Button(category: .ImpUrg_1st)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 30))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext

    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, context)
    }
}
