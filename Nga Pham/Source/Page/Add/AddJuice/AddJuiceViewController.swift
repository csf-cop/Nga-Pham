//
//  AddJuiceViewController.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/19/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import UIKit
import TLPhotoPicker
import Photos

final class AddJuiceViewController: UIViewController {

    @IBOutlet private weak var juiceImageView: UIImageView!
    @IBOutlet private weak var addJuiceButton: UIButton!
    @IBOutlet private weak var juiceNameTextField: UITextField!
    @IBOutlet private weak var juiceNoteTextView: UITextView!
    @IBOutlet private weak var imageDescriptionStackView: UIStackView!
    @IBOutlet private weak var unitMersurePicker: PickerViewTextField!

    var viewModel: AddJuiceViewModel = AddJuiceViewModel()
    private lazy var imagePicker: UIImagePickerController = UIImagePickerController()
    private var isJuiceImage: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Thêm hoa quả"
        juiceNameTextField.delegate = self
        configGesture()
        viewModel.handleErrorMessage = { [weak self] error in
            self?.showError(error)
        }
    }

    @IBAction func addJuiceTouchUpInside(_ sender: UIButton) {
        let juiceName: String = juiceNameTextField.text.unwrapped(or: "")
        let juiceDescription: String = juiceNoteTextView.text.unwrapped(or: "")
        let unit: String = unitMersurePicker.text.unwrapped(or: "")
        viewModel.addJuice(name: juiceName, description: juiceDescription, unit: unit) { [] sussess in
            if sussess {
                self.dismiss(animated: true)
            }
        }
    }

    @IBAction func moreJuiceImageTouchUpInside(_ sender: UIButton) {
        accessToLibrary(isJuiceImage: false)
    }

    @objc func pickPhoto(sender: UITapGestureRecognizer) {
        showAlert(title: App.Strings.Camera.libraryPhotoAlertTitle,
                  message: App.Strings.Camera.libraryPhotoMessage,
                  buttonTitles: CameraConfig.typeButtonTitles,
                  highlightedButtonIndex: CameraConfig.typeButtonTitles.firstIndex(of: App.Strings.library)) { index in
            if index == CameraConfig.typeButtonTitles.firstIndex(of: App.Strings.library) {
                self.accessToLibrary()
            } else if index == CameraConfig.typeButtonTitles.firstIndex(of: App.Strings.camera) {
                self.accessToCamera()
            }
        }
    }

    @objc private func uploadPhoto(sender: UITapGestureRecognizer) {
        accessToLibrary(isJuiceImage: false)
    }
}

