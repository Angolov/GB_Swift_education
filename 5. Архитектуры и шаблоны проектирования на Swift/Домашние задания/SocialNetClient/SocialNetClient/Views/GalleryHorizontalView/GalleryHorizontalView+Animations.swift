//
//  GalleryHorizontalView+Animations.swift
//  SocialNetClient
//
//  Created by Антон Головатый on 28.01.2022.
//

import UIKit

//MARK: - Extension of GalleryHorizontalView for animations

extension GalleryHorizontalView {
    
    //MARK: - Animations methods
    
    @objc func onPan(_ recognizer: UIPanGestureRecognizer) {
        if let animator = interactiveAnimator,
           animator.isRunning { return }
        
        switch recognizer.state {
        case .began: touchBegan(recognizer)
        case .changed: touchMoves(recognizer)
        case .ended: touchEnded(recognizer)
        default: return
        }
    }
    
    private func touchBegan(_ recognizer: UIPanGestureRecognizer) {
        transformViewsToIdentity()
        
        loadImageBy(index: currentIndex, isMain: true)
        self.bringSubviewToFront(self.mainImageView)
        
        interactiveAnimator?.startAnimation()
        let animation: (() -> Void)? = { [weak self] in
            self?.mainImageView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width,
                                                              y: 0)
        }
        interactiveAnimator = UIViewPropertyAnimator(duration: 0.5,
                                                     curve: .easeInOut,
                                                     animations: animation)
        interactiveAnimator.pauseAnimation()
        isLeftSwipe = false
        isRightSwipe = false
        chooseFlag = false
    }
    
    private func touchMoves(_ recognizer: UIPanGestureRecognizer) {
        var translation = recognizer.translation(in: self.view)
        
        if translation.x < 0 && (!isLeftSwipe) && (!chooseFlag) {
            if currentIndex == (imageUrls.count - 1) {
                interactiveAnimator.stopAnimation(true)
                return
            }
            chooseFlag = true
            isLeftSwipe = true
            onChange(isLeft: isLeftSwipe)
            
            interactiveAnimator.stopAnimation(true)
            interactiveAnimator.addAnimations { [weak self] in
                guard let self = self else { return }
                self.mainImageView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
                self.secondaryImageView.transform = .identity
            }
            interactiveAnimator.addCompletion({ [weak self] _ in
                guard let self = self else { return }
                self.onChangeCompletion(isLeft: self.isLeftSwipe)
            })
            
            interactiveAnimator.startAnimation()
            interactiveAnimator.pauseAnimation()
        }
        
        if translation.x > 0 && (!isRightSwipe) && (!chooseFlag) {
            if currentIndex == 0 {
                interactiveAnimator.stopAnimation(true)
                return
            }
            isRightSwipe = true
            chooseFlag = true
            onChange(isLeft: !isRightSwipe)
            
            interactiveAnimator.stopAnimation(true)
            
            interactiveAnimator.addAnimations { [weak self] in
                guard let self = self else { return }
                self.mainImageView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
                self.secondaryImageView.transform = .identity
            }
            interactiveAnimator.addCompletion({ [weak self] _ in
                guard let self = self else { return }
                self.onChangeCompletion(isLeft: !self.isRightSwipe)
            })
            
            interactiveAnimator.startAnimation()
            interactiveAnimator.pauseAnimation()
        }
        
        if isRightSwipe && (translation.x < 0) { return }
        if isLeftSwipe && (translation.x > 0) { return }
        
        translation.x = translation.x < 0 ? -translation.x : translation.x
        interactiveAnimator.fractionComplete = translation.x / (UIScreen.main.bounds.width)
    }
    
    private func touchEnded(_ recognizer: UIPanGestureRecognizer) {
        if let animator = interactiveAnimator,
           animator.isRunning { return }
        
        var translation = recognizer.translation(in: self.view)

        translation.x = translation.x < 0 ? -translation.x : translation.x
        
        if (translation.x / (UIScreen.main.bounds.width)) > 0.5  {
            interactiveAnimator.startAnimation()
        } else {
            interactiveAnimator.stopAnimation(true)
            interactiveAnimator.finishAnimation(at: .start)
            interactiveAnimator.addAnimations { [weak self] in
                guard let self = self else { return }
                self.mainImageView.transform = .identity
                if self.isLeftSwipe {
                    self.secondaryImageView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
                }
                if self.isRightSwipe {
                    self.secondaryImageView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
                }
            }
            interactiveAnimator.addCompletion({ [weak self] _ in
                guard let self = self else { return }
                self.transformViewsToIdentity()
            })
            interactiveAnimator.startAnimation()
        }
    }
    
    private func transformViewsToIdentity() {
        mainImageView.transform = .identity
        secondaryImageView.transform = .identity
    }
    
    private func onChange(isLeft: Bool) {
        transformViewsToIdentity()
        loadImageBy(index: currentIndex, isMain: true)
        
        if isLeft {
            loadImageBy(index: currentIndex + 1, isMain: false)
            secondaryImageView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
        } else {
            loadImageBy(index: currentIndex - 1, isMain: false)
            secondaryImageView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
        }
    }
    
    private func onChangeCompletion(isLeft: Bool) {
        transformViewsToIdentity()
        currentIndex = isLeft ? currentIndex + 1 : currentIndex - 1
        customPageView.currentPage = currentIndex
        loadImageBy(index: currentIndex, isMain: true)
        bringSubviewToFront(mainImageView)
    }
}
