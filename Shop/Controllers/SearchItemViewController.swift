//  Created by Duje Medak on 13/05/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import UIKit

class SearchItemViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var button_search: UIButton!
    @IBOutlet weak var searchText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchText.delegate = self as UITextFieldDelegate
        button_search.layer.cornerRadius = 5
        button_search.clipsToBounds = true
        setInitialStatesOfViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        searchText.text = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateEntry()
    }
    
    func animateEntry(){
        let duration = 0.4
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
            self.searchText.alpha = 1
            self.searchText.layer.borderColor = UIColor.black.withAlphaComponent(1).cgColor
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
            self.button_search.alpha = 1
            self.button_search.layer.borderColor = UIColor.black.withAlphaComponent(1).cgColor
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func setInitialStatesOfViews(){
        searchText.alpha = 0.1
        searchText.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
        button_search.alpha = 0.1
        button_search.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func onSearchButtonTapped(_: Any) {
        loadNewView()
    }
    
    func loadNewView(){
        if let search = searchText.text{
            let vm = ItemListViewModel(service: CombinedMovieAPI(), title: search)
            let vc = ItemListViewController(viewModel: vm)
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()  //if desired
        loadNewView()
        return true
    }
}

