//
//  TakeVideoViewController.swift
//  cyh-swift
//
//  Created by shelleyimac on 16/11/18.
//  Copyright © 2016年 Sanfriend Technology Co. Ltd. All rights reserved.
//

import UIKit
import MobileCoreServices

enum VideoQuality {
    case QualityLow
    case QualityMedium
    case QualityHighest
    case Quality4K
}

class TakeVideoViewController: UIViewController, SCRecorderDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//MARK: 公开属性
    
    /**
     自定义 video分辨率 不能超过设备录像的最大分辨率
     默认 CGSizeZero
     */
    var videoSize: CGSize
    
    /**
     当 为true并且 videoSize = CGSizeZero 时，视频尺寸设置为正方形， 边长为宽或者高较小的一方
     默认 false
     */
    var videoSizeAsSquare : Bool
    
    /**
     当 videoSize = CGSizeZero 时 设置视频质量
     QualityLow --> 640x480
     QualityMedium --> 1280x720
     QualityHighest --> 1920x1080
     Quality4K --> 3840x2160 (4K)
     默认 QualityMedium
     */
    var videoQuality : VideoQuality
    
//MARK: 私有属性
    //SCRecorder相关
   private var videoRecorder : SCRecorder
   
    //UI界面
   private var preView : UIView!
   private var videoSlider : SFVideoSlider!
   private var takeVideoBtn : UIButton!
   private var confirmBtn : UIButton!
   private var timeLabel : UILabel!
    
    //其他
   private var imagePicker : UIImagePickerController!

    init() {
        videoSize = CGSize.zero
        videoSizeAsSquare = false
        videoQuality = VideoQuality.QualityMedium
        videoRecorder = SCRecorder.init()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UICOLOR_GOLD
        
        loadUI()
        
        if Platform.isSimulator{ //模拟器
           let alert = UIAlertView.init(title: "模拟器", message: "摄像头不可用", delegate: self, cancelButtonTitle: "确定")
           alert.show()
            return
        }
        
        if videoSize == CGSize.zero {
            videoRecorder.videoConfiguration.sizeAsSquare = videoSizeAsSquare
            videoRecorder.videoConfiguration.preset = self.getVideoQuality()
        }else {
            videoRecorder.videoConfiguration.size = videoSize
            videoRecorder.videoConfiguration.sizeAsSquare = false
        }
      //  videoRecorder.captureSessionPreset = AVCaptureSessionPreset1280x720

        videoRecorder.session = nil
        videoRecorder.delegate = self
        videoRecorder.previewView = preView
        
        imagePicker = UIImagePickerController.init()
        imagePicker.delegate = self
        
        videoRecorder.startRunning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        videoRecorder.session = SCRecordSession.init()
        updateTimeRecordedLabel()
        confirmBtn.isEnabled = false
        print("---------viewWillDisappear")
    }
    

