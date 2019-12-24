//
//  HomeViewController.swift
//  Pokemon
//
//  Created by Andrew Chaves on 06/12/19.
//  Copyright © 2019 Andrew Chaves. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var tbPokemeons: UITableView!
    var arrPokemonTypesVM = [PokemonTypeViewModel]()
    var checkedPokemonTypesVM:PokemonTypeViewModel!
    var arrPokemonsVM = [PokemonViewModel]()
    var arrVisiblePokemonsVM = [PokemonViewModel]()
    var bannerContainer:UIView!
    var actInd: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        downloadPokemonTypes()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK :- Setup view Methods
    func setupArrPokemonTypes() {
        let checkedIndex = arrPokemonTypesVM.firstIndex(of: checkedPokemonTypesVM)
        arrPokemonTypesVM.remove(at: checkedIndex!)
        arrPokemonTypesVM.insert(checkedPokemonTypesVM, at: 0)
    }
    
    func setupCarrosel() {
        
        if bannerContainer != nil {
            bannerContainer.removeFromSuperview()
        }
        
        bannerContainer = UIView()
        view.addSubview(bannerContainer)
        bannerContainer.anchor(top: view.layoutMarginsGuide.topAnchor, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, paddingTop: 56, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 80, enableInsets: false)
       
        let bannerScroll = UIScrollView()
        bannerScroll.isScrollEnabled = true
        bannerScroll.showsHorizontalScrollIndicator = false
        bannerScroll.showsVerticalScrollIndicator = false
        bannerContainer.addSubview(bannerScroll)
        bannerScroll.anchor(top: bannerContainer.topAnchor, left: bannerContainer.leftAnchor, bottom: bannerContainer.bottomAnchor, right: bannerContainer.rightAnchor, paddingTop:0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        var padLeft:CGFloat = 10
        
        var idx:Int = 0
        for ptvm in arrPokemonTypesVM {
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(pokemonTypeTappedMethod(_:)))

            let thumbImageView = UIImageView()
            thumbImageView.downloaded(from: ptvm.thumbnailImage!)
            thumbImageView.frame = CGRect(x:padLeft, y: 0, width: 60, height: 60)
            thumbImageView.isUserInteractionEnabled = true
            thumbImageView.tag = idx
            thumbImageView.addGestureRecognizer(tapGestureRecognizer)
            bannerScroll.addSubview(thumbImageView)
            idx = idx + 1
            
            let thumbName = UILabel()
            thumbName.text = ptvm.name
            if ptvm == checkedPokemonTypesVM {
                thumbName.textColor = UIColor.init(cgColor: CGColor(srgbRed: 0.0, green: 1.0, blue: 153.0/255.0, alpha: 1.0))
            }else{
                thumbName.textColor = .black
            }
            thumbName.textAlignment = .center
            thumbName.font = UIFont.boldSystemFont(ofSize: 12.0)
            thumbName.frame = CGRect(x:padLeft, y: thumbImageView.frame.height, width: 60, height: 20)
            bannerScroll.addSubview(thumbName)
                  

            padLeft = padLeft + 70
            
        }
        bannerScroll.contentSize.width = CGFloat(arrPokemonTypesVM.count * 70)
        setupVisiblePokemons()
    }
    
    @objc func pokemonTypeTappedMethod(_ sender:AnyObject){
        checkedPokemonTypesVM = arrPokemonTypesVM[sender.view.tag]
        setupCarrosel()
    }
    
    func setupTableView() {
        tbPokemeons.register(PokemonTableViewCell.self, forCellReuseIdentifier: "cellid")
        tbPokemeons.delegate = self
        tbPokemeons.dataSource = self
    }
    
    func setupVisiblePokemons() {
        arrVisiblePokemonsVM = [PokemonViewModel]()
        for pvm in arrPokemonsVM {
            if pvm.type.contains(checkedPokemonTypesVM.name!) {
                arrVisiblePokemonsVM.append(pvm)
            }
        }
        self.tbPokemeons.reloadData()
    }
    
    @IBAction func orderPokemonsByName(_ sender: Any) {
        if (sender as! UIButton).tag == 10 {
            arrVisiblePokemonsVM = arrVisiblePokemonsVM.sorted(by: {$0.name! <  $1.name! })
            tbPokemeons.reloadData()
            (sender as! UIButton).tag = 20
        } else {
            setupVisiblePokemons()
            (sender as! UIButton).tag = 10
        }
    }
    
    func filterPokemonsByName(name:String) {
        setupVisiblePokemons()
        arrVisiblePokemonsVM = arrVisiblePokemonsVM.filter({$0.name!.contains(name)})
        tbPokemeons.reloadData()
    }
    
    func showActivityIndicatory(uiView: UIView) {
        actInd.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0);
        actInd.center = uiView.center
        actInd.hidesWhenStopped = true
        actInd.style = UIActivityIndicatorView.Style.large
        uiView.addSubview(actInd)
        actInd.startAnimating()
    }
    
    func stopActivityIndicatory() {
        actInd.stopAnimating()
        actInd.removeFromSuperview()
    }
    
    
    //MARK: - Tableview delegate methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath) as! PokemonTableViewCell
        let pt:PokemonViewModel = arrVisiblePokemonsVM[indexPath.row] as PokemonViewModel
        cell.setUpCell(pokemonVM: pt)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrVisiblePokemonsVM.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK :- Search bar delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text! != "" {
            filterPokemonsByName(name: searchBar.text!)
        }else{
            setupVisiblePokemons()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
    // MARK :- API calls
    func downloadPokemonTypes() {
        showActivityIndicatory(uiView: self.view)
        let pokemonRequest = PokemonRequest()
        DispatchQueue.main.async {
            pokemonRequest.fetchPokemons(completion: { pokemons in
              if let pokemons = pokemons {
                for p in pokemons {
                    let pvm = PokemonViewModel(pokemon: p)
                    self.arrPokemonsVM.append(pvm)
                }
                self.stopActivityIndicatory()
                self.setupTableView()
                self.setupArrPokemonTypes()
                self.setupCarrosel()
              }
            })
        }
    }
    
}
