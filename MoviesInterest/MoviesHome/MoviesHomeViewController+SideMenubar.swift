//
//  MoviesHomeViewController+SideMenubar.swift
//  SwipeDemo
//
//  Created by Pradeep Dahiya on 28/05/2019.
//  Copyright © 2019 Pradeep Dahiya. All rights reserved.
//

import Foundation
import UIKit

extension MoviesHomeViewController:MoreMenuBarDelegate{

    
    func setupSideMenu()  {
        //Left Side Menu bar Create
        
        arrBtnImageListLeft.append(SideMenuImageList(imgButton: #imageLiteral(resourceName: "in_theaters")))
        arrBtnImageListLeft.append(SideMenuImageList(imgButton: #imageLiteral(resourceName: "popular")))
        arrBtnImageListLeft.append(SideMenuImageList(imgButton: #imageLiteral(resourceName: "top_rated")))
        arrBtnImageListLeft.append(SideMenuImageList(imgButton: #imageLiteral(resourceName: "upcoming")))
        
        var heightOfMenuBarLeft = (DeviceScale.SCALE_X * 20.0) //Top-Bottom Spacing
        heightOfMenuBarLeft += ((DeviceScale.SCALE_X * 16.66) * CGFloat((arrBtnImageListLeft.count - 1))) //Button between spacing
        heightOfMenuBarLeft += (CGFloat(arrBtnImageListLeft.count) * 50.0) //Button height spacing
        
        let originYOfMenuBarLeft = (self.view.frame.size.height / 2.0) - (heightOfMenuBarLeft / 2)
        
        sideMenubarLeft = (SideMenubar.init(frame: CGRect(x: (ScreenSize.WIDTH - (DeviceScale.SCALE_X * 84.0)),y: originYOfMenuBarLeft,width: (DeviceScale.SCALE_X * 84.0),height: heightOfMenuBarLeft)).createUI(view: self.view, arrBtnImageList: arrBtnImageListLeft) as! SideMenubar)
        sideMenubarLeft.delegate = self
    }
    
    func tappedOnEvent(sender: UIControl, sideMenubar: SideMenubar) {
        sideMenubarLeft.hide()
        let cat = Category.init(rawValue: sender.tag)
//        if cat == .search {
//            perform(segue: .showSearch, sender: nil)
//        }
//        else{
//
//            }
//        }
        self.title = String(describing: NavigationTitle.init(rawValue: sender.tag)).uppercased()
        loadMovies(category: cat!) { [weak self] movies in
            self?.movies = movies
        }
    }
    
    func moreMenuItemHide(sideMenubar: SideMenubar) {
        print("moreMenuItemHide")
    }
    
    func moreMenuItemShow(sideMenubar: SideMenubar) {
        print("moreMenuItemShow")
    }
    
    
}
