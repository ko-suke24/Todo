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
//            Color.tBackground
//                .edgesIgnoringSafeArea(.top)
//                .frame(height:0)
//            UserView(image: Image("profile"), userName: "aaaa")
            TaskToday()
                .frame(width: 330, height: 250)
            
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
            }.frame(width: 300, height: 300)
            .padding()
            Spacer()
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
