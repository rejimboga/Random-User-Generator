//
//  DetailsViewController.swift
//  Random User Generator
//
//  Created by Macbook Air on 24.01.2022.
//

import UIKit
import MapKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var phoneNumberStack: UIStackView!
    @IBOutlet weak var genderStack: UIStackView!
    @IBOutlet weak var birthdayStack: UIStackView!
    @IBOutlet weak var locationStack: UIStackView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var locationMapView: MKMapView!
    
    var user: UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up radius for each stack view
        phoneNumberStack.layer.cornerRadius = 20
        genderStack.layer.cornerRadius = 20
        birthdayStack.layer.cornerRadius = 20
        locationStack.layer.cornerRadius = 10
        
        // Set up radius for map view
        locationMapView.layer.cornerRadius = 10
        
        configureWith(user: user)
    }
    
    private func configureWith(user: UserModel?) {
        if let url = URL(string: user?.picture?.large ?? "") {
            avatarImage.sd_setImage(with: url, completed: nil)
            avatarImage.layer.cornerRadius = avatarImage.frame.height / 2
        }
        
        guard let userNameTitle = user?.name?.title else { return }
        guard let userNameFirst = user?.name?.first else { return }
        guard let userNameLast = user?.name?.last else { return }
        fullNameLabel.text = "\(userNameTitle) \(userNameFirst) \(userNameLast)"
        
        guard let phoneNumber = user?.phone else { return }
        phoneNumberLabel.text = phoneNumber
        
        guard let gender = user?.gender else { return }
        genderLabel.text = gender

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let date = user?.dob?.date else { return }
        if let dobDate = dateFormatter.date(from: date) {
            dateFormatter.dateFormat = "YYYY-MM-dd"
            let normalDateString = dateFormatter.string(from: dobDate)
            birthdayLabel.text = normalDateString
        }
        
        // Location info
        guard let country = user?.location?.country else { return }
        guard let city = user?.location?.city else { return }
        guard let state = user?.location?.state else { return }
        guard let street = user?.location?.street?.name else { return }
        guard let streetNumber = user?.location?.street?.number else { return }
        
        addressLabel.text = "\(streetNumber) \(street) St., \(city), \(state), \(country)"
        
        // Set up a map view
        guard let latitude = Double(user?.location?.coordinates?.latitude ?? "") else { return }
        guard let longitude = Double(user?.location?.coordinates?.longitude ?? "") else { return }
        
        let userCoordinate = CLLocation(latitude: latitude, longitude: longitude)
        
        locationMapView.centerToLocation(userCoordinate, regionRadius: 500)
        let annotation = MKPointAnnotation()
        annotation.coordinate = userCoordinate.coordinate
        annotation.title = "\(streetNumber), \(street)"
        locationMapView.addAnnotation(annotation)
    }
}

private extension MKMapView {
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius,
                                                  longitudinalMeters: regionRadius)
        
        setRegion(coordinateRegion, animated: true)
    }
}
