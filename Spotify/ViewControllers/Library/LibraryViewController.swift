//
//  LibraryViewController.swift
//  Spotify
//
//  Created by Poorav Lukhi on 07/12/24.
//

import UIKit
import ObjectMapper

class LibraryViewController: UIViewController {
    //MARK: - Outlets
    
    ///View
    @IBOutlet weak var screenMainView: UIView!
    @IBOutlet weak var screenNavigationView: UIView!
    @IBOutlet weak var userProfileView: UIView!
    @IBOutlet weak var playlistsButtonView: UIView!
    @IBOutlet weak var playlistView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchManiView: UIView!
    @IBOutlet weak var playlistInfoView: UIView!
    
    ///Stack View
    @IBOutlet weak var mainStackView: UIStackView!
    
    ///Text Field
    @IBOutlet weak var searchMusicTextField: UITextField!
    
    ///Label
    @IBOutlet weak var screenTitleLabel: UILabel!
    @IBOutlet weak var playlistsLabel: UILabel!
    @IBOutlet weak var playlistsNameLabel: UILabel!
    @IBOutlet weak var noOfSongsLabel: UILabel!
    
    @IBOutlet weak var emptyPlaylistMessageLabel: UILabel!
    ///Button
    @IBOutlet weak var addLibraryButton: UIButton!
    @IBOutlet weak var toggleButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    ///Image View
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var backScreenImageView: UIImageView!
    @IBOutlet weak var addSongImageView: UIImageView!
    
    ///Collection View
    @IBOutlet weak var playlistsCollectionView: UICollectionView!
    
    ///Table View
    @IBOutlet weak var playlistsTableView: UITableView!
    
