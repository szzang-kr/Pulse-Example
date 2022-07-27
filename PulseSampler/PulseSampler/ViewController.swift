//
//  ViewController.swift
//  PulseSampler
//
//  Created by Ahn Sang Hoon on 2022/07/05.
//

import UIKit

import Logging
import PinLayout
import PulseUI

class ViewController: UIViewController {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Pulse Sample"
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    private lazy var sessionRequestButton: UIButton = {
        let button = UIButton.make(title: "URLSession request")
        button.addTarget(self, action: #selector(sessionRequest), for: .touchUpInside)
        return button
    }()
    private lazy var afRequestButton: UIButton = {
        let button = UIButton.make(title: "Alamofire request")
        button.addTarget(self, action: #selector(afRequest), for: .touchUpInside)
        return button
    }()
    private lazy var controllerButton: UIButton = {
        let button = UIButton.make(title: "Pulse UI")
        button.addTarget(self, action: #selector(showController), for: .touchUpInside)
        return button
    }()
    
    private let logger = Logger(label: Bundle.main.bundleIdentifier!)
    private let service = Service()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(stackView)
        stackView.pin
            .top()
            .left()
            .right()
            .height(300)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(sessionRequestButton)
        stackView.addArrangedSubview(afRequestButton)
        stackView.addArrangedSubview(controllerButton)
    }
    
    @objc
    private func sessionRequest() {
        service.request()
    }
    
    @objc
    private func afRequest() {
        logger.info("tap Alamofire Request")
        service.afRequest()
    }
    
    @objc
    private func showController() {
        logger.info("tap Open Controller")
        present(MainViewController(), animated: true)
    }
}

extension UIButton {
    static func make(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }
}
