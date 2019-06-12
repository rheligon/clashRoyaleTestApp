//
//  ApiHandler.swift
//  ClashRoyaleTestApp
//
//  Created by Roberto Heligon on 6/8/19.
//  Copyright © Roberto Heligon. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class ApiHandler: NSObject {
    
    public let serverURL = "http://www.clashapi.xyz"
    private let APIQueue = DispatchQueue(label: "com.clashTestApp.apiQueue", attributes: .concurrent)
    
    override init() {
        super.init()
    }
    
    //MARK: - Get Cards information
    public func getCardsInfo(delegate: APIResponseDelegate?){
        
        Alamofire.request(self.serverURL + ServerMethods.GetCards.url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON(queue: APIQueue) { (responseData) -> Void in
            
            //Check for errors
            let statusCode = responseData.response?.statusCode
            if statusCode != 200 {
                DispatchQueue.main.async {
                    delegate?.failure(error: self.checkError(response: responseData), delegate: delegate, api: self)
                }
                return
            }
            
            //Parse Response
            if((responseData.result.value) != nil) {
                let resJsonVar = JSON(responseData.result.value!)
                
                if let cardsArray = (resJsonVar.array?.compactMap { return Card.buildCard(json: $0) }) {
                    DispatchQueue.main.async {
                        delegate?.success(response: cardsArray, responseFrom: ServerMethods.GetCards)
                    }
                }else{
                    DispatchQueue.main.async {
                        let msg = "There has been a serialization error, please try again"
                        delegate?.failure(error: msg, delegate: delegate, api: self)
                    }
                }
            }
        }
    }

    //MARK: - Function to check the error returned
    private func checkError(response: Alamofire.DataResponse<Any>) -> String{
        
        if let error = response.result.error as? AFError {
            switch error {
            case .invalidURL(let url):
                return "Invalid URL: \(url)"
            case .parameterEncodingFailed:
                return "Parameter encoding failed"
            case .multipartEncodingFailed:
                return "Multipart encoding failed"
            case .responseValidationFailed:
                return "Response validation failed"
            case .responseSerializationFailed:
                return "Response serialization failed"
            }
        } else if let _ = response.result.error as? URLError {
            return "URL Error occurred"
        } else {
            return "Unknown error, please contact the administrator"
        }
    }
}


//MARK: - Defining API Delegate Protocol
protocol APIResponseDelegate:class {
    func success(response: Any, responseFrom: ServerMethods?)
    func failure(error: String, delegate: APIResponseDelegate?, api: ApiHandler?)
}

//MARK: - Define failure function so It's optional in the delegates
extension APIResponseDelegate {
    func failure(error: String, delegate: APIResponseDelegate?, api: ApiHandler?) {
        
        let vc: UIViewController? = delegate as? UIViewController
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        vc?.present(alert, animated: true, completion: nil)
    }
}

//MARK: Enum with all methods urls
enum ServerMethods: String {
    case GetCards = "/api/cards"
    case GetImage = "/images/cards/"
    
    var url: String {
        return self.rawValue
    }
}
