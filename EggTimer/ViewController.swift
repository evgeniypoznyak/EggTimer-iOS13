//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 740]
    @IBOutlet weak var topLabel: UILabel!
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    var player: AVAudioPlayer?

    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        progressBar.progress = 0
        secondsPassed = 0
        timer.invalidate()
        
        let hardness = sender.currentTitle!
        topLabel.text = hardness
        
        totalTime =  eggTimes[hardness]!
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
    }
    
    
    @objc func updateCounter() {
        
        if totalTime > secondsPassed {
            secondsPassed += 1
            let percentegeProgress : Float = Float(secondsPassed) / Float(totalTime)
            progressBar.progress = percentegeProgress
        }
        else {
            topLabel.text  = "Done"
            playSound()
            timer.invalidate()
        }
        
    };
    

    func playSound() {
        
//        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
//        player = try! AVAudioPlayer(contentsOf: url!)
//        player?.play()
        
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)            
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