    // ViewModel for managing data and state
    var viewModel = LibraryViewModel()
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Perform any additional setup after loading the view
        setupUI()
    }
    
    /// Set up the user interface elements on the screen
    private func setupUI() {
        // Ensures that layout updates are done before UI changes
        view.layoutIfNeeded()
        
        //GlobalFunctions.removeAllUserPlaylistData()
        
        // Set the background color of the view
        self.view.backgroundColor = Colors.Black
        
        playlistView.isHidden = true
        
        // Configure the screen title label
        screenTitleLabel.setSemiboldLabel(
            title: Localization.Dashboard.Library.title,
            size: FontSize.displayMedium,
            color: Colors.White
        )
        
        // Configure user profile image view
        userProfileImageView.image = AppImageName.ic_user_profile
        userProfileImageView.setRoundedView()
        
        // Set corner radius and border for the playlists view
        let cornerRadiusSize = playlistsLabel.frame.size.height
        playlistsButtonView.setCornerRadiusWithBorder(
            cornerRadius: cornerRadiusSize,
            borderWidth: BorderSize.B01,
            borderColor: Colors.White
        )
        
        // Configure playlists label
        playlistsLabel.setLabel(
            title: Localization.Library.Section.playlists,
            size: FontSize.subtitle,
            color: Colors.White
        )
        
        addLibraryButton.setImage(AppImageName.ic_add, for: .normal)
        addLibraryButton.tintColor = Colors.White
        
        // Configure the toggle button image and tint color based on the view model state
        toggleButton.setImage(viewModel.isGridView ? AppImageName.ic_list : AppImageName.ic_grid, for: .normal)
        toggleButton.tintColor = Colors.White
        
        searchManiView.isHidden = true
        
        searchView.setCornerRadiusOnly(CornerRadiusSize.C20)
        
        searchView.backgroundColor = Colors.CustomBackgroundGray
        
        searchMusicTextField.setTextfield(placeholder: Localization.Common.Message.search, size: FontSize.subtitle, color: Colors.White)
        
        cancelButton.setButton(title: Localization.Library.Action.cancel, size: FontSize.extraLarge, color: Colors.White, bgColor: Colors.Clear)
        
        playlistsNameLabel.setSemiboldLabel(title: "", size: FontSize.title, color: Colors.White)
                
        searchMusicTextField.delegate = self
        emptyPlaylistMessageLabel.isHidden = true
        getUserPlaylist()
        registerCell()
        updateCollectionViewLayout()
        playlistsCollectionView.reloadData()
    }
    
    // Register collection view cell
    func registerCell() {
        // Register the cell with its nib and reuse identifier
        playlistsCollectionView.register(PlaylistsCollectionViewCell.nib, forCellWithReuseIdentifier: PlaylistsCollectionViewCell.reuseIdentifier)

        playlistsCollectionView.register(PlaylistsGridCollectionViewCell.nib, forCellWithReuseIdentifier: PlaylistsGridCollectionViewCell.reuseIdentifier)
        
        // Set data source and delegate for the collection view
        playlistsCollectionView.dataSource = self
        playlistsCollectionView.delegate = self
        
        // Register the table view cell using the nib name from the view model
        playlistsTableView.register(PlaylistsTableViewCell.nib, forCellReuseIdentifier: PlaylistsTableViewCell.reuseIdentifier)
        
        ///Set the table view's data source and delegate
        playlistsTableView.dataSource = self
        playlistsTableView.delegate = self
    }
    
    // MARK: - Button Actions
    
    /// Action triggered when the add library button is tapped
    @IBAction func addLibraryButtonTouchUpInside(_ sender: UIButton) {
        dismissKeyboard()
        // Attempting to load a view controller from the storyboard
        if let createPlaylistViewController = loadViewController(Storyboard: Storyboards.AddPlaylist, ViewController: ViewControllers.CreatePlaylistViewController) as? CreatePlaylistViewController {
            // Successfully casted the loaded view controller to CreatePlaylistViewController
            // Now we push this view controller onto the navigation stack for navigation
            createPlaylistViewController.modalPresentationStyle = .overFullScreen
            createPlaylistViewController.viewModel.delegate = self
            self.present(createPlaylistViewController, animated: false)
        } else {
            // If the view controller could not be loaded or cast, handle the error
            print("Failed to load CreatePlaylistViewController from the storyboard.")
        }
    }
    
    /// Action triggered when the toggle button is tapped
    @IBAction func toggleButtonButtonTouchUpInside(_ sender: UIButton) {
        dismissKeyboard()
        // Toggle between grid and list view
        viewModel.isGridView.toggle()
        
        // Update the toggle button's image based on the new state
        toggleButton.setImage(viewModel.isGridView ? AppImageName.ic_list : AppImageName.ic_grid, for: .normal)
        
        // Update the collection view layout based on the new value of `isGridView`
        updateCollectionViewLayout()
        
        playlistsCollectionView.reloadData()
        scrollToTop()
    }
    
    @IBAction func backButtonTouchUpInside(_ sender: UIButton) {
        dismissKeyboard()
        saveUserPlaylist()
        playlistView.isHidden = true
        playlistsCollectionView.reloadData()
    }
    
    @IBAction func addSongButtonTouchUpInside(_ sender: UIButton) {
        dismissKeyboard()
        searchManiView.isHidden = false
        playlistInfoView.isHidden = true
        viewModel.isSearchMode = true
        viewModel.searchMusicTrackListData.removeAll()
        searchMusicTextField.text = ""
        playlistsTableView.reloadData()
    }
    
    @IBAction func cancelButtonTouchUpInside(_ sender: UIButton) {
        dismissKeyboard()
        searchManiView.isHidden = true
        playlistInfoView.isHidden = false
        viewModel.isSearchMode = false
        playlistsTableView.reloadData()
    }
    
    func dismissKeyboard() {
        searchMusicTextField.resignFirstResponder()
    }
    
    func saveUserPlaylist() {
        // Initialize an empty array to hold saved playlists
        var userSavedPlaylist = [PlaylistData]()
        
        // Retrieve existing playlist data from UserDefaults
        if let savedUserPlayList = GlobalVariables.UserDefault.value(forKey: GlobalVariables.UserDefaultsKeys.userPlayListKey.rawValue) as? [[String: Any]] {
            // Map the JSON array to an array of PlayListData objects using the Mapper
            userSavedPlaylist = Mapper<PlaylistData>().mapArray(JSONArray: savedUserPlayList)
        }
        
        // Check if there are any music tracks in the addedMusicTrackListData
        if viewModel.addedMusicTrackListData.count > 0 {
            // Create a new PlayListData object for the new playlist
            let newPlayList = PlaylistData()
            newPlayList.PlaylistName = viewModel.playlistName
            newPlayList.MusicTrack = viewModel.addedMusicTrackListData
                            
            if let selectedIndexNumber = viewModel.selectedIndexNumber, viewModel.isEdit {
                // Update the playlist to the existing playlist list
                userSavedPlaylist[selectedIndexNumber] = newPlayList
            } else {
                // Append the new playlist to the existing playlist list
                userSavedPlaylist.append(newPlayList)
            }
            
            viewModel.userPlaylistData = userSavedPlaylist
            
            // Convert the updated playlist array to JSON and save it back to UserDefaults
            let playlistJSON = userSavedPlaylist.toJSON()
            
            GlobalVariables.UserDefault.set(playlistJSON, forKey: GlobalVariables.UserDefaultsKeys.userPlayListKey.rawValue)
            GlobalVariables.UserDefault.synchronize()
        } else {
            print("No tracks have been added to the playlist.")
        }
    }
    
    func getUserPlaylist() {
        // Initialize an empty array to hold saved playlists
        var userSavedPlaylist = [PlaylistData]()
        
        // Retrieve existing playlist data from UserDefaults
        if let savedUserPlayList = GlobalVariables.UserDefault.value(forKey: GlobalVariables.UserDefaultsKeys.userPlayListKey.rawValue) as? [[String: Any]] {
            // Map the JSON array to an array of PlayListData objects using the Mapper
            userSavedPlaylist = Mapper<PlaylistData>().mapArray(JSONArray: savedUserPlayList)
            
            viewModel.userPlaylistData = userSavedPlaylist
        }
    }
}

