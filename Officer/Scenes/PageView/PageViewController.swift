//
//  PageViewController.swift
//  Officer
//
//  Created by Furkan Eruçar on 19.08.2022.
//

import UIKit

class PageViewController: UIPageViewController {
    
    
    
    
    let officeViewController = OfficeViewController()
    let mapKitViewController = MapKitViewController()
    
    var viewControllerArray = [UIViewController]()
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print("init(coder:) has not been implemented")
    }
        

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let officeStoryboard = UIStoryboard(name: Constants.officeStoryboardName, bundle: nil)
        let officeDestination: OfficeViewController = officeStoryboard.instantiateViewController(identifier: Constants.officeStoryboardIdentifier)
        
        let mapKitStoryboard = UIStoryboard(name: "MapKit", bundle: nil)
        let mapKitDestination: MapKitViewController = mapKitStoryboard.instantiateViewController(identifier: "MapKitViewController")
        
        delegate = self
        dataSource = self
        
        viewControllerArray.append(officeDestination)
        viewControllerArray.append(mapKitDestination)
        
        var transitionStyle: UIPageViewController.TransitionStyle {
            return .scroll
        }
        
        
        self.navigationController?.navigationBar.isHidden = true
        //navigationItem.setHidesBackButton(true, animated: true)
        
        
        
        if let firstViewController = viewControllerArray.first {
            setViewControllers([firstViewController], direction: .forward, animated: true)
        }
        
        
        
    }

}

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
