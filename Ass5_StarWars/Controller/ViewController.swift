//
//  ViewController.swift
//  Ass5_StarWars
//
//  Created by user228139 on 11/11/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var swTable: UITableView!

    var myStarWarArray = [Results]()
    var myHomeWorld = [String]()
    var builHomeWorldArray = String()
    var myIndex = Int()
    var myPagination = String()
    var isPagination = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swTable.delegate = self
        swTable.dataSource = self
        fillDataToTable()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "sWSegue" {
            let viewDetail = segue.destination as! SWViewController
            let cell = sender as! StarWTableViewCell
            let indexPath = swTable.indexPath(for: cell)
            viewDetail.nameRef = myStarWarArray[indexPath!.row].name!
            viewDetail.eyeRef = myStarWarArray[indexPath!.row].eye_color!
            viewDetail.hairRef = myStarWarArray[indexPath!.row].hair_color!
            viewDetail.homeworldRef = myHomeWorld[indexPath!.row]
            viewDetail.listRef = myStarWarArray[indexPath!.row].films!
            
        }
    }
    
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myStarWarArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = swTable.dequeueReusableCell(withIdentifier: "swCell", for:indexPath) as! StarWTableViewCell
        cell.nameCharacter.text = myStarWarArray[indexPath.row].name
        cell.hairColorChar.text = myStarWarArray[indexPath.row].hair_color
        cell.eyeColorChar.text = myStarWarArray[indexPath.row].eye_color
        cell.homeChar.text = myHomeWorld[indexPath.row]
        
        //Initiate Pagination
        if indexPath.item == myStarWarArray.count - 1 && !isPagination{
            
            if let url = URL(string: myPagination){
                self.isPagination = true
                var getRequest = URLRequest(url: url)
                getRequest.httpMethod = "GET"
                
                let perfom = URLSession.shared.dataTask(with: getRequest){data, response, error in
                    
                    if let thisData = data{
                        let decoder = JSONDecoder()
                        do{
                            let jsonDecode = try? decoder.decode(StarWarModel.self, from: thisData)
                            self.myStarWarArray.append(contentsOf: jsonDecode!.results!)
                            guard let newPagination = jsonDecode?.next else{
                                return
                            }
                            self.myPagination = newPagination
                            DispatchQueue.main.async {
                                self.swTable.reloadData()
                            }
                            
                        }catch{
                            let alert = UIAlertController(title:"NOT FOUND", message: "Enter a valid URl", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
                            self.present(alert, animated: true)
                        }
                        for i in self.myStarWarArray{
                            self.getHomeworld(i.homeworld!)
                            self.myHomeWorld.append(self.builHomeWorldArray)
                            
                        }
                    }
                    
                }
                perfom.resume()
            }
            self.isPagination = false
            
        }
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func getHomeworld (_ hWString: String) {
        guard let url  = URL(string: hWString) else{
            return
        }
        var getRequest1 = URLRequest(url: url)
        getRequest1.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: getRequest1){data1, response1, error1 in
            if let newData = data1{
                let decoder = JSONDecoder()
                do{
                    let newDecode = try? decoder.decode(HomeWorldModel.self, from: newData)
                    self.builHomeWorldArray = newDecode!.name
                    self.myHomeWorld.insert(self.builHomeWorldArray, at: self.myIndex)
                    self.myIndex += 1
                    
                }catch{
                    let alert = UIAlertController(title:"NOT FOUND", message: "Enter a valid URl", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
                    self.present(alert, animated: true)
                }
            }
        }
        task.resume()
    }
    
    func fillDataToTable (){
        guard let url = URL(string: "https://swapi.dev/api/people/") else{
            return
        }
        //let session = URLSession(configuration: .default)
        var getRequest = URLRequest(url: url)
        getRequest.httpMethod = "GET"
        
        let perfom = URLSession.shared.dataTask(with: getRequest){data, response, error in
           
            if let thisData = data{
                let decoder = JSONDecoder()
                do{
                    let jsonDecode = try? decoder.decode(StarWarModel.self, from: thisData)
                    self.myStarWarArray = (jsonDecode!.results!)
                    self.myPagination = jsonDecode!.next!
                    
                    DispatchQueue.main.async {
                        self.swTable.reloadData()
                    }
                    
                }catch{
                    let alert = UIAlertController(title:"NOT FOUND", message: "Enter a valid URl", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
                    self.present(alert, animated: true)
                }
                for i in self.myStarWarArray{
                    self.getHomeworld(i.homeworld!)
                    self.myHomeWorld.append(self.builHomeWorldArray)
                    
                }
            }
            
        }
        perfom.resume()
    }
    
}

