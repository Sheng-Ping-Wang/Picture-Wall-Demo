//
//  SecondViewController.swift
//  PictureWallPractice
//
//  Created by Wang Sheng Ping on 2021/3/17.
//

import UIKit

class SecondViewController: UIViewController {
    
    
    //MARK: - Properties
    
    let secondView = SecondView()
    var pictureInfo = [ImageInfo]() {
        didSet{
            DispatchQueue.main.async {
                self.secondView.myCollectionView.reloadData()
                print(self.pictureInfo[0].urls)
            }
        }
    }
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = secondView
        secondView.myCollectionView.dataSource = self
        secondView.myCollectionView.delegate = self
        fetchImages()
        setNavBtn()
    }
    
    //MARK: - Functions
    
    func setNavBtn() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: secondView.addBtn)
        secondView.addBtn.addTarget(self, action: #selector(addImages), for: .touchUpInside)
    }
    
    @objc func addImages() {
        DispatchQueue.main.async {
            self.fetchImages()
        }
        
    }
    
    func fetchImages() {
        let address = "https://api.unsplash.com/photos/?client_id=\(APIKeys.APIKey)&order_by=ORDER&per_page=30"
        if let url = URL(string: address) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                }else if let response = response as? HTTPURLResponse, let data = data {
                    print("Status Code: \(response.statusCode)")
                    do{
                        let decoder = JSONDecoder()
                        let picInfo = try decoder.decode([ImageInfo].self, from: data)
                        self.pictureInfo.append(contentsOf: picInfo)
                    }catch{
                        print(error)
                    }
                }
            }.resume()
        }
        
    }

}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension SecondViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pictureInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.collectionViewId, for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        
        DispatchQueue.main.async {
            cell.myImageView.loadImages(from: self.pictureInfo[indexPath.row].urls.regularUrl)
        }
        
        return cell
    }
    
    
}


