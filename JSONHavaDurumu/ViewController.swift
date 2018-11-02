//
//  ViewController.swift
//  JSONHavaDurumu
//
//  Created by Gokhan Gokova on 1.11.2018.
//  Copyright © 2018 Gokhan Gokova. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var ilText: UITextField!
    @IBOutlet weak var ilLabel: UILabel!
    var tempArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "https://api.openweathermap.org/data/2.5/weather?q=istanbul&lang=tr&appid=9b6db371af398e1e94d77d7012f4913c&units=metric"
        if let url = URL(string: url) {
            let request =  URLRequest(url: url)
            
            URLSession.shared.dataTask(with: request) { (data, response, err) in
                let Json = JSONDecoder()
                do {
                    let newJson = try Json.decode(Weather.self, from: data!)
                    DispatchQueue.main.sync {
                        self.ilLabel.text = "İstanbul için hava \(newJson.main.temp) derece ve \(newJson.weather[0].description)"
                    }
                    
                } catch {}
                }.resume()
        }
    }
    
    
    @IBAction func getirClicked(_ sender: Any) {
        let url = "https://api.openweathermap.org/data/2.5/weather?q=\(ilText.text!)&lang=tr&appid=9b6db371af398e1e94d77d7012f4913c&units=metric"
        
        if let url = (URL(string: url)) {
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                if error == nil {
                    if let data = data {
                        do {
                            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                            
                            let weather = jsonResult["weather"] as! NSArray
                            let desc = weather.firstObject as! [String : AnyObject]
                            
                            if let weatherDescription = desc["description"] as? String {
                                if let temp = jsonResult["main"] as? NSDictionary {
                                    if let tempNow = temp["temp"] as? Double {
                                        var tempp = Int(tempNow.rounded())
                                        DispatchQueue.main.sync {
                                            self.ilLabel.text = "\(self.ilText.text!) için hava \(tempp) derece ve \(weatherDescription)"
                                        }

                                    }
                                }
                            }

                        } catch {
                            
                        }
                    }
                    
                }
            }
            task.resume()
        }
        
    }
    
}
