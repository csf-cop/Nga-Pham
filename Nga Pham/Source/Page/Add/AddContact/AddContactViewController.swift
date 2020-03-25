//
//  AddContactViewController.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/19/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import UIKit
import TLPhotoPicker
import Photos

final class AddContactViewController: UIViewController {

    @IBOutlet private weak var addContactButton: UIButton!
    @IBOutlet private weak var fullNameTextField: UITextField!
    @IBOutlet private weak var phoneTextField: UITextField!
    @IBOutlet private weak var addressTextField: UITextField!
    @IBOutlet private weak var noteTextView: UITextView!
    @IBOutlet private weak var avatarImageView: UIImageView!
    
    private lazy var imagePicker: UIImagePickerController = UIImagePickerController()
    var viewModel: AddContactViewModel = AddContactViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Thêm liên lạc"
        configUI()
        let gesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.pickPhoto))
        avatarImageView.addGestureRecognizer(gesture)
    }

    @IBAction func addContactTouchUpInside(_ sender: UIButton) {
        let name: String = fullNameTextField.text.unwrapped(or: "")
        let address: String = addressTextField.text.unwrapped(or: "")
        let phone: String = phoneTextField.text.unwrapped(or: "")
        let note: String = noteTextView.text

        if let addedContact: CoreContact = viewModel.addContact(name: name, address: address, phone: phone, note: note) {
            notificationCenter.post(name: .ReloadContacts, object: addedContact)
        }
        self.dismiss(animated: true)
    }
}

extension AddContactViewController {
    private func configUI() {
        phoneTextField.keyboardType = .asciiCapableNumberPad
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

    private func accessToLibrary() {
        let photos: PHAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photos {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization ({ [weak self] status in
                guard let this: AddContactViewController = self else { return }
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
            configure.singleSelectedMode = true
            configure.customLocalizedTitle = CameraConfig.customLocalizedTitle
            viewController.configure = configure

            self.present(viewController, animated: true)
        }
    }

    private func accessToCamera() {
        if AVCaptureDevice.authorizationStatus(for: .video) == .notDetermined {
            AVCaptureDevice.requestAccess(for: .video) { [weak self] cameraGranted -> Void in
                guard let this: AddContactViewController = self else { return }
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

extension AddContactViewController {
    struct CameraConfig {
        static let alertButtonTitles: [String] = [App.Strings.cancel, App.Strings.setting]
        static let typeButtonTitles: [String] = [App.Strings.library, App.Strings.camera]
        static let numberOfColumn: Int = 3
        static let maxSelectedAssets: Int = 9
        static let customLocalizedTitle: [String: String] = ["Camera Roll": App.Strings.Camera.cameraRoll,
                                                             "Selfies": App.Strings.Camera.selfies,
                                                             "Favorites": App.Strings.favorite,
                                                             "My Photo Stream": App.Strings.Camera.myPhotoStream]
    }
}

// MARK: TLPhotosPickerViewControllerDelegate
extension AddContactViewController: TLPhotosPickerViewControllerDelegate {
    func dismissPhotoPicker(withTLPHAssets: [TLPHAsset]) {
        viewModel.getSelectedImage(selectedAssets: withTLPHAssets)
    }

    func dismissComplete() {
        if !viewModel.images.isEmpty {
            avatarImageView.image = viewModel.images[0]
        }
    }
}

// MARK: - UINavigationControllerDelegate, UIImagePickerControllerDelegate
extension AddContactViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image: UIImage = info[.originalImage] as? UIImage {
            viewModel.takePhoto(image: image)
        } else {
            navigationController?.popViewController(animated: false)
        }
        imagePicker.dismiss(animated: true) {
            guard let image: UIImage = info[.originalImage] as? UIImage else { return }
            self.avatarImageView.image = image
        }
    }
}
