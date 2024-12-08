//
//  PlaylistsTableViewCell.swift
//  Spotify
//
//  Created by Poorav Lukhi on 07/12/24.
//

import UIKit
import SDWebImage

class PlaylistsTableViewCell: UITableViewCell {
    
    ///Button
    @IBOutlet weak var moreOptionButton: UIButton!
    @IBOutlet weak var addMusicButton: UIButton!

    ///Label
    @IBOutlet weak var musicInfoLabel: UILabel!
    @IBOutlet weak var musicNameLabel: UILabel!
    
    ///Image View
    @IBOutlet weak var musicImageView: UIImageView!
    
    ///View
    @IBOutlet weak var moreOptionView: UIView!
    @IBOutlet weak var addMusicView: UIView!
    @IBOutlet weak var cellMainView: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    // This method should be called when updating the layout
    func cellDataSetup(musicTrackData: MusicTrackListResponseData, indexNo: Int, isAddView: Bool = false, isAlreadyAdded: Bool = false) {
     
        moreOptionView.isHidden = isAddView
        
        if(isAlreadyAdded && isAddView) {
            addMusicView.isHidden = true
        } else {
            addMusicView.isHidden = !isAddView
        }
        
        if let trackImageUrl = musicTrackData.artworkUrl100 {
            if let imageUrl = GlobalFunctions.convertStringToUrl(trackImageUrl) {
                musicImageView.sd_setImage(with:  imageUrl, placeholderImage: AppImageName.ic_loader, completed: nil)
            }
        }

        if let trackName = musicTrackData.trackName {
            musicNameLabel.setSemiboldLabel(title: trackName, size: FontSize.subtitle, color: Colors.White)
        }
        
        if let artistName = musicTrackData.artistName {
            musicInfoLabel.setSemiboldLabel(title: artistName, size: FontSize.extraLarge, color: Colors.GrayText)
        }
        
        if let collectionName = musicTrackData.collectionName {
            if let musicInfoText = musicInfoLabel.text {
                musicInfoLabel.text = musicInfoText + ", collectionName"
            } else {
                musicInfoLabel.setSemiboldLabel(title: collectionName, size: FontSize.subtitle, color: Colors.White)
            }
        }
    }
}
