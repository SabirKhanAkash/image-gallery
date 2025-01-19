import UIKit
import Flutter
import Photos

@main
@objc class AppDelegate: FlutterAppDelegate {
    private let CHANNEL = "com.akash.image_gallery/images"

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller = window?.rootViewController as! FlutterViewController
        let methodChannel = FlutterMethodChannel(name: CHANNEL, binaryMessenger: controller.binaryMessenger)

        methodChannel.setMethodCallHandler { (call, result) in
            switch call.method {
            case "getAllImages":
                self.getAllImages(result: result)
            case "getAlbums":
                self.getAlbums(result: result)
            default:
                result(FlutterMethodNotImplemented)
            }
        }

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func getAllImages(result: @escaping FlutterResult) {
        var imagePaths = [String]()

        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
            if status == .authorized || status == .limited {
                let assets = PHAsset.fetchAssets(with: .image, options: nil)

                assets.enumerateObjects { (asset, index, stop) in
                    let assetId = asset.localIdentifier
                    imagePaths.append("assets-library://asset/asset.JPG?id=\(assetId)&ext=JPG")
                }
                result(imagePaths)
            } else {
                result(FlutterError(code: "PERMISSION_DENIED", message: "Permission not granted", details: nil))
            }
        }
    }

    private func getAlbums(result: @escaping FlutterResult) {
        var albums = [[String: Any]]()

        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
            if status == .authorized || status == .limited {
                let collections = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: nil)

                collections.enumerateObjects { (collection, index, stop) in
                    var albumImages = [String]()
                    let assets = PHAsset.fetchAssets(in: collection, options: nil)

                    assets.enumerateObjects { (asset, index, stop) in
                        let assetId = asset.localIdentifier
                        albumImages.append("assets-library://asset/asset.JPG?id=\(assetId)&ext=JPG")
                    }

                    if albumImages.count > 0 {
                        albums.append([
                            "albumName": collection.localizedTitle ?? "Unknown",
                            "images": albumImages
                        ])
                    }
                }
                result(albums)
            } else {
                result(FlutterError(code: "PERMISSION_DENIED", message: "Permission not granted", details: nil))
            }
        }
    }
}
