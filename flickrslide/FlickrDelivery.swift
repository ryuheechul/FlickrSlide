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
        let cache = Cache<JSON>(name: "flickr")
        let urlString = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&page=\(page)"

        let URL = NSURL(string: urlString)!

        cache.fetch(URL: URL).onSuccess { JSON in
            print(JSON)
            var result = [String]()

            let _items: Array? = (JSON.dictionary?["items"] as! NSArray) as Array

            if let items = _items {
                for item in items {

                    let _media: Dictionary? = (item["media"] as! NSDictionary) as Dictionary

                    if let media = _media {

                        let _url:String? = media["m"] as? String

                        if let url = _url {
                            result.append(url)
                        }
                    }

                }

            }

            completion(urls: result)
        }
    }
}
