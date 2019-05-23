import UIKit
import AVKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UIDocumentPickerDelegate {
    
    @IBOutlet weak var ddddd: UIDatePicker!
    
    @IBOutlet weak var clockLabel: UILabel!
    
    @IBOutlet weak var durationTimePicker: UIPickerView!
    
    let list = [1,3,5,10,15,30]
    
    var t:Timer!
    var t2:Timer!
    var t3:Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ddddd.datePickerMode = .time
        ddddd.setDate(Date(timeIntervalSinceNow: .init(integerLiteral: 90)), animated: true)
        
        durationTimePicker.delegate = self
        
        t2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(clockTest), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        t2.invalidate()
    }
    
    @objc func clockTest(){
        let a = DateFormatter()
        a.timeStyle = .short
        print(a.string(from: Date()))
        print(a.string(from: ddddd.date))
        let b = list[durationTimePicker.selectedRow(inComponent:0)]
        clockLabel.text = "⏰ " + a.string(from: ddddd.date) + "\n🎚Fadein " + String(b) + " min\n🎼 " + "\n🔁 5 times"
    }
    
    @IBAction func openMp3(_ sender: Any) {
        let 👩🏻‍💻 = UIDocumentPickerViewController(documentTypes: ["com.adobe.pdf"], in: .import)
        👩🏻‍💻.delegate = self
        self.present(👩🏻‍💻, animated: true, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "alarmSegue") {
            let 👩🏻‍💻: AlarmViewController = (segue.destination as? AlarmViewController)!
            👩🏻‍💻.AlarmTime = ddddd.date
            👩🏻‍💻.FadeTime = list[durationTimePicker.selectedRow(inComponent:0)]
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row].description + " min"
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        let 🗂 = FileManager.default
        let 📍 = URL(string: 🗂.urls(for: .documentDirectory, in: .userDomainMask)[0].absoluteString + "selectedMp3.mp3")!
        
        do{ try 🗂.removeItem(at: 📍)
        }catch{ print("👿") }
        
        do{ try 🗂.copyItem(at: urls.first!, to: 📍)
        }catch{ print("👿") }
    }
    
}
