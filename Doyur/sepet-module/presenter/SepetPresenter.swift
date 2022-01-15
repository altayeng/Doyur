//
//  SepetPresenter.swift
//  Doyur
//
//  Created by Altay Kırlı on 9.01.2022.
//

import Foundation

class SepetPresenter : ViewToPresenterSepetProtocol {
    var sepetInteractor: PresenterToInteractorSepetProtocol?
    var sepetView: PresenterToViewSepetProtocol?
    
    func sepetiYukle(kullanici_adi: String) {
        sepetInteractor?.tumSepetiYukle(kullanici_adi: kullanici_adi)
    }
    
    func sepetYemekSil(sepet_yemek_id: String, kullanici_adi: String) {
        sepetInteractor?.sepetYemekSil(sepet_yemek_id: sepet_yemek_id, kullanici_adi: kullanici_adi)
    }
}

extension SepetPresenter : InteractorToPresenterSepetProtocol {
    func presenteraVeriGonder(yemeklerListesi: Array<Sepet>?) {
        sepetView?.vieweVeriGonder(yemeklerListesi: yemeklerListesi)
    }
}
