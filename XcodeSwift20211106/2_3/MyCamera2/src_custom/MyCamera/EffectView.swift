//
//  EffectView.swift
//  EffectView
//
//  Created by Swift-Beginners.
//

import SwiftUI

// フィルタ名を列挙した配列（Array）
// 0.モノクロ
// 1.Chrome
// 2.Fade
// 3.Instant
// 4.Noir
// 5.Process
// 6.Tonal
// 7.Transfer
// 8.SepiaTone
let filterArray = ["CIPhotoEffectMono",
                   "CIPhotoEffectChrome",
                   "CIPhotoEffectFade",
                   "CIPhotoEffectInstant",
                   "CIPhotoEffectNoir",
                   "CIPhotoEffectProcess",
                   "CIPhotoEffectTonal",
                   "CIPhotoEffectTransfer",
                   "CISepiaTone"
]

// 選択中のエフェクト（filterArrayの添字）
var filterSelectNumber = 0

struct EffectView: View {
    // エフェクト編集画面（sheet）の開閉状態を管理
    @Binding var isShowSheet: Bool
    // 撮影した写真
    let captureImage: UIImage
    // 表示する写真
    @State var showImage: UIImage?
    // シェア画面（sheet）の開閉状態を管理
    @State var isShowActivity = false
    
    var body: some View {
        // 縦方向にレイアウト
        VStack {
            // スペースを追加
            Spacer()
            
            if let unwrapShowImage = showImage {
                // 表示する写真がある場合は画面に表示
                Image(uiImage: unwrapShowImage)
                    // リサイズする
                    .resizable()
                    // アスペクト比（縦横比）を維持して画面内に
                    // 収まるようにする
                    .aspectRatio(contentMode: .fit)
            }
            
            // スペースを追加
            Spacer()
            // 「エフェクト」ボタン
            Button(action: {
                // ボタンをタップしたときのアクション
                // フィルタ名を配列から取得
                let filterName = filterArray[filterSelectNumber]
                
                // 次回に適用するフィルタを決めておく
                filterSelectNumber += 1
                // 最後のフィルタまで適用した場合
                if filterSelectNumber == filterArray.count {
                    // 最後の場合は、最初のフィルタに戻す
                    filterSelectNumber = 0
                }
                
                // 元々の画像の回転角度を取得
                let rotate = captureImage.imageOrientation
                // UIImage形式の画像をCIImage形式に変換
                let inputImage = CIImage(image: captureImage)
                
                // フィルタの種別を引数で指定された種類を
                // 指定してCIFilterのインスタンスを取得
                guard let effectFilter =
                    CIFilter(name: filterName) else {
                    return
                }
                // フィルタ加工のパラメータを初期化
                effectFilter.setDefaults()
                // インスタンスにフィルタ加工する元画像を設定
                effectFilter.setValue(
                    inputImage, forKey: kCIInputImageKey)
                // フィルタ加工を行う情報を生成
                guard let outputImage =
                    effectFilter.outputImage else {
                    return
                }
                // CIContextのインスタンスを取得
                let ciContext = CIContext(options: nil)
                // フィルタ加工後の画像をCIContext上に描画し、
                // 結果をcgImageとしてCGImage形式の画像を取得
                guard let cgImage =
                    ciContext.createCGImage(
                        outputImage, from: outputImage.extent)
                    else {
                    return
                }
                // フィルタ加工後の画像をCGImage形式から
                // UIImage形式に変更。その際に回転角度を指定。
                showImage = UIImage(cgImage: cgImage,
                            scale: 1.0,
                            orientation: rotate)
            }) {
                // テキストを表示する
                Text("エフェクト")
                    // 横幅いっぱい
                    .frame(maxWidth: .infinity)
                    // 高さ50ポイントを指定
                    .frame(height: 50)
                    // 文字列をセンタリング指定
                    .multilineTextAlignment(.center)
                    // 背景を青色に指定
                    .background(Color.blue)
                    // 文字色を白色に指定
                    .foregroundColor(Color.white)
            } // 「エフェクト」ボタンここまで
            
            // スペースを追加
            .padding()
            // 「シェア」ボタン
            Button(action: {
                // ボタンをタップしたときのアクション
                // UIActivityViewControllerを表示する
                isShowActivity = true
            }) {
                // テキストを表示する
                Text("シェア")
                    // 横幅いっぱい
                    .frame(maxWidth: .infinity)
                    // 高さ50ポイントを指定
                    .frame(height: 50)
                    // 文字列をセンタリング指定
                    .multilineTextAlignment(.center)
                    // 背景を青色に指定
                    .background(Color.blue)
                    // 文字色を白色に指定
                    .foregroundColor(Color.white)
            } // 「シェア」ボタンここまで
            .sheet(isPresented: $isShowActivity) {
                // UIActivityViewControllerを表示する
                ActivityView(shareItems: [showImage!])
            }
            // スペースを追加
            .padding()
            // 「閉じる」ボタン
            Button(action: {
                // ボタンをタップしたときのアクション
                // エフェクト編集画面を閉じる
                isShowSheet = false
            }) {
                // テキストを表示する
                Text("閉じる")
                    // 横幅いっぱい
                    .frame(maxWidth: .infinity)
                    // 高さ50ポイントを指定
                    .frame(height: 50)
                    // 文字列をセンタリング指定
                    .multilineTextAlignment(.center)
                    // 背景を青色に指定
                    .background(Color.blue)
                    // 文字色を白色に指定
                    .foregroundColor(Color.white)
            } // 「閉じる」ボタンここまで
            // スペースを追加
            .padding()
  
        } // VStackここまで
        // 写真が表示されるときに実行される
        .onAppear {
            // 撮影した写真を表示する写真に設定
            showImage = captureImage
        } // .onAppearここまで
        
    } // bodyここまで
} // EffectViewここまで

struct EffectView_Previews: PreviewProvider {
    static var previews: some View {
        EffectView(
            isShowSheet: Binding.constant(true),
            captureImage: UIImage(named: "preview_use")!)
    }
}
