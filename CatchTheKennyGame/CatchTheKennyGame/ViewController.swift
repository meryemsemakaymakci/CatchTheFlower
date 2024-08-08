//
//  ViewController.swift
//  CatchTheKennyGame
//
//  Created by Sema Kaymakçı on 7.07.2024.
//

import UIKit

class ViewController: UIViewController {
    
//    Variables
    var score = 0
    var timer = Timer()
    var counter = 0
    var floArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    

//    Views
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var flo1: UIImageView!
    @IBOutlet weak var flo2: UIImageView!
    @IBOutlet weak var flo3: UIImageView!
    @IBOutlet weak var flo4: UIImageView!
    @IBOutlet weak var flo5: UIImageView!
    @IBOutlet weak var flo6: UIImageView!
    @IBOutlet weak var flo7: UIImageView!
    @IBOutlet weak var flo8: UIImageView!
    @IBOutlet weak var flo9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score: \(score)"
        
//        Highscore check
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
//        Images
        flo1.isUserInteractionEnabled = true
        flo2.isUserInteractionEnabled = true
        flo3.isUserInteractionEnabled = true
        flo4.isUserInteractionEnabled = true
        flo5.isUserInteractionEnabled = true
        flo6.isUserInteractionEnabled = true
        flo7.isUserInteractionEnabled = true
        flo8.isUserInteractionEnabled = true
        flo9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        flo1.addGestureRecognizer(recognizer1)
        flo2.addGestureRecognizer(recognizer2)
        flo3.addGestureRecognizer(recognizer3)
        flo4.addGestureRecognizer(recognizer4)
        flo5.addGestureRecognizer(recognizer5)
        flo6.addGestureRecognizer(recognizer6)
        flo7.addGestureRecognizer(recognizer7)
        flo8.addGestureRecognizer(recognizer8)
        flo9.addGestureRecognizer(recognizer9)
        
        floArray = [flo1, flo2, flo3, flo4, flo5, flo6, flo7, flo8, flo9]
        
        
//        Timers
        counter = 10
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideFlo), userInfo: nil, repeats: true)
        
        hideFlo()
    }
    
    @objc func hideFlo() {

        for flo in floArray {
            flo.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(floArray.count - 1)))
        floArray[random].isHidden = false
    }
    
    @objc func increaseScore() {
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc func countDown() {
        
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for flo in floArray {
                flo.isHidden = true
            }
//          HighScore
            
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            
//          Alert
            let alert = UIAlertController(title: "Time's Up!", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
                
//                Replay function
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideFlo), userInfo: nil, repeats: true)
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