//MARK: 加载UI界面
    private func loadUI() {
        preView = UIView.init(frame: CGRect(x: 0, y: 0, width: SD_SCREEN_WIDTH, height: SD_SCREEN_WIDTH))
        self.view.addSubview(preView)
      
        let operationView = UIView.init()
        self.view.addSubview(operationView)
        operationView.snp.makeConstraints { (make) in
            make.left.equalTo(preView)
            make.top.equalTo(preView.snp.bottom)
            make.bottom.equalTo(self.view)
            make.right.equalTo(self.view)
        }
        
        videoSlider = SFVideoSlider.init()
        operationView.addSubview(videoSlider)
        videoSlider.snp.makeConstraints { (make) in
            make.left.equalTo(operationView)
            make.top.equalTo(operationView)
            make.size.equalTo(CGSize(width: SD_SCREEN_WIDTH, height: 4))
        }
        videoSlider.thumbTintColor = .clear
        videoSlider.tintColor = UICOLOR_GOLD
        videoSlider.value = 0
        
        let middlePoint = UIView.init()
        operationView.addSubview(middlePoint)
        middlePoint.snp.makeConstraints { (make) in
            make.left.equalTo(videoSlider).offset(SD_SCREEN_WIDTH*7/16)
            make.top.equalTo(operationView)
            make.size.equalTo(CGSize(width: 3, height: 6))
        }
        middlePoint.backgroundColor = UICOLOR_GOLD
        
        timeLabel = UILabel.init()
        operationView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(operationView)
            make.top.equalTo(operationView).offset(10)
            make.size.equalTo(CGSize(width: SD_SCREEN_WIDTH, height: 30))
        }
        timeLabel.textAlignment = .center
        timeLabel.backgroundColor = .clear
        timeLabel.textColor = UICOLOR_GOLD
        timeLabel.font = UIFont.systemFont(ofSize: SD_FONT_SIZE_SMALL)
        
        takeVideoBtn = UIButton.init()
        operationView.addSubview(takeVideoBtn)
        takeVideoBtn.snp.makeConstraints { (make) in
            make.center.equalTo(operationView)
            make.size.equalTo(CGSize(width: 90, height: 90))
        }
        takeVideoBtn.size = CGSize(width: 90, height: 90)
        takeVideoBtn.layer.cornerRadius = takeVideoBtn.width / 2
        takeVideoBtn.layer.masksToBounds = true
        takeVideoBtn.setTitle("按住拍")
       
        takeVideoBtn.addGestureRecognizer(UILongPressGestureRecognizer.init(target: self, action:#selector(touchTakeVideoBtn)))
        takeVideoBtn.setBackgroundImage(UIImage.init(color: UICOLOR_GOLD), for: .normal)
        takeVideoBtn.setBackgroundImage(UIImage.init(color: .lightGray), for: .disabled)
        takeVideoBtn.setTitleColor(.black)
        
        let localVideoBtn = UIButton.init()
        operationView.addSubview(localVideoBtn)
        localVideoBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(operationView).multipliedBy(0.5).offset(-20)
            make.centerY.equalTo(operationView)
            make.size.equalTo(CGSize(width: 60, height: 60))
        }
        localVideoBtn.setBackgroundImage(UIImage.init(named: "pub-video"), for: .normal)
        localVideoBtn.addTarget(self, action: #selector(useLocalVideo), for: .touchUpInside)
        
        let localVideoL = UILabel.init()
        operationView.addSubview(localVideoL)
        localVideoL.snp.makeConstraints { (make) in
            make.centerX.equalTo(localVideoBtn)
            make.top.equalTo(localVideoBtn.snp.bottom)
            make.size.equalTo(CGSize(width: 60, height: 20))
        }
        localVideoL.text = "本地视频"
        localVideoL.textAlignment = .center
        localVideoL.textColor = UICOLOR_GOLD
        localVideoL.font = UIFont.systemFont(ofSize: SD_FONT_SIZE_SMALL)
        
        confirmBtn = UIButton.init()
        confirmBtn.size = CGSize(width: 60, height: 60)
        operationView.addSubview(confirmBtn)
        confirmBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(operationView).multipliedBy(1.5).offset(20)
            make.centerY.equalTo(takeVideoBtn)
            make.size.equalTo(CGSize(width: 60, height: 60))
        }
        confirmBtn.layer.cornerRadius = confirmBtn.width / 2
        confirmBtn.layer.masksToBounds = true
        confirmBtn.setTitle("确定")
        confirmBtn.setTitleColor(.black)
        confirmBtn.setBackgroundImage(UIImage.init(color: .lightGray), for: .disabled)
        confirmBtn.setBackgroundImage(UIImage.init(color: UICOLOR_GOLD), for: .normal)
        confirmBtn.addTarget(self, action: #selector(gotoEditVideo), for: .touchUpInside)
        
     //   let reverseCarmeraItem = UIBarButtonItem.init(title: "切换镜头", style: .plain, target: self, action: #selector(reverseCarmera))
        
        let reverseCarmeraItem = UIBarButtonItem.init(barButtonSystemItem: .camera, target: self, action: #selector(reverseCarmera))
       
      //  reverseCarmeraItem.setTitleTextAttributes([NSForegroundColorAttributeName: UICOLOR_GOLD], for: .normal)
        self.navigationItem.rightBarButtonItem = reverseCarmeraItem
        
//        let negativeSpacer = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
//        negativeSpacer.width = -10
//        
//        self.navigationItem.rightBarButtonItems = [negativeSpacer, reverseCarmeraItem]
    }
    
    func getVideoQuality() -> String {
        switch videoQuality {
        case VideoQuality.QualityLow:
            return SCPresetLowQuality
            
        case VideoQuality.QualityMedium:
            return SCPresetMediumQuality
            
        case VideoQuality.QualityHighest:
            return SCPresetHighestQuality
            
        case VideoQuality.Quality4K:
            return SCPreset4KQuality
        }
    }
    
    @objc private func touchTakeVideoBtn(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {  //开始拍摄
            videoRecorder.record()
        }else if sender.state == .ended { //结束拍摄
            videoRecorder.pause()
        }        
    }

//MARK: 使用本地视频的操作
    @objc private func useLocalVideo() {
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = [kUTTypeMovie as String]
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @objc private func gotoEditVideo() {
        if videoRecorder.session == nil { return }
        
        if CMTimeGetSeconds(videoRecorder.session!.duration) > 16 || CMTimeGetSeconds(videoRecorder.session!.duration) < 7 {
            let alert = UIAlertView.init(title: "提示", message: "视频时长: 7至15秒", delegate: self, cancelButtonTitle: "确定")
            alert.show()
            videoRecorder.session?.removeAllSegments()
            confirmBtn.isEnabled = false
            return
        }
        
        let editVideoVC = EditVideoViewController.init()
        editVideoVC.recordSession = videoRecorder.session
        self.navigationController?.pushViewController(editVideoVC, animated: true)
    }

    @objc private func reverseCarmera() {
        videoRecorder.switchCaptureDevices()
    }
    
//MARK:更新拍摄时长
    private func updateTimeRecordedLabel() {
        var currentTime = kCMTimeZero
        if videoRecorder.session != nil {
            currentTime = videoRecorder.session!.duration;
        }
        
        if CMTimeGetSeconds(currentTime) >= 7 { //拍摄时长超过7秒，确定按钮可用
            confirmBtn.isEnabled = true
        }
        
        if CMTimeGetSeconds(currentTime) >= 15.9 { //拍摄时长超过16秒，拍摄停止
            videoRecorder.pause()
            takeVideoBtn.isEnabled = false
        }
        
        videoSlider.value = Float(CMTimeGetSeconds(currentTime)) / 15.9
        timeLabel.text = String.init(format: "%.1f秒", CMTimeGetSeconds(currentTime))
    }
    
//MARK: SCRecorder - delegate
    func recorder(_ recorder: SCRecorder, didAppendVideoSampleBufferIn session: SCRecordSession) {
        updateTimeRecordedLabel()
    }
    
//MARK: UIImagePickerController - delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker .dismiss(animated: true, completion: nil)
        
        if let videoUrl = info[UIImagePickerControllerMediaURL] as? URL {
            let segment = SCRecordSessionSegment.init(url: videoUrl, info: nil)
            videoRecorder.session?.removeAllSegments()
            videoRecorder.session?.addSegment(segment)
        }
        
        //去视频编辑界面
        gotoEditVideo()
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
