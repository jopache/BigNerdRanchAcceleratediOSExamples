import UIKit

class MoodListViewController: UITableViewController {
    // MARK: variables
    private var moodEntries: [MoodEntry] = []
    
    // MARK: overrides
    // TODO: Test putting overrides in extension
}

extension MoodListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moodEntries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let moodEntry = moodEntries[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        cell.imageView?.image = moodEntry.mood.image
        cell.textLabel?.text = "I was \(moodEntry.mood.name)"
        cell.detailTextLabel?.text = "on \(DateFormatter.localizedString(from: moodEntry.timestamp, dateStyle: .medium, timeStyle: .medium))"
        
        return cell
        
    }
}

extension MoodListViewController: MoodsConfigurable {
    func add(_ moodEntry: MoodEntry) {
        moodEntries.insert(moodEntry, at: 0)
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    }
}
