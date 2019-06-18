
import UIKit

class JournalTableViewController: UITableViewController {
    
    var journals = [Journal]()
    var selectedDay = 0
    
    @IBAction func goBackToJournalTableViewControllerWithSegue(segue: UIStoryboardSegue) {
        let controllerInEdit = segue.source as? EditTableViewController
        if let journal = controllerInEdit?.journal {
            if let row = tableView.indexPathForSelectedRow?.row  {
                journals[row] = journal
            } else {
                journals.insert(journal, at: 0)
            }
            Journal.saveToFile(journals: journals)
            tableView.reloadData()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        if let journals = Journal.readJournalsFromFile() {
            self.journals = journals
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        journals.remove(at: indexPath.row)
        Journal.saveToFile(journals: journals)
        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var numberOfJournalInSelectedDay = 0
        for i in 0..<journals.count {
            let day = Calendar.current.component(.day, from: journals[i].date)
            if day == selectedDay {
                numberOfJournalInSelectedDay += 1
            }
        }
        return journals.count
        //return numberOfJournalInSelectedDay
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath) as! JournalTableViewCell
        let journal = journals[indexPath.row]
        var selectedDate: Int {
            return Calendar.current.component(.day, from: journal.date) - 1
        }
        print("selectedDate = \(selectedDate)")
        print("selectedDay = \(selectedDay)")
        //if selectedDate == selectedDay {
            cell.descriptionLabel.text = journal.description
            cell.bulletLabel.text = journal.bullet
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM月 dd日 yyyy年"
            cell.dateLabel.text = dateFormatter.string(from: journal.date)
        //}
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let controller = segue.destination as? EditTableViewController
        if let row = tableView.indexPathForSelectedRow?.row {
            controller?.journal = journals[row]
        }
    }
    

}
