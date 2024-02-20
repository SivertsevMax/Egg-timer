import UIKit

class View: UIView {
    let softEgg = UIButton()
    let mediumEgg = UIButton()
    let hardEgg = UIButton()
    let stop = UIButton()
    var timeLabel = UILabel()
    var timeProgress = UIProgressView()
    
    lazy var contentStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        return stack
    }()
    
    
    
    func setUIElement() {
        self.backgroundColor = .systemGray
        timeLabel.text = "CHOOSE"
        timeLabel.font = UIFont.systemFont(ofSize: 30)
        timeLabel.textColor = .black
        timeLabel.textAlignment = .center
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(timeLabel)
        
        self.addSubview(timeProgress)
        timeProgress.translatesAutoresizingMaskIntoConstraints = false
        timeProgress.isHidden = true
        
        let _: () = NSLayoutConstraint(item: timeProgress, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        let _: () = NSLayoutConstraint(item: timeProgress, attribute: .top, relatedBy: .equal, toItem: timeLabel, attribute: .bottom, multiplier: 1, constant: 50).isActive = true
        let _: () = NSLayoutConstraint(item: timeProgress, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1, constant: 0).isActive = true
        let _: () = NSLayoutConstraint(item: timeProgress, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 5).isActive = true
        
        
        softEgg.titleLabel?.text = "soft_egg"
        softEgg.tag = 3
        softEgg.setImage(UIImage(named: softEgg.titleLabel!.text!), for: .normal)
         mediumEgg.titleLabel?.text = "medium_egg"
        mediumEgg.tag = 7
        mediumEgg.setImage(UIImage(named: mediumEgg.titleLabel!.text!), for: .normal)
        hardEgg.titleLabel?.text = "hard_egg"
        hardEgg.tag = 12
        hardEgg.setImage(UIImage(named: hardEgg.titleLabel!.text!), for: .normal)
        
        let _: () = NSLayoutConstraint(item: timeLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        let _: () = NSLayoutConstraint(item: timeLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .topMargin, multiplier: 1, constant: 50).isActive = true
        let _: () = NSLayoutConstraint(item: timeLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 250).isActive = true
        let _: () = NSLayoutConstraint(item: timeLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50).isActive = true
        
        self.addSubview(stop)
        stop.translatesAutoresizingMaskIntoConstraints = false
        stop.backgroundColor = .systemGray2
        stop.setTitle("STOP", for: .normal)
        stop.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        stop.setTitleColor(.black, for: .normal)
        stop.layer.cornerRadius = 6
        stop.isHidden = true
        
        let _: () = NSLayoutConstraint(item: stop, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        let _: () = NSLayoutConstraint(item: stop, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottomMargin, multiplier: 1, constant: 0).isActive = true
        let _: () = NSLayoutConstraint(item: stop, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100).isActive = true
        let _: () = NSLayoutConstraint(item: stop, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50).isActive = true
    }
    
    func addStopButtonTarget(_ target: Any?, action: Selector) {
        stop.addTarget(target, action: action, for: .touchUpInside)
    }
    func addHardButtonTarget(_ target: Any?, action: Selector) {
        hardEgg.addTarget(target, action: action, for: .touchUpInside)
    }
    func addMediumButtonTarget(_ target: Any?, action: Selector) {
        mediumEgg.addTarget(target, action: action, for: .touchUpInside)
    }
    func addSoftButtonTarget(_ target: Any?, action: Selector) {
        softEgg.addTarget(target, action: action, for: .touchUpInside)
    }
    
}
