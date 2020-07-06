# PlayMusic
PlayMusic view


Language recommend: swift 4


install: Cocoapods

  pod 'PlayMusic'

- viewtype:
  + smallView and bigView for custom 2 view playMusic


- setup image for button:

+ playButtonImage
+ pauseButtonImage
+ previousButtonImage
+ nextButtonImage
+ repeatButtonImage
  + example: music.repeatButtonImage(image: uiimage(name: "pause"))

- setup name of song....
+ ishiddenTitle = true
   + example: music.ishiddenTitle = true
         music.songName = "Huy Spring"
