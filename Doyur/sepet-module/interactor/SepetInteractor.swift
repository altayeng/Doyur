//
//  SepetInteractor.swift
//  Doyur
//
//  Created by Altay Kırlı on 9.01.2022.
//


import Foundation
import Alamofire

class SepetInteractor : PresenterToInteractorSepetProtocol {
    var sepetPresenter: InteractorToPresenterSepetProtocol?
    
    func tumSepetiYukle(kullanici_adi: String) {
        let params: Parameters = ["kullanici_adi": kullanici_adi]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php", method: .post, parameters: params).response { response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(SepetCevap.self, from: data)
                    var liste = [Sepet]()
                    if let gelenListe = cevap.sepet_yemekler {
                        liste = gelenListe
                    }
                    
                    self.sepetPresenter?.presenteraVeriGonder(yemeklerListesi: liste)
                } catch {
                    print(String(describing: error))
                    self.sepetPresenter?.presenteraVeriGonder(yemeklerListesi: [Sepet]())
                }
            } else {
                self.sepetPresenter?.presenteraVeriGonder(yemeklerListesi: nil)
            }
        }
    }
    
    func sepetYemekSil(sepet_yemek_id: String, kullanici_adi: String) {
        let params: Parameters = ["sepet_yemek_id": sepet_yemek_id, "kullanici_adi": kullanici_adi]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php", method: .post, parameters: params).response { response in
            if let data = response.data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        print(json)
                        if let success = json["success"] as? Int {
                            if success == 1 {
                                self.tumSepetiYukle(kullanici_adi: kullanici_adi)
                            }
                        }
                    }
                } catch {
                    print(String(describing: error))
                }
            }
        }
    }
    
    func sepetiSil(kullanici_adi:String) {
        
    }
}
