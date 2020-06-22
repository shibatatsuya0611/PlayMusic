//
//  MusicData.swift
//  PlayMusic
//
//  Created by Xuan Huy on 6/8/20.
//  Copyright © 2020 Xuan Huy. All rights reserved.
//

import Foundation

open class MusicData
{
    enum MusicType
    {
        case LOCAL, ONLINE, NONE
    }
    
    var musicName: String?
    var singer: String?
    var art: String?
    var imgAvata: String?
    var linkUrl: String?
    var ext: String?
    var type: MusicType?
    
    func initMusicData(musicName: String, singer: String, art: String, imgAvata: String,linkUrl: String, ext: String, type: MusicType)
    {
        self.musicName = musicName
        self.singer = singer
        self.art = art
        self.imgAvata = imgAvata
        self.linkUrl = linkUrl
        self.ext = ext
        self.type = type
    }
}
