//
//  GirisVC.swift
//  Doyur
//
//  Created by Altay Kırlı on 15.01.2022.
//

import UIKit

class GirisVC: UIViewController {

    
    @IBOutlet weak var userNameTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func girisButton(_ sender: Any) {
        UserDefaults.standard.set(userNameTF.text, forKey: "kullanici_adi")
        self.performSegue(withIdentifier: "toMenu", sender: nil)

        let alert = UIAlertController(title: "Doyur!", message: "Başarıyla Giriş Yapıldı", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: { (action: UIAlertAction!) in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true)
        
    }
    
    
}
