//
//  ListViewController.swift
//  swifty_protein
//
//  Created by Jonas BELLESSA on 11/9/17.
//  Copyright © 2017 Jonas BELLESSA. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var ligandList: UITableView!

    var ligands : [String] = []{
        didSet{
            self.ligandList.reloadData()
        }
    }
    
    var selectedLigand : Int?
    
    var filteredLigands = [String]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredLigands = self.ligands.filter({( ligand : String) -> Bool in
            return ligand.contains(searchText)
        })

        self.ligandList.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goGame"{
            if let dest = segue.destination as? GameViewController{
                if isFiltering(){
                    dest.ligandName = filteredLigands[self.selectedLigand ?? 0]
                }else{
                    dest.ligandName = ligands[self.selectedLigand ?? 0]
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedLigand = indexPath.row
        performSegue(withIdentifier: "goGame", sender: "")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ligandList.delegate = self
        self.ligandList.dataSource = self
        self.loadList()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Ligand"
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        } else {
            // Fallback on earlier versions
            navigationItem.titleView = searchController.searchBar
        }
        definesPresentationContext = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredLigands.count
        }
        return ligands.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ligandCell", for: indexPath) as! ListLigandCell
//        cell.name = ligands[indexPath.row]
        if isFiltering() {
          cell.name = filteredLigands[indexPath.row]
        } else {
            cell.name = ligands[indexPath.row]
        }        
        return cell
    }
    
    
    func loadList(){
        let path = Bundle.main.path(forResource: "ligands", ofType: "txt")
        do{
            let text = try String(contentsOfFile: path!)
            self.ligands = text.components(separatedBy: "\n")
        }catch{
            print (error)
        }        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension ListViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
