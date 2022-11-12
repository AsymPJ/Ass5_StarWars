//
//  SWViewController.swift
//  Ass5_StarWars
//
//  Created by user228139 on 11/12/22.
//

import UIKit

class SWViewController: UIViewController {

    @IBOutlet weak var nameDetail: UILabel!
    
    @IBOutlet weak var hairDetail: UILabel!
    
    @IBOutlet weak var eyeDetail: UILabel!
    
    @IBOutlet weak var homeworldDetail: UILabel!
    
    @IBOutlet weak var listMovies: UITextView!
    
    var nameRef = ""
    var hairRef = ""
    var eyeRef = ""
    var homeworldRef = ""
    var listRef = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameDetail.text = nameRef
        hairDetail.text = hairRef
        eyeDetail.text = eyeRef
        homeworldDetail.text = homeworldRef
        showFilms()
        
    }
    
    func showFilms (){
        for i in listRef{
            listMovies.text += i
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
