//
//  CreatePlaylistViewController.swift
//  Spotify
//
//  Created by Poorav Lukhi on 07/12/24.
//

import UIKit
import Toast_Swift

class CreatePlaylistViewController: UIViewController {
    
    //MARK: - Outlets
    
    ///View
    @IBOutlet weak var screenMainView: UIView!
    @IBOutlet weak var addPlaylistsView: UIView!
    @IBOutlet weak var gestureRecogniserView: UIView!
    @IBOutlet weak var screenBottomView: UIView!
    @IBOutlet weak var createPlaylistsView: UIView!
    
    ///Label
    @IBOutlet weak var playlistsLabel: UILabel!
    @IBOutlet weak var createPlaylistsMessageLabel: UILabel!
    @IBOutlet weak var playlistsNameLabel: UILabel!
    
    ///Button
    @IBOutlet weak var createPlaylistButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    ///Image View
    @IBOutlet weak var playlistImageView: UIImageView!
    
    ///Text Field
    @IBOutlet weak var playlistNameTextField: UITextField!
    
    // ViewModel for managing data and state
    var viewModel = CreatePlaylistViewModel()
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Perform any additional setup after loading the view
        setupUI()
    }
    
    /// Set up the user interface elements on the screen
    private func setupUI() {
        view.layoutIfNeeded()
        
        view.backgroundColor = .clear
        
        addPlaylistsView.setRoundCorners([.topLeft, .topRight], radius: CornerRadiusSize.C20)
        addPlaylistsView.backgroundColor = Colors.CustomGray
        screenBottomView.backgroundColor = Colors.Clear
        
        playlistsLabel.setSemiboldLabel(title: Localization.Library.Section.playlists, size: FontSize.title, color: Colors.White)
        createPlaylistsMessageLabel.setLabel(title: Localization.Playlist.createPlaylistPrompt, size: FontSize.extraLarge, color: Colors.GrayText)
        
        createPlaylistsView.setRoundCorners([.topLeft, .topRight], radius: CornerRadiusSize.C20)
        createPlaylistsView.backgroundColor = Colors.CustomGray
        createPlaylistsView.isHidden = true
        
        playlistsNameLabel.setBoldLabel(title: Localization.Playlist.namePrompt, size: FontSize.huge, color: Colors.White)
        
        confirmButton.setSemiBoldButton(title: Localization.Playlist.Action.confirm, size: FontSize.title, color: Colors.Black, bgColor: Colors.CustomGreen)
        
        playlistNameTextField.setSemiboldTextfield(placeholder: Localization.Playlist.Prompt.enterPlaylistName, size: FontSize.title, color: Colors.White)
        playlistNameTextField.delegate = self
        playlistNameTextField.tintColor = Colors.White
        
        confirmButton.setRoundedView()
        
        animateAddPlaylistsViewOut()
        addTapGesture()
    }
    
    func addTapGesture() {
        // Create a tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissViewController))
        tapGesture.cancelsTouchesInView = false // Allow touches to pass through to other elements if needed
        gestureRecogniserView.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissViewController() {
        // Dismiss the current view controller
        self.dismiss(animated: true, completion: nil)
    }

    // Function to animate the dismissal of the "Add Playlists" view
    func animateAddPlaylistsViewOut() {
        // Perform the animation with keyframes
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [], animations: {
            // Move the 'addPlaylistsView' outside of the screen (off-screen)
            self.addPlaylistsView.center.y -= (self.addPlaylistsView.bounds.height + self.addPlaylistsView.frame.origin.y + self.addPlaylistsView.frame.size.height)
        }, completion: { (finished: Bool) in
            if finished {
                // Change the background color of the 'screenBottomView' to a custom gray color
                self.screenBottomView.backgroundColor = Colors.CustomGray
            }
        })
    }
    
    // MARK: - Button Actions
    
    /// Action triggered when the add library button is tapped
    @IBAction func createPlaylistButtonTouchUpInside(_ sender: UIButton) {
        playlistNameTextField.resignFirstResponder()
        // Add functionality for adding to the library
        createPlaylistsView.isHidden = false
    }
    
    @IBAction func confirmButtonTouchUpInside(_ sender: UIButton) {
        playlistNameTextField.resignFirstResponder()
        // Add functionality for adding to the library
        let playlistName = playlistNameTextField.text ?? ""

        if(playlistName.blank()) {
            self.view.makeToast(Localization.Playlist.Prompt.enterPlaylistName)
            return
        }
        
        viewModel.delegate?.createPlaylist(playlistName)
        dismiss(animated: true)
    }
}

extension CreatePlaylistViewController: UITextFieldDelegate {
    // Dismiss the keyboard when the "Return" key is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Dismiss the keyboard
        return true
    }
}
