//
//  AnasayfaInteractor.swift
//  Doyur
//
//  Created by Altay Kırlı on 9.01.2022.
//

import Foundation
import Alamofire

class AnasayfaInteractor : PresenterToInteractorAnasayfaProtocol{
    
    var anasayfaPresenter: InteractorToPresenterAnasayfaProtocol?
    
    func tumYemekleriYukle() {
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php", method: .get).response { response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(YemekCevap.self, from: data)
                    var liste = [Yemek]()
                    if let gelenListe = cevap.yemekler {
                        liste = gelenListe
                    }
                    
                    self.anasayfaPresenter?.presenteraVeriGonder(yemeklerListesi: liste)
                } catch {
                    print(String(describing: error))
                    self.anasayfaPresenter?.presenteraVeriGonder(yemeklerListesi: nil)
                }
            } else {
                self.anasayfaPresenter?.presenteraVeriGonder(yemeklerListesi: nil)
            }
        }
    }
    
    func sepetYemeklerSayisiYukle(kullanici_adi: String) {
        let params: Parameters = ["kullanici_adi": kullanici_adi]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php", method: .post, parameters: params).response { response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(SepetCevap.self, from: data)
                    self.anasayfaPresenter?.presenteraVeriGonder(sepetYemeklerSayisi: cevap.sepet_yemekler?.count ?? 0)
                } catch {
                    print(String(describing: error))
                    self.anasayfaPresenter?.presenteraVeriGonder(sepetYemeklerSayisi: 0)
                }
            } else {
                self.anasayfaPresenter?.presenteraVeriGonder(sepetYemeklerSayisi: 0)
            }
        }
    }
    
}
