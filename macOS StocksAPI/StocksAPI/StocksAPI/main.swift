//
//  File.swift
//  StocksAPI
//
//  Created by Michal Zavadil on 05/06/2018.
//  Copyright © 2018 Michal Zavadil. All rights reserved.
//

import Foundation

extension URLSession {
    func synchronousDataTask(urlrequest: URLRequest) -> (Data?, URLResponse?, Error?) {
        var data: Data?
        var response: URLResponse?
        var error: Error?
        
        let semaphore = DispatchSemaphore(value: 0)
        
        let dataTask = self.dataTask(with: urlrequest) {
            data = $0
            response = $1
            error = $2
            
            semaphore.signal()
        }
        dataTask.resume()
        
        _ = semaphore.wait(timeout: .distantFuture)
        
        return (data, response, error)
    }
}

public class realtime {
    
    struct stockBody: Decodable {
        let __type: String
        let ConsolidatedShares: Int
        let MarketCloseTime: String
        let MarketStatus: String
        let Price: Double
        let RefreshTime: String
        let ServerTime: String
        let high: Double
        let low: Double
        let previousclose: Double
        let totVol: Int
        let tradedate: String
    }
    
    struct stockStructure: Decodable {
        let result: stockBody
    }
    
    var downloadedData: Data?
    
    open func stock(symbol: String) -> Void {
            
        let url = URL(string: "https://www.nasdaq.com/callbacks/NLSHandler2.ashx")
        let ua = ["googlebot", "mediapartners-google", "googlebot-news", "adsbot-google", "googlebot-image", "googlebot-mobile", "bingbot", "msnbot", "msnbot-media", "Yahoo-MMCrawler", "DuckDuckBot", "YandexBot"]
        
        let randomIndex = Int(arc4random_uniform(UInt32(ua.count)))
        let randomUa = ua[randomIndex]
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue(randomUa, forHTTPHeaderField: "User-Agent")
        request.httpBody = "msg=Last&symbol=\(symbol)".data(using: String.Encoding.utf8)
        
        let (data, _, _) = URLSession.shared.synchronousDataTask(urlrequest: request)
        
        downloadedData =  data!
        
    }
    
    open func getPrice() -> Double {
        do {
            let json = try JSONDecoder().decode(stockStructure.self, from: self.downloadedData!)
            return json.result.Price
        }
        catch{
            return -1.0
        }
    }
    
    open func getChange() -> Double {
        do {
            let json = try JSONDecoder().decode(stockStructure.self, from: self.downloadedData!)
            
            let prevClose = json.result.previousclose
            let price = json.result.Price
            
            let val = price-prevClose
            
            return val
        }
        catch{
            return -1.0
        }
    }
    
    open func getPercentChange() -> Double {
        do {
            let json = try JSONDecoder().decode(stockStructure.self, from: self.downloadedData!)
            
            let prevClose = json.result.previousclose
            let price = json.result.Price
            
            let change = price-prevClose
            
            let percentChange = change/prevClose*100
            
            return percentChange
        }
        catch{
            return -1.0
        }
    }
    
    open func getVolume() -> Int {
        do {
            let json = try JSONDecoder().decode(stockStructure.self, from: self.downloadedData!)
            return json.result.totVol
        }
        catch{
            return -1
        }
    }
    
    open func getTodaysHigh() -> Double {
        do {
            let json = try JSONDecoder().decode(stockStructure.self, from: self.downloadedData!)
            return json.result.high
        }
        catch{
            return -1.0
        }
    }
    
    open func getTodaysLow() -> Double {
        do {
            let json = try JSONDecoder().decode(stockStructure.self, from: self.downloadedData!)
            return json.result.low
        }
        catch{
            return -1.0
        }
    }
    
    open func getPreviousClose() -> Double {
        do {
            let json = try JSONDecoder().decode(stockStructure.self, from: self.downloadedData!)
            return json.result.previousclose
        }
        catch{
            return -1.0
        }
    }
    
    open func getMarketStatus() -> String {
        do {
            let json = try JSONDecoder().decode(stockStructure.self, from: self.downloadedData!)
            return json.result.MarketStatus
        }
        catch{
            return "There was an error obtaining market's status."
        }
    }
    
    open func getMarketCloseTime() -> String {
        do {
            let json = try JSONDecoder().decode(stockStructure.self, from: self.downloadedData!)
            return json.result.MarketCloseTime
        }
        catch{
            return "There was an error obtaining market's close time"
        }
    }
    
    open func getConsolidatedShares() -> Int {
        do {
            let json = try JSONDecoder().decode(stockStructure.self, from: self.downloadedData!)
            return json.result.ConsolidatedShares
        }
        catch{
            return -1
        }
    }
    
    open func getServerTime() -> String {
        do {
            let json = try JSONDecoder().decode(stockStructure.self, from: self.downloadedData!)
            return json.result.ServerTime
        }
        catch{
            return "There was an error obtaining server's time"
        }
    }
    
    open func getTradeDate() -> String {
        do {
            let json = try JSONDecoder().decode(stockStructure.self, from: self.downloadedData!)
            return json.result.tradedate
        }
        catch{
            return "There was an error obtaining trade's date"
        }
    }
    
    /*open func getAll() -> String {
        do {
            let json = try JSONDecoder().decode(stockStructure.self, from: self.downloadedData!)
            print(json.result)
            return "-"
        }
        catch{
            return "Error"
        }
    }*/
    
    public init() {}
    
}

public class stocksAPI{
    
    open func getVersion() -> String {
        return "2.0"
    }
    
    open func getCreator() -> String {
        return "Michal Zavadil"
    }
    
    public init() {}
    
}

