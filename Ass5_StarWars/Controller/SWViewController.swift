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
    var filmTitle = String()
    
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
            guard let url = URL(string: i) else {
                return
            }
            var filmsRequest = URLRequest(url: url)
            filmsRequest.httpMethod = "GET"
            
            let taskFilm = URLSession.shared.dataTask(with: filmsRequest){data, response, error in
                if let data = data{
                    let decodeFilms = JSONDecoder()
                    
                    let filmJson = try? decodeFilms.decode(FilmsModel.self, from: data)
                    self.filmTitle = filmJson!.title!
                    self.listMovies.text += self.filmTitle + "\n"
                        
                }
            }
            taskFilm.resume()
            
            
            
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
