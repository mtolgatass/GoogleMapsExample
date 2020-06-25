//
//  DetailScreenViewController.swift
//  MartiPlacesApp
//
//  Created by MUSTAFA TOLGA TAS on 23.06.2020.
//  Copyright © 2020 MUSTAFA TOLGA TAS. All rights reserved.
//

import UIKit
import SnapKit

class DetailScreenViewController: UIViewController {
    
    // MARK: - Variables
    var interactor : DetailScreenInteractor?
    var router : (NSObjectProtocol & DetailScreenRoutingLogic & DetailScreenDataPassing)?
    
    lazy var stackView = UIStackView()
    lazy var imageView = UIImageView()
    lazy var label = UILabel()
    
    var selectedResult : Candidates?
    var photoData : UIImage!{
        didSet{
            applyPhoto()
        }
    }
    
    // MARK: - Initializers & Override Functions
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        getPhotoUrl()
    }
    
    // MARK: - Class Functions
    private func getPhotoUrl(){
        guard let model = selectedResult else {
            setPlaceholderImage()
            return
            
        }
        guard let photos = model.photos else {
            setPlaceholderImage()
            return
        }
        guard let photoRef = photos.first?.photo_reference else {
            setPlaceholderImage()
            return
        }
        
        interactor?.getPhotoUrl(photoRef: photoRef)
    }
    
    private func setup() {
        let viewController = self
        let interactor = DetailScreenInteractor()
        let presenter = DetailScreenPresenter()
        let router = DetailScreenRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupUI(){
        stackView.axis = .vertical
        stackView.spacing = 16
        
        imageView.layer.cornerRadius = 4
        imageView.layer.masksToBounds = true
        
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = selectedResult?.formatted_address
        label.numberOfLines = 0
        label.textAlignment = .center
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { (make) in
            make.width.equalTo(300)
            make.center.equalTo(self.view)
        }
    }
    
    private func applyPhoto(){
        self.imageView.image = photoData
    }
    private func setPlaceholderImage(){
        self.imageView.image = UIImage(named: "placeholder")
    }
    
    func displayError(_ message: String) {
        let alert = UIAlertController(title: "Network Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
