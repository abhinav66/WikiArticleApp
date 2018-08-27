//
//  ViewController.swift
//  WikiArticleApp
//
//  Created by Abhinav Singh on 8/27/18.
//  Copyright © 2018 Abhinav. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var wikiTableView: UITableView!
    
    let viewModel = WikiViewModel()
    var page = [Pages]()
    @IBOutlet weak var wikiActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Wiki Article"
        self.wikiActivityIndicator.stopAnimating()
        getData()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData(){
        self.page.append(contentsOf:self.viewModel.getPagesFromDatabase())
        self.wikiTableView.reloadData()
    }
    
    func showAlert(message:String,title:String) {
        let objAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let objAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:
        {Void in
            
            
        })
        
        
        objAlertController.addAction(objAction)
        present(objAlertController, animated: true, completion: nil)
    }
    
    func getImage(_ imageView:UIImageView,IndexPath:Foundation.IndexPath,url:String)
    {
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
            if let url=URL(string: url),let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async(execute: { () -> Void in
                    imageView.image = UIImage(data: data)
                })
            }
        })
    }


}
extension ViewController:UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return page.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var pageCell:WikiTableViewCell? = wikiTableView.dequeueReusableCell(withIdentifier: "wikiTableCell", for: indexPath) as? WikiTableViewCell
        
        if pageCell == nil {
            pageCell = wikiTableView.dequeueReusableCell(withIdentifier: "wikiTableCell", for: indexPath) as? WikiTableViewCell
        }
        
        configureCell(pageCell!, IndexPath: indexPath)
        return pageCell!
    }
    
    func configureCell(_ cell:WikiTableViewCell,IndexPath:Foundation.IndexPath)
    {
        if let title = self.page[IndexPath.row].title{
            cell.title.text = title
        }else{
            cell.title.text = ""
        }
        
        if let desc = self.page[IndexPath.row].desc{
            cell.desc.text = desc
        }else {
            cell.desc.text = ""
        }
        
        if let thumb = self.page[IndexPath.row].thumbnail{
            self.getImage(cell.thumbnailImg, IndexPath: IndexPath, url: thumb)
        }else {
            cell.thumbnailImg.image = UIImage(named:"")
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = self.page[indexPath.row].canonicalurl,let uri = URL(string:url){
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let wikiController = storyBoard.instantiateViewController(withIdentifier: "wikiWebViewController") as! WikiWebviewViewController
            wikiController.url = uri
            self.navigationController?.pushViewController(wikiController, animated: false)
        }else {
            self.showAlert(message: "No page present for this selection", title: "Article Missing")
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text != nil && searchBar.text?.trimmingCharacters(in: .whitespaces) != "" {
            self.wikiActivityIndicator.startAnimating()
            viewModel.getWikiData(query: searchBar.text!){[weak self](success:Bool,data:[Pages]?) in
                if success{
                    if let pg = data {
                        DispatchQueue.main.async {
                            self?.page = []
                            self?.page.append(contentsOf:pg)
                            self?.wikiTableView.reloadData()
                            self?.wikiActivityIndicator.stopAnimating()
                        }
                    }else{
                        DispatchQueue.main.async {
                            self?.showAlert(message: "No result matched your search. Showing previous query results.", title: "No Result Found")
                            self?.wikiActivityIndicator.stopAnimating()
                        }
                    }
                }else{
                    DispatchQueue.main.async {
                        self?.page = []
                        self?.page.append(contentsOf:(self?.viewModel.getPagesFromDatabase())!)
                        self?.wikiTableView.reloadData()
                        self?.showAlert(message: "Could not retrieve search results. Showing previous query results.", title: "No Result Found")
                        self?.wikiActivityIndicator.stopAnimating()
                    }
                }
                
            }
        }
    }
    
    func loadData(pages:[Pages]){
        DispatchQueue.main.async {
        }
    }
    
    
}

