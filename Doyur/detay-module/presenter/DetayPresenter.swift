//
//  DetayPresenter.swift
//  Doyur
//
//  Created by Altay Kırlı on 9.01.2022.
//

import Foundation

class DetayPresenter : ViewToPresenterDetayProtocol{
    var detayInteractor: PresenterToInteractorDetayProtocol?
    var detayView: PresenterToViewDetayProtocol?
    
    func sepeteEkle(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String) {
        detayInteractor?.sepeteEkle(yemek_adi: yemek_adi, yemek_resim_adi: yemek_resim_adi, yemek_fiyat: yemek_fiyat, yemek_siparis_adet: yemek_siparis_adet, kullanici_adi: kullanici_adi)
    }
}

extension DetayPresenter : InteractorToPresenterDetayProtocol{
    func presenteraVeriGonder(basariliMi: Bool, hataMesaj: String?) {
        detayView?.vieweVeriGonder(basariliMi: basariliMi, hataMesaj: hataMesaj)
    }
}
