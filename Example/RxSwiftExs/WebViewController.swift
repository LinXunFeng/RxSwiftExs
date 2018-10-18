//
//  WebViewController.swift
//  RxSwiftExs_Example
//
//  Created by LinXunFeng on 2018/10/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import WebKit
import RxSwift
import RxSwiftExs

fileprivate let ScreenW = UIScreen.main.bounds.size.width
fileprivate let ScreenH = UIScreen.main.bounds.size.height

class WebViewController: BaseViewController {

    // MARK:- UI
    fileprivate var webView : WKWebView = {
        let view = WKWebView(frame: CGRect(
            x: 0,
            y: 0,
            width: ScreenW,
            height: ScreenH))
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        
        self.view.addSubview(webView)
        let htmlPath = Bundle.main.path(forResource: "js", ofType: "html")!
        webView.load(URLRequest(url: URL(fileURLWithPath: htmlPath)))
    }
    
    fileprivate func bind() {
        let funcName = "lxfFuncName"
        webView.rx.addMessageHandler(funcName)
        webView.rx.scriptMessageHandler
            .subscribe(onNext: { message in
                print("funcName -- \(message.name)")
                guard let info = message.body as? [String : Any] else { return }
                print("info -- \(info)")
            })
            .disposed(by: disposeBag)
    }
}
