//
//  AnasayfaVC.swift
//  Doyur
//
//  Created by Altay Kırlı on 9.01.2022.
//

import UIKit

class AnasayfaVC: UIViewController {
    
    var anasayfaPresenterNesnesi:ViewToPresenterAnasayfaProtocol?
    @IBOutlet weak var yemeklerCV: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var yemekler = [Yemek]()
    var filteredYemekler = [Yemek]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tabsItem = self.tabBarController?.tabBar.items {
            appDelegate.sepetTab = tabsItem[1]
        }
        
        AnasayfaRouter.createModule(ref: self)
        
        anasayfaPresenterNesnesi?.sepetYemeklerSayisiYukle(kullanici_adi: appDelegate.getKullaniciAdi())
        
        searchBar.delegate = self
        yemeklerCV.delegate = self
        yemeklerCV.dataSource = self
        
        let genislik = yemeklerCV.frame.size.width
        let tasarim = UICollectionViewFlowLayout()
        tasarim.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        tasarim.minimumInteritemSpacing = 10
        tasarim.minimumLineSpacing = 10
        
        let itemGenislik = (genislik - 30) / 2
        tasarim.itemSize = CGSize(width: itemGenislik, height: itemGenislik * 1.15)
        yemeklerCV.collectionViewLayout = tasarim
        
    }
   
    override func viewWillAppear(_ animated: Bool) {
        anasayfaPresenterNesnesi?.yemekleriYukle()
    }
    
    

}

extension AnasayfaVC : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredYemekler = self.yemekler.filter { yemek in
            if yemek.yemek_adi!.lowercased().contains(searchText.lowercased()) {
                return true
            }
            if searchText.isEmpty {
                return true
            }
            return false
        }
        self.yemeklerCV.reloadData()
    }
}

extension AnasayfaVC : PresenterToViewAnasayfaProtocol {
    func vieweVeriGonder(sepetYemeklerSayisi: Int) {
        appDelegate.sepetTab?.badgeValue = sepetYemeklerSayisi == 0 ? nil : "\(sepetYemeklerSayisi)"
    }
    
    func vieweVeriGonder(yemeklerListesi: Array<Yemek>?) {
        if let yemekler = yemeklerListesi {
            self.yemekler = yemekler
            self.filteredYemekler = yemekler
            DispatchQueue.main.async {
                self.yemeklerCV.reloadData()
            }
        } else {
            let alert = UIAlertController(title: "Hata", message: "Yemek listesi yüklenirken hata oluştu!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: { (action: UIAlertAction!) in
                self.navigationController?.popViewController(animated: true)
            }))
            self.present(alert, animated: true)
        }
    }
}

extension AnasayfaVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredYemekler.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let yemek = filteredYemekler[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "yemekHucre", for: indexPath) as! YemekCollectionViewCell
        
        cell.resimGoster(resimAdi: yemek.yemek_resim_adi!)
        cell.yemekAdiLabel.text = yemek.yemek_adi!
        cell.yemekFiyatLabel.text = "₺\(yemek.yemek_fiyat!)"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let yemek = filteredYemekler[indexPath.row]
        performSegue(withIdentifier: "toDetay", sender: yemek)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay" {
            let yemek = sender as? Yemek
            let targetVC = segue.destination as! DetayVC
            targetVC.yemek = yemek
        }
    }
}
