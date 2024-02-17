import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //MARK: - Variable
    
    var maxProgress = 0
    let softEgg = UIButton()
    let mediumEgg = UIButton()
    let hardEgg = UIButton()
    let stop = UIButton()
    var timeLabel = UILabel()
    var timeProgress = UIProgressView()
    var player: AVAudioPlayer!
    var timer = Timer()
    var timeInSecond = 0
    var audioPlay = false
    lazy var contentStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        return stack
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUIElement()
        stackSet()
    }
    
    //MARK: - Functions
    
    func setUIElement() {
        view.backgroundColor = .systemGray
        timeLabel.text = "CHOOSE"
        timeLabel.font = UIFont.systemFont(ofSize: 30)
        timeLabel.textColor = .black
        timeLabel.textAlignment = .center
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timeLabel)
        
        view.addSubview(timeProgress)
        timeProgress.translatesAutoresizingMaskIntoConstraints = false
        timeProgress.isHidden = true
        
        let _: () = NSLayoutConstraint(item: timeProgress, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        let _: () = NSLayoutConstraint(item: timeProgress, attribute: .top, relatedBy: .equal, toItem: timeLabel, attribute: .bottom, multiplier: 1, constant: 50).isActive = true
        let _: () = NSLayoutConstraint(item: timeProgress, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leadingMargin, multiplier: 1, constant: 0).isActive = true
        let _: () = NSLayoutConstraint(item: timeProgress, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 5).isActive = true
        
        
        softEgg.titleLabel?.text = "soft_egg"
        softEgg.tag = 3
        softEgg.setImage(UIImage(named: softEgg.titleLabel!.text!), for: .normal)
        softEgg.addTarget(self, action: #selector(eggButton(sender:)), for: .touchUpInside)
        mediumEgg.titleLabel?.text = "medium_egg"
        mediumEgg.tag = 7
        mediumEgg.setImage(UIImage(named: mediumEgg.titleLabel!.text!), for: .normal)
        mediumEgg.addTarget(self, action: #selector(eggButton(sender:)), for: .touchUpInside)
        hardEgg.titleLabel?.text = "hard_egg"
        hardEgg.tag = 12
        hardEgg.setImage(UIImage(named: hardEgg.titleLabel!.text!), for: .normal)
        hardEgg.addTarget(self, action: #selector(eggButton(sender:)), for: .touchUpInside)
        
        let _: () = NSLayoutConstraint(item: timeLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        let _: () = NSLayoutConstraint(item: timeLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1, constant: 50).isActive = true
        let _: () = NSLayoutConstraint(item: timeLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 250).isActive = true
        let _: () = NSLayoutConstraint(item: timeLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50).isActive = true
        
        view.addSubview(stop)
        stop.translatesAutoresizingMaskIntoConstraints = false
        stop.addTarget(self, action: #selector(stop(sender:)), for: .touchUpInside)
        stop.backgroundColor = .systemGray2
        stop.setTitle("STOP", for: .normal)
        stop.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        stop.setTitleColor(.black, for: .normal)
        stop.layer.cornerRadius = 6
        stop.isHidden = true
        
        let _: () = NSLayoutConstraint(item: stop, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        let _: () = NSLayoutConstraint(item: stop, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottomMargin, multiplier: 1, constant: 0).isActive = true
        let _: () = NSLayoutConstraint(item: stop, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100).isActive = true
        let _: () = NSLayoutConstraint(item: stop, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50).isActive = true
    }
    
    @objc
    func eggButton(sender: UIButton) {
        if !timer.isValid && !audioPlay {
            startTimer(time: sender.tag)
        } else {
            return
        }
    }
    
    func startTimer(time sender: Int) {
        stop.isHidden = false
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        timeInSecond = sender * 60
        maxProgress = timeInSecond
        timeProgress.isHidden = false
        timeProgress.progress = 1
        timeLabel.text = setTimerTime()
    }
    
    @objc
    func fireTimer() {
        startProgress()
        timeInSecond -= 1
        timeLabel.text = setTimerTime()
        if timeInSecond == 0 {
            timeLabel.text = "EGGS ARE READY"
            stop.isHidden = true
            timeProgress.isHidden = true
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                self.timeLabel.text = "CHOOSE"
                self.audioPlay = false
            })
        }
    }
    
    @objc
    func stop(sender: UIButton) {
        timer.invalidate()
        self.timeLabel.text = "CHOOSE"
        stop.isHidden = true
        timeProgress.isHidden = true
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
        timeProgress.setProgress(Float(1) * Float(timeInSecond) / Float(maxProgress), animated: true)    }
    
    func stackSet() {
        view.addSubview(contentStack)
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.addArrangedSubview(softEgg)
        contentStack.addArrangedSubview(mediumEgg)
        contentStack.addArrangedSubview(hardEgg)
        contentStack.spacing = 16
        contentStack.distribution = .fillEqually
        
        NSLayoutConstraint.activate([
            contentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            contentStack.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            contentStack.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4)
        ])
    }
    
}

