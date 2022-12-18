//
//  ProductsVC.swift
//  VapingApp
//
//  Created by iOSayed on 16/12/2022.
//

import UIKit

class ProductsVC: UIViewController  {
    
    private var products = [ProductModel]()
    private var isOffline:Bool = false {
        didSet{
            if isOffline {
                DispatchQueue.main.async {
                    ToastManager.shared.showToast(message: "   You're Offline   ", type: .error, view: self.view)
                }
            }else{
             // You're Online
            }
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var spinnerView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Products list"
        checkNetwork()
        collectionView.delegate = self
        collectionView.dataSource = self
        registerCollectionViewCells()
        
        self.collectionView.alpha = 0.7
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MARK: Functions
    
    
    private func registerCollectionViewCells(){
        collectionView.register(UINib(nibName: "ProductsCell", bundle: nil), forCellWithReuseIdentifier: "ProductsCell")
        
        collectionView.register(ProductsLoadingFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "ProductsLoadingFooter")
    }
    
    private func checkNetwork(){
        if NetworkMonitor.shared.isConnected {
            isOffline = false
            fetchData()
            print("You're Online")
        }else {
            isOffline = true
            getCachedProducts()
            print("You're Offline")
        }
    }
    
    
    private func getCachedProducts() {
        if let data = UserDefaults.standard.object(forKey:Constants.UserDefaultsKeys.Cached.rawValue) as? Data,
           let productCached = try? JSONDecoder().decode([ProductModel].self, from: data) {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.products = productCached
                self.collectionView.alpha = 1
                self.spinnerView.stopAnimating()
                self.spinnerView.isHidden = true
                self.collectionView.reloadData()
            }
        }
    }
    
    func fetchData() {
        DispatchQueue.global(qos: .background ).async {
            DispatchQueue.main.async
            {
                self.spinnerView.startAnimating()
            }
            Networking.shared.FetchData(from: Constants.shared.baseURL) {
                [weak self ] result in
                guard let self = self  else {return}
                
                switch result {
                case .success(let data):
                    //cached Data
                    UserDefaults.standard.set(data, forKey: Constants.UserDefaultsKeys.Cached.rawValue)
                    do {
                        let jsonData = try JSONDecoder().decode([ProductModel].self, from: data)
                        self.products.append(contentsOf: jsonData)
                        DispatchQueue.main.async {
                            self.collectionView.alpha = 1
                            self.spinnerView.stopAnimating()
                            self.spinnerView.isHidden = true
                            self.collectionView.reloadData()
                        }
                    }catch {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    if error.localizedDescription.contains("offline") {
                        self.isOffline = true
                    }
                    print(error.localizedDescription)
                    
                }
            }
        }
    }
    
}
extension ProductsVC : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsCell", for: indexPath) as! ProductsCell
        cell.setData(from: products[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let approximateWidthOfContent = view.frame.size.width

        let size = CGSize(width: approximateWidthOfContent, height: 1000)

        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]
        let estimatedFrame = NSString(string: products[indexPath.item].productDescription).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)

        let estimatedFrame2 = NSString(string: "\(products[indexPath.item].price)").boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)

        return CGSize(width:(collectionView.frame.size.width) / 2 , height: (estimatedFrame.height + estimatedFrame2.height ) + CGFloat(products[indexPath.item].image.height) + 85)
   }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "DetailsVC") as!  DetailsVC
        
        vc.product = self.products[indexPath.item]
        let nav = UINavigationController(rootViewController: vc)
        nav.title = "Products Details"
        nav.modalPresentationStyle = .fullScreen
        presentDetail(nav)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ProductsLoadingFooter", for: indexPath)
        if products.count <= 0 || isOffline {
            footer.isHidden = true
        }else
        {
            footer.isHidden = false
        }
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 100)
    }
    
    func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == products.count - 1  {
            print("Load more Data")
            fetchData()
        }
    }
}

