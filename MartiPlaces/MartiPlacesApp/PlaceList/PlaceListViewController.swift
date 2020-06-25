//
//  PlaceListViewController.swift
//  MartiPlacesApp
//
//  Created by MUSTAFA TOLGA TAS on 23.06.2020.
//  Copyright © 2020 MUSTAFA TOLGA TAS. All rights reserved.
//

import UIKit

protocol PlaceDisplayLogic: class {
    func displayPlaces(viewModel: PlaceList.GetPlaces.ViewModel)
    func displayError(_ message : String)
    func displayEmpty(_ message : String)
}

class PlaceListViewController: UIViewController {
    
    // MARK: - Variables
    var interactor : PlaceListInteractor?
    var router : (NSObjectProtocol & PlaceListRoutingLogic & PlaceListDataPassing)?
    var placesViewModel : PlaceListViewModel?
    var cellType: CellType = .empty
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    enum CellType {
        case place, empty
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
        
        configureTableView()
    }
    
    // MARK: - Class Functions
    private func setup() {
        let viewController = self
        let interactor = PlaceListInteractor()
        let presenter = PlaceListPresenter()
        let router = PlaceListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: "PlaceCell", bundle: nil), forCellReuseIdentifier: "PlaceCell")
        tableView.register(UINib(nibName: "EmptyCell", bundle: nil), forCellReuseIdentifier: "EmptyCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        navigationItem.title = "Places"
    }
    
    private func fetchPlaces(text : String){
        interactor?.searchPlaces(text: text)
    }
    
    private func applyResults(){
        if placesViewModel == nil {
            cellType = .empty
        }else {
            cellType = .place
        }
        tableView.reloadData()
    }
    // MARK: - IBActions
    @IBAction private func searchButtonAction(_ sender: Any) {
        fetchPlaces(text: textField.text ?? "")
    }
}
// MARK: - Display Logic
extension PlaceListViewController : PlaceDisplayLogic {
    func displayPlaces(viewModel: PlaceList.GetPlaces.ViewModel) {
        self.placesViewModel = viewModel.displayResults
        applyResults()
    }
    
    func displayError(_ message: String) {
        let alert = UIAlertController(title: "Network Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func displayEmpty(_ message: String) {
        let alert = UIAlertController(title: "Network Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
// MARK: - Table View Extension
extension PlaceListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.placesViewModel?.candidates.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch cellType {
        case .empty:
            return configureEmptyCell()
        case .place:
            return configurePlaceCell()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.push(storyboardName: "Main", withIdentifier: "MapScreen", setupBlock: { (controller) in
            guard let controller = controller as? MapScreenViewController else {
                return
            }
            controller.selectedResult = self.placesViewModel?.candidates.first
            controller.title = "Map"
        })
    }
    
    func configurePlaceCell() -> PlaceCell {
        let placeCell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell") as! PlaceCell
        placeCell.placeNameLabel.text = placesViewModel?.candidates.first?.name ?? ""
        return placeCell
    }
    
    func configureEmptyCell() -> EmptyCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emptyCell") as! EmptyCell
        return cell
    }
}
