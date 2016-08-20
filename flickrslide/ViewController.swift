//
//  ViewController.swift
//  flickrslide
//
//  Created by RyuHee chul on 8/18/16.
//  Copyright © 2016 RyuHeechul. All rights reserved.
//

import UIKit
import Haneke

class ViewController: UIViewController {

    @IBOutlet var imgV : UIImageView?
    var delivery: FlickrDelivery?
    var queue: [String] = []
    var timer = NSTimer()
    var isFetching = false
    var page = 0
    var isShowing = true

    @IBAction func startPause(sender: UIBarButtonItem) {
        sender.sy
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        delivery = FlickrDelivery()

        if queue.count == 0 {
            self.fetchPhotos()
        }

        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(ViewController.showNext), userInfo: nil, repeats: true)
    }

    func fetchPhotos() {
        if isFetching {
            return
        }

        isFetching = true
        delivery?.get(page, completion: { (urls) in
            self.queue.insertContentsOf(urls.reverse(), at: 0)
            self.isFetching = false
        })
        page+=1
    }

    func showNext() {
        if queue.count == 0 {
            fetchPhotos()
            return
        }

        if queue.count <= 3 {
            fetchPhotos()
        }

        let urlString:String? = queue.popLast()

        if urlString == nil {
            return
        }

        if let url = NSURL(string: urlString!) {
            imgV?.hnk_setImageFromURL(url)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

