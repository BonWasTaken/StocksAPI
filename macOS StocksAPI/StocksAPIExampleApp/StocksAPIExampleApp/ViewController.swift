//
//  ViewController.swift
//  StocksAPIExampleApp
//
//  Created by Michal Zavadil on 05/06/2018.
//  Copyright © 2018 Michal Zavadil. All rights reserved.
//

import Cocoa
import StocksAPI

class ViewController: NSViewController {

    @IBOutlet weak var lbl1: NSTextField!
    @IBOutlet weak var lbl2: NSTextField!
    @IBOutlet weak var lbl3: NSTextField!
    @IBOutlet weak var lbl4: NSTextField!
    @IBOutlet weak var lbl5: NSTextField!
    @IBOutlet weak var lbl6: NSTextField!
    @IBOutlet weak var lbl7: NSTextField!
    @IBOutlet weak var lbl8: NSTextField!
    @IBOutlet weak var lbl9: NSTextField!
    @IBOutlet weak var lbl10: NSTextField!
    @IBOutlet weak var lbl11: NSTextField!
    @IBOutlet weak var lbl12: NSTextField!
    
    @IBOutlet weak var txtBox1: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func btn1(_ sender: Any) {

        let rt = realtime()
        rt.stock(symbol: txtBox1.stringValue)
        
        lbl1.stringValue = String(rt.getConsolidatedShares())
        lbl2.stringValue = String(rt.getPrice())
        lbl3.stringValue = String(rt.getVolume())
        lbl4.stringValue = String(rt.getTodaysHigh())
        lbl5.stringValue = String(rt.getTodaysLow())
        lbl6.stringValue = rt.getMarketStatus()
        lbl7.stringValue = rt.getMarketCloseTime()
        lbl8.stringValue = rt.getTradeDate()
        lbl9.stringValue = rt.getServerTime()
        lbl10.stringValue = String(round(1000*rt.getChange())/1000)
        lbl11.stringValue = String(round(1000*rt.getPercentChange())/1000)
        lbl12.stringValue = String(rt.getPreviousClose())
        
    }
    
}

