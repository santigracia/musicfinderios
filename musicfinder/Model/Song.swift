//
//  Song.swift
//  musicfinder
//
//  Created by Santi Gracia on 9/14/19.
//  Copyright © 2019 Mixpanel. All rights reserved.
//

import Foundation

class Song {
    
    var songTitle : String = ""
    var songAuthor : String = ""
    var style : String = ""
    var songPrice : Double = 0
    
    init(songTitle : String, songAuthor : String, style : String, songPrice : Double) {
        self.songTitle = songTitle
        self.songAuthor = songAuthor
        self.songPrice = songPrice
        self.style = style
    }
    
}
