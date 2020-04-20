//
//  ModifyContactViewController.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/19/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import UIKit
import TLPhotoPicker
import Photos

final class ModifyContactViewController: ViewController {

    @IBOutlet private weak var addContactButton: UIButton!
    @IBOutlet private weak var fullNameTextField: UITextField!
    @IBOutlet private weak var phoneTextField: UITextField!
    @IBOutlet private weak var addressTextField: UITextField!
    @IBOutlet private weak var noteTextView: UITextView!
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var mofifyActionView: UIView!
    
    private lazy var imagePicker: UIImagePickerController = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Thêm liên lạc"
        configUI()
        let gesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.pickPhoto))
        avatarImageView.addGestureRecognizer(gesture)
        guard let viewModel: ModifyContactViewModel = viewModel as? ModifyContactViewModel else { return }
        viewModel.handleErrorMessage = { [weak self] error in
            self?.showError(error)
        }
    }

    @IBAction func modifyContactTouchUpInside(_ sender: UIButton) {
        let name: String = fullNameTextField.text.unwrapped(or: "")
        let address: String = addressTextField.text.unwrapped(or: "")
        let phone: String = phoneTextField.text.unwrapped(or: "")
        let note: String = noteTextView.text

        guard let viewModel: ModifyContactViewModel = viewModel as? ModifyContactViewModel else { return }
        showIndicator()
        viewModel.modifyContact(name: name, address: address, phone: phone, note: note) { [] isSuccess in
            self.hideIndicator()
            if isSuccess {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }

    @IBAction func deleteContactTouchUpInside(_ sender: UIButton) {
        guard let viewModel: ModifyContactViewModel = viewModel as? ModifyContactViewModel else { return }
        showIndicator()
        viewModel.deleteContact { [] isSuccess in
            self.hideIndicator()
            if isSuccess {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }

    override func leftButtonTouchUpInside() {
        dismiss(animated: true)
    }
}

extension ModifyContactViewController {
    private func configUI() {
        phoneTextField.keyboardType = .asciiCapableNumberPad
        fullNameTextField.delegate = self
        phoneTextField.delegate = self
        addressTextField.delegate = self

        guard let viewModel: ModifyContactViewModel = viewModel as? ModifyContactViewModel else { return }
        if viewModel.mode == .add {
            mofifyActionView.isHidden = true
        } else {
            addContactButton.isHidden = true
            fullNameTextField.text = viewModel.contact.fullName
            phoneTextField.text = viewModel.contact.phone
            addressTextField.text = viewModel.contact.address
            noteTextView.text = viewModel.contact.noteInfo
            if let imageData: Data = viewModel.contact.image {
                avatarImageView.image = UIImage(data: imageData)
            } else {
                avatarImageView.image = #imageLiteral(resourceName: "img_no_image")
            }
        }
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
                guard let this: ModifyContactViewController = self else { return }
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
                guard let this: ModifyContactViewController = self else { return }
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

extension ModifyContactViewController {
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
extension ModifyContactViewController: TLPhotosPickerViewControllerDelegate {
    func dismissPhotoPicker(withTLPHAssets: [TLPHAsset]) {
        guard let viewModel: ModifyContactViewModel = viewModel as? ModifyContactViewModel else { return }
        viewModel.getSelectedImage(selectedAssets: withTLPHAssets)
    }

    func dismissComplete() {
        guard let viewModel: ModifyContactViewModel = viewModel as? ModifyContactViewModel else { return }
        if !viewModel.images.isEmpty {
            avatarImageView.image = viewModel.images[0]
        }
    }
}

// MARK: - UINavigationControllerDelegate, UIImagePickerControllerDelegate
extension ModifyContactViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image: UIImage = info[.originalImage] as? UIImage {
            guard let viewModel: ModifyContactViewModel = viewModel as? ModifyContactViewModel else { return }
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

extension ModifyContactViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
