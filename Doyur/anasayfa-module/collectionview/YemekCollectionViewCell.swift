//
//  YemekCollectionViewCell.swift
//  Doyur
//
//  Created by Altay Kırlı on 9.01.2022.
//

import UIKit
import Kingfisher

class YemekCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var contentContainer: UIView!
    @IBOutlet weak var yemekIV: UIImageView!
    @IBOutlet weak var yemekAdiLabel: UILabel!
    @IBOutlet weak var yemekFiyatLabel: UILabel!
    
    func resimGoster(resimAdi: String) {
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(resimAdi)") {
            DispatchQueue.main.async {
                self.yemekIV.kf.setImage(with: url)
            }
        }
    }
}
