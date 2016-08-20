//
//  FlickrDelivery.swift
//  flickrslide
//
//  Created by RyuHee chul on 8/19/16.
//  Copyright © 2016 RyuHeechul. All rights reserved.
//

import UIKit
import Haneke

class FlickrDelivery: NSObject {

    func get(page: Int, completion: (urls: Array<String>) -> Void ) {
        let cache = Cache<JSON>(name: "github")
        let urlString = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&page=\(page)"

        print(urlString)
        let URL = NSURL(string: urlString)!


        cache.fetch(URL: URL).onSuccess { JSON in
            var arr = [String]()

            let ab: Array? = (JSON.dictionary?["items"] as! NSArray) as Array

            for a in ab! {
                let url:String = (a["media"]!)!["m"] as! String
                arr.append(url)
            }

            completion(urls: arr)
        }
    }
}
