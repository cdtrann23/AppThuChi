import UIKit

class Popup: UIView {
    @IBOutlet weak var dateTimeTextField: UITextField!
    @IBOutlet weak var dateTimePicker: UIDatePicker!
    @IBOutlet weak var backToView: UIButton!
    
    public var complection: ((String?) -> Void)?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        selectdate()
    }
    
    func xibSetup(frame: CGRect) {
        let view = loadXib()
        view.frame = frame
        addSubview(view)

    }

    
    func loadXib() -> UIView  {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "Popup", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        return view!
        
    }
    
    func selectdate() {
        dateTimePicker.datePickerMode = .date
        
        dateTimePicker.addTarget(self, action: #selector(dateChange(picker:)), for: UIControl.Event.valueChanged)
        dateTimePicker.preferredDatePickerStyle = .wheels
        dateTimePicker.maximumDate = Date()
    
        dateTimeTextField.inputView = dateTimePicker
        dateTimeTextField.text = formatDate(date: Date())
    }
    
    @objc func dateChange(picker: UIDatePicker)
    {
        dateTimeTextField.text = formatDate(date: picker.date)
    }
    
    func formatDate(date: Date) -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: date)
    }

}
