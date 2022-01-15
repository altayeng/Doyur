//
//  SepetVC.swift
//  Doyur
//
//  Created by Altay Kırlı on 9.01.2022.
//

import UIKit

class SepetVC: UIViewController {
    var presenterNesnesi: ViewToPresenterSepetProtocol?
    var sepetYemekler = [Sepet]()
    @IBOutlet weak var sepetYemeklerTV: UITableView!
    @IBOutlet weak var toplamTutarLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SepetRouter.createModule(ref: self)
        
        sepetYemeklerTV.delegate = self
        sepetYemeklerTV.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenterNesnesi?.sepetiYukle(kullanici_adi: appDelegate.getKullaniciAdi())
    }
    
    @IBAction func siparisButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "Doyur!", message: "Siparişiniz Alındı!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Menüye Dön", style: .default, handler: { (action: UIAlertAction!) in
            self.tabBarController?.selectedIndex = 0
        }))
        self.present(alert, animated: true)
    }
    
    
}

extension SepetVC : PresenterToViewSepetProtocol {
    func vieweVeriGonder(yemeklerListesi: Array<Sepet>?) {
        if let sepetYemekler = yemeklerListesi {
            self.sepetYemekler = sepetYemekler
            DispatchQueue.main.async {
                self.sepetYemeklerTV.reloadData()
                var toplamTutar = 0
                appDelegate.sepetTab?.badgeValue = sepetYemekler.count == 0 ? nil : "\(sepetYemekler.count)"
                for yemek in sepetYemekler {
                    toplamTutar += Int(yemek.yemek_siparis_adet!)! * Int(yemek.yemek_fiyat!)!
                }
                self.toplamTutarLabel.text = "₺\(toplamTutar)"
            }
            if self.sepetYemekler.count == 0 {
                let alert = UIAlertController(title: "Uyarı", message: "Doyuracak bir şey yok.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yemekleri Listele", style: .default, handler: { (action: UIAlertAction!) in
                    self.tabBarController?.selectedIndex = 0
                }))
                self.present(alert, animated: true)
            }
        } else {
            let alert = UIAlertController(title: "Hata", message: "Yemek listesi yüklenirken sorun oluştu!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: { (action: UIAlertAction!) in
                self.navigationController?.popViewController(animated: true)
            }))
            self.present(alert, animated: true)
        }
        
    }
    }


extension SepetVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sepetYemekler.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sepetYemek = sepetYemekler[indexPath.row]
        let hucre = tableView.dequeueReusableCell(withIdentifier: "sepetYemekHucre", for: indexPath) as! TableViewHucre
        
        hucre.selectionStyle = .none
        hucre.yemekAdiLabel.text = sepetYemek.yemek_adi!
        hucre.yemekTutarLAbel.text = "\(sepetYemek.yemek_siparis_adet!) adet ₺\(Int(sepetYemek.yemek_siparis_adet!)! * (Int(sepetYemek.yemek_fiyat!)!))"
        hucre.resimGoster(resimAdi: sepetYemek.yemek_resim_adi!)
        
        return hucre
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let silAction = UIContextualAction(style: .destructive, title: "Sil"){ (contextualAction,view,bool) in
            
            let sepetYemek = self.sepetYemekler[indexPath.row]
            self.presenterNesnesi?.sepetYemekSil(sepet_yemek_id: sepetYemek.sepet_yemek_id!, kullanici_adi: appDelegate.getKullaniciAdi())
        }
        
        return UISwipeActionsConfiguration(actions: [silAction])
    }
    
    
}
