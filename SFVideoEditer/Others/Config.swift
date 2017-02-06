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
let SD_FONT_SIZE_XXSMALL : CGFloat = 11.5
let SD_FONT_SIZE_XSMALL : CGFloat = 13
let SD_FONT_SIZE_SMALL : CGFloat = 14.5
let SD_FONT_SIZE_TEXT : CGFloat = 16
let SD_FONT_SIZE_BODY : CGFloat = 16
let SD_FONT_SIZE_SUBTITLE : CGFloat = 17.5
let SD_FONT_SIZE_TITLE : CGFloat = 19
let SD_FONT_SIZE_NORMAL : CGFloat = 19
let SD_FONT_SIZE_SYSTEM	: CGFloat = 20
let SD_FONT_SIZE_NAVIGATION : CGFloat = 21
let SITEM_HEIGHT : CGFloat = 40

//MARK: 颜色设置
let UICOLOR_GOLD : UIColor = UIColor.rgbaColor(0xDCBA7FFF)
let UICOLOR_GOLD_BG : UIColor = UIColor.rgbaColor(0xe4c694FF)
let UICOLOR_BG : UIColor = UIColor.rgbaColor(0x2d2d2dff)

let SCOLOR_ITEM_BG : UIColor = UIColor.rgbaColor(0xeaece0ff)
let SCOLOR_ITEM_BG_LIGHT : UIColor = UIColor.rgbaColor(0xfcf7efee)
let SCOLOR_BG : UIColor = UIColor.rgbaColor(0xfffcf4ff)

let SCOLOR_LABEL_TXT : UIColor = UIColor.rgbaColor(0x705334ff)
let SCOLOR_SEPERATOR : UIColor = UIColor.rgbaColor(0xcec3b3ff)
let SCOLOR_BLACK : UIColor = UIColor.rgbaColor(0x000000ff)
let SCOLOR_GOLDEN : UIColor = UIColor.rgbaColor(0xff9f35ff)

func SRGBColor(_ red: Float, _ green: Float, _ blue: Float) -> UIColor {
    return UIColor.init(colorLiteralRed: red/255, green: green/255, blue: blue/255, alpha: 1)
}


//MARK: 高度设置
let SD_STATUS_BAR_HALF_HEIGHT : CGFloat! = 10
let SD_STATUS_BAR_HEIGHT : CGFloat! = 20 	// 状态条高度
let SD_SEARCHBAR_OFFSET_Y : CGFloat! = 44	// 搜索条移动高度
let SD_BOTTOM_BTN_HEIGHT : CGFloat! = 44
let SD_TABBAR_HEIGHT : CGFloat! = 49
let SD_TOP_NAV_HEIGHT : CGFloat! = UIApplication.shared.isStatusBarHidden ? 44 : 64   // 顶部导航条高度(含状态条)
let SD_NAV_ONLY_HEIGHT : CGFloat! = 10
let SD_TOP_PADDING : CGFloat! = UIApplication.shared.isStatusBarHidden ? 5 : ((UIDevice.current.systemVersion as NSString).floatValue >= 7.0 ? 24 : 4)
let SD_WRAPPER_WIDTH : CGFloat! = UIScreen.main.bounds.size.width - 20
let SD_WRAPPER_X : CGFloat! = 10

let SD_SCREEN_WIDTH : CGFloat! = UIScreen.main.bounds.width
let SD_SCREEN_HEIGHT : CGFloat! = (UIDevice.current.systemVersion as NSString).floatValue > 7.0 ? UIScreen.main.bounds.height : UIScreen.main.bounds.height-20
let SD_SCREEN_HEIGHT_WITHNAV : CGFloat! = SD_SCREEN_HEIGHT - SD_TOP_NAV_HEIGHT
let SD_SCREEN_CENTER_Y : CGFloat! = UIScreen.main.bounds.size.height / 2
let SD_SCREEN_CENTER_X : CGFloat! = UIScreen.main.bounds.size.width / 2

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
        loadingCover?.alpha = 0.9
        UIApplication.shared.keyWindow?.addSubview(loadingCover!)
    }
    
    if indicateLoader == nil {
        indicateLoader?.backgroundColor = .red
        indicateLoader = UIActivityIndicatorView.init(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        indicateLoader?.centerX = ((loadingCover?.width)! - (indicateLoader?.width)!)/2
        indicateLoader?.centerY = ((loadingCover?.height)! - (indicateLoader?.height)!)/2
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
    
    indicateLoader?.isHidden = true
    indicateLoader?.stopAnimating()
    
}

