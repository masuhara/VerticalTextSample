//
//  VerticalWritingLabel.swift
//  VerticalWritingSample
//
//  Created by Masuhara on 2019/03/09.
//  Copyright © 2019 Ylab.inc. All rights reserved.
//

import UIKit
import CoreText

class VerticalWritingLabel: UILabel {
    
    override var text: String? {
        didSet {
            if let text = text {
                print("Text changed.\(text)")
            } else {
                print("Text not changed.")
            }
        }
    }

    override func draw(_ rect: CGRect) {
        // super.draw(rect)
        
        verticalize(rect: rect)
    }

    
    func verticalize(rect: CGRect) {
        // Drawing code
        let context:CGContext = UIGraphicsGetCurrentContext()!
        
        context.translateBy(x: 0, y: 0) //座標中心を左上にする。
        context.scaleBy(x: 1.0, y: -1.0) // 反転させる。（これをしないと文字が逆になる）
        context.textMatrix = CGAffineTransform.identity // それまでの修飾をクリア？
        context.rotate(by: -CGFloat(Double.pi/2)) // 文字だけで無く文章が縦になるように、領域を90度回転する。
        
        // 描画したい領域を作成
        // とりあえず、画面いっぱい近く
        let path:CGMutablePath = CGMutablePath();
        let bounds:CGRect = CGRect(x: 0.0, y: 0.0, width: rect.size.height - 50.0 , height: rect.size.width - 50.0) // 回転しているので、高さと幅を入れ換えているのに注意
        path.addRect(bounds)
        
        print(path)
        
        // 修飾用の準備
        let attrString: CFMutableAttributedString = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0)
        CFAttributedStringReplaceString(attrString, CFRangeMake(0, 0), self.text! as CFString)
        
        // 縦書きにする
        CFAttributedStringSetAttribute(attrString, CFRangeMake(0, self.text!.count), kCTVerticalFormsAttributeName, true as CFTypeRef)
        
        // 行間を詰める
        var height = 23.0
        let settings = [
            CTParagraphStyleSetting(
                spec: .minimumLineHeight,
                valueSize: Int(MemoryLayout.size(ofValue: height)),
                value: &height),
            CTParagraphStyleSetting(
                spec: .maximumLineHeight,
                valueSize: Int(MemoryLayout.size(ofValue: height)),
                value: &height)
        ]
        let style = CTParagraphStyleCreate(settings, Int(settings.count))
        CFAttributedStringSetAttribute(attrString, CFRangeMake(0, self.text!.count), kCTParagraphStyleAttributeName, style as CFTypeRef)
        
        //修飾の指定
        //ここではフォントサイズ設定
        let font = UIFont.systemFont(ofSize: 20)
        CFAttributedStringSetAttribute(attrString, CFRangeMake(0, self.text!.count), kCTFontAttributeName, font)
        
        let framesetter: CTFramesetter = CTFramesetterCreateWithAttributedString(attrString);
        
        let frame:CTFrame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0, 0), path, nil);
        
        // 上記の内容を描画
        CTFrameDraw(frame, context)
    }
}
