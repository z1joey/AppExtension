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
private let User_Preference_Key = "com.tecpal.preference"

public class UserPreference {
    static let standard = UserPreference()
    private init() {}

    fileprivate lazy var preference: Preference = {
        return Preference()
    }()

    var recipeSort: RecipeSort {
        return preference.recipeSort
    }

    var searchHistory: [String] {
        return preference.searchHistory
    }

    func update(_ recipeSort: RecipeSort) {
        preference.recipeSort = recipeSort
    }

    func append(_ searchHistoryItem: String) {
        var searchHistory = preference.searchHistory
        searchHistory.append(searchHistoryItem)
        preference.searchHistory = searchHistory
    }

    func clearSearchHistory() {
        preference.searchHistory = []
    }
}

private struct Preference {
    fileprivate var recipeSort: RecipeSort {
        didSet { save() }
    }
    fileprivate var searchHistory: [String] {
        didSet { save() }
    }

    private var userDefaults = UserDefaults.standard

    fileprivate init() {
        searchHistory = decodedPreference().searchHistory
        recipeSort = decodedPreference().recipeSort
    }

    fileprivate init(recipeSort: RecipeSort, searchHistory: [String]) {
        self.recipeSort = recipeSort
        self.searchHistory = searchHistory
    }

    private func save() {
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: self)
        userDefaults.set(encodedData, forKey: User_Preference_Key)
    }
}

private func decodedPreference() -> Preference {
    if let decoded  = UserDefaults.standard.data(forKey: User_Preference_Key) {
        let decodedPreference = NSKeyedUnarchiver.unarchiveObject(with: decoded)
        if let preference = decodedPreference as? Preference {
            return preference
        }
    }

    return Preference(recipeSort: .lastUpdated, searchHistory: [])
}

// MARK: -
public enum RecipeSort: String {
    case lastUpdated
    case popularity
}
