import UIKit

class MoodSelectionViewController: UIViewController {
    // MARK: Outlets
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var addMoodButton: UIButton!
    
    // MARK: Variables
    var moods: [Mood] = [] {
        didSet {
            moodButtons = moods.map { mood in
               let moodButton = UIButton()
                moodButton.setImage(mood.image, for: .normal)
                moodButton.imageView?.contentMode = .scaleAspectFit
                moodButton.addTarget(self, action: #selector(moodSelectionChanged(_:)), for: .touchUpInside)
                return moodButton
            }
            currentMood  = moods.first
        }
    }
    
    var currentMood: Mood? {
        didSet {
            guard let currentMood = currentMood else {
                addMoodButton?.setTitle(nil, for: .normal)
                addMoodButton?.backgroundColor = nil
                return
            }
            
            addMoodButton?.setTitle("I'm currently \(currentMood.name)", for: .normal)
            addMoodButton?.backgroundColor = currentMood.color
        }
    }
    
    var moodsConfigurable: MoodsConfigurable!
    
    var moodButtons: [UIButton] = [] {
        didSet {
            oldValue.forEach { $0.removeFromSuperview() }
            moodButtons.forEach { stackView.addArrangedSubview($0) }
        }
    }
    
    // MARK: Functions
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        moods = [.happy, .sad, .angry, .goofy, .crying, .confused, .sleepy, .meh]
        addMoodButton.layer.cornerRadius = addMoodButton.bounds.height / 2
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "embedContainerViewController"?:
            guard let moodsConfigurable = segue.destination as? MoodsConfigurable else {
                preconditionFailure("Embedded view controller expected to conform to MoodsConfigurable")
            }
            self.moodsConfigurable = moodsConfigurable
            segue.destination.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: 160, right: 0)
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }
    
    // MARK: Actions
    @objc func moodSelectionChanged(_ sender: UIButton) {
        guard let selectedIndex = moodButtons.index(of: sender) else {
            preconditionFailure("Unable to find the tapped button")
        }
        currentMood = moods[selectedIndex]
    }
    
    @IBAction func addMoodTapped(_ sender: Any) {
        guard let currentMood = currentMood else {
            return }
        let newMoodEntry = MoodEntry(mood: currentMood, timestamp: Date())
        moodsConfigurable.add(newMoodEntry)
    }
    
}


//class Promise<T> {
//
//    var subscribers: [(T) -> Void] = []
//
//    func done(result: T) -> Void {
//        subscribers.forEach(<#T##body: ((T) -> Void) throws -> Void##((T) -> Void) throws -> Void#>)
//    }
//
//    func then(callback: (T) -> Void) {
//
//    }
//}
//
//extension URLSession {
//    func dataTaskAsync(with request: URLRequest) throws -> (data: Data, response: URLResponse, error: Error?) {
//
//        dataTask(with: request) {
//
//        }
//        return (data: Data(), response: URLResponse(), error: nil)
//    }
//}

