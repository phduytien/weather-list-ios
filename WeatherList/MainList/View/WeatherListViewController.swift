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
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    private var currStatusCode: HTTPResponseStatusCode = .ok
    private lazy var viewModel = WeatherListViewModel(delegate: self)
    private var currUnit: Units = .default
    private var weatherList: [WeatherItemUIModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIs()
        setupNavigationBar()
    }
    
    // MARK: - Setup UIs
    
    private func setupUIs() {
        // SearchBar text
        let textFieldInsideUISearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideUISearchBar?.font = .callOut
        // SearchBar placeholder
        let labelInsideUISearchBar = textFieldInsideUISearchBar?.value(forKey: "placeholderLabel") as? UILabel
        labelInsideUISearchBar?.font = .callOut
        UISegmentedControl.appearance().setTitleTextAttributes([.font: UIFont.footnote], for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes([.font: UIFont.footnote], for: .selected)
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
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let confirmAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
            WeatherListCache.shared.empty()
        })
        let alertController = UIAlertController(title: "Reset Cache",
                                                message: "Do you want to reset all cache?",
                                                preferredStyle: .alert)
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    @IBAction func numberOfDayTFDidChanged(_ sender: Any) {
        executeFetchWeatherList()
    }
    
    @IBAction func temperatureUnitValueChanged(_ sender: Any) {
        switch segmentControl.selectedSegmentIndex {
        case 1:
            currUnit = .metric
        case 2:
            currUnit = .imperial
        default:
            currUnit = .default
        }
        executeFetchWeatherList()
    }
}

// MARK: - Private
private extension WeatherListViewController {
    
    @discardableResult
    func validateSearchConditions(isShowError: Bool = false) -> Bool {
        let searchBarText = searchBar.text?.trimmingCharacters(in: .whitespaces)
        guard let cityName = searchBarText, !cityName.isEmpty, cityName.count >= 3 else {
            if isShowError {
                showErrorMessage(.invalidCity)
            } else {
                currStatusCode = .ok
                weatherList = []
            }
            return false
        }
        return true
    }
    
    func showErrorMessage(_ errorType: ErrorType) {
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        let alertController = UIAlertController(title: errorType.errorTitle,
                                                message: errorType.errorMessage,
                                                preferredStyle: .alert)
        
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    func executeFetchWeatherList() {
        // If match validation conditons, continue requesting
        guard validateSearchConditions() else {
            return
        }
        // Create request
        let request = WeatherListRequest(cityName: searchBar.text,
                                         numberOfDays: numberOfDaysTextField.text,
                                         unit: currUnit)
        viewModel.fetchWeatherListWithRequest(request)
    }
}

// MARK: - UISearchBarDelegate
extension WeatherListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if validateSearchConditions(isShowError: true) {
            view.endEditing(true)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        executeFetchWeatherList()
    }
}

// MARK: - WeatherListViewDelegate
extension WeatherListViewController: WeatherListViewDelegate {
    
    func didFetchWeatherListFailed(_ statusCode: HTTPResponseStatusCode?, errorMessage: String?) {
        guard let statusCode = statusCode else {
            return
        }
        switch statusCode {
        case .noInternet:
            showErrorMessage(.fetchingNoInternet)
        case .badRequest:
            showErrorMessage(.fetchingBadRequest)
        case .unknown:
            showErrorMessage(.fetchingUnknown)
        default:
            break
        }
        currStatusCode = statusCode
        weatherList = []
    }
    
    func didFetchWeatherListSucceed(_ list: [WeatherItemUIModel]) {
        currStatusCode = .ok
        weatherList = list
    }
}


// MARK: - UITableViewDataSource, UITableViewDelegate
extension WeatherListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if weatherList.isEmpty && currStatusCode == .notFound {
            return 1
        }
        return weatherList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: WeatherItemTableViewCell.identifier, for: indexPath) as? WeatherItemTableViewCell {
            var contentText: String?
            if currStatusCode == .notFound {
                contentText = "No search city found"
            } else {
                contentText = weatherList.safeElement(at: indexPath.row)?.weatherItemDescription(unit: currUnit)
            }
            if let contentText = contentText {
                let attributedString = NSMutableAttributedString(string: contentText)
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = .spacingNormal
                attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
                cell.weatherItemLabel.attributedText = attributedString
            }
            return cell
        }
        return WeatherItemTableViewCell()
    }
}


// MARK: - UIScrollViewDelegate
extension WeatherListViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}