// MARK: - UICollectionView DataSource & Delegate Methods

extension LibraryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // Returns the number of items in the section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        emptyPlaylistMessageLabel.isHidden = true
        if(viewModel.userPlaylistData.count == 0) {
            emptyPlaylistMessageLabel.isHidden = false
            emptyPlaylistMessageLabel.setBoldLabel(title: Localization.Common.Message.emptyPlaylists, size: FontSize.title, color: Colors.White)
        }
        
        return viewModel.userPlaylistData.count
    }
    
    // Returns the cell for each index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Dequeue reusable cell using the correct reuse identifier
        if viewModel.isGridView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaylistsGridCollectionViewCell.reuseIdentifier, for: indexPath) as! PlaylistsGridCollectionViewCell
            
            let playlistdata = viewModel.userPlaylistData[indexPath.row]
            
            cell.cellDataSetup(playlistData: playlistdata)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaylistsCollectionViewCell.reuseIdentifier, for: indexPath) as! PlaylistsCollectionViewCell
            
            let playlistdata = viewModel.userPlaylistData[indexPath.row]
            
            cell.cellDataSetup(playlistData: playlistdata)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dismissKeyboard()
        let playlistData = viewModel.userPlaylistData[indexPath.row]
        
        let playlistName = playlistData.PlaylistName ?? ""
        
        if let musicTrackData = playlistData.MusicTrack {
            viewModel.addedMusicTrackListData = musicTrackData
        }
        
        searchManiView.isHidden = true
        playlistInfoView.isHidden = false
        viewModel.isSearchMode = false
        playlistView.isHidden = false
        searchMusicTextField.text = ""
        viewModel.searchMusicTrackListData.removeAll()
        
        viewModel.isEdit = true
        viewModel.selectedIndexNumber = indexPath.row
        
        viewModel.playlistName = playlistName
        playlistsNameLabel.setSemiboldLabel(title: playlistName, size: FontSize.title, color: Colors.White)
        noOfSongsLabel.setLabel(title: "\(viewModel.addedMusicTrackListData.count) \(Localization.Library.Section.songs)", size: FontSize.extraLarge, color: Colors.GrayText)
        playlistsTableView.reloadData()

    }
    
    func scrollToTop() {
        if(viewModel.userPlaylistData.count > 0) {
            let indexPath = IndexPath(item: 0, section: 0) // First item in the first section
            playlistsCollectionView.scrollToItem(at: indexPath, at: .top, animated: true)
        }
    }
}

// Assuming `viewModel.isGridView` is a boolean flag

extension LibraryViewController {
    
    func updateCollectionViewLayout() {
        // Create a new instance of UICollectionViewFlowLayout
        let layout = UICollectionViewFlowLayout()
        
        // Check if we need to show in Grid or List view
        if viewModel.isGridView {
            // Set grid layout - multiple items per row
            let itemWidth = (GlobalVariables.SCREEN_WIDTH - 15) / 2 // Two items per row
            layout.itemSize = CGSize(width: itemWidth, height: 230) // Adjust height as needed
            
            // Set minimum line spacing and item spacing if needed
            layout.minimumLineSpacing = 30
            layout.minimumInteritemSpacing = 0

        } else {
            layout.itemSize = CGSize(width: GlobalVariables.SCREEN_WIDTH - 30, height: 95) // Full width for each item
            
            // Set minimum line spacing and item spacing if needed
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        }
                
        // Apply the layout to the collection view
        playlistsCollectionView.collectionViewLayout = layout
    }
}

extension LibraryViewController: CreatePlaylistProtocol {
    func createPlaylist(_ playlistName: String) {
        viewModel.isEdit = false
        viewModel.selectedIndexNumber = nil
        searchMusicTextField.text = ""
        viewModel.searchMusicTrackListData.removeAll()
        playlistView.isHidden = false
        viewModel.addedMusicTrackListData.removeAll()
        viewModel.searchMusicTrackListData.removeAll()
        viewModel.playlistName = playlistName
        playlistsNameLabel.setSemiboldLabel(title: playlistName, size: FontSize.title, color: Colors.White)
        playlistsTableView.reloadData()
        
        noOfSongsLabel.setLabel(title: "\(viewModel.addedMusicTrackListData.count) \(Localization.Library.Section.songs)", size: FontSize.extraLarge, color: Colors.GrayText)

    }
}

//MARK: - SERVICE METHOD

