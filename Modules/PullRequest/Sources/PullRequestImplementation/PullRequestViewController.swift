//
//  PullRequestViewController.swift
//  PullRequest
//
//  Created by Gabriel Ferreira de Carvalho on 15/04/25.
//

import UIKit
import ReducerCore

typealias PullRequestViewControllerType = StatefulCollectionViewController<
    Action,
    State,
    ViewModel,
    ViewModel.Section,
    ViewModel.Item
>

final class PullRequestViewController: PullRequestViewControllerType {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        execute(.initialLoad)
    }
}
