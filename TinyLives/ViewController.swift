//
//  ViewController.swift
//  TinyLives
//
//  Created by Jacky Wong on 25/3/21.
//

import UIKit
import ZKCarousel
import FirebaseDatabase

class ViewController: UIViewController {
    
    // Instantiated and used with Storyboards
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    
    @IBOutlet var feedbackButton: UIBarButtonItem!
    @IBOutlet var carousel: ZKCarousel! = ZKCarousel()
    @IBOutlet var communicationCollectionView: UICollectionView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var tableViewHeightConstraint: NSLayoutConstraint!
    
    // Collection View property
    private let reuseIdentifier = "commCell"
    
    private let sectionInsets = UIEdgeInsets(
        top: 8.0,
        left: 16.0,
        bottom: 8.0,
        right: 16.0)
    
    private let itemsPerRow: Int = 10
    
    var commItems = [CommunicationRowData]()
    
    
    // Table View property
    private let tableContentReusable = "contentCell"
    private let tableHeaderResuable = "headerCell"
    
    
    // For categorising list of posts associating with a date
    var datePostMap: [Date: [Post]] = [:]
    
    // To use for cell's header
    var sortedDateHeader = [Date]()
    
    // Firebase
    let database: DatabaseReference = Database.database().reference()
    
    var _tempPosts: [Post] = [Post]()
    
    var numberOfPost: Int = 5
    
    // VCs
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        getPosts()
        
        // Bugged with pagination
//        get10PostPerLoad()
//        tableView.isScrollEnabled = false
    }
    
    private func setupUI() {
        
        // Carousel view
        setupCarousel()
        
        setupCommsData()
        
        setupTableView()
    }
    
    private func setupCarousel() {
        
        // Create as many slides as you'd like to show in the carousel
        let slide = ZKCarouselSlide(image: UIImage(),
                                    title: "Hello There",
                                    description: "Welcome to the ZKCarousel demo! Swipe left to view more slides!")
        let slide1 = ZKCarouselSlide(image: UIImage(),
                                     title: "A Demo Slide",
                                     description: "lorem ipsum devornum cora fusoa foen sdie ha odab ebakldf shjbesd ljkhf")
        let slide2 = ZKCarouselSlide(image: UIImage(),
                                     title: "Another Demo Slide",
                                     description: "lorem ipsum devornum cora fusoa foen ebakldf shjbesd ljkhf")
        let slide3 = ZKCarouselSlide(image: UIImage(),
                                     title: "Hello There",
                                     description: "Welcome to the ZKCarousel demo! Swipe left to view more slides!")
        let slide4 = ZKCarouselSlide(image: UIImage(),
                                     title: "A Demo Slide",
                                     description: "lorem ipsum devornum cora fusoa foen sdie ha odab ebakldf shjbesd ljkhf")
        let slide5 = ZKCarouselSlide(image: UIImage(),
                                     title: "Another Demo Slide",
                                     description: "lorem ipsum devornum cora fusoa foen ebakldf shjbesd ljkhf")
        
        // Add the slides to the carousel
        self.carousel.slides = [slide, slide1, slide2, slide3, slide4, slide5]
        
        
        // You can optionally use the 'interval' property to set the timing for automatic slide changes. The default is 1 second.
        self.carousel.interval = 5
        
        // OPTIONAL - use this function to automatically start traversing slides.
        self.carousel.start()
        
        // OPTIONAL - use this function to stop automatically traversing slides.
        // self.carousel.stop()
    }
    
    func setupCommsData() {
        // Comms Row
        // Create item
        let TTS = CommunicationRowData.init()
        TTS.iconImageName = "smartphone"
        TTS.title = "Talk to School"
        TTS.backgroundColorName = "SkyBlue"
        TTS.id = "TTS"
        commItems.append(TTS)
        
        let RFA = CommunicationRowData.init()
        RFA.iconImageName = "calendar"
        RFA.title = "Request for Absence"
        RFA.backgroundColorName = "DeepSkyBlue"
        RFA.id = "RFA"
        commItems.append(RFA)
        
        let MI = CommunicationRowData.init()
        MI.iconImageName = "medicalInstruction"
        MI.title = "Medical Instruction"
        MI.backgroundColorName = "GrassGreen"
        MI.id = "MI"
        commItems.append(MI)
        
        // Random guessed name
        let HU = CommunicationRowData.init()
        HU.iconImageName = "hearing"
        HU.title = "Hearing Upcoming"
        HU.backgroundColorName = "WhineyGreen"
        HU.id = "HU"
        commItems.append(HU)
    }
    // TableView
    func setupTableView() {
        
        tableView.estimatedRowHeight = 80
        tableView.sectionHeaderHeight = 40
        tableView.estimatedSectionHeaderHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    // Data
    func sortData() {
        
        for post in _tempPosts {
            
            let uploadedDate = post.uploadedDate.removeTimeStamp!
            if self.datePostMap[uploadedDate] == nil {
                var newPostArray = [Post]()
                newPostArray.append(post)
                self.datePostMap[uploadedDate] = newPostArray
            } else {
                self.datePostMap[uploadedDate]?.append(post)
            }
        
        }
        
        
        self.sortedDateHeader = self.datePostMap.keys.sorted(by: >)
        
        self.tableView.reloadData()
        self.tableView.layoutIfNeeded()
        tableViewHeightConstraint.constant = tableView.contentSize.height
    }
    
    @objc func promptFeatureNotAvailable() {
        let alert = UIAlertController (title: "Oops", message: "Feature not implemented", preferredStyle: .alert)
        
        let dismissAction = UIAlertAction(title: "Okay", style: .cancel)
        alert.addAction(dismissAction)
        self.present(alert, animated: true)
    }
    
    @IBAction func prompt(sender: Any) {
        promptFeatureNotAvailable()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MI" || segue.identifier == "TTS" {
            if let color = sender as? String {
                segue.destination.view.backgroundColor = UIColor(named: color)
            }
        }
    }
    //  Bugged with pagination
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print("jacky1 asdf = \(self.scrollView.contentOffset.y)")
//
//        if scrollView == self.scrollView {
//            print("jacky1")
//             tableView.isScrollEnabled = (self.scrollView.contentOffset.y >= 15)
//         }
//
//         if scrollView == self.tableView {
//            print("jacky2")
//             self.tableView.isScrollEnabled = (tableView.contentOffset.y > 0)
//         }
//
//        if scrollView == tableView {
//            print("jacky3")
//            if (scrollView.contentOffset.y + 100) >= (scrollView.contentSize.height - scrollView.frame.size.height) {
//                numberOfPost += 5
//                get10PostPerLoad()
//                print("jacky the contentoffset y = \(scrollView.contentOffset.y + 100)")
//                print("jacky the scrollView.contentSize.height = \(scrollView.contentSize.height)")
//                print("jacky the scrollView.frame.size.height = \(scrollView.frame.size.height)")
//                print("jacky the minus = \(scrollView.contentSize.height - scrollView.frame.size.height)")
//            }
//
//        }
//    }
}

