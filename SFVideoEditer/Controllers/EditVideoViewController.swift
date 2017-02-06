//
//  EditVideoViewController.swift
//  cyh-swift
//
//  Created by shelleyimac on 16/11/21.
//  Copyright © 2016年 Sanfriend Technology Co. Ltd. All rights reserved.
//

import UIKit

class EditVideoViewController: UIViewController, SCPlayerDelegate, UITableViewDelegate, UITableViewDataSource {

    //SCPlayer相关
   private var videoPlayer : SCPlayer!
   var recordSession : SCRecordSession?
   private var newVideoUrl : URL!
   private var exportSession : SCAssetExportSession!
   private var mixOutPutUrl : URL?
   private var mixAssetExportSession : SCAssetExportSession?
   private var exportUrl : URL!
    
    //UI相关
   private var replayBtn : UIButton!
   private var playSlider : SFVideoSlider!
   private var musicTableView : UITableView!
    
    //bgMusic相关
   private let selectImgTag = 1000
   private var selectedFlag = 0
   private var bgMusicPlayer : AVAudioPlayer!
   private var bgMusicUrl : URL?
   private var bgMusicArray : [(String,URL)] = Array.init()
   private let bgMusicIdentifier = "bgMusicCell"
   private let unselectImage = UIImage.init(named: "icon-check")
   private let selectedImage = UIImage.init(named: "icon-checked")
   
    //其他
   private var isfromShengHuo : Bool? = false
   private var sliderTimer : Timer!
   private var signStr : String!
   private var thumbnail : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .black;
        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.tintColor = UICOLOR_GOLD
        
        let commitBarBtn = UIBarButtonItem.init(title: "提交", style: .plain, target: self, action: #selector(exportVideo))
        self.navigationItem.rightBarButtonItem = commitBarBtn
        
        videoPlayer = SCPlayer.init()
        videoPlayer.delegate = self
        bgMusicPlayer = AVAudioPlayer.init()
        
        loadUI()
        loadMusicData()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ShowLoading()
        preViewVideo()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopBGMsicPlayer()
    }

//MARK: 加载UI数据
    private func loadUI() {
        let playerView = SCVideoPlayerView.init(player: videoPlayer)
        self.view.addSubview(playerView)
        playerView.playerLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerView.frame = CGRect(x: 0, y: 0, width: SD_SCREEN_WIDTH, height: SD_SCREEN_WIDTH)
        
        replayBtn = UIButton.init()
        playerView.addSubview(replayBtn)
        replayBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(playerView)
            make.centerY.equalTo(playerView).offset(23)
            make.size.equalTo(CGSize(width: 60, height: 60))
        }
        replayBtn.setBackgroundImage(UIImage.init(named: "icn_play_big"), for: .normal)
        replayBtn.addTarget(self, action: #selector(replayVideo), for: .touchUpInside)
        replayBtn.isHidden = true
        
        let bgMusicHeight : CGFloat = 44
        musicTableView = UITableView.init(frame: CGRect(x: 0, y: SD_SCREEN_WIDTH + bgMusicHeight, width: SD_SCREEN_WIDTH, height: SD_SCREEN_HEIGHT_WITHNAV-SD_SCREEN_WIDTH))
        self.view.addSubview(musicTableView)
        musicTableView.delegate = self
        musicTableView.dataSource = self
        musicTableView.backgroundColor = .black
        musicTableView.separatorStyle = .none
        musicTableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: bgMusicIdentifier)
        
        let titleL = UILabel.init(frame: CGRect(x: 0, y: SD_SCREEN_WIDTH, width: SD_SCREEN_WIDTH, height: bgMusicHeight))
        self.view.addSubview(titleL)
        titleL.text = " 背景音乐"
        titleL.textColor = UICOLOR_GOLD
        titleL.setBorderBottomColor(UIColor.rgbaColor(0xffffff33), andWidth: 1)
        
        playSlider = SFVideoSlider.init()
        titleL.addSubview(playSlider)
        playSlider.snp.makeConstraints { (make) in
            make.top.equalTo(titleL)
            make.left.equalTo(titleL)
            make.size.equalTo(CGSize(width: SD_SCREEN_WIDTH, height: 4))
        }
        playSlider.tintColor = UICOLOR_GOLD
        playSlider.isUserInteractionEnabled = false
        playSlider.thumbTintColor = .clear
        playSlider.value = 0
        playSlider.maximumValue = Float(CMTimeGetSeconds((recordSession?.duration)!))
    }

//MARK: 加载音乐数据
    private func loadMusicData() {
        if let bgMusicName: [String] = NSArray.init(contentsOfFile: Bundle.main.path(forResource: "BGM", ofType: ".plist")!) as? [String] {
            
            for name in bgMusicName {
                if  let bgMusicUrl = Bundle.main.url(forResource: name, withExtension: ".mp3") {
                    bgMusicArray.append((name,bgMusicUrl))
                }
            }
            
        }
 
        
    }
    
