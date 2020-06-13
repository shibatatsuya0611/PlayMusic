//
//  PlayMusic.swift
//  PlayMusic
//
//  Created by Xuan Huy on 6/8/20.
//  Copyright © 2020 Xuan Huy. All rights reserved.
//
import UIKit
import AVKit

class PlayMusic: UIView
{
    let imgView: UIImageView =
    {
       let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "main")
        
        return img
    }()
    
    let slider: UISlider =
    {
       let s = UISlider()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.backgroundColor = .blue
        s.isUserInteractionEnabled = true
        s.clearsContextBeforeDrawing = true
        s.autoresizesSubviews = true
        s.isContinuous = true
        s.thumbTintColor = .clear
        
        return s
    }()
    
    let lbltimerMove: UILabel =
    {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "0:00"
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    let lbltimerEnd: UILabel =
    {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "0:00"
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    let lblSongName: UILabel =
    {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Example"
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    let lblSinger: UILabel =
    {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Example"
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    let btnPrevious: UIButton =
    {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.setTitle("<<", for: .normal)
        btn.setImage(UIImage(named: "Back track.png"), for: .normal)
//        btn.backgroundColor = .green
        
        return btn
    }()
    
    let btnPlay: UIButton =
    {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.setTitle("||", for: .normal)
//        btn.backgroundColor = .green
        btn.setImage(UIImage(named: "icon_play.png"), for: .normal)
        
        return btn
    }()
//    let lbltimeSlider: UILabel =
//    {
//        let lbl = UILabel()
//        lbl.translatesAutoresizingMaskIntoConstraints = false
//        lbl.text = ""
//        lbl.textColor = .clear
//        lbl.textAlignment = .center
//        lbl.isHidden = true
//
//        return lbl
//    }()
    
    let btnNext: UIButton =
    {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.setTitle(">>", for: .normal)
//        btn.backgroundColor = .green
        btn.setImage(UIImage(named: "Fast forward.png"), for: .normal)
        return btn
    }()
    
    let btnRepeat: UIButton =
    {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("rp", for: .normal)
        btn.backgroundColor = .green
        return btn
    }()
    
    var data:MusicData!
    {
        didSet
        {
            self.lblSongName.text = data.musicName
            self.lblSinger.text = data.singer
        }
    }
    
    //MARK: Properties
    enum MusicType
    {
        case ONLINE, LOCAL, NONE
    }
    
    var onlinePlayer: AVPlayer?
    var localPlayer: AVAudioPlayer?
    var musicType: MusicType?
    
    public override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        setupUI()
        prepareButton()
        initPlayer()
        
        localPlayer?.play()
        onlinePlayer?.play()
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
        slider.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 10), size: .init(width: 0, height: 10))
        lbltimerMove.anchor(top: slider.bottomAnchor, leading: slider.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .zero)
        lbltimerEnd.anchor(top: slider.bottomAnchor, leading: nil, bottom: nil, trailing: slider.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .zero)
        lblSongName.anchor(top: slider.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 50, left: 0, bottom: 0, right: 0), size: .zero)
        lblSongName.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        lblSinger.anchor(top: lblSongName.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .zero)
        lblSinger.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        btnPlay.anchor(top: lblSinger.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 20, left: 0, bottom: 0, right: 0), size: .init(width: 30, height: 30))
        btnPlay.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        btnPrevious.anchor(top: lblSinger.bottomAnchor, leading: nil, bottom: nil, trailing: btnPlay.leadingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 40), size: .init(width: 30, height: 30))
        btnNext.anchor(top: lblSinger.bottomAnchor, leading: btnPlay.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 40, left: 10, bottom: 0, right: 0), size: .init(width: 30, height: 30))
        btnRepeat.anchor(top: nil, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 10), size: .init(width: 30, height: 30))
        btnRepeat.centerYAnchor.constraint(equalTo: btnNext.centerYAnchor).isActive = true
        
    }
    
    func prepareButton()
    {
        btnPlay.addTarget(self, action: #selector(onClickBtnPlay(_:)), for: .touchUpInside)
        btnNext.addTarget(self, action: #selector(onClickNext(_:)), for: .touchUpInside)
        btnPrevious.addTarget(self, action: #selector(onClickBack(_:)), for: .touchUpInside)
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        btnRepeat.addTarget(self, action: #selector(onClickRepeat(_:)), for: .touchUpInside)
    }
    
    
    fileprivate func initPlayer()
    {
        if data == nil {
            return
        }
        
        if musicType == MusicType.LOCAL {
            guard let url = Bundle.main.url(forResource: data?.linkUrl, withExtension: data?.ext) else {
                return
            }
            do {
                localPlayer = try AVAudioPlayer(contentsOf: url)
//                let audioSession = AVAudioSession.sharedInstance()
//                do
//                {
//                    try audioSession.setCategory(AVAudioSessionCategoryPlayback)
//                }
//                catch
//                {
//                    print(error)
//                }
                let duration = localPlayer?.duration
                let min = Int(duration!) / 60
                let second = Int(duration!) % 60
                self.lbltimerEnd.text = "\(min):\(second)"
                self.slider.maximumValue = Float(duration!)
                
            } catch let err {
                print(err.localizedDescription)
            }
        }
        else if musicType == MusicType.ONLINE {
            let url = URL(string: (self.data!.linkUrl)!)
            onlinePlayer = AVPlayer(url: url!)
            guard let duration = onlinePlayer?.currentItem?.asset.duration else {
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
    
    //MARK: Slider
    @objc func updateSlider()
    {
        if localPlayer == nil && onlinePlayer == nil
        {
            return
        }
        if localPlayer!.isPlaying == true
        {
            slider.value = Float(localPlayer!.currentTime)
            let duration = localPlayer?.currentTime
            let min = Int(duration!) / 60
            let secon = Int(duration!) % 60
            self.lbltimerMove.text = "\(min):\(secon)"
            
        }
        if onlinePlayer != nil
        {
            let currentTimeBySecond = CMTimeGetSeconds((onlinePlayer!.currentTime()))
            slider.value = Float(currentTimeBySecond)
            
            let min = Int(currentTimeBySecond) / 60
            let secon = Int(currentTimeBySecond) % 60
            self.lbltimerMove.text = "\(min):\(secon)"
        }
    }
    
    @objc func sliderValueChanged(_ sender: Any)
    {
        localPlayer?.stop()

        print("value: \(Int(slider.value))")
       
        localPlayer?.currentTime = TimeInterval(slider.value)
        localPlayer?.prepareToPlay()
        localPlayer?.play()
        
        onlinePlayer?.seek(to: CMTime(seconds: Double(slider.value), preferredTimescale: 1))
        onlinePlayer?.play()


        let min = Int(slider.value) / 60
        let secon = Int(slider.value) % 60
        self.lbltimerMove.text = "\(min):\(secon)"
    }
    
    func setUISliderThumbValueWithLabel(slider: UISlider) -> CGPoint
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

        if localPlayer != nil {
            if sender.isSelected == true {
                localPlayer?.stop()
            } else {
                localPlayer?.play()
            }
        }
        else if onlinePlayer != nil {
            if sender.isSelected == true {
                onlinePlayer?.play()
            } else {
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
        if localPlayer != nil
        {
            localPlayer?.currentTime = TimeInterval(tagertTime)
        } else if onlinePlayer != nil {
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
        if localPlayer != nil
        {
            localPlayer?.currentTime = TimeInterval(tagertTime)
        } else if onlinePlayer != nil {
            onlinePlayer?.seek(to: CMTime(seconds: Double(tagertTime), preferredTimescale: 1))
        }
    }
    
    @objc func onClickRepeat(_ sender: UIButton)
    {
        
        sender.isSelected = !sender.isSelected

        if localPlayer != nil {
            if sender.isSelected == true {
                print("repeat:")
                localPlayer?.numberOfLoops = -1
            } else {
                print("stopRepeat")
                localPlayer?.stop()
            }
        }
        else if onlinePlayer != nil {
            
        }
    }
    
}
