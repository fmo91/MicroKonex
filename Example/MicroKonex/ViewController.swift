//
//  ViewController.swift
//  MicroKonex
//
//  Created by fmo91 on 01/31/2017.
//  Copyright (c) 2017 fmo91. All rights reserved.
//

import UIKit
import ObjectMapper
import MicroKonex
import Microfutures
import Konex

struct Post: Mappable {
    var title = ""
    var id = -1
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
    }
}

struct GetAllPostsRequest: KonexRequest {
    var path: String = "https://jsonplaceholder.typicode.com/posts"
}

struct GetAPostByIDRequest: KonexRequest {
    let id: Int
    
    var path: String { return "https://jsonplaceholder.typicode.com/posts/\(id)" }
    
    
    init(id: Int) {
        self.id = id
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let client = KonexClient()
        
        let request = GetAllPostsRequest()
        
        client
            .mf_requestArray(of: Post.self, request: request)
            .map { posts in
                return posts.first!.id
            }
            .flatMap { (postID: Int) -> Future<Post> in
                let request = GetAPostByIDRequest(id: postID)
                return client.mf_requestObject(ofType: Post.self, request: request)
            }
            .subscribe(
                onNext: { post in
                    print("\(post.title)")
                },
                onError: { error in
                    print("Error")
                }
            )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

