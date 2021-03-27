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
    @IBOutlet var carousel: ZKCarousel! = ZKCarousel()
    @IBOutlet var communicationCollectionView: UICollectionView!
    @IBOutlet var tableView: UITableView!
    
    // Collection View property
    private let reuseIdentifier = "commCell"
    
    private let sectionInsets = UIEdgeInsets(
        top: 8.0,
        left: 8.0,
        bottom: 8.0,
        right: 8.0)
    
    private let itemsPerRow: Int = 10
    
    // Table View property
    private let tableContentReusable = "contentCell"
    private let tableHeaderResuable = "headerCell"
    
    private let numberOfRows: Int = 10
    
    private var postHeaders = [Post]()
    
    // For categorising list of posts associating with a date
    var datePostMap: [Date: [Post]] = [:]
    
    // To use for cell's header
    var sortedDateHeader = [Date]()
    
    // Firebase
    let database: DatabaseReference = Database.database().reference()
    
    var _tempPosts: [Post] = [Post]()
    
    // VCs
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        getPosts()
    }
    
    private func setupUI() {
        // Carousel view
        setupCarousel()
        
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
    }
}

// MARK:- CollectionView funcs
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // Data source and delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsPerRow
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reuseIdentifier,
            for: indexPath)
        cell.backgroundColor = .orange
        return cell
    }
    
    // Flow layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = collectionView.frame.height - sectionInsets.top - sectionInsets.bottom
        let width = height * 0.6
        
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
            self.sortData()
        }
    }
}
