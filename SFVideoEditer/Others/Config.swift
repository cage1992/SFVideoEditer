//
//  Config.swift
//  cyh-swift
//
//  Created by shelleyimac on 16/9/30.
//  Copyright © 2016年 Sanfriend Technology Co. Ltd. All rights reserved.
//

import UIKit

let IOS_VERSION : Float! =  (UIDevice.current.systemVersion as NSString).floatValue
    
//MARK:  字体设置
let SD_FONT_SIZE_SMALL : CGFloat = 14.5


//MARK: 颜色设置
let UICOLOR_GOLD : UIColor = UIColor.rgbaColor(0xDCBA7FFF)

func SRGBColor(_ red: Float, _ green: Float, _ blue: Float) -> UIColor {
    return UIColor.init(colorLiteralRed: red/255, green: green/255, blue: blue/255, alpha: 1)
}

//MARK: 高度设置

let SD_TOP_NAV_HEIGHT : CGFloat! = UIApplication.shared.isStatusBarHidden ? 44 : 64   // 顶部导航条高度(含状态条)
let SD_SCREEN_WIDTH : CGFloat! = UIScreen.main.bounds.width
let SD_SCREEN_HEIGHT : CGFloat! = (UIDevice.current.systemVersion as NSString).floatValue > 7.0 ? UIScreen.main.bounds.height : UIScreen.main.bounds.height-20
let SD_SCREEN_HEIGHT_WITHNAV : CGFloat! = SD_SCREEN_HEIGHT - SD_TOP_NAV_HEIGHT

//MARK: 检测设备信息相关方法
/** 检测是模拟器/真机 */
struct Platform {
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
            isSim = true
        #endif
        return isSim
    }()
}

/**
 * 显示进度指示器
 */
var indicateLoader : UIActivityIndicatorView?
var loadingCover : UIView?

public func ShowLoading() {
    
    if loadingCover == nil  {
        loadingCover = UIView.init(frame: (UIApplication.shared.keyWindow?.bounds)!)
        loadingCover?.backgroundColor = .black
        loadingCover?.alpha = 0.7
        UIApplication.shared.keyWindow?.addSubview(loadingCover!)
    }
    
    if indicateLoader == nil {
        
        indicateLoader = UIActivityIndicatorView.init(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        indicateLoader?.centerX = ((loadingCover?.width)! - (indicateLoader?.width)!)/2
        indicateLoader?.centerY = ((loadingCover?.height)! - (indicateLoader?.height)!)/2
        indicateLoader?.activityIndicatorViewStyle = .whiteLarge;
        loadingCover?.addSubview(indicateLoader!)
    }
    
    indicateLoader?.isHidden = false
    indicateLoader?.startAnimating()
}

/**
 * 隐藏进度指示器
 */
public func HideLoading() {
    if loadingCover != nil  {
       loadingCover?.removeFromSuperview()
       loadingCover = nil
    }
    
    if indicateLoader != nil  {
        indicateLoader?.removeFromSuperview()
        indicateLoader = nil
    }
    
}

