//
//  MapScreenViewController.swift
//  MartiPlacesApp
//
//  Created by MUSTAFA TOLGA TAS on 23.06.2020.
//  Copyright © 2020 MUSTAFA TOLGA TAS. All rights reserved.
//

import UIKit
import GoogleMaps

class MapScreenViewController: UIViewController {
    
    // MARK: - Variables
    var interactor : MapScreenInteractor?
    var router : (NSObjectProtocol & MapScreenRoutingLogic & MapScreenDataPassing)?
    var selectedResult : Candidates?
    
    var currentLocation : CLLocation?
    var mapView : GMSMapView!
    var zoomLevel : Float = 15.0
    
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
        
        setupMapView()
    }
    
    // MARK: - Class Functions
    private func setupMapMarker(lat : Double, lon : Double){
        let location = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let marker = GMSMarker(position: location)
        marker.title = selectedResult?.name
        marker.snippet = selectedResult?.formatted_address
        marker.map = mapView
    }
    
    private func setupMapView(){
        guard let lat = selectedResult?.geometry?.location?.lat else {
            showError()
            return
        }
        guard let lon = selectedResult?.geometry?.location?.lng else {
            showError()
            return
        }
        
        let camera = GMSCameraPosition.camera(withLatitude: lat,
                                              longitude: lon,
                                              zoom: zoomLevel)
        mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.isMyLocationEnabled = true
        
        setupMapMarker(lat : lat, lon : lon)
        
        mapView.delegate = self
        
        view.addSubview(mapView)
    }
    
    private func setup() {
        let viewController = self
        let interactor = MapScreenInteractor()
        let presenter = MapScreenPresenter()
        let router = MapScreenRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func showError(){
        let alert = UIAlertController(title: "Error", message: "An error occured", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
            self.router?.popViewController()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
// MARK: - GMSMap View Extension
extension MapScreenViewController : GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        self.router?.push(storyboardName: "Main", withIdentifier: "DetailScreen", setupBlock: { (controller) in
            guard let controller = controller as? DetailScreenViewController else {
                return
            }
            controller.selectedResult = self.selectedResult
            controller.title = self.selectedResult?.name
        })
    }
}
