//
//  ViewController.swift
//  VerticalWritingSample
//
//  Created by Masuhara on 2019/03/09.
//  Copyright © 2019 Ylab.inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // @IBOutlet weak var sampleLabel: VerticalWritingLabel!
    @IBOutlet weak var sampleTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }

    func setUpTableView() {
        sampleTableView.dataSource = self
        let nib = UINib(nibName: "SampleTableViewCell", bundle: Bundle.main)
        sampleTableView.register(nib, forCellReuseIdentifier: "Cell")
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SampleTableViewCell
        cell.verticalLabel.text = "ああああああああああああああああああ"
        // cell.setNeedsDisplay()
        
        return cell
    }
}
