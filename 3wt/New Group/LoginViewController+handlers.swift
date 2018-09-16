//
//  LoginViewController+handlers.swift
//  3wt
//
//  Created by Seth Merritt on 8/26/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import Foundation
import Firebase


extension LoginViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func handleSelectedProfileImageview() {
        print("trying to handle the picker")
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImageFromPicker: UIImage?
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else    if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        if let selectedImage = selectedImageFromPicker {
            profileImageView.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @objc func handleLoginRegisterChange() {
        let title = loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, for: .normal)
        
        //set height for input container. If index is 0 then height is 100 otherwise 150
        inputsContainerViewHeightAnchor?.constant = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 100 : 150
        //change height of name text
        firstNameTextFieldHeightAnchor?.isActive = false
        firstNameTextFieldHeightAnchor = firstNameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0 : 1/3)
        firstNameTextFieldHeightAnchor?.isActive = true
        
        emailTextFieldHeightAnchor?.isActive = false
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        emailTextFieldHeightAnchor?.isActive = true
        
        passwordTextFieldHeightAnchor?.isActive = false
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        passwordTextFieldHeightAnchor?.isActive = true
        
    }
    
    @objc func handleLoginRegister() {
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            handleLogin()
        } else {
            handleRegister()
        }
    }
    
    func handleLogin() {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print(error?.localizedDescription as Any)
                return
            }
            //Sends notification to system that user just logged in for the HealthCatasourceController to respond to.
            //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "RefreshHealthPage"), object: nil)
            self.setCurrentUser()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    func handleRegister() {
        guard let email = emailTextField.text, let password = passwordTextField.text, let firstName = firstNameTextField.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print(error as Any)
                return
            }
            
            guard let uid = user?.uid else { return }
            //successfully authenticated user at this point
            let imageName = NSUUID().uuidString //created a uniqueID for the image
            let storageRef = Storage.storage().reference().child("profile_images").child(imageName)  //sets up the reference to the storage bucket
            
            if let uploadData = UIImagePNGRepresentation(self.profileImageView.image!) {  //turns the profile image loaded to a PNG data to upload.
                storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                    if error != nil {
                        print(error as Any)
                        return
                    }
                    if let profileImageURL = metadata?.downloadURL()?.absoluteString {
                        self.registerUserIntoDatabaseWithUID(uid: uid, firstName: firstName, email: email, profileImageURL: profileImageURL)
                    }
                })
            }
        }
    }
    
    private func registerUserIntoDatabaseWithUID(uid: String, firstName: String, email: String, profileImageURL: String) {
        
        let usersReference = db.collection("users")
        let newWTUser = WTUser(email: email, firstName: firstName, lastName: "N/A", timeStamp: Date(), profileImageURL: profileImageURL)
        
        usersReference.document(uid).setData(newWTUser.dictionary!, completion: { (usererror) in
            
            if usererror != nil {
                print("USER LOAD ERROR", usererror?.localizedDescription as Any)
                return
            }
            //sucessfully added the user
            print("Saved user successfully")
            self.setCurrentUser()
            self.dismiss(animated: true, completion: nil)
            
        })
        
    }
    
}
