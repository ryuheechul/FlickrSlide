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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let url = NSURL(string: "https://farm9.staticflickr.com/8255/29003563911_af1999f62c_m.jpg")
        imgV?.hnk_setImageFromURL(url!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

