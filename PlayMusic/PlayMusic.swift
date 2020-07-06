//
//  PlayMusic.swift
//  PlayMusic
//
//  Created by Xuan Huy on 6/8/20.
//  Copyright © 2020 Xuan Huy. All rights reserved.
//
import UIKit
import AVKit

open class PlayMusic: UIView
{
    let slider: UISlider =
    {
       let s = UISlider()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.backgroundColor = .clear
        s.isUserInteractionEnabled = true
        s.clearsContextBeforeDrawing = true
        s.autoresizesSubviews = true
        s.isContinuous = true
        s.thumbTintColor = .clear
        s.minimumTrackTintColor = .purple
        s.maximumTrackTintColor = .cyan
        
        return s
    }()
    
    let lbltimerMove: UILabel =
    {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "0:00"
        lbl.font = .systemFont(ofSize: 10)
        lbl.textAlignment = .center
        
        return lbl
    }()
    
   let lbltimerEnd: UILabel =
    {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "0:00"
        lbl.font = .systemFont(ofSize: 10)
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    let lblSongName: UILabel =
    {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = ""
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 11)
        
        return lbl
    }()
    
    let lblSinger: UILabel =
    {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = ""
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 11)
        
        return lbl
    }()
    
   let btnPrevious: UIButton =
    {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.setTitle("<<", for: .normal)
//        btn.setImage(UIImage(named: "Back track.png"), for: .normal)
//        btn.backgroundColor = .green
        
        return btn
    }()
    
  let btnPlay: UIButton =
    {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.setTitle("||", for: .normal)
//        btn.backgroundColor = .green
//        btn.setImage(UIImage(named: "icon_play.png"), for: .normal)
        
        return btn
    }()
    
    let btnNext: UIButton =
    {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.setTitle(">>", for: .normal)
//        btn.backgroundColor = .green
//        btn.setImage(UIImage(named: "Fast forward.png"), for: .normal)
        return btn
    }()
    
   let btnRepeat: UIButton =
    {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("rp", for: .highlighted)
        btn.backgroundColor = .clear
        
        return btn
    }()
    
    public var isTitleHidden = true
    {
        didSet
        {
            if(isTitleHidden == false)
            {
                lblSongName.text = "Example"
                lblSinger.text = "Example"
            }
            else
            {
                lblSongName.text = ""
                lblSinger.text = ""
            }
        }
    }
    
    
    ///////////////////
//    let lbltime: UILabel =
//    {
//        let lbl = UILabel()
//        lbl.translatesAutoresizingMaskIntoConstraints = false
//        lbl.text = ":::::::123"
//        lbl.backgroundColor = .red
//
//        return lbl
//    }()
    
    //MARK: Small UI
    
    let imgAvata: UIImageView =
        {
            let img = UIImageView()
            img.translatesAutoresizingMaskIntoConstraints = false
            img.clipsToBounds = true
            img.layer.cornerRadius = 15
            
            return img
    }()
    
    
    
    
    var imagebuttonPlay: UIImage?
    var imagebuttonPause: UIImage?
    
    public var url:String = ""
    public var exten = ""
    
