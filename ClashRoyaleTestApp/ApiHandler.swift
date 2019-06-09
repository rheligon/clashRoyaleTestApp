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
                        delegate?.success(response: [], responseFrom: ServerMethods.GetCards)
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
                return "Invalid URL: \(url) - \(error.localizedDescription)"
            case .parameterEncodingFailed:
                return "Parameter encoding failed: \(error.localizedDescription)"
            case .multipartEncodingFailed:
                return "Multipart encoding failed: \(error.localizedDescription)"
            case .responseValidationFailed:
                return "Response validation failed: \(error.localizedDescription)"
            case .responseSerializationFailed:
                return "Response serialization failed: \(error.localizedDescription)"
            }
        } else if let error = response.result.error as? URLError {
            return "URLError occurred: \(error)"
        } else {
            if let err = response.result.error{
                return "Unknown error: \(err)"
            }else{
                let msg = "Contact Administrator"
                return msg
            }
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
        
        print("---------------- HUBO UN ERROR ----------------")
        print(error)
        
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
