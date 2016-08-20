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

    @IBOutlet weak var toolbar: UIToolbar!

    @IBOutlet var imgV : UIImageView?
    var tf:UITextField?
    var delivery: FlickrDelivery?
    var queue: [String] = []
    var timer = NSTimer()
    var isFetching = false
    var page = 0
    var isShowing = true

    @IBAction func buttonTapped(sender: AnyObject) {
        if tf?.isFirstResponder() == true {
            tf?.resignFirstResponder()
            return
        }

        timer.invalidate()
        self.navigationController?.navigationBar.hidden = false
        toolbar.hidden = false
    }

    func interval() -> Double {
        let intervalText = tf?.text
        var interval = Double(intervalText!)

        if interval == 0 {
            interval = 1
        }

        return interval!
    }

    @IBAction func start(sender: UIBarButtonItem) {
        timer = NSTimer.scheduledTimerWithTimeInterval(interval(), target: self, selector: #selector(ViewController.showNext), userInfo: nil, repeats: true)
        showNext()

        self.navigationController?.navigationBar.hidden = true
        toolbar.hidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        delivery = FlickrDelivery()

        if queue.count == 0 {
            self.fetchPhotos()
        }

        let titlebar:UIView? = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        tf = UITextField(frame: CGRect(x: 0, y: 0, width: 30, height: 40))
        let lbl:UILabel? = UILabel(frame: CGRect(x: 30, y: 0, width: 20, height: 40))
        tf?.keyboardType = UIKeyboardType.NumberPad
        tf?.returnKeyType = UIReturnKeyType.Done

        lbl?.text = "s"
        tf?.placeholder = "1"
        tf?.text = "1"

        titlebar?.addSubview(tf!)
        titlebar?.addSubview(lbl!)

        tf?.addTarget(self, action: #selector(ViewController.textDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)

        self.navigationController?.navigationBar.topItem?.titleView = titlebar!
    }

    func textDidChange(textField: UITextField) {
        let text = textField.text
        let textNum = Int(text!)

        if textNum > 0 && textNum < 11 {
            if textNum > 1 {
                tf?.resignFirstResponder()
            }
            return
        }

        else if textNum < 1 {
//            textField.text = "1"
        }
        else if textNum > 10 {
            textField.text = "10"
        }
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

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.3 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { 
                self.imgV?.hnk_setImageFromURL(url)
            })
            UIView.animateWithDuration(0.5, animations: {
                self.imgV?.alpha = 0
            }, completion: { (Bool) in

                UIView.animateWithDuration(0.5, animations: {
                    self.imgV?.alpha = 1
                })
            })

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

