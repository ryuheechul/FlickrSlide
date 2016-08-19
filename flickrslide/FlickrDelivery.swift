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

    func get(index: Int? ) -> Int? {
        let cache = Cache<JSON>(name: "github")
        let URL = NSURL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1")!

        cache.fetch(URL: URL).onSuccess { JSON in
            print(JSON)
        }

        return 1
    }
}
