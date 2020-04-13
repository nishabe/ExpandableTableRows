//
//  ViewController.swift
//  ExapandableTableView
//
//  Created by Aneesh Abraham on 4/11/20.
//  Copyright © 2020 qaz. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    let cellId = "cellId123123"
    
    var twoDimensionalArray = [
        ExpandableNames(isExpanded: false, names: ["Amy", "Bill", "Zack", "Steve", "Jack", "Jill", "Mary"]),
        ExpandableNames(isExpanded: false, names: ["Carl", "Chris", "Christina", "Cameron"]),
        ExpandableNames(isExpanded: false, names: ["David", "Dan"]),
        ExpandableNames(isExpanded: false, names: ["Patrick", "Patty"]),
    ]
    
    var showIndexPaths = false
    
    @objc func handleShowIndexPath() {
        
        print("Attemping reload animation of indexPaths...")
        
        // build all the indexPaths we want to reload
        var indexPathsToReload = [IndexPath]()
        
        for section in twoDimensionalArray.indices {
            for row in twoDimensionalArray[section].names.indices {
                print(section, row)
                let indexPath = IndexPath(row: row, section: section)
                indexPathsToReload.append(indexPath)
            }
        }
        
//        for index in twoDimensionalArray[0].indices {
//            let indexPath = IndexPath(row: index, section: 0)
//            indexPathsToReload.append(indexPath)
//        }
        
        showIndexPaths = !showIndexPaths
        
        let animationStyle = showIndexPaths ? UITableViewRowAnimation.right : .left
        
        tableView.reloadRows(at: indexPathsToReload, with: animationStyle)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show IndexPath", style: .plain, target: self, action: #selector(handleShowIndexPath))
        
        navigationItem.title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let button = UIButton(type: .system)
        button.setTitle("Open", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .yellow
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        
        button.tag = section
        
        return button
    }
    
    @objc func handleExpandClose(button: UIButton) {
        print("Trying to expand and close section...")
        
        let selectedSection = button.tag
        
        let expandedSectionCollection = twoDimensionalArray.filter({ $0.isExpanded == true })
        // count == 1, when a section is already expanded
        if expandedSectionCollection.count == 1 {
            if let expandedSection = expandedSectionCollection.first {
                // Get index of selected section
                if let expandedSectionIndex = twoDimensionalArray.firstIndex(of: expandedSection) {
                    expandOrShrinkSection(isExpanding: false, selectedSection: expandedSectionIndex)
                    if expandedSectionIndex != selectedSection {
                        expandOrShrinkSection(isExpanding: true, selectedSection: selectedSection)
                    }
                }
            }
        } else {
            expandOrShrinkSection(isExpanding: true, selectedSection: selectedSection)
        }
        
        // Set button title
        button.setTitle("Close" , for: .normal)
    }
    
    private func expandOrShrinkSection(isExpanding: Bool, selectedSection: Int) {
        if isExpanding {
            twoDimensionalArray[selectedSection].isExpanded = true
            tableView.insertRows(at: getIndexPathsOfSection(selectedSection), with: .fade)
        } else {
            twoDimensionalArray[selectedSection].isExpanded = false
            tableView.deleteRows(at: getIndexPathsOfSection(selectedSection), with: .none)
        }
    }
     
    private func getIndexPathsOfSection(_ selectedSection: Int) -> [IndexPath] {
        var indexPaths = [IndexPath]()
        for row in twoDimensionalArray[selectedSection].names.indices {
            let indexPath = IndexPath(row: row, section: selectedSection)
            indexPaths.append(indexPath)
        }
        return indexPaths
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return twoDimensionalArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !twoDimensionalArray[section].isExpanded {
            return 0
        }
        
        return twoDimensionalArray[section].names.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let name = twoDimensionalArray[indexPath.section].names[indexPath.row]
        
        cell.textLabel?.text = name
        
        if showIndexPaths {
            cell.textLabel?.text = "\(name)   Section:\(indexPath.section) Row:\(indexPath.row)"
        }
        
        return cell
    }

}


