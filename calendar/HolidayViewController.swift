//
//  HolidayViewController.swift
//  Day2Day
//
//  Created by Kam Hong Chan on 18/06/2018.
//  Copyright © 2018 Kam Hong Chan. All rights reserved.
//

import UIKit
import Foundation

class HolidayViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    if let urlStr = "https://drive.ntou.edu.tw/STgj/document.json?a=r11a0Y6l-4M&dl=1&ht=NTA0ODhkZjMyOTZkNWI3OTFhMWVkZGI0NjA1ZjIxYTA=".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlStr) {
        let task = URLSession.shared.dataTask(with: url) { (data, response , error) in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            if let data = data, let holidayResults = try?decoder.decode(HolidayResults.self, from: data)
            {
                for Holiday in holidayResults.results {
                    print(Holiday)
                }
            } else {
                print("error")
            }
        }
        task.resume()
        }}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
