//
//  FlickrDelivery.swift
//  flickrslide
//
//  Created by RyuHee chul on 8/19/16.
//  Copyright © 2016 RyuHeechul. All rights reserved.
//

import UIKit
import Alamofire

class FlickrDelivery: NSObject {

    func get(page: Int, completion: (urls: Array<String>) -> Void ) {
        let urlString = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&page=\(page)"

        Alamofire.request(.GET, urlString).responseJSON { (response) in
            var result = [String]()
            if let JSON = response.result.value {

                let _items: Array? = (JSON["items"] as! NSArray) as Array

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

            }

            completion(urls: result)
        }
    }
}
