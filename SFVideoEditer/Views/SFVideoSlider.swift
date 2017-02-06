//
//  CYHVideoSlider.swift
//  cyh-swift
//
//  Created by shelleyimac on 16/11/18.
//  Copyright © 2016年 Sanfriend Technology Co. Ltd. All rights reserved.
//

import UIKit

class SFVideoSlider: UISlider {

    override func thumbRect(forBounds bounds: CGRect, trackRect rect: CGRect, value: Float) -> CGRect {
        var newRect = CGRect.init(x: rect.origin.x, y: rect.origin.y, width: rect.size.width, height: rect.size.height)
        newRect.origin.x = rect.origin.x - 10
        newRect.size.width = rect.size.width + 20
        
        return super.thumbRect(forBounds: bounds, trackRect: newRect, value: value).insetBy(dx: 10, dy: 10)
    }

//MARK: 改变进度条高度
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x , y: bounds.origin.y, width: bounds.size.width, height: bounds.size.height + 2)
    }
    
}