// MARK:- CollectionView funcs
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // Data source and delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return commItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reuseIdentifier,
            for: indexPath) as! CommunicationRowCollectionViewCell
        
        cell.iconImageView.image = UIImage(named: commItems[indexPath.row].iconImageName)
        cell.titleLabel.text = commItems[indexPath.row].title
        cell.backgroundColor = UIColor(named: commItems[indexPath.row].backgroundColorName)
        
        cell.layer.cornerRadius = 16
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.clear.cgColor
        cell.layer.masksToBounds = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if commItems[indexPath.row].id == "TTS" || commItems[indexPath.row].id == "MI" {
            self.performSegue(withIdentifier: commItems[indexPath.row].id, sender: commItems[indexPath.row].backgroundColorName)
        } else {
            promptFeatureNotAvailable()
        }
        
    }
    
    // Flow layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = collectionView.frame.height - sectionInsets.top - sectionInsets.bottom
        let width = height * 0.7
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
}

// MARK:- TableView funcs
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datePostMap[sortedDateHeader[section]]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableContentReusable) as! PostsTableViewCell
        
        let date = sortedDateHeader[indexPath.section]
        cell.messageLabel.text = datePostMap[date]?[indexPath.row].message
        
        cell.downloadButton.isHidden = datePostMap[date]?[indexPath.row].downloadable ?? true
        cell.expireDate.isHidden = cell.downloadButton.isHidden
        cell.imageStackView.isHidden = cell.downloadButton.isHidden
        cell.downloadButton.addTarget(self, action: #selector(promptFeatureNotAvailable), for: .touchUpInside)

        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: tableHeaderResuable) as! PostHeaderTableViewCell
        
        // Only check for 1st and 2nd section
        // Today and yesterday's
        switch section  {
        case 0:
            if sortedDateHeader[section].removeTimeStamp?.toString() == Date().toString() {
                cell.titleLabel.text = "TODAY"
            }
        case 1:
            if sortedDateHeader[section].removeTimeStamp?.toString() == Date().yesterday().toString() {
                cell.titleLabel.text = "YESTERDAY"
            }
        default:
            cell.titleLabel.text = sortedDateHeader[section].toString()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return sortedDateHeader.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

// Firebase related
extension ViewController {
    
    func getPosts() {
        
        indicatorView.startAnimating()
        
        let post = database.child("post")
        
        post.observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let postDict = snap.value as! [String:Any]
                
                let newPost = Post()
                newPost.downloadable = postDict["downloadable"] as? Bool
                newPost.expiryDate = postDict["expiryDate"] as? String ?? ""
                newPost.message = postDict["message"] as? String ?? ""
                newPost.title = postDict["title"] as? String ?? ""
                
                if let uploadedDate = postDict["uploadedDate"] as? TimeInterval {
                    let convertedLocalDate = uploadedDate.toLocalDate()
                    print("The converted local date = \(convertedLocalDate)")
                    newPost.uploadedDate = convertedLocalDate
                }
                self._tempPosts.append(newPost)
            }
            DispatchQueue.main.async {
                
                self.indicatorView.stopAnimating()
                
                self.sortData()
            }
        }
    }
    
    func get10PostPerLoad() {
        
        
        let post = database.child("post")
        indicatorView.startAnimating()
        post.queryLimited(toFirst: UInt(numberOfPost)).observe(.value) { (snapshot) in
            
            print("jacky the child count = \(snapshot.childrenCount)")
            var newQueriedPosts = [Post]()
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let postDict = snap.value as! [String:Any]
                
                let newPost = Post()
                newPost.downloadable = postDict["downloadable"] as? Bool
                newPost.expiryDate = postDict["expiryDate"] as? String ?? ""
                newPost.message = postDict["message"] as? String ?? ""
                newPost.title = postDict["title"] as? String ?? ""
                
                if let uploadedDate = postDict["uploadedDate"] as? TimeInterval {
                    let convertedLocalDate = uploadedDate.toLocalDate()
                    print("The converted local date = \(convertedLocalDate)")
                    newPost.uploadedDate = convertedLocalDate
                }
                newQueriedPosts.append(newPost)
            }
            self._tempPosts = newQueriedPosts
            
            print("jacky the post = \(self._tempPosts)")
            
            DispatchQueue.main.async {
                
                self.indicatorView.stopAnimating()
                
                self.sortData()
            }
        }
    }
}
