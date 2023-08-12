import UIKit

class HourCollectionView: UICollectionView {
    
    private var collectionViewDataSource: UICollectionViewDiffableDataSource<Int, ByTime>?
                            
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(frame: .zero, collectionViewLayout: layout)
        
        createCollectionViewDataSource()
        setupCollectionViewFlowLayout(layout: layout)
        
        register(HourCollectionCell.self, forCellWithReuseIdentifier: HourCollectionCell.reuseId)
   }
   
   required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
    
    private func createCollectionViewDataSource() {
        collectionViewDataSource = UICollectionViewDiffableDataSource<Int, ByTime>(collectionView: self, cellProvider: { (collectionView, indexPath, model) -> UICollectionViewCell? in

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourCollectionCell.reuseId, for: indexPath) as? HourCollectionCell
            cell?.configure(with: model)
            
            return cell
        })
    }
    
    private func setupCollectionViewFlowLayout(layout: UICollectionViewFlowLayout) {
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 6
        layout.itemSize = CGSize(width: 73, height: 114)
        layout.invalidateLayout()
        
        contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        backgroundColor = #colorLiteral(red: 0.9589126706, green: 0.9690223336, blue: 0.9815708995, alpha: 1)

        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        layer.cornerRadius = 10
    }
    
    func reloadCellData(with data: [ByTime]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, ByTime>()
        snapshot.appendSections([0])
        snapshot.appendItems(data, toSection: 0)
        collectionViewDataSource?.apply(snapshot)
    }
}
