import UIKit

class SearchResultViewController: UIViewController,
 UICollectionViewDelegate, UICollectionViewDataSource{


    @IBOutlet weak var cruiseViewCollection: UICollectionView!
    

    
    let cruises = ["Bahamas Cruise",
                   "Caribbean Cruise",
                   "Cuba Cruise",
                   "Sampler Cruise",
                   "Star Cruise"]
    
    let cruiseIamges: [UIImage] = [
    
        UIImage(named: "cruise_home")!,
        UIImage(named: "cruise_home")!,
        UIImage(named: "cruise_home")!,
        UIImage(named: "cruise_home")!,
        UIImage(named: "cruise_home")!,
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cruiseViewCollection.register(CruiseCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")

        cruiseViewCollection.delegate = self
        cruiseViewCollection.dataSource = self
        
        
        let layout = cruiseViewCollection.collectionViewLayout as! UICollectionViewFlowLayout
                layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
                layout.minimumInteritemSpacing = 5
                layout.itemSize = CGSize(width: (cruiseViewCollection.frame.size.width - 20) / 2, height: (cruiseViewCollection.frame.size.height / 3))
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cruises.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CruiseCollectionViewCell
            
            // Set the cruise name and image for each cell
        print("Cruise name from array:\(cruises[indexPath.item])")
       
        if indexPath.item < cruises.count {
            print("Index out of bounds for cruises: indexPath.item = \(indexPath.item), cruises.count = \(cruises.count)")
            print(cruises.count)
            cell.cruiseLabel.text = cruises[indexPath.item]
        }

        if indexPath.item < cruiseIamges.count {
            cell.cruiseImage.image = cruiseIamges[indexPath.item]
        }

//        cell.cruiseLabel.text = cruises[indexPath.item]
//        cell.cruiseImage.image = cruiseIamges[indexPath.item]

        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
            
            return cell
        }
    
}

