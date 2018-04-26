//
//  ViewController.swift
//  willItGIF!
//
//  Created by david moed on 4/26/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

import UIKit
import GiphyCoreSDK

class ViewController: UIViewController {

    @IBOutlet var IdontGIFashit: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let gifURL : String = "https://media.giphy.com/media/2nCc9WTvgCDIc/giphy.gif"
        let imageURL = UIImage.gifImageWithURL(gifURL)
        let imageView3 = UIImageView(image: imageURL)
        imageView3.frame = CGRect(x: 20.0, y: 390.0, width: self.view.frame.size.width - 40, height: 150.0)
        view.addSubview(imageView3)
        
        let test = makeGifArray(numPlayers: 4)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeGifArray (numPlayers: Int) {
        //
        let gifArrSize = numPlayers * 13;
        
        //array of all urls to load in
        let gifUrlArr: Array<String> = Array()
        
        //get url w/ query from giphy api
        for i in 0 ... 3 {
            //TODO query giphy api for url
            //place url in index for array
            //return the array
            print("my loop sounds nice check" , i)
            
            //TODO set random flag to call giphy api with different tags
            let op = GiphyCore.shared.search("cats") { (response, error) in
                
                print("inside giphy call")
                
                if let error = error as NSError? {
                    print("error: ", error)
                }
                
                if let response = response, let data = response.data, let pagination = response.pagination {
                    print(response.meta)
                    print(pagination)
                    for result in data {
                        print(result)
                    }
                } else {
                    print("No Results Found")
                }
            }
            print(op)
        }
        
    }


}

