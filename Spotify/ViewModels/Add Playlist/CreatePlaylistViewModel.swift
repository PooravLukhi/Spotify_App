//
//  CreatePlaylistViewModel.swift
//  Spotify
//
//  Created by Poorav Lukhi on 07/12/24.
//

import Foundation
import UIKit


protocol CreatePlaylistProtocol: AnyObject {
    func createPlaylist(_ playlistName: String)
}

class CreatePlaylistViewModel: NSObject {
    
    weak var delegate: CreatePlaylistProtocol?

}
