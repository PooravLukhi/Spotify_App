//
//  LibraryViewModel.swift
//  Spotify
//
//  Created by Poorav Lukhi on 07/12/24.
//

import Foundation
import UIKit

class LibraryViewModel: NSObject {
    var isGridView = false // Track current view mode
    
    var playlistName = ""
    
    var isSearchMode = false
    
    var isEdit = false
    var selectedIndexNumber: Int?
    
    var lastInputTime: Date?

    var timer: Timer?
    
    var userPlaylistData = [PlaylistData]()
    
    var searchMusicTrackListData = [MusicTrackListResponseData]()
    var addedMusicTrackListData = [MusicTrackListResponseData]()

    func callSearchMusicListService(_ searchText: String, completion: @escaping (_ status: Bool, _ message: String) -> Void) {

        WebServicesCollection.sharedInstance.searchMusicListService(searchText) { [weak self] (data, error, message, rStatus) in
            if(rStatus == 1) {
                if let responseData = data {
                    self?.searchMusicTrackListData = responseData
                    completion(true, message ?? "")
                } else {
                    completion(false, message ?? "")
                }
            } else {
                completion(false, message ?? "")
            }
        }
    }

}
