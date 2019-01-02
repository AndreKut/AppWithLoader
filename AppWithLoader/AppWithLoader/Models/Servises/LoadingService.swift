//
//  LoadService.swift
//  AppWithLoader
//
//  Created by Andre on 1/1/19.
//  Copyright © 2019 Free. All rights reserved.
//

import BoltsSwift
import DownloadingService

protocol LoadingService {
    func baseDataRequest(baseUrl: URL) -> Task<[UnsplashItemModel]?>

    func downloadImage(urls: [URL]) -> Task<[UIImage?]>
    func cancelDownloadImage()

    func downloadJSON(urls: [URL]) -> Task<[JSON?]>
    func cancelDownloadJSON()

    func downloadData(urls: [URL]) -> Task<[Data?]>
    func cancelDownloadData()
}

class LoadingServicesImpl: LoadingService {

    let imageLoader: Loader = SharedInstance.imageLoaderInstance
    let jsonLoader: Loader = SharedInstance.jsonLoaderInstance
    let dataLoader: Loader = SharedInstance.dataLoaderInstance

    let storingService: StoringService
    
    init(storingService: StoringService) {
        self.storingService = storingService
    }

    func baseDataRequest(baseUrl: URL) -> Task<[UnsplashItemModel]?> {
        let taskComplition = TaskCompletionSource<[UnsplashItemModel]?>()
        jsonLoader.loadRequest(fromUrls: [baseUrl], complition: { [weak self] results in
            results.forEach { result in
                guard  let json = result.result as? JSON,
                    let jsonArray = json.array as? [[String: Any]] else {
                        return
                }
                var unsplashItemModels: [UnsplashItemModel] = []

                jsonArray.forEach({ json in
                    guard let unsplashItemModel = UnsplashItemModel(JSON: json) else {
                        return
                    }
                    unsplashItemModels.append(unsplashItemModel)
                })

                self?.storingService.saveUnsplashItemModels(unsplashItemModels)
                taskComplition.set(result: unsplashItemModels)
            }
        })

        return taskComplition.task
    }

    func downloadImage(urls: [URL]) -> Task<[UIImage?]> {
        let taskComplition = TaskCompletionSource<[UIImage?]>()

        imageLoader.loadRequest(fromUrls: urls) { [weak self] results in

            let noErrorResult = results.filter({ $0.error == nil })
            let imageResult = noErrorResult.map({ $0.result as? UIImage })

            taskComplition.set(result: imageResult)
        }

        return taskComplition.task
    }

    func downloadJSON(urls: [URL]) -> Task<[JSON?]> {
        let taskComplition = TaskCompletionSource<[JSON?]>()
        
        jsonLoader.loadRequest(fromUrls: urls) { results in
            let noErrorResult = results.filter({ $0.error == nil })
            let jsonResult = noErrorResult.map({ $0.result as? JSON })

            taskComplition.set(result: jsonResult)
        }

        return taskComplition.task
    }

    func downloadData(urls: [URL]) -> Task<[Data?]> {
        let taskComplition = TaskCompletionSource<[Data?]>()

        dataLoader.loadRequest(fromUrls: urls) { [weak self] results in
            let noErrorResult = results.filter({ $0.error == nil })
            let dataResult = noErrorResult.map({ $0.result as? Data })

            taskComplition.set(result: dataResult)
        }

        return taskComplition.task
    }

    func cancelDownloadImage() {
        imageLoader.cancel()
    }

    func cancelDownloadJSON() {
        jsonLoader.cancel()
    }

    func cancelDownloadData() {
        dataLoader.cancel()
    }
}
