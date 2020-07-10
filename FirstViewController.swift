//
//  FirstViewController.swift
//  Oasis
//
//  Created by Brian Jung on 7/1/20.
//  Copyright © 2020 Brian Jung. All rights reserved.
//

import UIKit

class FirstViewController:UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var cityPicker: UIPickerView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var Image1: UIImageView!
    @IBOutlet weak var Image2: UIImageView!
    @IBOutlet weak var Image3: UIImageView!
    @IBOutlet weak var Image4: UIImageView!
    @IBOutlet weak var Image5: UIImageView!
    
    
    var cityPickerData: [String] = [String]()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cityPickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cityPickerData[row]
    }
    
    @IBAction func CulturePressed(_ sender: UIButton) {
        Image1.image = UIImage(named: "Culture1")
        Image2.image = UIImage(named: "Culture2")
        Image3.image = UIImage(named: "Culture3")
        Image4.image = UIImage(named: "Culture4")
        Image5.image = UIImage(named: "Culture5")
        
    }
    
    @IBAction func AdventurePressed(_ sender: UIButton) {
        Image1.image = UIImage(named: "Adventure1")
        Image2.image = UIImage(named: "Adventure2")
        Image3.image = UIImage(named: "Adventure3")
        Image4.image = UIImage(named: "Adventure4")
        Image5.image = UIImage(named: "Adventure5")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cityPickerData = ["Hong Kong", "London", "New York", "Los Angeles"]
        cityPicker.delegate = self
        cityPicker.dataSource = self
        cityPicker.setValue(UIColor.white, forKeyPath: "textColor")

    }
}


