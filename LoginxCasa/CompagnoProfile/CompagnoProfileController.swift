import UIKit

class CompagnoProfileController: UIViewController{
    
    enum TextFieldType : Int {
        case name = 0
        case surname
    }
    @IBOutlet weak var Img: UIButton!
    
    @IBOutlet var textFields: [UITextField]!
    
    var name : String!
    var surname : String!
    var image : Data!
    
    @IBOutlet weak var nameLabel: UITextField!
    
    @IBOutlet weak var surnameLabel: UITextField!
    
    //    var nameShow : String!
    //    var surnameShow : String!
    //    var imageShow : Data!
    
    private var pickerController:UIImagePickerController?
    
    
    var compagno : Compagno = Compagno()
    weak var delegate : CompagnoDelegate?
    private var empty : Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        nameLabel.text = nameShow
        //        surnameLabel.text = surnameShow
        //         if let imageProfile = imageShow {
        //                    Img.setImage(UIImage(data: imageProfile), for: .normal)
        //                }
        if(compagno.name == nil && compagno.surname == nil && compagno.image == nil){
            empty = true
        }
        else{
            empty = false
        }
        nameLabel.text = compagno.name
        surnameLabel.text = compagno.surname
        if let imageProfile = compagno.image {
            Img.setImage(UIImage(data: imageProfile), for: .normal)
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func AddAction(_ sender: UIButton) {
        
        
        
        
        for i in 0..<textFields.count {
            
            switch textFields[i].tag {
            case TextFieldType.name.rawValue:
                name = textFields[i].text
                break
            case TextFieldType.surname.rawValue:
                surname = textFields[i].text
                break
            default : break
            }
            
        }
        image=Img.imageView?.image?.pngData()
        //compagno = Compagno(name: name, surname: surname, image: image)
        
        guard (name != nil && !name!.isEmpty) || (surname != nil && !surname!.isEmpty) else {
            
            let alert = UIAlertController(title: "Attenzione", message: "O il Nome o il Cognome sono obbligatori", preferredStyle: .alert)
            let okay = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            alert.addAction(okay)
            self.present(alert, animated: true, completion: nil)
            
            return }
        
        if(empty){
            compagno = Compagno(name: name, surname: surname, image: image)
            delegate?.addingCompagno(compagno: compagno)
        }
        else{
            delegate?.editCompagno(compagno: compagno,name: name,surname: surname,image: image)
        }
        
        navigationController?.popViewController(animated: true)
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func AddPictureProfile(_ sender: UIButton) {
        self.pickerController = UIImagePickerController()
        self.pickerController!.delegate = self
        self.pickerController!.allowsEditing = true
        
        let alert = UIAlertController(title: nil, message: "Foto profilo", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Annulla", style: .cancel, handler: nil)
        alert.addAction(cancel)
        
        #if !targetEnvironment(simulator)
        let photo = UIAlertAction(title: "Scatta foto", style: .default) { action in
            self.pickerController!.sourceType = .camera
            self.present(self.pickerController!, animated: true, completion: nil)
        }
        alert.addAction(photo)
        #endif
        
        let camera = UIAlertAction(title: "Carica foto", style: .default) { alert in
            self.pickerController!.sourceType = .photoLibrary
            self.present(self.pickerController!, animated: true, completion: nil)
        }
        alert.addAction(camera)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
}
extension CompagnoProfileController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else {
            debugPrint("No image found")
            return
        }
        
        let img2 = checkImageSizeAndResize(image: image)
        
        self.Img.setImage(img2, for: .normal )
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    private func checkImageSizeAndResize(image : UIImage) -> UIImage {
        
        let imageSize: Int = image.pngData()!.count
        let imageDimension = Double(imageSize) / 1024.0 / 1024.0
        print("size of image in MB: ", imageDimension)
        
        if imageDimension > 15 {
            
            let img = image.resized(withPercentage: 0.5) ?? UIImage()
            
            
            return checkImageSizeAndResize(image: img)
            
        }
        
        return image
        
        
    }
    
}
