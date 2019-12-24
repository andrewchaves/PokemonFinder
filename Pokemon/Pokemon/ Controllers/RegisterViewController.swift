//
//  RegisterViewController.swift
//  Pokemon
//
//  Created by Andrew Chaves on 06/12/19.
//  Copyright © 2019 Andrew Chaves. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class RegisterViewController: UIViewController, UITextFieldDelegate,  UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var lbSalute: UILabel!
    @IBOutlet weak var lbQuestion: UILabel!
    @IBOutlet weak var tfAnswer: SkyFloatingLabelTextFieldWithIcon!
    
    var arrPokemonTypesVM = [PokemonTypeViewModel]()
    var checkedPokemonTypesVM:PokemonTypeViewModel!
    var shadowView:UIView!
    var tbPokemonTypes = UITableView()
    var nameResponded:String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        downloadPokemonTypes()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
   
    // Mark :- Controller setup
    
    func setupView() {
        tfAnswer.delegate = self
        if nameResponded != "" {
            lbSalute.text      = "Hello,\(nameResponded)!"
            lbQuestion.text    = "...now, tell us wich is your favorite Pokemon type:"
            tfAnswer.text      = ""
            tfAnswer.withImage(direction: .Right, image: UIImage.init(named: "arrow-down")!, colorSeparator: UIColor.clear, colorBorder: UIColor.clear)
            tfAnswer.delegate  = self
            tfAnswer.resignFirstResponder()
        }
    }
    
    func setupPokemonTypePicker() {
        
        shadowView = UIView()
        shadowView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
        shadowView.roundCorners(value: 2.0)
        self.view.addSubview(shadowView)
        shadowView.anchor(top: self.view.topAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0.0, height: 0, enableInsets: false)
        
        let pickerContainer = UIView()
        pickerContainer.backgroundColor = .white
        pickerContainer.roundCorners(value: 2.0)
        shadowView.addSubview(pickerContainer)
        pickerContainer.anchor(top: nil, left: self.view.leftAnchor, bottom: self.view.layoutMarginsGuide.bottomAnchor, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0.0, height: 320, enableInsets: false)
        
        let lbSelect = UILabel()
        lbSelect.text = "Select your favorite Pokemon type"
        lbSelect.textColor = .darkGray
        lbSelect.numberOfLines = 2
        lbSelect.font = UIFont.systemFont(ofSize: 20.0)
        pickerContainer.addSubview(lbSelect)
        lbSelect.anchor(top: pickerContainer.topAnchor, left: pickerContainer.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: self.view.frame.width/1.5, height: 0, enableInsets: false)
        
        let btClose  = UIButton.init(type: .custom)
        let closeImage = UIImage(named: "close")
        btClose.setImage(closeImage, for: .normal)
        btClose.addTarget(self, action: #selector(closePokemonTypePicker), for: .touchUpInside)
        pickerContainer.addSubview(btClose)
        btClose.anchor(top: pickerContainer.topAnchor, left: nil, bottom: nil, right: pickerContainer.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 32, height: 32, enableInsets: false)
        
        let btConfirm  = UIButton.init(type: .custom)
        btConfirm.backgroundColor = .systemPink
        btConfirm.setTitle("Confirm", for: .normal)
        btConfirm.setTitleColor(UIColor.white, for: .normal)
        btConfirm.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22.0)
        btConfirm.roundCorners()
        btConfirm.applyShadow()
        btConfirm.addTarget(self, action: #selector(closePokemonTypePicker), for: .touchUpInside)
        pickerContainer.addSubview(btConfirm)
        btConfirm.anchor(top: nil, left: pickerContainer.leftAnchor, bottom: pickerContainer.bottomAnchor, right: pickerContainer.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 10, paddingRight: 8, width: 0, height: 40, enableInsets: false)
        
        tbPokemonTypes.register(PokemonTypeTableViewCell.self, forCellReuseIdentifier: "cellid")
        tbPokemonTypes.backgroundColor = .lightGray
        tbPokemonTypes.delegate = self
        tbPokemonTypes.dataSource = self
        tbPokemonTypes.separatorStyle = .none
        tbPokemonTypes.bounces = false
        tbPokemonTypes.showsVerticalScrollIndicator = false
        pickerContainer.addSubview(tbPokemonTypes)
        tbPokemonTypes.anchor(top: lbSelect.bottomAnchor, left: pickerContainer.leftAnchor, bottom: btConfirm.topAnchor, right: pickerContainer.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 4, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        
        
        
    }
    
    @objc func closePokemonTypePicker() {
        shadowView.removeFromSuperview()
    }
    
    // MARK :- TextField delegate methods
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if nameResponded != "" {
            setupPokemonTypePicker()
            textField.resignFirstResponder()
        }
    }
    
    //MARK: - Tableview delegate methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath) as! PokemonTypeTableViewCell
        let pt:PokemonTypeViewModel = arrPokemonTypesVM[indexPath.row] as PokemonTypeViewModel
        
        cell.setUpCell(pokemonTypeVM: pt)
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPokemonTypesVM.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        for apt in arrPokemonTypesVM {
            apt.checked = false
        }
        checkedPokemonTypesVM = arrPokemonTypesVM[indexPath.row]
        tfAnswer.text = arrPokemonTypesVM[indexPath.row].name
        arrPokemonTypesVM[indexPath.row].checked = true
        tbPokemonTypes.reloadData()
    }

    
    // Mark :- Navigation Methods
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "homeSegue" {
           if nameResponded == "" {
               if tfAnswer.text != "" {
                    nameResponded = tfAnswer.text!
                    setupView()
                    return false
               }else {
                    showToast(message: "Fill the form, please.")
               }
               return false
           } else if tfAnswer.text != "" {
                return true
           }else {
                showToast(message: "Fill the form, please.")
                return false
           }
       }
       return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homeSegue" {
            if let destVC = segue.destination as? HomeViewController {
                destVC.arrPokemonTypesVM = self.arrPokemonTypesVM
                destVC.checkedPokemonTypesVM = self.checkedPokemonTypesVM
            }
        }
    }
    
    //Mark :- Text Field delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true;
    }
    
    // MARK :- API calls
    
    func downloadPokemonTypes() {
        let pokemonTypeRequest = PokemonTypeRequest()
        DispatchQueue.main.async {
            pokemonTypeRequest.fetchPokemonTypes(completion: { pokemonTypes in
              if let pokemonTypes = pokemonTypes {
                for pt in pokemonTypes {
                    let ptvm = PokemonTypeViewModel(pokemonType: pt, checked: false)
                    self.arrPokemonTypesVM.append(ptvm)
                }
                self.tbPokemonTypes.reloadData()
              }
            })
        }
    }

}
