//
//  ViewController.swift
//  BitcoinTicker
//
//  Created by Angela Yu on 23/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    

    
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let symbolArray = ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]
    var currentSymbol : String = ""
    
    
    var finalURL = ""

    //Pre-setup IBOutlets
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        
        
    }

    
    //TODO: Place your 3 UIPickerView delegate methods here
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row] + symbolArray[row]
    }
   
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(symbolArray[row] + currencyArray[row])
        
        
        finalURL = baseURL + currencyArray[row]
        bitcoinPriceLabel(url: finalURL)
         print(finalURL)
        print(row)
        currentSymbol = symbolArray[row]
        print(currentSymbol)
    }
    

    
    
    
//    
//    //MARK: - Networking
//    /***************************************************************/
//    
       func bitcoinPriceLabel(url: String) {
        
        Alamofire.request(url, method: .get)
           .responseJSON { response in
                if response.result.isSuccess {

                    print("Sucess! Got the weather data")
                   let PriceJSON : JSON = JSON(response.result.value!)

                    self.updatePriceData(json: PriceJSON)

                } else {
                    print("Error: \(String(describing: response.result.error))")
                   self.bitcoinPriceLabel.text = "Connection Issue"
                }
           }
   }

    
//    //MARK: - JSON Parsing
//    /***************************************************************/
//    
      func updatePriceData(json : JSON) {
       
        if let priceResult = json["ask"].double {

           bitcoinPriceLabel.text = currentSymbol + String(priceResult)

        }
        else {
        bitcoinPriceLabel.text = "Price Unavailable"
       
    }
    




}
}
