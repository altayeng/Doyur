//
//  AnasayfaPresenter.swift
//  Doyur
//
//  Created by Altay Kırlı on 9.01.2022.
//

import Foundation

class AnasayfaPresenter : ViewToPresenterAnasayfaProtocol{
    
    var anasayfaInteractor: PresenterToInteractorAnasayfaProtocol?
    
    var anasayfaView: PresenterToViewAnasayfaProtocol?
    
    func yemekleriYukle() {
        anasayfaInteractor?.tumYemekleriYukle()
    }
    
    func sepetYemeklerSayisiYukle(kullanici_adi: String) {
        anasayfaInteractor?.sepetYemeklerSayisiYukle(kullanici_adi: kullanici_adi)
    }
}

extension AnasayfaPresenter : InteractorToPresenterAnasayfaProtocol {
    func presenteraVeriGonder(sepetYemeklerSayisi: Int) {
        anasayfaView?.vieweVeriGonder(sepetYemeklerSayisi: sepetYemeklerSayisi)
    }
    
    func presenteraVeriGonder(yemeklerListesi: Array<Yemek>?) {
        anasayfaView?.vieweVeriGonder(yemeklerListesi: yemeklerListesi)
    }
}
