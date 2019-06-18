

import UIKit

class Holiday1TableViewController: UITableViewController {
    
    var holidays = [HolidayResults]()
    var holidaydate = [String]()
    var holidayevent = [String]()
    var row :Int = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if let urlStr = "https://drive.ntou.edu.tw/STgj/document.json?a=r11a0Y6l-4M&dl=1&ht=NTA0ODhkZjMyOTZkNWI3OTFhMWVkZGI0NjA1ZjIxYTA=".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlStr) {
            let task = URLSession.shared.dataTask(with: url) { (data, response , error) in
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                if let data = data, let holidayResults = try?
                    decoder.decode(HolidayResults.self, from: data)
                {
                    for Holiday in holidayResults.results {
                        let holidaydate = self.holidaydate.append(Holiday.date)
                        let holidayevent = self.holidayevent.append(Holiday.name)
                    }
                } else {
                    print("error")
                }
            }
            task.resume()
        }
    
        sleep(2)
        print(holidayevent)
        print(holidaydate)
        print(UserDefaults.standard.dictionaryRepresentation())
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return holidayevent.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        let cell = tableView.dequeueReusableCell(withIdentifier: "holiday1cell", for: indexPath) as! Holiday1TableViewCell
        //if holidaydate.count > 0
        //{
        cell.hdateLabel.text = holidaydate[indexPath.row]
        cell.heventLabel.text = holidayevent[indexPath.row]
        //}
        //else{
        
        //}
        //tableView.reloadData()
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
