//
//  ViewController.swift
//  RxSwiftExs
//
//  Created by LinXunFeng on 10/16/2018.
//  Copyright (c) 2018 LinXunFeng. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {
    
    override init() {
        super.init()
        self.title = "RxSwiftExs Example"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let vc = WebViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

