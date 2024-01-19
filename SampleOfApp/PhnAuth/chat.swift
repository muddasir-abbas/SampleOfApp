//
//  chat.swift
//  SampleOfApp
//
//  Created by Macbook on 18/01/2024.
//

import UIKit

import Firebase
import FirebaseDatabase
import SVProgressHUD
import SDWebImage

class chat: UIViewController,UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var btnSend: UIButton!
    
    @IBOutlet weak var chatTableView: UITableView!
    
    @IBOutlet weak var chatTxtView: UITextView!
    
    @IBOutlet weak var chatTxtView_height: NSLayoutConstraint!
    
    @IBOutlet weak var chatView_bottom: NSLayoutConstraint!
    
    @IBOutlet weak var msgAreaView_top: NSLayoutConstraint!
    
    var window: UIWindow?
    var theData: [MyMessage] = []
    var ref: DatabaseReference!
    var msgComing:Bool = true
    var textMsg = ""
    var keyBoard_height = 0
    var length:[Int] = []
    var bottomSpace:CGFloat = 0.0
    var isFromCreateMsg:Bool = false
    var keyboardEnable:Bool = false
    var isFromSent:Bool = false
    var isLoadingChat:Bool = false
    var gradientLayer: CAGradientLayer!
    var buyer_id:Int = 0
    var seller_id:Int = 0
    var offer_id:Int = 0
    var offer_table_id:Int = 0
    var buyerName:String = ""
    var isComplete:Bool = false
    var completeCount = 800000
    var isCompleteSeller:Bool = false
    var completeCountSeller = 800000
    var price = ""
    var isMatched: Bool = true
    var sellerName = ""
    var method = ""
    var methodDetail = ""
    var created_at = ""
    var text = ""
    var seconds = 900
    var timer = Timer()
    var buyer_payment_details = ""
    var status = ""
    var payment_sent = ""
    var report:Int = 0
    var reported_credit_add:Int = 0
    var reported_credit_sub:Int = 0
    var isTradeReported:Bool = false
    let currentUser = Utility.customObject(forKey: "user")
    var payment_recieved_text = ""
    var payment_sent_text = ""
    var chatProfileImg = ""
    
    var chat: [String] = []
    var sendRecieveChat = true
    var isreceive:Bool?
    
    //MARK: - View Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.getPendingTrades()
        //        self.btnCancelTrade.isHidden = true
        //        self.btnCancel_height.constant = 0
        //        self.btnAcceptOffr.isHidden = true
        print("self.buyer_payment_details", self.buyer_payment_details)
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.chatTableView.delegate = self
        self.chatTableView.dataSource = self
        //        self.lblTradeDolor.text = "$"+self.price
        //        self.lblYahoo.text = self.method
        print("buyerName=", self.buyerName)
        print("methodDetail=", self.methodDetail)
        let user = Utility.customObject(forKey: "user")
        
        
        self.chatTxtView_height.constant = 40
        self.chatTxtView.text="Type your message here"
        let font = UIFont(name: "Roboto-Regular", size: 15)
        let color = UIColor.gray
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: self.chatTxtView.text)
        let valueRange = NSMakeRange(0, self.chatTxtView.text.count)
        attributedString.removeAttribute(.backgroundColor, range: valueRange)
        self.chatTxtView.attributedText = attributedString
        self.chatTxtView.font = font
        let attrs: [NSAttributedString.Key: Any] = [.font: font!, .foregroundColor: color]
        self.chatTxtView.typingAttributes = attrs
        self.chatTxtView.textColor = UIColor.gray
        func viewDidAppear(_ animated: Bool) {
            self.chatTxtView.delegate = self
            if(chatTxtView.text.trim == "")
            {
                if(self.keyboardEnable || self.isFromCreateMsg)
                {
                    self.chatTxtView.text = ""
                    let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: "")
                    let font = UIFont(name: "Roboto-Regular", size: 18)
                    let color = UIColor.gray
                    let valueRange = NSMakeRange(0, 0)
                    attributedString.removeAttribute(.backgroundColor, range: valueRange)
                    self.chatTxtView.attributedText = attributedString
                    self.chatTxtView.font = font
                    let attrs: [NSAttributedString.Key: Any] = [.font: font!, .foregroundColor: color]
                    self.chatTxtView.typingAttributes = attrs
                    self.chatTxtView.becomeFirstResponder()
                    self.chatTxtView_height.constant = 40
                    self.viewDidLayoutSubviews()
                }
                else
                {
                    self.chatTxtView.text="Type your message here"
                    self.chatTxtView.textColor = UIColor.gray
                    self.adjustUITextViewHeight(arg:chatTxtView)
                }
            }
            
        }
    }
        //MARK: - Show Alert And Send Massage Through Alert -
        func showConfirmAlert()
        {
            let user = Utility.customObject(forKey: "user")
            var title = ""
            var sellerMsg = ""
            if(self.seller_id == user?.id) {
                title = "confirm transfer"
                sellerMsg = self.payment_recieved_text
            }
            else {
                title = "confirm transfer"
                sellerMsg = self.payment_sent_text
            }
            
            let alertController = UIAlertController(title:title , message:sellerMsg, preferredStyle: UIAlertController.Style.alert)
            let respondAction = UIAlertAction(title: "Confirm", style: UIAlertAction.Style.default) {
                (result : UIAlertAction) -> Void in
                if(self.seller_id == user?.id) {
                    self.sendMsg(text:sellerMsg, path: "", type: "message", isForComplete: true)
                    let params1:[String:Any] = ["id":self.offer_table_id,"status":"complete"]
                    SVProgressHUD.show()
                    LoginAndRegistrationReqModel.sharedModel().initChangeOfferStatus(parameters: params1, completion: { (status,response,error) in
                        if(status)
                        {
                            self.chatTxtView.resignFirstResponder()
                            let child_completed = "complete_trade/\(self.offer_table_id)"
                            self.ref = Database.database().reference()
                            let date = Date()
                            let formatter1 = DateFormatter()
                            formatter1.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                            formatter1.timeZone = TimeZone(abbreviation: "UTC")
                            let utcTimeZoneStr1 = formatter1.string(from: date)
                            let expdate = date.addingTimeInterval(5 * 60)
                            let utcTimeZoneStr2 = formatter1.string(from: expdate)
                            let buyerObj = ["id":self.buyer_id,"username":self.buyerName] as [String : Any]
                            let sellerObj = ["id":self.seller_id,"username":self.sellerName] as [String : Any]
                            let acceptObj = ["buyer":buyerObj,"buyer_id":self.buyer_id,"created_at":utcTimeZoneStr1,"expire_at":utcTimeZoneStr2,"id":self.offer_table_id,"offer_id":self.offer_id,"payment_details":self.methodDetail,"payment_method":self.method,"price":self.price,"seller":sellerObj,"seller_id":self.seller_id,"updated_at":utcTimeZoneStr1] as [String : Any]
                            self.ref.child(child_completed).childByAutoId().updateChildValues(acceptObj)
                            SVProgressHUD.dismiss()
                        }
                        else
                        {
                            SVProgressHUD.showError(withStatus: error?.localizedDescription)
                        }
                    })
                }
                else{
                    self.sendMsg(text:sellerMsg, path: "", type: "message", isForComplete: false)
                    SVProgressHUD.show()
                    LoginAndRegistrationReqModel.sharedModel().initChangePaymentStatus(offerId: self.offer_table_id, completion: { (status,response,error) in
                        if(status)
                        {
                            self.chatTxtView.resignFirstResponder()
                            let child_payment_sent = "payment_sent/\(self.offer_table_id)"
                            self.ref = Database.database().reference()
                            let offerIdObj = ["id":self.offer_table_id] as [String:Any]
                            self.ref.child(child_payment_sent).childByAutoId().updateChildValues(offerIdObj)
//                            self.btnCancelTrade.isHidden = true
//                            self.btnCancel_height.constant = 0
//                            if(self.currentUser?.id != self.seller_id)
//                            {
//                                self.btnAcceptOffr.isHidden = true
//                            }
                        }
                        SVProgressHUD.dismiss()
                    })
                    
                }
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default) {
                (result : UIAlertAction) -> Void in
                
                print("Trade Cancel")
                
            }
            alertController.addAction(respondAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true){
                if let allContainerView = alertController.view.superview?.subviews{
                    for myview in allContainerView{
                        if (myview.gestureRecognizers != nil){
                            myview.isUserInteractionEnabled = false
                        }
                    }
                }
            }
        }
        func uploadImageToServer(attachs: UIImage) {
            SVProgressHUD.show()
            var uploadProgess: Int = 0
            LoginAndRegistrationReqModel.sharedModel().initUploadImage(upload_image:attachs, completion: {(status,data,error) in
                if(status) {
                    print("Response",data!)
                    let success = data!.value(forKey: "success") as! Bool
                    let message = data!.value(forKey: "message") as! String
                    
                    if(success) {
                        if let imagePath = data!.value(forKey: "path") as? String {
                            if(self.chatTxtView.text.trim == "" || self.chatTxtView.text == "Type your message here") {
                                self.sendMsg(text: "", path: imagePath, type: "image", isForComplete: false)
                            }
                            else{
                                print("Text==",self.chatTxtView.text as Any)
                                self.sendMsg(text: self.chatTxtView.text, path: imagePath, type: "image", isForComplete: false)
                            }
//                            self.imgSelected.image = nil
//                            self.imgSelected.isHidden = true
//                            self.imgSelected_View.isHidden = true
                        }
                        SVProgressHUD.dismiss()
                    }
                    else {
                        SVProgressHUD.showError(withStatus: message)
                    }
                }
                else {
                    SVProgressHUD.showError(withStatus: error!.localizedDescription)
                }
            })
            LoginAndRegistrationReqModel.sharedModel().progressBlock = { (progress,error,files) -> Void in
                if(Int(progress! * 100) == 100) {
                    uploadProgess = 100
                }
                var msg = ""
                if(uploadProgess == 100) {
                    msg = "Contents \(Int(progress! * 100))%"
                    
                }
                else {
                    msg = "Uploading \(Int(progress! * 100))%"
                }
                SVProgressHUD.showProgress(Float(progress!), status: msg)
                
            }
        }
        
        //MARK: - Send And Receive Chat -
        func getChat()
        {
            let child_ref = "chat_messages/"+"\(self.offer_table_id)"
            ref = Database.database().reference()
            ref.child(child_ref).getData(completion: { error, snapshot in
                guard error == nil else {
                    SVProgressHUD.showError(withStatus: error?.localizedDescription)
                    return
                }
                print(snapshot?.value as Any)
                if let value = snapshot?.value as? NSDictionary
                {
                    self.loadChatMsgs(value: value)
                }
            })
        }
        
        func loadChatMsgs(value: NSDictionary)
        {
            let user = Utility.customObject(forKey: "user")
            self.theData.removeAll()
            self.theData = []
            for (_, val) in value {
                let obj = val as! [String:Any]
                print("obj==",obj as Any)
                var msg = MyMessage()
                if(obj["username"] as? String == user?.username)
                {
                    msg.incoming = false
                }
                else{
                    msg.incoming = true
                    if(user?.id==self.seller_id)
                    {
                        self.sellerName = user!.username
                        self.buyerName = obj["username"] as! String
                    }
                    else
                    {
                        self.sellerName = obj["username"] as! String
                        self.buyerName = user!.username
                    }
                }
                if let type = obj["type"] as? String {
                    msg.type = type
                }
                else {
                    msg.type = "message"
                }
                
                msg.message = obj["message"] as! String
                msg.img_path = obj["path"] as! String
                msg.userName = obj["username"] as! String
                if(obj["time"] != nil)
                {
     
                    self.chatTableView.scrollToBottom()
                }
                
                // MARK: - UIImagePicker Controller Delegate
                func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
                    //        picker.view!.removeFromSuperview()
                    //        picker.removeFromParent()
                    picker.dismiss(animated: true, completion: nil)
                }
                
                func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                    let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage?

                }
                
                
                
                // MARK: - TextView Delegate
                func textViewDidBeginEditing(_ textView: UITextView)
                {
                    self.chatTxtView.textColor = UIColor.black
                    if(self.chatTxtView.text=="Type your message here")
                    {
                        self.chatTxtView_height.constant = 40
                        self.chatTxtView.text = ""
                        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: "")
                        let font = UIFont(name: "Roboto-Regular", size: 18)
                        let color = UIColor.black
                        let valueRange = NSMakeRange(0, 0)
                        attributedString.removeAttribute(.backgroundColor, range: valueRange)
                        self.chatTxtView.attributedText = attributedString
                        self.chatTxtView.font = font
                        let attrs: [NSAttributedString.Key: Any] = [.font: font!, .foregroundColor: color]
                        self.chatTxtView.typingAttributes = attrs
                        self.chatTxtView.becomeFirstResponder()
                        self.viewDidLayoutSubviews()
                    }
                }
                
                func textViewDidEndEditing(_ textView: UITextView)
                {
                    if(self.chatTxtView.text.trim == "")
                    {
                        self.chatTxtView.text="Type your message here"
                        let font = UIFont(name: "Roboto-Regular", size: 15)
                        let color = UIColor.gray
                        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: self.chatTxtView.text)
                        let valueRange = NSMakeRange(0, self.chatTxtView.text.count)
                        attributedString.removeAttribute(.backgroundColor, range: valueRange)
                        self.chatTxtView.attributedText = attributedString
                        self.chatTxtView.font = font
                        let attrs: [NSAttributedString.Key: Any] = [.font: font!, .foregroundColor: color]
                        self.chatTxtView.typingAttributes = attrs
                        self.chatTxtView.textColor = UIColor.gray
                    }
                }
                
                func textViewDidChange(_ textView: UITextView) {
                    self.adjustUITextViewHeight(arg:textView)
                }
                
                func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
                {
                    if let paste = UIPasteboard.general.string, text == paste
                    {
                        print("paste")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1)
                        {
                            self.adjustUITextViewHeight(arg:self.chatTxtView)
                            self.btnSend.isUserInteractionEnabled = true
                        }
                    }
                    else
                    {
                        print("normal typing")
                        print("Number of lines==",self.chatTxtView.numberOfLines() as Any)
                     
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1)
                        {
                            self.adjustUITextViewHeight(arg:self.chatTxtView)
                        }
                        
                    }
                    return true
                }
                
        func calculateHeight(inString:MyMessage) -> CGFloat
                {
                    let cell = chatTableView.dequeueReusableCell(withIdentifier: "ReceiverCell") as! ReceiverCell
                    let label = cell.bubbleView.chatLabel
                    label.font = UIFont(name: "Roboto-Regular", size: 18)
                    let label_frame = NSString(string: inString.message).boundingRect(with: CGSize(width: 0.50 * view.frame.width, height: .infinity), options: [.usesFontLeading, .usesLineFragmentOrigin], attributes: [.font : label.font!], context: nil)
                    let requredSize:CGRect = label_frame
                    return requredSize.height
                }
                
                func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
                    URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
                }
                
            }
        }
    
    @IBAction func btnSend(_ sender: Any)
    {
        
        if sendRecieveChat == true {
            self.chat.append(self.chatTxtView.text)
            sendRecieveChat = false
            isreceive = true
            self.chatTableView.reloadData()
        }
        else {
            self.chat.append(self.chatTxtView.text)
            
            sendRecieveChat = true
            isreceive = false
            self.chatTableView.reloadData()
        }
    }
    

    // MARK: - Adjust TextView Height -
    func adjustUITextViewHeight(arg : UITextView)
    {
        if(self.chatTxtView.text.trim == "" || self.chatTxtView.text! == "Type your message here")
        {
            self.chatTxtView_height.constant = 40
        }
        else
        {
            //            if(self.chatTxtView.numberOfLines() > 0) {
            //                print("height adjusted")
            //                self.chatTxtView_height.constant = arg.contentSize.height+10
            //            }
            if(self.chatTxtView_height.constant<200)
            {
                self.chatTxtView_height.constant = arg.contentSize.height
            }
            self.view.superview?.layoutIfNeeded()
        }
        self.msgAreaView_top.constant = 350
    }
    func insertToUnread()
    {
        let user = Utility.customObject(forKey: "user")
        let user_id = user!.id
        let obj = ["id": self.offer_id,"sender_id":user_id] as [String : Any]
        let child_ref = "new_messages/\(self.seller_id)"
        ref = Database.database().reference()
        ref.child(child_ref).childByAutoId().updateChildValues(obj, withCompletionBlock: { error, result in
            print("Result==",result as Any)
            guard error == nil else {
                print(error!.localizedDescription)
                return;
            }
        })
    }
    func sendMsg(text:String, path:String,type:String, isForComplete:Bool)
    {
        self.chatTxtView.text=""
        self.adjustUITextViewHeight(arg:self.chatTxtView)
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        let utcTimeZoneStr = formatter.string(from: date)
        print("CurrentTime==",utcTimeZoneStr)
        let user = Utility.customObject(forKey: "user")
        let myName = user!.username
        //self.buyer_id = user!.id
        var obj:[String:Any] = [:]
        if(type=="image")
        {
            obj = ["id": user!.id,"message":text,"path":path,"username":myName,"time":utcTimeZoneStr, "type":type] as [String : Any]
        }
        else
        {
            obj = ["id": user!.id,"message":text,"path":"","username":myName,"time":utcTimeZoneStr, "type":type] as [String : Any]
        }
        let child_ref = "chat_messages/"+"\(self.offer_table_id)"
        self.isFromSent = true
        ref = Database.database().reference()
        ref.child(child_ref).childByAutoId().updateChildValues(obj, withCompletionBlock: { error, result in
            print("Result==",result as Any)
            guard error == nil else {
                print(error!.localizedDescription)
                return;
            }
            if(!isForComplete)
            {
                if(text=="This Trade has been reported to admin" || type == "image")
                {
                    
                }
                else
                {
                    self.chatTxtView.becomeFirstResponder()
                }
                self.adjustUITextViewHeight(arg:self.chatTxtView)
                self.insertToUnread()
                self.getChat()
            }
        })
    }

}
extension chat: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.chatTableView.backgroundColor = UIColor.clear
        let text = chat[indexPath.row]
        if isreceive == true {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SenderCell", for: indexPath) as! SenderCell
            cell.textLabel?.numberOfLines = 0
            cell.bubbleView.chatLabel.numberOfLines = 0
            cell.nameLbl.text = ""
            cell.timeLbl.text = ""
            cell.bubbleView.chatLabel.isHidden = false
            cell.bubbleView.imageMsgLabel.isHidden = true
            cell.bubbleView.chatLabel.text = text
            NSLayoutConstraint.activate([
                cell.bubbleView.imageView.heightAnchor.constraint(equalToConstant: 0)
            ])
            cell.bubbleView.imageView.isHidden = true
            cell.bubbleView.incoming = false
            return cell

            
        }
        
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiverCell", for: indexPath) as! ReceiverCell
            cell.textLabel?.numberOfLines = 0
            cell.bubbleView.chatLabel.numberOfLines = 0
            cell.nameLbl.text = ""
            cell.timeLbl.text = ""
            NSLayoutConstraint.activate([
                cell.bubbleView.imageView.heightAnchor.constraint(equalToConstant: 0)
            ])
            cell.bubbleView.chatLabel.isHidden = false
            cell.bubbleView.imageMsgLabel.isHidden = true
            cell.bubbleView.chatLabel.text = text
            cell.bubbleView.imageView.isHidden = true
            cell.bubbleView.incoming = true
            return cell
        }

    }
    
}
