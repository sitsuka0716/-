
import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var lastMonth: UIButton!
    @IBOutlet weak var nextMonth: UIButton!
    @IBOutlet weak var calendar: UICollectionView!
    @IBOutlet weak var back2day: UIButton!
    
    var currentYear = Calendar.current.component(.year, from: Date())
    var currentmonth = Calendar.current.component(.month, from: Date())
    var currentday = Calendar.current.component(.day, from: Date())
    
    var nowYear = Calendar.current.component(.year, from: Date())
    var nowmonth = Calendar.current.component(.month, from: Date())
    var nowday = Calendar.current.component(.day, from: Date())
    
    var months = ["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"]
    
    @IBAction func lastMonth(_ sender: UIButton) {
        currentmonth = currentmonth - 1
        if currentmonth == 0{
            currentmonth = 12
            currentYear = currentYear-1
        }
        setUp()
    }
    
    @IBAction func nextMonth(_ sender: UIButton) {
        currentmonth = currentmonth + 1
        if currentmonth == 13{
            currentmonth = 1
            currentYear = currentYear+1
        }
        setUp()
    }
    
    @IBAction func back2day(_ sender: UIButton) {
        currentYear = Calendar.current.component(.year, from: Date())
        currentmonth = Calendar.current.component(.month, from: Date())
        setUp()
        calendar.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationController?.navigationBar.prefersLargeTitles=true
        navigationController?.navigationBar.largeTitleTextAttributes=[NSAttributedStringKey.foregroundColor:UIColor.black]
        setUp()
    }
    
    var numberofDaysInThisMonth:Int{
        let dateComponents = DateComponents(year:currentYear,month:currentmonth)
        let date = Calendar.current.date(from: dateComponents)!
        let range = Calendar.current.range(of:.day, in: .month, for: date)
        return range?.count ?? 0
    }
    
    var whatDayIsIt:Int{
        let dateComponents = DateComponents(year:currentYear,month:currentmonth)
        let date = Calendar.current.date(from: dateComponents)!
        return Calendar.current.component(.weekday, from:date)
    }
    
    var howManyItemsShouldIAdd:Int{
        return whatDayIsIt - 1
    }
    
    
    func setUp(){
        timeLabel.text = "\(currentYear) " +  months[currentmonth-1]
        calendar.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberofDaysInThisMonth + howManyItemsShouldIAdd
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell",for:indexPath)
        
        if  let textLabel = cell.contentView.subviews[0] as? UILabel{
            if indexPath.row < howManyItemsShouldIAdd {
               textLabel.text = ""
               textLabel.textColor = UIColor.black
            }
            else if (currentmonth==nowmonth && currentYear==nowYear &&   indexPath.row-howManyItemsShouldIAdd+1 == nowday) {
                textLabel.text="\(indexPath.row+1-howManyItemsShouldIAdd)"
                textLabel.textColor = UIColor.red
            }
            else{
                textLabel.text="\(indexPath.row+1-howManyItemsShouldIAdd)"
                textLabel.textColor = UIColor.black
            }
        }
        return cell
    }
    
    
    
    
}

