//
//  LocationPickerViewController.swift
//  MessengerApp
//
//  Created by Антон Головатый on 03.03.2022.
//

import UIKit
import CoreLocation
import MapKit

//MARK: - LocationPickerViewController class declaration
/// Controller that shows map to pick a location
final class LocationPickerViewController: UIViewController {
    
    //MARK: - Properties
    public var completion: ((CLLocationCoordinate2D) -> Void)?
    
    private let map: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    private var coordinates: CLLocationCoordinate2D?
    private var isPickable = true
    
    //MARK: - Initializers
    init(coordinates: CLLocationCoordinate2D?) {
        self.coordinates = coordinates
        isPickable = coordinates == nil
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        map.frame = view.bounds
    }
    
    //MARK: - Private methods
    private func setupView() {
        title = "Pick Location"
        view.backgroundColor = .systemBackground
        
        if isPickable {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Send",
                                                                style: .done,
                                                                target: self,
                                                                action: #selector(sendButtonTapped))
            map.isUserInteractionEnabled = true
            let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapMap(_:)))
            gesture.numberOfTouchesRequired = 1
            gesture.numberOfTapsRequired = 1
            map.addGestureRecognizer(gesture)
        }
        else {
            guard let coordinates = coordinates else { return }
            let pin = MKPointAnnotation()
            pin.coordinate = coordinates
            map.addAnnotation(pin)
        }
        view.addSubview(map)
    }
    
    //MARK: - Actions
    @objc func sendButtonTapped() {
        guard let coordinates = coordinates else {
            return
        }
        navigationController?.popViewController(animated: true)
        completion?(coordinates)
    }
    
    @objc func didTapMap(_ gesture: UITapGestureRecognizer) {
        let locationInView = gesture.location(in: map)
        coordinates = map.convert(locationInView, toCoordinateFrom: map)

        for annotation in map.annotations {
            map.removeAnnotation(annotation)
        }
        
        if let coordinates = coordinates {
            let pin = MKPointAnnotation()
            pin.coordinate = coordinates
            map.addAnnotation(pin)
        }
    }
}
