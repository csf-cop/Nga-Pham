//
//  JuiceDetailViewController.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/16/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import UIKit

final class JuiceDetailViewController: UIViewController {

    @IBOutlet weak var juiceNameLabel: UILabel!
    @IBOutlet weak var juiceImageView: UIImageView!
    @IBOutlet weak var juiceDescriptionLabel: UILabel!
    
    var viewModel: JuiceDetailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.isHidden = true
        settingUI()
        settingData()
    }
    @IBAction func orderJuiceTouchUpInside(_ sender: UIButton) {
        let orderVC: OrderJuiceViewController = OrderJuiceViewController()
        navigationController?.pushViewController(orderVC, animated: true)
    }
}

extension JuiceDetailViewController {
    private func settingUI() {
        title = "Juice Detail"
    }

    private func settingData() {
        guard let viewModel: JuiceDetailViewModel = viewModel else { return }
        juiceNameLabel.text = viewModel.juiceModel.juice.juiceName
        juiceDescriptionLabel.text = viewModel.juiceModel.juice.juiceDescription
    }
}
