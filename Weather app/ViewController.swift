//
//  ViewController.swift
//  Weather app
//
//  Created by macbook on 29.03.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var loadingFlag: UIActivityIndicatorView!
    

    override func viewDidLoad() {
        loadingFlag.startAnimating()
        super.viewDidLoad()
        CurrentPositionManagerImpl()
        
    }


}

