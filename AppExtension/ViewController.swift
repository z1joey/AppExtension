//
//  ViewController.swift
//  AppExtension
//
//  Created by joey on 12/29/20.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var someLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if UIApplication.isFirstLaunch() {
            someLabel.text = "First Launch"
        } else {
            someLabel.text = "Hello World"
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //segmentedControl.selectedSegmentIndex = preference.recipeSort.rawValue
    }

    @IBAction func valueChanged(_ sender: UISegmentedControl) {
        if let recipeSort = RecipeSort(rawValue: sender.selectedSegmentIndex) {
            //preference.update(recipeSort)
        }
    }

    @IBAction func buttonAction(_ sender: UIButton) {
        UserPreference.SearchHistory.append(item: textField.text, completion: { [weak self] completed in
            guard completed else { return }
            let items = UserPreference.SearchHistory.getItems()
            self?.tableView.insertRows(at: [IndexPath(row: items.count - 1, section: 0)], with: .bottom)
        })
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let items = UserPreference.SearchHistory.getItems()
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let items = UserPreference.SearchHistory.getItems()
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserPreference.SearchHistory.remove(atIndex: indexPath.row, completion: { [weak self] completed in
            guard completed else { return }
            self?.tableView.deleteRows(at: [indexPath], with: .top)
        })
    }
}
