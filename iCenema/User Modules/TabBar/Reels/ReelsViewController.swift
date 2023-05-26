//
//  ReelsViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 24/02/2023.
//

import UIKit
import SwiftUI
import CompositionalLayoutableSection

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
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
 
        DispatchQueue.main.async {
            if let stories = self.stories, let stories_copy = try? stories.copy().otherStories {
                let storyPreviewScene = IGStoryPreviewController.init(stories: stories_copy, handPickedStoryIndex:  0, handPickedSnapIndex: 0)
                self.navigationController?.pushViewController(storyPreviewScene, animated: true)
            }
        }
    }
    
   

}





