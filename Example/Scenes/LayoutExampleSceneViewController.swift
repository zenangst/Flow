//
//  LayoutExampleSceneViewController.swift
//  Blueprints
//
//  Created by Chris on 06/12/2018.
//  Copyright (c) 2018 Christoffer Winterkvist. All rights reserved.
//

import UIKit

protocol LayoutExampleSceneDisplayLogic: class {

    func displayExampleData(viewModel: LayoutExampleScene.GetExampleData.ViewModel)
}

class LayoutExampleSceneViewController: UIViewController, LayoutExampleSceneDisplayLogic {

    @IBOutlet weak var layoutExampleCollectionView: UICollectionView!

    var exampleDataSource: [LayoutExampleScene.GetExampleData.ViewModel.DisplayedExampleSection]?
    var activeLayout: BlueprintLayout = .vertical
    var itemsPerRow: CGFloat = 1
    var itemsPerColumn: Int = 2
    var interactor: LayoutExampleSceneBusinessLogic?
    var router: (LayoutExampleSceneRoutingLogic & LayoutExampleSceneDataPassing)?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setup()
    }

    private func setup() {
        let viewController = self
        let interactor = LayoutExampleSceneInteractor()
        let presenter = LayoutExampleScenePresenter()
        let router = LayoutExampleSceneRouter()
        let worker = LayoutExampleSceneWorker()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureScene(completion: {
            fetchExampleData()
        })
    }

    private func configureScene(completion: () -> Void) {
        configureNavigationController()
        configureNavigationItems()
        configureCollectionView()
        configureBluePrintLayout()
        completion()
    }
}

extension LayoutExampleSceneViewController {

    func fetchExampleData() {
        let request = LayoutExampleScene.GetExampleData.Request(numberOfSections: 1,
                                                                numberOfRowsInSection: 10)
        interactor?.getExampleData(request: request)
    }

    func displayExampleData(viewModel: LayoutExampleScene.GetExampleData.ViewModel) {
        exampleDataSource = viewModel.displayedExampleSections
        layoutExampleCollectionView.reloadData()
    }
}
