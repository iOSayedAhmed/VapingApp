//
//  Onboard.swift
//  VapingApp
//
//  Created by iOSayed on 16/12/2022.
//

import UIKit

class OnboardVC: UIViewController {
    
    
    var products = [ProductModel]()

    let transition = CustomTransition()
    //MARK: IBOutlet
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var continueButton: UIButton!
    
    
    private  var slide = [SlideModel]()
    private var currentPage = 0
    
    
    let subTitle = """
Plug un device using the charger provided
Devices will charge fully in under 20 minutes
"""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
  
    }
    
    
    
    //MARK: Functions
    
    func fetchData() {
        Networking.shared.FetchData(from: "https://api.jsonserve.com/JsTnaP") {
            [weak self ] result in
            guard let self = self  else {return}

            switch result {
            case .success(let data):
                
                do {
                    let jsonData = try JSONDecoder().decode([ProductModel].self, from: data)
                    print(jsonData)
                    self.products.append(contentsOf: jsonData)
                }catch {
                    print(error)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    private func setupUI(){
        collectionView.isScrollEnabled = false
        if let welcomeImage = UIImage(named:"welcome") , let chargingImage = UIImage(named: "charging"), let firstPuffImage = UIImage(named: "firstPuff"), let locatorImage = UIImage(named: "locator"), let lockImage = UIImage(named: "lock"),let statisticImage = UIImage(named: "statistic") {
            slide = [SlideModel(title: "Welcome", ValueProposition: "Value Proposition #1", subTitle: subTitle, image: welcomeImage),SlideModel(title: "Charging Your Device", ValueProposition: "Value Proposition #2", subTitle: subTitle, image: chargingImage),SlideModel(title: "First Puff", ValueProposition: "Value Proposition #3", subTitle: subTitle, image: firstPuffImage),SlideModel(title: "Usage Statistics", ValueProposition: "Value Proposition #4", subTitle: subTitle, image: statisticImage),SlideModel(title: "Device Locator", ValueProposition: "Value Proposition #5", subTitle: subTitle, image: locatorImage),SlideModel(title: "Lock & Unlock", ValueProposition: "Value Proposition #6", subTitle: subTitle, image: lockImage)]
        }
    }
    
    
    //MARK: IBActions
    
    @IBAction func continueButtonClicked(_ sender: UIButton) {
        if currentPage == slide.count - 1 {
            //  presentLoginVC()
            print("presentHomeVC")
            collectionView.isScrollEnabled = false
            let vc = storyboard?.instantiateViewController(withIdentifier: "ProductsVC") as! ProductsVC
            vc.view.backgroundColor = .lightGray
            let nav = UINavigationController(rootViewController: vc)
            nav.navigationBar.tintColor = .black
            nav.modalPresentationStyle = .fullScreen
            nav.transitioningDelegate = self
            present(nav, animated: true)
           // presentDetail(nav)
        }else {
            currentPage += 1
            let index = IndexPath(item: currentPage, section: 0)
            collectionView.isPagingEnabled = false
            collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            collectionView.isPagingEnabled = true
            
        }
        
    }
    
    
    
    
    
    
}
extension OnboardVC : UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slide.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardCell", for: indexPath) as! OnboardCell
        cell.setUp(slide[indexPath.row])
        return cell
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    
    //Transitions
    
}
extension OnboardVC : UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = true
        transition.originFrame = continueButton.frame
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}