//MARK: 首次播放视频
    private func preViewVideo() {
        if recordSession == nil {
            let alert = UIAlertView.init(title: "提示", message: "视频出错，请重试", delegate: self, cancelButtonTitle: "确定")
            alert.show()
            return
        }
        newVideoUrl = URL.init(fileURLWithPath: NSHomeDirectory() + String.init(format: "/Library/Caches/%@.mp4", getVideoName()))
        
        exportSession = SCAssetExportSession.init(asset: recordSession!.assetRepresentingSegments())
        exportSession.outputFileType = AVFileTypeMPEG4
      //  exportSession.videoConfiguration.sizeAsSquare = true
        exportSession.videoConfiguration.keepInputAffineTransform = false
        exportSession.outputUrl = newVideoUrl
        exportSession.exportAsynchronously {[unowned self]  in
            self.sliderTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.updateSlider), userInfo: nil, repeats: true)
            RunLoop.current.add(self.sliderTimer, forMode: .commonModes)
            self.replayVideo()
            HideLoading()
           
        }
    }
    
    //获取视频文件名称(uid + time)
    private func getVideoName() -> String {
        let formetter = DateFormatter.init()
        formetter.dateFormat = "_yyyyMMddHHmmss"
        let time = formetter.string(from: Date.init())
        
        return "SFVideo" + time
    }
    
