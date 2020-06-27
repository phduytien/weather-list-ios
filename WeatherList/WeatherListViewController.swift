//
//  WeatherListViewController.swift
//  WeatherList
//
//  Created by TienPham on 6/27/20.
//  Copyright © 2020 Tien Pham. All rights reserved.
//

import UIKit

class WeatherListViewController: UIViewController {
    
    // MARK: - Private UIs
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var numberOfDaysTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var viewModel = WeatherListViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIs()
        setupNavigationBar()
    }
    
    // MARK: - Setup UIs
    
    private func setupUIs() {
        
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Weather Forecast"
        let barButtonReset = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(resetAndRefresh))
        navigationItem.setRightBarButton(barButtonReset, animated: false)
        navigationController?.navigationBar.subviews.forEach { subView in
            subView.isExclusiveTouch = true
        }
    }
    
    // MARK: - IBAction
    
    @objc private func resetAndRefresh() {
        
    }
    
    @IBAction func temperatureUnitValueChanged(_ sender: Any) {
        
    }
}

// MARK: - Private
private extension WeatherListViewController {
    
    @discardableResult
    func validateSearchConditions() -> Bool {
        let searchBarText = searchBar.text?.trimmingCharacters(in: .whitespaces)
        guard let cityName = searchBarText, !cityName.isEmpty, cityName.count >= 3 else {
            showErrorMessage(.invalidCity)
            return false
        }
        return true
    }
    
    func showErrorMessage(_ error: ErrorType) {
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        let alertController = UIAlertController(title: error.errorTitle,
                                                message: error.errorMessage,
                                                preferredStyle: .alert)
        
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
}

// MARK: - UISearchBarDelegate

extension WeatherListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if validateSearchConditions() {
            view.endEditing(true)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}

// MARK: - UITextFieldDelegate

extension WeatherListViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}
