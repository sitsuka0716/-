
import UIKit

class CalendarViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var calendarCollectionView: UICollectionView!
    @IBOutlet weak var monthAndYearLabel: UILabel!
    @IBAction func nextMonthButton(_ sender: Any) {
        monthOnMyCalendar += 1
        if monthOnMyCalendar > 12 {
            monthOnMyCalendar = 1
            yearOnMyCalendar += 1
        }
        setUp()
    }
    @IBAction func lastMonthButton(_ sender: Any) {
        monthOnMyCalendar -= 1
        if monthOnMyCalendar < 1 {
            monthOnMyCalendar = 12
            yearOnMyCalendar -= 1
        }
        setUp()
    }
    
    
    var currentYear = Calendar.current.component(.year, from: Date())
    var currentMonth = Calendar.current.component(.month, from: Date())
    var currentDay = Calendar.current.component(.day, from: Date())
    var yearOnMyCalendar = Calendar.current.component(.year, from: Date())
    var monthOnMyCalendar = Calendar.current.component(.month, from: Date())
    var dayOnMyCalendar = Calendar.current.component(.day, from: Date())
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    var numberOfDaysOfThisMonth: Int {
        let dateComponents = DateComponents(year: yearOnMyCalendar, month: monthOnMyCalendar)
        let date = Calendar.current.date(from: dateComponents)!
        let range = Calendar.current.range(of: .day, in: .month, for: date)
        return range?.count ?? 0
    }
    var whatTheFirstDayInThisMonth: Int {
        let dateComponents = DateComponents(year: yearOnMyCalendar, month: monthOnMyCalendar)
        let date = Calendar.current.date(from: dateComponents)!
        return Calendar.current.component(.weekday, from: date)
    }
    var addEmptyItemsInThisMonth: Int {
        return whatTheFirstDayInThisMonth - 1
    }
    var selectedIndexpathRow = 0
    
    func setUp() {
        selectedIndexpathRow = Calendar.current.component(.day, from: Date()) - 1
        monthAndYearLabel.text = months[monthOnMyCalendar-1] + " \(yearOnMyCalendar)"
        calendarCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 選取的cell的indexpath.row
        selectedIndexpathRow = indexPath.row
        collectionView.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfDaysOfThisMonth + addEmptyItemsInThisMonth
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 檢查是否有可回收的cell，若有就回傳一個cell，若沒有就產生一個cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        // 取得contentView上面的第一個物件
        if let dayLabel = cell.contentView.subviews[0] as? UILabel {
            dayLabel.textColor = UIColor.black
            dayLabel.backgroundColor = UIColor.white
            if indexPath.row < addEmptyItemsInThisMonth {
                dayLabel.text = ""
            }
            else {
                dayLabel.text = "\(indexPath.row + 1 - addEmptyItemsInThisMonth)"
                if currentYear == yearOnMyCalendar && currentMonth == monthOnMyCalendar && currentDay == (indexPath.row + 1 - addEmptyItemsInThisMonth) {
                    dayLabel.textColor = UIColor.red
                }
            }
            // 選取的cell是幾號
            if indexPath.row == selectedIndexpathRow && indexPath.row >= addEmptyItemsInThisMonth {
                dayLabel.textColor = UIColor.white
                dayLabel.backgroundColor = UIColor.red
                if let dayLabeltext = dayLabel.text, let selectedDay = Int(dayLabeltext) {
                    dayOnMyCalendar = selectedDay
                }
                print("dayOnMyCalendar = \(dayOnMyCalendar)")
            }
        }
        return cell
    }
    
    // 設定每一個cell的左右間隔為0
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // 設定每一個cell的上下間隔為0
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // 設定每一個cell的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 7
        return CGSize(width: width, height: 40)
    }
    
    /*
    // viewController的方法，當螢幕轉向時會執行
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        // 重新設定每一個cell的大小
        calendarCollectionView.collectionViewLayout.invalidateLayout()
        calendarCollectionView.reloadData()
    }
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = true
        setUp()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let controller = segue.destination as? JournalTableViewController
        controller?.selectedDay = dayOnMyCalendar
    }
    

}