extension AddJuiceViewController {
    private func configGesture() {
        let gesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.pickPhoto))
        juiceImageView.addGestureRecognizer(gesture)

        let uploadGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.uploadPhoto))
        guard let images: [UIImageView] = imageDescriptionStackView.arrangedSubviews as? [UIImageView] else { return }
        for image in images {
            image.addGestureRecognizer(uploadGesture)
        }
    }

    private func accessToLibrary(isJuiceImage: Bool = true) {
        self.isJuiceImage = isJuiceImage
        let photos: PHAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photos {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization ({ [weak self] status in
                guard let this: AddJuiceViewController = self else { return }
                if status == .authorized {
                    this.presentLibraryPhoto()
                }
            })
        case .authorized:
            presentLibraryPhoto()
        default:
            showAlert(title: App.Strings.Camera.libraryPhotoAlertTitle,
                      message: App.Strings.Camera.libraryPhotoMessage,
                      buttonTitles: CameraConfig.alertButtonTitles,
                      highlightedButtonIndex: CameraConfig.alertButtonTitles.firstIndex(of: App.Strings.cancel)) { index in
                if index == CameraConfig.alertButtonTitles.firstIndex(of: App.Strings.setting) {
                    App.openSetting()
                }
            }
        }
    }

    private func presentLibraryPhoto() {
        DispatchQueue.main.async {
            let viewController: PhotoPickerViewController = PhotoPickerViewController()
            viewController.delegate = self
            var configure: TLPhotosPickerConfigure = TLPhotosPickerConfigure()
            configure.usedCameraButton = false
            configure.numberOfColumn = CameraConfig.numberOfColumn
            configure.allowedVideo = false
            configure.allowedLivePhotos = false
            configure.allowedVideoRecording = false
            configure.tapHereToChange = App.Strings.Camera.tapHereToChange
            configure.doneTitle = App.Strings.complete
            configure.cancelTitle = App.Strings.cancel
            if self.isJuiceImage {
                configure.singleSelectedMode = true
            } else {
                configure.singleSelectedMode = false
                configure.maxSelectedAssets = CameraConfig.maxSelectedAssets
            }
            configure.customLocalizedTitle = CameraConfig.customLocalizedTitle
            viewController.configure = configure

            self.present(viewController, animated: true)
        }
    }

    private func accessToCamera() {
        if AVCaptureDevice.authorizationStatus(for: .video) == .notDetermined {
            AVCaptureDevice.requestAccess(for: .video) { [weak self] cameraGranted -> Void in
                guard let this: AddJuiceViewController = self else { return }
                if cameraGranted {
                    this.presentCamera()
                }
            }
        } else if AVCaptureDevice.authorizationStatus(for: .video) == .authorized {
            presentCamera()
        } else {
            showAlert(title: App.Strings.Camera.cameraAlertTitle,
                      message: App.Strings.Camera.cameraAlertMessage,
                      buttonTitles: CameraConfig.alertButtonTitles,
                      highlightedButtonIndex: CameraConfig.alertButtonTitles.firstIndex(of: App.Strings.cancel)) { index in
                if index == CameraConfig.alertButtonTitles.firstIndex(of: App.Strings.setting) {
                    App.openSetting()
                }
            }
        }
    }

    private func presentCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true)
        } else {
            alert(message: "Device not support camera")
        }
    }
}

// MARK: TLPhotosPickerViewControllerDelegate
extension AddJuiceViewController: TLPhotosPickerViewControllerDelegate {
    func dismissPhotoPicker(withTLPHAssets: [TLPHAsset]) {
        viewModel.getSelectedImage(isJuiceImage: isJuiceImage, selectedAssets: withTLPHAssets)
    }

    func dismissComplete() {
        if isJuiceImage {
            if !viewModel.juiceImage.isEmpty {
                juiceImageView.image = viewModel.juiceImage[0]
            }
        } else {
            let buttons: [UIImageView] = imageDescriptionStackView.arrangedSubviews.compactMap({ $0 as? UIImageView })
            for image in buttons {
                image.image = viewModel.uploadableImages[safe: image.tag].unwrapped(or: UIImage())
            }
        }
    }
}

// MARK: - UINavigationControllerDelegate, UIImagePickerControllerDelegate
extension AddJuiceViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image: UIImage = info[.originalImage] as? UIImage {
            viewModel.takePhoto(image: image)
        } else {
            navigationController?.popViewController(animated: false)
        }
        imagePicker.dismiss(animated: true) {
            guard let image: UIImage = info[.originalImage] as? UIImage else { return }
            self.juiceImageView.image = image
        }
    }
}

extension AddJuiceViewController {
    struct CameraConfig {
        static let alertButtonTitles: [String] = [App.Strings.cancel, App.Strings.setting]
        static let typeButtonTitles: [String] = [App.Strings.library, App.Strings.camera]
        static let numberOfColumn: Int = 3
        static let maxSelectedAssets: Int = 4
        static let customLocalizedTitle: [String: String] = ["Camera Roll": App.Strings.Camera.cameraRoll,
                                                             "Selfies": App.Strings.Camera.selfies,
                                                             "Favorites": App.Strings.favorite,
                                                             "My Photo Stream": App.Strings.Camera.myPhotoStream]
    }
}

extension AddJuiceViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
