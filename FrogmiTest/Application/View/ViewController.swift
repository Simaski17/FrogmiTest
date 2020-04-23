//
//  ViewController.swift
//  FrogmiTest
//
//  Created by Jimmy Hernandez on 23-04-20.
//  Copyright © 2020 Jimmy Hernandez. All rights reserved.
//

import UIKit
import JGProgressHUD

class ViewController: UIViewController {

    @IBOutlet weak var tableViewMain: UITableView!
    
    private var viewModel = MainViewModel()
    let hud = JGProgressHUD(style: .dark)
    private var nextItem = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.delegate = self
        tableViewMain.isHidden = true
        viewModel.getListStore(per_page: 10)
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrStore.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FrogmiTableViewCell
        if (viewModel.arrStore.count > 0) {
            cell.setup(event: viewModel.arrStore, index: indexPath)
        }
        return cell
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == tableViewMain{
            
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
            {
                if nextItem {
                    viewModel.getListStore(per_page: 10)
                    nextItem = false
                    hud.textLabel.text = "Cargando..."
                    hud.show(in: self.view)
                    hud.position = .bottomCenter
                }
            }
        }
    }
    
}

extension ViewController: MainViewModelDelegate {
    func reloadData() {
        self.tableViewMain.isHidden = false
        self.tableViewMain.reloadData()
        self.hud.dismiss()
        nextItem = true
    }
    
    func endData() {
        self.hud.dismiss()
        nextItem = true
    }
    
}
