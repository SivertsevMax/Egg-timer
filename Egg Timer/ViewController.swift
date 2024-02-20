import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //MARK: - Variable
    
    let cookingTime = [3,7,12]
    var maxProgress = 0
    var player: AVAudioPlayer!
    var timer = Timer()
    var timeInSecond = 0
    var audioPlay = false
    
    //MARK: - Lifecycle
    
    override func loadView() {
        self.view = CustomView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view().setUIElement()
        view().stackSet()
        setButtonTarget()
    }
    
    //MARK: - Functions
    
    @objc
    func eggButton(sender: UIButton) {
        if !timer.isValid && !audioPlay {
            startTimer(time: cookingTime[sender.tag])
        } else {
            return
        }
    }
    
    func startTimer(time sender: Int) {
        view().stop.isHidden = false
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        timeInSecond = sender * 60
        maxProgress = timeInSecond
        view().timeProgress.isHidden = false
        view().timeProgress.progress = 1
        view().timeLabel.text = setTimerTime()
    }
    
    @objc
    func fireTimer() {
        startProgress()
        timeInSecond -= 1
        view().timeLabel.text = setTimerTime()
        if timeInSecond == 0 {
            view().timeLabel.text = "EGGS ARE READY"
            view().stop.isHidden = true
            view().timeProgress.isHidden = true
            timeInSecond = 0
            self.timer.invalidate()
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            do {
                player = try AVAudioPlayer(contentsOf: url!, fileTypeHint: nil)
                audioPlay = true
            } catch _{
                return
            }
            player.play()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                self.view().timeLabel.text = "CHOOSE"
                self.audioPlay = false
            })
        }
    }
    
    @objc
    func stop(sender: UIButton) {
        timer.invalidate()
        self.view().timeLabel.text = "CHOOSE"
        view().stop.isHidden = true
        view().timeProgress.isHidden = true
    }
    
    func setTimerTime() -> String{
        if timeInSecond % 60 == 0 {
            return "\(timeInSecond / 60):00"
        } else if timeInSecond % 60 < 10 {
            return "\(timeInSecond / 60):0\(timeInSecond % 60)"
        } else {
            return "\(timeInSecond / 60):\(timeInSecond % 60)"
        }
    }
    
    func startProgress() {
        view().timeProgress.setProgress(Float(1) * Float(timeInSecond) / Float(maxProgress), animated: true)    }
    
    func view() -> CustomView {
       return self.view as! CustomView
    }
    
    func setButtonTarget() {
        view().softEgg.addTarget(self, action: #selector(eggButton(sender:)), for: .touchUpInside)
        view().mediumEgg.addTarget(self, action: #selector(eggButton(sender:)), for: .touchUpInside)
        view().hardEgg.addTarget(self, action: #selector(eggButton(sender:)), for: .touchUpInside)
        view().stop.addTarget(self, action: #selector(stop(sender:)), for: .touchUpInside)
    }
}

