//
//  ContentView.swift
//  MyMusic
//
//  Created by Swift-Beginners on 2021/07/23.
//

import SwiftUI

struct ContentView: View {
    // 音を鳴らすためのSoundPlayerクラスのインスタンス生成
    let soundPlayer = SoundPlayer()
    
    var body: some View {
        ZStack {
            // 背景画像を表示する
            BackgroundView(imageName: "background")
            
            // 水平にレイアウト（横方向にレイアウト）
            HStack {
                // シンバルボタン
                Button(action: {
                    // ボタンをタップしたときのアクション
                    // シンバルの音を鳴らす
                    soundPlayer.cymbalPlay()
                }) {
                    // 画像を表示する
                    Image("cymbal")
                } // シンバルボタン ここまで
                
                // ギターボタン
                Button(action: {
                    // ボタンをタップしたときのアクション
                    // ギターの音を鳴らす
                    soundPlayer.guitarPlay()
                }) {
                    // 画像を表示する
                    Image("guitar")
                } // ギターボタン ここまで
            } // HStack ここまで
        } // ZStack ここまで
    } // body ここまで
} // ContentView ここまで

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
