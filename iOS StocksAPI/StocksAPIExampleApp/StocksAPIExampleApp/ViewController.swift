//
//  ViewController.swift
//  StocksAPIExampleApp
//
//  Created by Michal Zavadil on 05/06/2018.
//  Copyright © 2018 Michal Zavadil. All rights reserved.
//

import UIKit
import StocksAPI

class ViewController: UIViewController {

    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var lbl4: UILabel!
    @IBOutlet weak var lbl5: UILabel!
    @IBOutlet weak var lbl6: UILabel!
    
    @IBOutlet weak var txtBox1: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btn1(_ sender: Any) {
        
        let rt = realtime()
        rt.stock(symbol: txtBox1.text!)

        lbl1.text = String(rt.getPrice())
        lbl2.text = String(round(1000*rt.getChange())/1000)
        lbl3.text = String(round(1000*rt.getPercentChange())/1000)
        lbl4.text = String(rt.getVolume())
        lbl5.text = String(rt.getPreviousClose())
        lbl6.text = String(rt.getMarketStatus())
        
    }
    
}

