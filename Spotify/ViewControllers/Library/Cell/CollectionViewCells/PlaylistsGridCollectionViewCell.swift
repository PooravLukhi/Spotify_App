//
//  PlaylistsGridCollectionViewCell.swift
//  Spotify
//
//  Created by Poorav Lukhi on 07/12/24.
//

import UIKit

class PlaylistsGridCollectionViewCell: UICollectionViewCell {

    //MARK: - Outlets
    
    ///Image View
    @IBOutlet weak var trackOneImageView: UIImageView!
    @IBOutlet weak var trackTwoImageView: UIImageView!
    @IBOutlet weak var trackThreeImageView: UIImageView!
    @IBOutlet weak var trackFourImageView: UIImageView!
    
    ///Label
    @IBOutlet weak var musicAlbumInfoLabel: UILabel!
    
    //View
    @IBOutlet weak var cellGridView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func cellDataSetup(playlistData: PlaylistData) {
        
        // Create an array of image views for easier handling
        let imageViews: [UIImageView] = [trackOneImageView, trackTwoImageView, trackThreeImageView, trackFourImageView]
        
        if let playlistName = playlistData.PlaylistName {
            musicAlbumInfoLabel.attributedText =  GlobalFunctions.createAttributedString(string1: playlistName, string2: "\n\(Localization.Library.Section.playlists) • \(playlistData.MusicTrack?.count ?? 0) \(Localization.Library.Section.songs)", color1: Colors.White, color2: Colors.GrayText, font1: .themeBoldFont(of: FontSize.title), font2: .themeMediumFont(of: FontSize.subtitle), includeSpace: true)
        }
        
        trackOneImageView.image = AppImageName.ic_music_album
        trackTwoImageView.image = AppImageName.ic_music_album
        trackThreeImageView.image = AppImageName.ic_music_album
        trackFourImageView.image = AppImageName.ic_music_album
        
        // Check if musicPlaylist exists
        if let musicPlaylist = playlistData.MusicTrack {
            let playlistCount = musicPlaylist.count
            
            // Loop through the musicPlaylist and corresponding image views
            for index in 0..<min(playlistCount, imageViews.count) {
                let track = musicPlaylist[index]
                
                // Check if artwork URL is available
                if let trackImageUrl = track.artworkUrl100,
                   let imageUrl = GlobalFunctions.convertStringToUrl(trackImageUrl) {
                    
                    // Set the image for the corresponding image view
                    imageViews[index].sd_setImage(with: imageUrl, placeholderImage: AppImageName.ic_music_album, completed: { image, error, cacheType, url in
                        if let error = error {
                            print("Error loading image for track at index \(index): \(error.localizedDescription)")
                        }
                    })
                } else {
                    // In case no artwork URL is found, set the placeholder
                    imageViews[index].image = AppImageName.ic_music_album
                }
            }
        } else {
            // If there is no musicPlaylist data, you can optionally set placeholder images
            imageViews.forEach { $0.image = AppImageName.ic_music_album }
        }
    }
}
