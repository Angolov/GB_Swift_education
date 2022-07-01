//
//  ScreenshotPageViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Антон Головатый on 26.06.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class ScreenshotPageViewController: UIPageViewController {
    
    // MARK: - Properties
    
    private let app: ITunesApp
    private var currentIndex: Int
    
    // MARK: Initializer
    
    init(app: ITunesApp, index: Int) {
        self.app = app
        self.currentIndex = index
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - VC lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        self.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let startVC = getViewController(index: currentIndex) {
            self.setViewControllers([startVC], direction: .forward, animated: true)
        }
    }
    
    // MARK: - Private methods
    
    func getViewController(index: Int) -> UIViewController? {
        
        guard index >= 0, index < app.screenshotUrls.count else { return nil }
        
        let imageString = app.screenshotUrls[index]
        return ImageViewController(imageString: imageString, index: index)
    }
}

// MARK: UIPageViewControllerDataSource

extension ScreenshotPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let imageViewController = viewController as? ImageViewController
        
        guard var currentControllerIndex = imageViewController?.index else { return nil }
        
        currentIndex = currentControllerIndex
        
        if currentControllerIndex == 0 { return nil }
        
        currentControllerIndex -= 1
        
        return getViewController(index: currentControllerIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let imageViewController = viewController as? ImageViewController
        
        guard var currentControllerIndex = imageViewController?.index else { return nil }
        
        currentIndex = currentControllerIndex
        
        if currentControllerIndex == app.screenshotUrls.count - 1 { return nil }
        
        currentControllerIndex += 1
        
        return getViewController(index: currentControllerIndex)
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentIndex
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return app.screenshotUrls.count
    }
}
