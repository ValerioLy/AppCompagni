//
//  SeatsController.swift
//  LoginxCasa
//
//  Created by Valerio Ly on 18/10/18.
//  Copyright © 2018 Valerio Ly. All rights reserved.
//

import UIKit

class SeatsController: UIViewController {
    
    var person : Persona?
    var listaCompagni : [Compagno]?
    var selected : [Compagno] = []
    var selectedIndex : [Int] = []
    var offsetTable : Int!
    let heightRow = 60
    var height = 0
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var collection: UICollectionView!
    //weak var delegate : CompagnoDelegate?

    
    @IBOutlet weak var heightTable: NSLayoutConstraint!
    
    
    @IBOutlet weak var scambiaButton: UIButton!{
        didSet{
            scambiaButton.setTitle("kSeatsScambia".localized, for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listaCompagni = person?.getPosti()
        offsetTable = Int(table.contentOffset.y)
        //table.estimatedRowHeight = 60
        //self.table.tableFooterView = self.collection
        //table.rowHeight = UITableView.automaticDimension
        //collection.sizeToFit()
        //self.collection.allowsSelection  = true
        height = 0
        heightTable.constant = CGFloat(height)
        //table.setNeedsUpdateConstraints()
        table.layoutIfNeeded()
        //table.updateConstraintsIfNeeded()
    }
    
    @IBAction func scambiaAction(_ sender: UIButton) {
        if selected.count == 2{
            /*table.deleteRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
            table.deleteRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)*/
            
            /*let temp = listaCompagni![selectedIndex[0]]
            listaCompagni![selectedIndex[0]] = listaCompagni![selectedIndex[1]]
            listaCompagni![selectedIndex[1]] = temp*/
            
            person!.setPosti( inizio: selectedIndex[0], fine: selectedIndex[1])
            listaCompagni = person?.getPosti()
            
            
            collection.reloadData()
            
            selected = []
            selectedIndex = []
            table.reloadData()
            height = 0
            heightTable.constant = CGFloat(height)
            table.layoutIfNeeded()
            
            //collection.setContentOffset(CGPoint(x: Int(0), y: selected.count * 60 + Int(offsetTable)), animated: true)
            /*heightCollection.constant = heightCollection.constant + table.rowHeight*2
            collection.layoutIfNeeded()*/
        }
    }
}


extension SeatsController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  listaCompagni?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeatsCollectionViewCell.kidentifier, for: indexPath) as! SeatsCollectionViewCell
        
        let image = listaCompagni?[indexPath.row].getImage()
        if image != nil {
            cell.BtnPosto.setBackgroundImage(UIImage(data: image!), for: .normal)
        }
        else{
            cell.BtnPosto.setBackgroundImage(UIImage(named: "userprofile"), for: .normal)
        }
        cell.BtnPosto.setTitle(String(indexPath.row + 1), for: .normal)
        //cell.BtnPosto.isUserInteractionEnabled = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selected.count >= 2 {
            selected = []
            selectedIndex = []
            /*table.deleteRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
            table.deleteRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)*/
            table.reloadData()
            height = 0
            
            //collection.sizeToFit()
            //heightCollection.constant = heightCollection.constant + table.rowHeight*2
        }
        
        selectedIndex.append(indexPath.row)
        selected.append(listaCompagni![indexPath.row])
        //collection.deselectItem(at: indexPath, animated: true)
        //let path = IndexPath(row: selected.count - 1, section: 0)
        
        //table.insertRows(at: [IndexPath(item: selected.count - 1, section: 0)], with: .automatic)
        
        //collection.sizeToFit()
        /*heightCollection.constant = heightCollection.constant - table.rowHeight
        collection.layoutIfNeeded()*/
        //table.rowHeight = UITableView.automaticDimension
        //collection.setContentOffset(CGPoint(x: Int(0), y: selected.count * 60 + Int(offsetTable)), animated: true)
        //heightTable.constant = CGFloat(table.numberOfRows(inSection: 0) * Int(table.rowHeight))
        height += 60
        heightTable.constant = CGFloat(height)
        
        table.layoutIfNeeded()
        //table.updateConstraintsIfNeeded()
        table.insertRows(at: [IndexPath(item: selected.count - 1, section: 0)], with: .automatic)
    }
    
    /*func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 75, height: 75)
    }*/
    
    /*func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        collection.setNeedsLayout()
        collection.layoutIfNeeded()
        let size = collection.systemLayoutSizeFitting(layoutAttributes.size)
        var newFrame = layoutAttributes.frame
        // note: don't change the width
        newFrame.size.height = ceil(size.height)
        layoutAttributes.frame = newFrame
        return layoutAttributes
    }*/
}


extension SeatsController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(heightRow)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selected.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTableSeats", for: indexPath) as! SeatsTableViewCell
        cell.immagine.image = UIImage( data: selected[indexPath.row].getImage()!)
        cell.nome.text = selected[indexPath.row].getName()
        cell.cognome.text = selected[indexPath.row].getSurname()
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            NSLog("Deleted")
            
            
            selected.remove(at: indexPath.row)
            NSLog("Deleted selected")
            selectedIndex.remove(at: indexPath.row)
            NSLog("Deleted selectedIndex")
            
            //table.deleteRows(at: [indexPath], with: .none)
            table.reloadData()
            
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        height -= 60
        heightTable.constant = CGFloat(height)
        
        table.layoutIfNeeded()
    }
}
