import UIKit

class PurchasesViewController: UIViewController {
    @IBOutlet weak var purchasesCollectionView: UICollectionView!
    @IBOutlet weak var messageLabel: UILabel!
    
    var purchases: [Purchase] = []
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getPurchases(idUser: "")
        if purchases.count > 0 {
            purchasesCollectionView.isHidden = false
            messageLabel.isHidden = true
        }else {
            purchasesCollectionView.isHidden = true
            messageLabel.isHidden = false
        }
    }
    
    private func getPurchases(idUser: String) {
        BeerEndPoint.getPurcharsesFromUser(withIdUser: "5c059fafb2b0ac21e4948722") { (items, error)  in
            if let error = error {
                self.present(Utils.showAlert(withTitle: "Error", message: error),animated: true)
                return
            }
            
            if let items = items {
                self.purchases = items
                self.purchasesCollectionView.reloadData()
                self.purchasesCollectionView.isHidden = false
                self.messageLabel.isHidden = true
                
            }
        }
    }
    
}

extension PurchasesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return purchases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PurchaseCollectionViewCell
        cell.purchaseDateLabel.text = purchases[indexPath.row].idPurchase
        return cell
    }
}

extension PurchasesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        purchases[indexPath.row].products.forEach({print($0.product.name)})
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "pucharseDetailVC") as! PurchaseDetailViewController
        detailVC.details = purchases[indexPath.row].details
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
