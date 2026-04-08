//
//  AsyncUIImage.swift
//  Claquette
//
//  Created by Artur Bruno on 06/04/26.
//

import UIKit

class UIAsyncImage: UIView {
    
    private enum State: String {
        case loading, loaded, failed
    }
    
    enum UIAsyncImageError: Error {
        case requestFailed, dataNotLoaded
    }
    
    /// The current state. It indicates if the image is loading, is loaded or failed to load.
    private var state: State = .loading {
        didSet {
            switch state {
            case .loading:
                placeholder.isHidden = false
                errorView.isHidden = true
                imageView.isHidden = true
            case .loaded:
                placeholder.isHidden = true
                errorView.isHidden = true
                imageView.isHidden = false
            case .failed:
                placeholder.isHidden = true
                errorView.isHidden = false
                imageView.isHidden = true
            }
        }
    }
    
    /// Instance-related cache to store previous image URLs.
    private let cache: NSCache<NSURL, UIImage>
    
    /// The current task responsible for downloading the image, or **nil** if no one image is being downloaded.
    private var downloadTask: Task<Void, Never>? = nil
    
    /// The provided URL to be downloaded. For each change in this variable, the `AsyncUIImage` will look up if the instance
    /// has a cached `UIImage` for the `URL`. If not, the instance will try to download the image.
    var url: URL? = nil {
        didSet {
            if let url, let image = cache.object(forKey: url as NSURL) {
                state = .loaded
                imageView.image = image
            } else {
                downloadImage()
            }
        }
    }
    
    /// The `UIView` to be displayed when the image is being downloaded.
    var placeholder: UIView {
        willSet { placeholder.removeFromSuperview() }
        didSet { addAndConstraintView(placeholder, representing: .loading) }
    }
    
    /// The `UIView` to be displayed if the image fails to be downloaded.
    var errorView: UIView {
        willSet { errorView.removeFromSuperview() }
        didSet { addAndConstraintView(errorView, representing: .failed) }
    }
    
    /// The `UIImageView` holder for the downloaded image.
    let imageView: UIImageView = UIImageView()
    
    /// Closure to be called when the image fails to be downloaded.
    var errorCompletion: (Error) -> Void = { _ in }
    
    init(
        cache: NSCache<NSURL, UIImage> = .init(),
        placeholder: UIView = UIAsyncImage.defaultPlaceholder,
        errorView: UIView = UIAsyncImage.defaultErrorView,
        errorCompletion: @escaping (Error) -> Void = { _ in }
    ) {
        self.cache = cache
        self.placeholder = placeholder
        self.errorView = errorView
        self.errorCompletion = errorCompletion
        
        super.init(frame: .zero)
        
        addAndConstraintView(imageView, representing: .loaded)
        addAndConstraintView(placeholder, representing: .loading)
        addAndConstraintView(errorView, representing: .failed)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addAndConstraintView(_ view: UIView, representing state: State) {
        self.state.rawValue != state.rawValue ? (view.isHidden = true) : (view.isHidden = false)
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func downloadImage() {
        cancelDownloadTaskIfNeeded()
        
        guard let url else { return }
        
        downloadTask = Task(priority: .utility) {
            do {
                state = .loading
                let urlRequest = URLRequest(url: url)
                
                try Task.checkCancellation()
                
                let (data, response) = try await URLSession.shared.data(for: urlRequest)
                
                guard let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
                    throw UIAsyncImageError.requestFailed
                }
                
                try Task.checkCancellation()
                
                guard let image = UIImage(data: data) else { throw UIAsyncImageError.dataNotLoaded }
                cache.setObject(image, forKey: url as NSURL)
                state = .loaded
                imageView.image = image
            } catch {
                state = .failed
                errorCompletion(error)
            }
        }
    }
    
    private func cancelDownloadTaskIfNeeded() {
        if let task = downloadTask {
            task.cancel()
            downloadTask = nil
        }
    }
}
