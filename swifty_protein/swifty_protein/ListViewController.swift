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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ligandList.delegate = self
        self.ligandList.dataSource = self
        self.loadList()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ligands.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ligandCell", for: indexPath) as! ListLigandCell
        cell.name = ligands[indexPath.row]
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