//MARK: UITableViewDelegate & UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bgMusicArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: bgMusicIdentifier)
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        
        cell.removeAllSubviews()
        let cellBtn = getCellBtn(rowNum: indexPath.row)
        cell.addSubview(cellBtn)
        return cell
    }
    
    private func getCellBtn(rowNum: Int) -> UIButton {
        let cellBtn = UIButton.init(frame: CGRect(x: 0, y: 0, width: SD_SCREEN_WIDTH, height: 45))
        cellBtn.setBackgroundColorNormalState(.black)
        cellBtn.tag = rowNum
        cellBtn.setBorderBottomColor(UIColor.rgbaColor(0xffffff22))
        cellBtn.contentHorizontalAlignment = .left
        cellBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        cellBtn.addTarget(self, action: #selector(selectBGMusic), for: .touchUpInside)
        
        let selectedImgView = UIImageView.init()
        selectedImgView.tag = cellBtn.tag + selectImgTag
        cellBtn.addSubview(selectedImgView)
        selectedImgView.snp.makeConstraints { (make) in
            make.centerY.equalTo(cellBtn)
            make.right.equalTo(cellBtn).offset(-40)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        if rowNum == 0 {
            cellBtn.setTitle("无音乐")
        }else{
            let (name,_) = bgMusicArray[rowNum - 1]
            cellBtn.setTitle(name)
        }
        
        if rowNum == selectedFlag {
            selectedImgView.image = selectedImage
        }else {
           selectedImgView.image = unselectImage
        }
        return cellBtn
    }

//MARK: 选择背景音乐
    @objc private func selectBGMusic(sender: UIButton) {
        if let selectImageView = sender.viewWithTag(sender.tag + selectImgTag) as? UIImageView {
           selectImageView.image = selectedImage
           selectedFlag = sender.tag
        }
        
        musicTableView.reloadData()
        if sender.tag == 0 {
            bgMusicUrl = nil
            stopBGMsicPlayer()
        } else {
            let selected = bgMusicArray[sender.tag - 1]
            bgMusicUrl = selected.1
        }
        replayVideo()
    }

    @objc private func updateSlider() {
       playSlider.value += 0.01
        if playSlider.value >=  Float(CMTimeGetSeconds((recordSession?.duration)!)) {
            stopBGMsicPlayer()
            videoPlayer.pause()
            replayBtn.isHidden = false
            sliderTimer.fireDate = Date.distantFuture
        }
        
    }
    
//MARK: 重播视频
    @objc private func replayVideo() {
        playSlider.value = 0
        replayBtn.isHidden = true
        
        if bgMusicUrl == nil {    //选择无音乐
            videoPlayer.setItemBy(exportSession.inputAsset)
        }else if let asset = videoAssetWithoutAudio(){   //选择对应音乐
            videoPlayer.setItemBy(asset)
            
            if (try? bgMusicPlayer = AVAudioPlayer.init(contentsOf: bgMusicUrl!)) == nil {
                let alert = UIAlertView.init(title: "提示", message: "背景音乐获取失败", delegate: self, cancelButtonTitle: "确定")
                alert.show()
            }else {
                bgMusicPlayer.prepareToPlay()
                bgMusicPlayer.play()
            }
        }
        videoPlayer.play()
        sliderTimer.fireDate = Date.distantPast
    }

    private func stopBGMsicPlayer() {
        if bgMusicUrl != nil {
            bgMusicPlayer.pause()
        }
    }
    
//MARK: 获取只有视频信息的asset
    private func videoAssetWithoutAudio() -> AVAsset? {
        let videoTimeRange = CMTimeRangeMake(kCMTimeZero, (recordSession?.duration)!)
        let videoAsset = exportSession.inputAsset
        let mixComposition = AVMutableComposition.init()
        
        //视频采集compositionVideoTrack
        let compositionVideoTrack = mixComposition.addMutableTrack(withMediaType: AVMediaTypeVideo, preferredTrackID: kCMPersistentTrackID_Invalid)
        
        guard ((try? compositionVideoTrack.insertTimeRange(videoTimeRange, of: (videoAsset?.tracks(withMediaType: AVMediaTypeVideo).first)!, at: kCMTimeZero)) != nil) else{
            let alert = UIAlertView.init(title: "提示", message: "视频处理失败", delegate: self, cancelButtonTitle: "确定")
            alert.show()
            return nil
        }

        let mixAssetExportSession = SCAssetExportSession.init(asset: mixComposition)
        return mixAssetExportSession.inputAsset
    }

    //点击完成按钮操作
    @objc private func exportVideo() {
       videoPlayer.pause()
       stopBGMsicPlayer()
       ShowLoading()
        if bgMusicUrl == nil {
            exportUrl = exportSession.outputUrl
            finishEditVideo()
        }else {
            mixMusicToVideo()
        }
    }
    
//MARK: 合成背景音乐
    private func mixMusicToVideo() {
        let videoDurationTime = recordSession?.duration
        let videoTimeRange = CMTimeRangeMake(kCMTimeZero, videoDurationTime!)
        let audioAsset  = AVURLAsset.init(url: bgMusicUrl!)
        let videoAsset = AVURLAsset.init(url: newVideoUrl)
        
        //创建AVMutableComposition对象来添加视频音频资源的AVMutableCompositionTrack
        let mixComposition = AVMutableComposition.init()
        
        //视频采集compositionVideoTrack
        let compositionVideoTrack = mixComposition.addMutableTrack(withMediaType: AVMediaTypeVideo, preferredTrackID: kCMPersistentTrackID_Invalid)
        compositionVideoTrack.preferredTransform = (exportSession.inputAsset?.preferredTransform)!
        
        //#warning 避免数组越界 tracksWithMediaType 找不到对应的文件时候返回空数组
            //TimeRange截取的范围长度
            //ofTrack来源
            //atTime插放在视频的时间位置
       try! compositionVideoTrack.insertTimeRange(videoTimeRange, of: (videoAsset.tracks(withMediaType: AVMediaTypeVideo).first)!, at: kCMTimeZero)
        
        //视频声音采集(也可不执行这段代码不采集视频音轨，合并后的视频文件将没有视频原来的声音)
//       let compositionVoiceTrack = mixComposition.addMutableTrack(withMediaType: AVMediaTypeAudio, preferredTrackID: kCMPersistentTrackID_Invalid)
//       try! compositionVoiceTrack.insertTimeRange(videoTimeRange, of: videoAsset.tracks(withMediaType: AVMediaTypeAudio).first!, at: kCMTimeZero)
        
        let audioTimeRange = CMTimeRangeMake(kCMTimeZero, videoDurationTime!)
        //音频采集compositionCommentaryTrack
        let compositionAudioTrack = mixComposition.addMutableTrack(withMediaType: AVMediaTypeAudio, preferredTrackID: kCMPersistentTrackID_Invalid)
        if (try? compositionAudioTrack.insertTimeRange(audioTimeRange, of: audioAsset.tracks(withMediaType: AVMediaTypeAudio).first!, at: kCMTimeZero)) == nil {
            let alert = UIAlertView.init(title: "提示", message: "视频处理失败", delegate: self, cancelButtonTitle: "确定")
            alert.show()
            return
        }
        
        //导出合并后文件用Session
        mixAssetExportSession = SCAssetExportSession.init(asset: mixComposition)
        //混合后的视频输出路径
        mixOutPutUrl = URL.init(fileURLWithPath: NSHomeDirectory() + String.init(format: "/Library/Caches/%@.mp4", getVideoName()))
        mixAssetExportSession!.outputFileType = AVFileTypeMPEG4
        mixAssetExportSession!.outputUrl = mixOutPutUrl
        mixAssetExportSession!.exportAsynchronously {[unowned self]  in
            self.exportUrl = self.mixAssetExportSession?.outputUrl
           try! FileManager.default.removeItem(atPath: (self.exportSession.outputUrl?.path)!)
           self.finishEditVideo()
        }
    }
    
    private func finishEditVideo() {
        setThumbnail()
        UISaveVideoAtPathToSavedPhotosAlbum(exportUrl.path, self, nil, nil)
        let alert = UIAlertView.init(title: "提示", message: "视频已保存至本地相册中", delegate: self, cancelButtonTitle: "确定")
        alert.show()
        HideLoading()
    }
    
    private func setThumbnail() {
        let urlSet = AVURLAsset.init(url: exportUrl)
        let imageGenerator = AVAssetImageGenerator.init(asset: urlSet)
        
        let time = recordSession?.duration
        guard let cgImage = try? imageGenerator.copyCGImage(at: time!, actualTime: nil) else {
            let alert = UIAlertView.init(title: "提示", message: "缩略图获取失败", delegate: self, cancelButtonTitle: "确定")
            alert.show()
            return
        }
        
        thumbnail = UIImage.init(cgImage: cgImage)
        
    }

}


