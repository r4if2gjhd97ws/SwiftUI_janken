//
//  ContentView.swift
//  SwiftUI_janken
//
//  Created by ようへい on 2022/10/29.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
      VStack{
        Image("gu")
          .resizable()
          .aspectRatio(contentMode: .fit)
        Text("グー")
        Button {
          print("ジャンケンボタン押下")
        } label: {
          Text("じゃんけん")
        }

      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