//    //MARK: Properties
    public enum MusicType
    {
        case ONLINE, LOCAL, NONE
    }
    
    public enum typeView
    {
        case small, big
    }
    
    var onlinePlayer: AVPlayer?
    var localPlayer: AVAudioPlayer?
    public var musicType: MusicType?
    public var viewType: typeView?
    {
        didSet
        {
            if viewType == typeView.small
            {
                setupSmallUI()
            }
            else if viewType == typeView.big
            {
                setupUI()
            }
        }
    }
    
    public override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        
        prepareButton()
        
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
        
        
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func setupSmallUI()
    {
        addSubview(imgAvata)
        addSubview(lblSongName)
        addSubview(lblSinger)
        addSubview(btnPlay)
        addSubview(btnNext)
        addSubview(btnRepeat)
        
        imgAvata.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        imgAvata.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imgAvata.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imgAvata.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        lblSongName.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -2).isActive = true
        lblSongName.leadingAnchor.constraint(equalTo: imgAvata.trailingAnchor, constant: 10).isActive = true
        
        lblSinger.topAnchor.constraint(equalTo: centerYAnchor, constant: 2).isActive = true
        lblSinger.leadingAnchor.constraint(equalTo: imgAvata.trailingAnchor, constant: 10).isActive = true
        
        btnRepeat.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        btnRepeat.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        btnRepeat.widthAnchor.constraint(equalToConstant: 20).isActive = true
        btnRepeat.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        btnNext.trailingAnchor.constraint(equalTo: btnRepeat.leadingAnchor, constant: -20).isActive = true
        btnNext.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        btnNext.widthAnchor.constraint(equalToConstant: 20).isActive = true
        btnNext.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        btnPlay.trailingAnchor.constraint(equalTo: btnNext.leadingAnchor, constant: -20).isActive = true
        btnPlay.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        btnPlay.widthAnchor.constraint(equalToConstant: 20).isActive = true
        btnPlay.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func setupUI()
    {
        addSubview(slider)
        addSubview(lbltimerMove)
        addSubview(lbltimerEnd)
        addSubview(lblSongName)
        addSubview(lblSinger)
        addSubview(btnPlay)
        addSubview(btnPrevious)
        addSubview(btnNext)
        addSubview(btnRepeat)
        
        slider.topAnchor.constraint(equalTo: topAnchor).isActive = true
        slider.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        slider.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        slider.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        lbltimerMove.topAnchor.constraint(equalTo: slider.bottomAnchor).isActive = true
        lbltimerMove.leadingAnchor.constraint(equalTo: slider.leadingAnchor).isActive = true
        lbltimerEnd.topAnchor.constraint(equalTo: slider.bottomAnchor).isActive = true
        lbltimerEnd.trailingAnchor.constraint(equalTo: slider.trailingAnchor).isActive = true
        
        lblSongName.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 10).isActive = true
        lblSongName.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        lblSinger.topAnchor.constraint(equalTo: lblSongName.bottomAnchor, constant: 5).isActive = true
        lblSinger.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        btnPlay.topAnchor.constraint(equalTo: lblSinger.bottomAnchor, constant: 10).isActive = true
        btnPlay.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        btnPlay.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btnPlay.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        btnPrevious.topAnchor.constraint(equalTo: lblSinger.bottomAnchor, constant: 10).isActive = true
        btnPrevious.trailingAnchor.constraint(equalTo: btnPlay.leadingAnchor, constant: -20).isActive = true
        btnPrevious.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btnPrevious.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        btnNext.topAnchor.constraint(equalTo: lblSinger.bottomAnchor, constant: 10).isActive = true
        btnNext.leadingAnchor.constraint(equalTo: btnPlay.trailingAnchor, constant: 20).isActive = true
        btnNext.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btnNext.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        btnRepeat.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        btnRepeat.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btnRepeat.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btnRepeat.centerYAnchor.constraint(equalTo: btnNext.centerYAnchor).isActive = true
        
    }
    
    func prepareButton()
    {
        btnPlay.addTarget(self, action: #selector(onClickBtnPlay(_:)), for: .touchUpInside)
        btnNext.addTarget(self, action: #selector(onClickNext(_:)), for: .touchUpInside)
        btnPrevious.addTarget(self, action: #selector(onClickBack(_:)), for: .touchUpInside)
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        btnRepeat.addTarget(self, action: #selector(onRepeat(_:)), for: .touchUpInside)
    }
    public func initPlayer(url: String)
    {
        if musicType == MusicType.ONLINE
        {
            let url = URL(string: (url))
            onlinePlayer = AVPlayer(url: url!)
            
            let avsession = AVAudioSession.sharedInstance()
            
            do{
                try avsession.setCategory(AVAudioSessionCategoryPlayback)
            }
            catch{
                
            }
            
            guard let duration = onlinePlayer?.currentItem?.asset.duration else
            {
                return
            }
            let durationBySecond = CMTimeGetSeconds(duration)
            let min = Int(durationBySecond) / 60
            let second = Int(durationBySecond) % 60
            self.lbltimerEnd.text = "\(min):\(second)"
            self.slider.maximumValue = Float(durationBySecond)
        }
        else {
            return
        }

    }
    
    //MARK: Button
    public func playButtonImage(image: UIImage)
    {
        imagebuttonPlay = image
        btnPlay.setImage(image, for: .normal)
    }
    
    public func pauseButtonImage(image: UIImage)
    {
        imagebuttonPause = image
//        btnPlay.setImage(image, for: .normal)
    }
    
    public func previousButtonImage(image: UIImage)
    {
        btnPrevious.setImage(image, for: .normal)
    }
    
    public func nextButtonImage(image: UIImage)
    {
        btnNext.setImage(image, for: .normal)
    }
    
    public func repeatButtonImage(image: UIImage)
    {
        btnRepeat.setImage(image, for: .normal)
    }
    public func songName(text: String)
    {
        lblSongName.text = text
    }
    
    public func singerName(text: String)
    {
        lblSinger.text = text
    }
    
    public func setbackgroundSlider(color: UIColor)
    {
        slider.backgroundColor = color
    }
    
    public func setAvata(image: UIImage)
    {
        imgAvata.image = image
    }
    
    public func play()
    {
        onlinePlayer?.play()
    }
    public func pause()
    {
        onlinePlayer?.pause()
    }
    public func rePlay()
    {
        onClickRepeat()
    }
    
    
    
    //MARK: Slider
    @objc func updateSlider()
    {
        if onlinePlayer == nil
        {
            return
        }
        if onlinePlayer != nil
        {
            let currentTimeBySecond = CMTimeGetSeconds((onlinePlayer!.currentTime()))
            slider.value = Float(currentTimeBySecond)
            
            let min = Int(currentTimeBySecond) / 60
            let secon = Int(currentTimeBySecond) % 60
            self.lbltimerMove.text = "\(min):\(secon)"
            
            if(slider.value == slider.maximumValue)
            {
                if(btnRepeat.isSelected == true)
                {
                    onClickRepeat()
                }
                else
                {
                    print("stop")
                }
            }
            
        }
    }
    
    @objc func sliderValueChanged(_ sender: UISlider)
    {
        onlinePlayer?.pause()

        print("value: \(Int(slider.value))")
        
        onlinePlayer?.seek(to: CMTime(seconds: Double(slider.value), preferredTimescale: 1))
        onlinePlayer?.play()


        let min = Int(slider.value) / 60
        let secon = Int(slider.value) % 60
        self.lbltimerMove.text = "\(min):\(secon)"
        
//        lbltime.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        lbltime.center = setUISliderThumbValueWithLabel(slider: sender)
    }
    
    public func setUISliderThumbValueWithLabel(slider: UISlider) -> CGPoint
    {
        let slidertTrack : CGRect = slider.trackRect(forBounds: slider.bounds)
        let sliderFrm : CGRect = slider.thumbRect(forBounds: slider.bounds, trackRect: slidertTrack, value: slider.value)
        return CGPoint(x: sliderFrm.origin.x + slider.frame.origin.x + 8, y: slider.frame.origin.y + 20)
    }
    
    //MARK: Button
    
    
    @objc func onClickBtnPlay(_ sender: UIButton)
    {
        print("Play")
        sender.isSelected = !sender.isSelected

        if onlinePlayer != nil
        {
            if sender.isSelected == true
            {
                print("play")
                btnPlay.setImage(imagebuttonPause, for: .normal)
                onlinePlayer?.pause()
                onlinePlayer?.play()
            }
            else
            {
                print("pause")
                btnPlay.setImage(imagebuttonPlay, for: .normal)
                onlinePlayer?.pause()
            }
        }
    }
    @objc func onClickNext(_ sender: UIButton)
    {
        print("next")
        
        let currentTime = slider.value
        var tagertTime: Float = 0
        if currentTime + 10 > slider.maximumValue
        {
            tagertTime = slider.maximumValue
        }
        else
        {
            tagertTime = currentTime + 10
        }
        slider.value = tagertTime
        if onlinePlayer != nil
        {
            onlinePlayer?.seek(to: CMTime(seconds: Double(tagertTime), preferredTimescale: 1))
        }
    }
    @objc func onClickBack(_ sender: UIButton)
    {
        print("back")
        let currentTime = slider.value
        var tagertTime: Float = 0
        if currentTime - 10 > 0
        {
            tagertTime = currentTime - 10
        }
        else
        {
            tagertTime = 0
        }
        slider.value = tagertTime
        if onlinePlayer != nil
        {
            onlinePlayer?.seek(to: CMTime(seconds: Double(tagertTime), preferredTimescale: 1))
        }
    }
    
    @objc func onRepeat(_ sender: UIButton)
    {
        sender.isSelected = !sender.isSelected
        if sender.isSelected == true
        {
            print("repeat")
        }
        else
        {
            print("false")
        }
    }
    
    func onClickRepeat()
    {
        print("repeat")
        onlinePlayer?.pause()
        slider.value = 0
        onlinePlayer?.seek(to: CMTime(seconds: Double(slider.value), preferredTimescale: 1))
        onlinePlayer?.play()
    }
    
}
