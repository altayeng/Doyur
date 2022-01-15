//
//  DetayRouter.swift
//  Doyur
//
//  Created by Altay Kırlı on 9.01.2022.
//

import Foundation

class DetayRouter : PresenterToRouterDetayProtocol {
    static func createModule(ref: DetayVC) {
        var presenter : ViewToPresenterDetayProtocol & InteractorToPresenterDetayProtocol = DetayPresenter()
        ref.detayPresenterNesnesi = presenter
        presenter.detayInteractor = DetayInteractor()
        ref.detayPresenterNesnesi?.detayInteractor?.detayPresenter = presenter
        presenter.detayView = ref
        
    }

    
}
