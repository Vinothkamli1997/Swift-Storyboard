//
//  OnBoardingViewController.swift
//  EliteCake
//
//  Created by Apple - 1 on 05/01/23.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides: [OnboardingSlide] = []
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextBtn.setTitle("Get Started", for: .normal)
            } else {
                nextBtn.setTitle("Next", for: .normal)
            }
        }
    }
    
    var loginScreen: UIStoryboard {
        return UIStoryboard(name:"Main", bundle: Bundle.main)
    }
    var homeStoryboard: UIStoryboard {
        return UIStoryboard(name:"HomeScreen", bundle: Bundle.main)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialLoads()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func skipBtnAction(_ sender: UIButton) {
        let vc = loginScreen.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func nextBtnAction(_ sender: UIButton) {
        if currentPage == slides.count - 1 {
            let vc = loginScreen.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

extension OnboardingViewController {
    
    private func initialLoads()  {
        slides = [
            OnboardingSlide(title: OnboardingConstant.title1, description: OnboardingConstant.description1, image: UIImage(named: "wlakThroughImage1")!),
            OnboardingSlide(title: OnboardingConstant.title2, description: OnboardingConstant.description2, image: UIImage(named: "walkThroughImage")!)
            
        ]
        
        collectionView.layer.shadowColor = UIColor.black.cgColor
        collectionView.layer.shadowOpacity = 0.5
        collectionView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        collectionView.layer.shadowRadius = 3.0
        collectionView.backgroundColor = UIColor(named: "ViewDarkMode")
        collectionView.layer.masksToBounds = false
        collectionView.cornerRadius = 20
        skipBtn.setTitle("Skip", for: .normal)
        skipBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        pageControl.currentPageIndicatorTintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        nextBtn.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.idendifier, for: indexPath) as! OnboardingCollectionViewCell
        
        cell.setup(slides[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}
