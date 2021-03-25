//
//  ViewController.swift
//  TinyLives
//
//  Created by Jacky Wong on 25/3/21.
//

import UIKit
import ZKCarousel

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
    
    // VCs
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        // Carousel view
        setupCarousel()
        
        // Collection view
        
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
}

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

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableContentReusable)
        cell?.backgroundColor = .blue
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableHeaderResuable)
        cell?.backgroundColor = .red
        return cell
    }
}