extension LibraryViewController {
    func searchMusicList(_ searchText: String) {
        showLoader(withStatus: Localization.Services.Message.wait)
        
        viewModel.callSearchMusicListService(searchText) { status, message in
            self.hideLoader()
            if status {
                self.playlistsTableView.reloadData()
            } else {
                self.view.makeToast(Localization.Services.Message.commonError)
            }
        }
    }
}

extension LibraryViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = textField.text! as NSString
        let newString: String = currentString.replacingCharacters(in: range, with: string)
        
        if newString.isEmpty {
            textField.text = newString
            viewModel.timer?.invalidate() // Invalidate any existing timer
            searchFiledChanges()
            return false
        } else {
            viewModel.lastInputTime = Date() // Update the last input time whenever the user types
            startTimer() // Restart the timer to check after 4 seconds
        }
        
        return true
    }
    
    func startTimer() {
        viewModel.timer?.invalidate() // Invalidate any existing timer
        viewModel.timer = Timer.scheduledTimer(timeInterval: GlobalVariables.searchTimeTimeInterval, target: self, selector: #selector(checkLastInput), userInfo: nil, repeats: false)
    }
    
    @objc func checkLastInput() {
        guard let lastInputTime = viewModel.lastInputTime else { return }
        let currentTime = Date()
        let elapsedTime = currentTime.timeIntervalSince(lastInputTime)
        if elapsedTime >= GlobalVariables.searchTimeTimeInterval {
            searchFiledChanges()
        }
    }
    
    func searchFiledChanges() {
        let newString = searchMusicTextField.text ?? ""
        if newString.count >= 2 {
            if (newString.hasPrefix(" ")) { return }
            searchMusicList(newString)
            return
        } else if newString == "" {
            searchMusicList(newString)
            view.endEditing(true)
            return
        } else if newString.count <= 2 {
            return
        } else {
            return
        }
    }
    
    // Dismiss the keyboard when the "Return" key is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Dismiss the keyboard
        return true
    }

}

// MARK: - Table View DataSource & Delegate Methods

extension LibraryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(viewModel.isSearchMode) {
            emptyPlaylistMessageLabel.isHidden = true
            if(viewModel.searchMusicTrackListData.count == 0) {
                emptyPlaylistMessageLabel.isHidden = false
                emptyPlaylistMessageLabel.setBoldLabel(title: Localization.Common.Message.emptySearchResults, size: FontSize.title, color: Colors.White)
            }
        } else {
            emptyPlaylistMessageLabel.isHidden = true
            if(viewModel.addedMusicTrackListData.count == 0) {
                emptyPlaylistMessageLabel.isHidden = false
                emptyPlaylistMessageLabel.setBoldLabel(title: Localization.Common.Message.emptyMusicTracks, size: FontSize.title, color: Colors.White)
            }
        }
        
        return viewModel.isSearchMode ?  viewModel.searchMusicTrackListData.count : viewModel.addedMusicTrackListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue a reusable cell with the identifier from the view model.
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistsTableViewCell") as! PlaylistsTableViewCell
        
        let musicTrackData = viewModel.isSearchMode ?  viewModel.searchMusicTrackListData[indexPath.row] : viewModel.addedMusicTrackListData[indexPath.row]
        
        if viewModel.isSearchMode {
            let isAlreadyAdded = checkTrackToAddedList(trackId: musicTrackData.trackId ?? 0)
            cell.cellDataSetup(musicTrackData: musicTrackData, indexNo: indexPath.row, isAddView: viewModel.isSearchMode, isAlreadyAdded: isAlreadyAdded)
        } else {
            cell.cellDataSetup(musicTrackData: musicTrackData, indexNo: indexPath.row, isAddView: viewModel.isSearchMode)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismissKeyboard()
        if viewModel.isSearchMode {
            let musicTrackData = viewModel.searchMusicTrackListData[indexPath.row]
            let isAlreadyAdded = checkTrackToAddedList(trackId: musicTrackData.trackId ?? 0)
            if(!isAlreadyAdded) {
                viewModel.addedMusicTrackListData.append(musicTrackData)
                tableView.reloadData()
                noOfSongsLabel.setLabel(title: "\(viewModel.addedMusicTrackListData.count) \(Localization.Library.Section.songs)", size: FontSize.extraLarge, color: Colors.GrayText)
            } else {
                view.makeToast(Localization.Playlist.Message.alreadyAdded(viewModel.playlistName))
            }
        }
    }
    
    func checkTrackToAddedList(trackId: Int) -> Bool {
        // Check if the trackId already exists in the addedMusicTrackListData
        if viewModel.addedMusicTrackListData.contains(where: { $0.trackId == trackId }) {
            print("Track with id \(trackId) is already added.")
            return true
        }
        
        return false
    }
}
