//
//  SepetRouter.swift
//  Doyur
//
//  Created by Altay Kırlı on 9.01.2022.
//

import Foundation

class SepetRouter : PresenterToRouterSepetProtocol {
    static func createModule(ref: SepetVC) {
        var presenter: ViewToPresenterSepetProtocol & InteractorToPresenterSepetProtocol = SepetPresenter()
        presenter.sepetView = ref
        presenter.sepetInteractor = SepetInteractor()
        ref.presenterNesnesi = presenter
        ref.presenterNesnesi?.sepetInteractor?.sepetPresenter = presenter
    }
}
