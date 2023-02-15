//
//  CharactersCVC.swift
//  RICK_AND_MORTY
//
//  Created by Jesús Fernández on 16/12/22.
//

import UIKit

private let reuseIdentifier = "charCell"

class CharactersCVC: UICollectionViewController {
    private let sectionInsets = UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)
    private let itemsPerRow: CGFloat = 2.0
    var items : [RickCharacter] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getAllCharactersFromApiWithURLSession()
        
    }
    
    func getAllCharactersFromApiWithURLSession() {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character?page=1")
        else { return }
        
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            if let error = error {
                print("\(error.localizedDescription)")
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("HttpCode response invalid")
                return
            }
            guard let data = data else {
                print("Error Fetching data")
                return
            }
            do {
                let response = try JSONDecoder().decode(CharactersResponse.self, from: data)
                DispatchQueue.main.async {
                    self.items = response.results ?? []
                    self.collectionView.reloadData()
                }
            }catch{
                print("Error decoding")
            }
        }.resume()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : CharacterCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CharacterCollectionViewCell
    
        cell.title.text = items[indexPath.row].name
        
        cell.title1.text = items[indexPath.row].species
        
        if let img = items[indexPath.row].image {
            cell.image.loadImageWithUrlSession(from: img)
        }else {
            cell.image.image = UIImage(named: "Rick")
        }
        
        
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

       // Uncomment this method to specify if the specified item should be selected  CHECK
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    

    

    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print(items[indexPath.row])
    }
    
}

extension CharactersCVC : UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
       
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWith = view.frame.width - paddingSpace
        let widthPerItem = availableWith / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
}

extension UIImageView {
    func loadImageWithUrlSession(from url : String) {
        guard let url = URL(string: url) else {return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
                  let data = data,
                    error == nil,
                  let image = UIImage(data: data) else {return}
            DispatchQueue.main.async {
                self.image = image
            }
            
        }.resume()
    }
}

