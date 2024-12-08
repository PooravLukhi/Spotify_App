//
//  HttpRequestManager.swift
//  Spotify
//
//  Created by Poorav Lukhi on 07/12/24.
//


import Foundation
import Alamofire
import ObjectMapper

class WebServicesCollection {
    static let sharedInstance = WebServicesCollection()
    // METHODS
    init() {}
    
    //MARK: - SERVICE METHOD
    
    func searchMusicListService(_ searchText: String, responce:@escaping (_ data:[MusicTrackListResponseData]?, _ error: NSError?, _ message: String?, _ rStatus : Int) -> Void){
        
        let URL =  (WebServicePrefix.GetWSUrl()) as String
        
        HttpRequestManager.sharedInstance.postParmRequest(endpointURL: URL, searchText: searchText) { (data, error, message, respObject, rStatus) in
            
            if error != nil{
                responce(nil, error, message, rStatus)
            }
            else{
                guard let responseArray:[MusicTrackListResponseData] = data else {
                    responce(nil, error, message, rStatus)
                    return
                }
                responce(responseArray, nil, message, rStatus)
            }
        }
    }
}

public enum WSRequestType : Int {
    case getReport
}

struct WebServicePrefix {
    static func GetWSUrl() -> String{
        return "https://itunes.apple.com/search"
    }
}

class HttpRequestManager {
    
    static let sharedInstance = HttpRequestManager()
    
    var Message : String = ""
    var resObjects : AnyObject!
    
    // METHODS
    
    init() {}
    
    //MARK:- POST PARAMETER REQUEST
    

    func postParmRequest(endpointURL: String, searchText: String, responseData: @escaping (_ data: [MusicTrackListResponseData]?, _ error: NSError?, _ message: String, _ responseObject: Any?, _ responseStatus: Int) -> Void) {

        let query = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "\(endpointURL)?term=\(query)&entity=musicTrack&country=us"
        
        print("apiURL => \(urlString)")
        
        // Indicating network activity
        ShowNetworkIndicator(true)
        
        AF.request(urlString, method: .get).validate().responseJSON { response in
            // Hiding network activity
            self.ShowNetworkIndicator(false)
            
            switch response.result {
            case .success(let value):
                guard let responseJSON = value as? [String: Any] else {
                    responseData(nil, nil, "Invalid response format", value, 0)
                    return
                }
                
                if let results = responseJSON["results"] as? [[String: Any]] {
                    
                    let musicTrackListData = Mapper<MusicTrackListResponseData>().mapArray(JSONArray: results)
                    
                    responseData(musicTrackListData, nil, "", value, 1)

                }

                
                print("responseJSON => \(responseJSON)")
                
            case .failure(let error):
                print("Error => \(error.localizedDescription)")
                responseData(nil, error as NSError, "Request failed", nil, 0)
            }
        }
    }

    //MARK: - Network indicator
    public func ShowNetworkIndicator(_ xx :Bool) {
        // UIApplication.shared.isNetworkActivityIndicatorVisible = xx
    }
}
