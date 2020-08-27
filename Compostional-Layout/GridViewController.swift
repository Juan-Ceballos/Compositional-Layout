//
//  ViewController.swift
//  Compostional-Layout
//
//  Created by Juan Ceballos on 8/26/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit

class GridViewController: UIViewController {
    
    // 3
    // setup enum to hold section for collection view
    enum Section {
        case main
    }
    
    // 4
    // declare our data source, which will be using Diffable data source
    // review: both the section idenfeier and item needs to be hashable objects
    private var dataSource: UICollectionViewDiffableDataSource<Section, Int>!
    
    @IBOutlet weak var collectionView: UICollectionView! // default is flow layout
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureDataSource()
    }
    
    // 2
    private func configureCollectionView()  {
        // this would work programmatically
        //collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        
        // change the collectionView's layout
        // do this if using Storyboard to layout your collection view
        // since stroyboard doews not support compositional layout
        
        collectionView.collectionViewLayout = createLayout() // from flow layout to compostional layout
        collectionView.backgroundColor = .systemBackground
    }


    // 1
    private func createLayout() -> UICollectionViewLayout {
        
        // 1
        // create and configure the item
        // item takes up 25 percent of the group's width
        // item takes up 100 percent of the group's height
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        // 2
        // create and configur4e the group
        // group takes up 100 percent of the section's width
        // group takes up 25 percent of the section's height
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.25))
        
        //let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2) // overrides sizes to fit items according to count
       
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        // 3
        // configure the section
        let section = NSCollectionLayoutSection(group: group)
        
        // 4
        // configure the layout
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    // 5
    // configure the data source
    private func configureDataSource()  {
        // setting up data source
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "labelCell", for: indexPath) as? LabelCell else {
                fatalError("could not dequeue a LabelCell")
            }
            cell.textLabel.text = "\(item)"
            cell.backgroundColor = .systemOrange
            return cell
        })
        
        // populate cc w/ actual data
        // setting the initial snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main]) // only one section
        snapshot.appendItems(Array(1...100)) // setting up arr of items of ints 1-100
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
}

