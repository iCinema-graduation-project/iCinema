//
//  ReelsViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 24/02/2023.
//

import UIKit
import SwiftUI

class ReelsViewController: ICinemaViewController {

    private let stories: IGStories? = {
        do {
            return try IGMockLoader.loadMockFile(named: "stories.json", bundle: .main)
        }catch let e as MockLoaderError {
            debugPrint(e.description)
        }catch{
            debugPrint("could not read Mock json file :(")
        }
        return nil
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            if let stories = self.stories, let stories_copy = try? stories.copy().otherStories {
                let storyPreviewScene = IGStoryPreviewController.init(stories: stories_copy, handPickedStoryIndex:  0, handPickedSnapIndex: 0)
                self.navigationController?.pushViewController(storyPreviewScene, animated: true)
            }
        }
    }


}

