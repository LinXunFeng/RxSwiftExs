//
//  WKWebView+Rx.swift
//  RxSwiftExs
//
//  Created by LinXunFeng on 2018/9/21.
//  Copyright © 2018年 LinXunFeng. All rights reserved.
//

import RxCocoa
import RxSwift
import WebKit

public extension Reactive where Base: WKWebView {
    internal var handlerProxy : RxWKWebViewHandlerProxy {
        return RxWKWebViewHandlerProxy.proxy(for: base)
    }
    
    var scriptMessageHandler: ControlEvent<WKScriptMessage> {
        return ControlEvent(events: handlerProxy.didReceiveMessagePublishSubject)
    }
    
    func addMessageHandler(_ message: String) {
        handlerProxy.addMessageHandler(message)
    }
}

private var webViewHandlerKey = "lxf_webViewHandlerKey"
extension WKWebView: AssociatedObjectStore {
    weak var handler : WKScriptMessageHandler? {
        get { return associatedObject(forKey: &webViewHandlerKey) }
        set { setAssociatedObject(newValue, forKey: &webViewHandlerKey) }
    }
}

class RxWKWebViewHandlerProxy
    : DelegateProxy<WKWebView,WKScriptMessageHandler>
    , DelegateProxyType
    ,WKScriptMessageHandler {
    
    public weak private(set) var webView:WKWebView?
    fileprivate var _didReceiveMessagePublishSubject: PublishSubject<(WKScriptMessage)>?
    
    public init(webView: ParentObject) {
        self.webView = webView
        super.init(parentObject: webView, delegateProxy: RxWKWebViewHandlerProxy.self)
    }
    
    static func registerKnownImplementations() {
        self.register { RxWKWebViewHandlerProxy(webView: $0) }
    }
    
    static func currentDelegate(for object: WKWebView) -> WKScriptMessageHandler? {
        return object.handler
    }
    
    static func setCurrentDelegate(_ handler: WKScriptMessageHandler?, to object: WKWebView) {
        object.handler = handler
    }
    
    var didReceiveMessagePublishSubject: PublishSubject<(WKScriptMessage)> {
        if let subject = _didReceiveMessagePublishSubject {
            return subject
        }
        let subject = PublishSubject<(WKScriptMessage)>()
        _didReceiveMessagePublishSubject = subject
        return subject
    }
    
    deinit {
        if let subject = _didReceiveMessagePublishSubject {
            subject.on(.completed)
        }
    }
    
    // MARK:- WKScriptMessageHandler
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        if let subject = _didReceiveMessagePublishSubject {
            subject.onNext((message))
        }
        
        self._forwardToDelegate?.userContentController(userContentController, didReceive: message)
    }
    
    func addMessageHandler(_ message: String) {
        guard let rxDelegate = webView?.handler else { return }
        webView?.configuration.userContentController.add(rxDelegate, name: message)
    }
}
