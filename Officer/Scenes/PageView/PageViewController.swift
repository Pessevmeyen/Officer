//
//  PageViewController.swift
//  Officer
//
//  Created by Furkan Eruçar on 19.08.2022.
//

import UIKit
import HandyViewController

class PageViewController: UIPageViewController, AnimationDelegate {
    
    let officeViewController = OfficeViewController()
    let mapKitViewController = MapKitViewController()
    
    var viewControllerArray = [UIViewController]()
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        title = Constants.appName
        
        delegate = self
        dataSource = self
        
        instantiateViewControllers()
        
        hideBackBarButton()
        
        setRightBarButtonItem()
        
    }
    
    //MARK: Custom Functions
    private func instantiateViewControllers() {
        let officeStoryboard = UIStoryboard(name: Constants.officeStoryboardName, bundle: nil)
        let officeDestination: OfficeViewController = officeStoryboard.instantiateViewController(identifier: Constants.officeIdentifier)
        
        let mapKitStoryboard = UIStoryboard(name: Constants.mapKitStoryboardName, bundle: nil)
        let mapKitDestination: MapKitViewController = mapKitStoryboard.instantiateViewController(identifier: Constants.mapKitIdentifier)
        
        viewControllerArray.append(officeDestination)
        viewControllerArray.append(mapKitDestination)
        
        officeDestination.delegate = self
        
        if let firstViewController = viewControllerArray.first {
            setViewControllers([firstViewController], direction: .forward, animated: true)
        }
    }
    
    func addingFavoriteAnimation() {
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(addingOffice), userInfo: nil, repeats: false)
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(setRightBarButtonItem), userInfo: nil, repeats: false)
    }
    
    func removingFavoriteAnimation() {
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(removingOffice), userInfo: nil, repeats: false)
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(setRightBarButtonItem), userInfo: nil, repeats: false)
    }
    
    //MARK: @objc Functions
    @objc private func setRightBarButtonItem() {
        let favoritesScreenButton = UIBarButtonItem.init(image: UIImage(named: "custom.heart.text.square"), style: .done, target: self, action: #selector(goToFavoritesScreen))
        favoritesScreenButton.tintColor = #colorLiteral(red: 0.5294117647, green: 0.1285524964, blue: 0.5745313764, alpha: 1)
        navigationItem.rightBarButtonItems = [favoritesScreenButton]
    }
    
    // When user click favorite button, right bar button turns the string to notify user
    @objc private func addingOffice() {
        navigationController?.isNavigationBarHidden = false
        let favoritesScreenButton = UIBarButtonItem.init(title: "Adding Office...", style: .done, target: self, action: nil)
        favoritesScreenButton.tintColor = #colorLiteral(red: 0.5294117647, green: 0.1285524964, blue: 0.5745313764, alpha: 1)
        navigationItem.rightBarButtonItems = [favoritesScreenButton]
    }
    
    // When user click favorite button again, right bar button turns the string to notify user
    @objc private func removingOffice() {
        let favoritesScreenButton = UIBarButtonItem.init(title: "Removing Office...", style: .done, target: self, action: nil)
        favoritesScreenButton.tintColor = #colorLiteral(red: 0.5294117647, green: 0.1285524964, blue: 0.5745313764, alpha: 1)
        navigationItem.rightBarButtonItems = [favoritesScreenButton]
    }
    
    @objc func goToFavoritesScreen() {
        
        let storyboard = UIStoryboard(name: Constants.favoriteStoryboardName, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: Constants.favoriteIdentifier)
        let transitioningDelegate = HandyTransitioningDelegate(from: self, to: controller)
        controller.modalPresentationStyle = .overFullScreen
        controller.transitioningDelegate = transitioningDelegate
        navigationController?.pushViewController(controller, animated: true)
        //present(controller, animated: true)
        
    }

}

//MARK: UIPageViewController Delegates
extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        //Sonuncudaysa ilkine git, ilkindeysen bir şey yapma.
        if viewController == viewControllerArray.last {
            return viewControllerArray.first
        } else if viewController == viewControllerArray.first {
            return nil
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if viewController == viewControllerArray.first {
            return viewControllerArray.last
        } else if viewController == viewControllerArray.last {
            return nil
        } else {
            return nil
        }
    }
    
}
