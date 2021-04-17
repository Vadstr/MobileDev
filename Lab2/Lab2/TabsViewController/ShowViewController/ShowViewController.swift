//
//  ShowViewController.swift
//  Lab2
//
//  Created by Vadim on 14.03.2021.
//

import UIKit

class ShowViewController: UIViewController {
    
    @IBOutlet weak var showGraphic: ShowGraphic!
    @IBOutlet weak var showPieChart: ShowPieChart!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            showGraphic.isHidden = false
            showPieChart.isHidden = true
        case 1:
            showGraphic.isHidden = true
            showPieChart.isHidden = false
        default:
            break
        }
    }
}
