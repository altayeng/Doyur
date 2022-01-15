//
//  TableViewHucre.swift
//  Doyur
//
//  Created by Altay Kırlı on 9.01.2022.
//

import UIKit

class TableViewHucre: UITableViewCell {
    
    @IBOutlet weak var contentContainer: UIView!
    @IBOutlet weak var yemekIV: UIImageView!
    @IBOutlet weak var yemekAdiLabel: UILabel!
    @IBOutlet weak var yemekTutarLAbel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func resimGoster(resimAdi: String) {
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(resimAdi)") {
            DispatchQueue.main.async {
                self.yemekIV.kf.setImage(with: url)
            }
        }
    }

}
