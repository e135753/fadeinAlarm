import UIKit
import AVKit

class AlarmViewController: UIViewController,AVAudioPlayerDelegate {
    
    var AlarmTime:Date!
    var FadeTime:Int!
    
    var x = 0
    var y = 0
    
    var clockLabel: UILabel!
    
    var aaa:AVAudioPlayer!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        clockLabel = UILabel(frame: .init(x: 0, y: 0, width: 200, height: 200))
        clockLabel.numberOfLines = 3
        clockLabel.textColor = .gray
        view.addSubview(clockLabel)
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(clock), userInfo: nil, repeats: true)
        clock()
        
        Timer(fireAt: AlarmTime, interval: .zero, target: self, selector: #selector(Alarmmm), userInfo: nil, repeats: false).fire()
        
        let g = UITapGestureRecognizer(target: self, action: #selector(dismiss(animated:completion:)))
        view.addGestureRecognizer(g)
        
        guard let 📍 = Bundle.main.url(forResource: "a", withExtension: "mp3") else { return }
        do{
            aaa = try AVAudioPlayer(contentsOf: 📍)
            aaa.delegate = self
            aaa.volume = .zero
            aaa.numberOfLoops = 5
        } catch {
            print("aaa")
        }
    }
    
    @objc func clock(){
        let a = DateFormatter()
        a.timeStyle = .short
        clockLabel.text = a.string(from: Date()) + "\nAlarm for " + a.string(from: AlarmTime) + ".\nFadein " + String(FadeTime) + "min."
        x = x % (Int(view.frame.width) - 200) + 1
        y = y % (Int(view.frame.height) - 200) + 1
        clockLabel.frame = .init(x: x, y: y, width: 200, height: 200)
    }
    
    @objc func Alarmmm(){
        print(self)
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool{
        return true
    }
}
