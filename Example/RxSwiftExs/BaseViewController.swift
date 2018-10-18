//
//  BaseViewController.swift
//  RxSwiftExs_Example
//
//  Created by LinXunFeng on 2018/10/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController: UIViewController {

    var disposeBag = DisposeBag()
    
    // MARK: Properties
    lazy private(set) var className: String = {
        return type(of: self).description().components(separatedBy: ".").last ?? ""
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    deinit {
        print("DEINIT: \(self.className)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    
}
