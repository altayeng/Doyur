//
//  KullaniciVC.swift
//  Doyur
//
//  Created by Altay Kırlı on 9.01.2022.
//

import UIKit

class KullaniciVC: UIViewController {
    
    @IBOutlet weak var kullaniciAdiLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kullaniciAdiLabel.text = "Mevcut Doyucu: \(appDelegate.getKullaniciAdi())"
    }

 
}
