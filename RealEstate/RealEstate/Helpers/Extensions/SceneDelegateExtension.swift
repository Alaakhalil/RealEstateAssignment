//
//  SceneDelegateExtention.swift
//  RealEstate
//
//  Created by Alaa Khalil on 12/01/2022.
//

import UIKit

extension SceneDelegate{
   
    // set the root 
    func setRoot(from storyBoard: StoryBoardConstants.storyBoard, with vcId: StoryBoardConstants.ViewControllersId) {
            let storyboard = UIStoryboard(name: storyBoard.rawValue, bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: vcId.rawValue)
            self.window?.rootViewController = viewController
            self.window?.makeKeyAndVisible()
        }
    
    // check if the user give the location access before
    func checkLocationAccess(){
        if(locationService.status == .notDetermined) || (locationService.status == .restricted) || (locationService.status == .denied){
            setRoot(from: .Main, with: .AccessLocation)
        }
    }
}
