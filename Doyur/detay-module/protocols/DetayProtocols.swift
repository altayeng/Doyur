//
//  DetayProtocols.swift
//  Doyur
//
//  Created by Altay Kırlı on 9.01.2022.
//

import Foundation

protocol ViewToPresenterDetayProtocol {
    var detayInteractor:PresenterToInteractorDetayProtocol? {get set}
    var detayView:PresenterToViewDetayProtocol? {get set}
    
    func sepeteEkle(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String)
}

protocol PresenterToInteractorDetayProtocol {
    var detayPresenter:InteractorToPresenterDetayProtocol? {get set}
    
    func sepeteEkle(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String)
}

protocol InteractorToPresenterDetayProtocol {
    func presenteraVeriGonder(basariliMi: Bool, hataMesaj: String?)
}

protocol PresenterToViewDetayProtocol {
    func vieweVeriGonder(basariliMi: Bool, hataMesaj: String?)
}

protocol PresenterToRouterDetayProtocol {
    static func createModule(ref:DetayVC)
}
