//
//  Extension.swift
//  AppExtension
//
//  Created by joey on 12/29/20.
//

import UIKit

// MARK: -
private let firstLaunchFlag = "isFirstLaunchFlag"

public extension UIApplication {
    static func isFirstLaunch() -> Bool {
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: firstLaunchFlag)

        if isFirstLaunch {
            UserDefaults.standard.set(true, forKey: firstLaunchFlag)
            UserDefaults.standard.synchronize()
        }

        return isFirstLaunch
    }
}

// MARK: -
public class UserPreference {
    struct SearchHistory {
        static private var items: [String] {
            set {
                UserDefaults.standard.setValue(newValue, forKey: UserPreferenceKey.searchHistory.rawValue)
            }
            get {
                let items = UserDefaults.standard.array(forKey: UserPreferenceKey.searchHistory.rawValue) as? [String]
                return items ?? []
            }
        }

        static func getItems() -> [String] {
            return items
        }

        static func append(item: String?, completion: ((Bool) -> Void)? = nil) {
            guard let item = item?.lowercased() else {
                completion?(false)
                return
            }
            guard !items.contains(item) else {
                completion?(false)
                return
            }

            var itemsCopy = items
            itemsCopy.append(item)
            items = itemsCopy
            completion?(true)
        }

        static func remove(atIndex index: Int, completion: ((Bool) -> Void)? = nil) {
            guard items.indices.contains(index) else {
                completion?(false)
                return
            }

            var itemsCopy = items
            itemsCopy.remove(at: index)
            items = itemsCopy
            completion?(true)
        }

        static func clear() {
            items = []
        }
    }
}

public enum UserPreferenceKey: String {
    case recipeSort = "com.tecpal.recipeSort"
    case searchHistory = "com.tecpal.searchHistory"
}

// MARK: -
public enum RecipeSort: Int {
    case lastUpdated
    case popularity
}
