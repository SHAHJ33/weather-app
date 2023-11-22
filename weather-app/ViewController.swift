//
//  ViewController.swift
//  weather-app
//
//  Created by ShahJee on 13/11/2023.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tempUnitLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var conditionImage: UIImageView!
    @IBOutlet weak var searchTextField: UITextField!
    
    let locationManager = CLLocationManager()
    let weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherManager.delegate = self
        locationManager.delegate = self
        searchTextField.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
    }

    @IBAction func searchPressed(_ sender: Any) {
        if searchTextField.text?.isEmpty == false
        {
            searchTextField.endEditing(true)
        }
    }
    
    @IBAction func locationPressed(_ sender: Any) {
        locationManager.requestLocation()
    }
    
}

extension ViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.tempLabel.text = weather.temperatureString
            self.conditionImage.image = UIImage(systemName: weather.conditionName)
            self.locationLabel.text = weather.city
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

// MARK: - TextField Delegates
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""
        {
            return true
        }
        else
        {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city )
        }
        searchTextField.text = ""
    }
}

// MARK: - Location Manager Delegates
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
