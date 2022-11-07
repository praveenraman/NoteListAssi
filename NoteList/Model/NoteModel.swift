//
//  NoteModel.swift
//  NoteList
//
//  Created by Admin on 05/11/22.
//

import Foundation
//Decodable
protocol ParsableProtocol{
    init(responseDict :Dictionary<String, AnyObject>);
}

struct NoteList: ParsableProtocol{
    var noteData = [NoteData]()
    init(responseDict: Dictionary<String, AnyObject>) {
        if let array = responseDict["NoteData"] as? NSArray{
            for dict in array {
                if let respDict:NSDictionary = dict as? NSDictionary{
                    if let respModal = respDict as? [String : AnyObject]{
                        self.noteData.append(NoteData.init(responseDict: respModal))
                    }
                }
            }
        }
    }
}

struct NoteData: ParsableProtocol{
    var id: Int = 0
    var address: String = ""
    var avgRating: Double = 0.0
    var coverPicId: String = ""
    var description: String = ""
    var headLine: String = ""
    var suggestedAsAdvertisedHotspot: Bool = false
    var hotSpotUserStatus: Bool = false
    var noteForHotSpotLocation: Bool = false
    var isPublished: Bool = false
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var postedDate: String = ""
    var privacy: Int = 0
    var shareable: Bool = false
    var updatedDate: String = ""
    var regionId: Int = 0
    var isDeletable: Bool = false
    var isEditable: Bool = false
    var notePoint: Double = 0.0
    var tags = [Tag]()
    var uploads = [Uploads]()
    var coverPic: CoverPic!
    var userDetails: UserDetails!
    var noteLike = [NoteLike]()
    var weight: Int = 0
    var favoriteStatus: Bool = false
    var status : Bool = false
    var commentsCount: Int = 0
    var count : Int = 0
    var userRating : Int = 0
    var favoriteId : Int = 0
    var reported : Bool = false
    var hotspotRejected : Bool = false
    var published : Bool = false
    var deletable : Bool = false
    var editable : Bool = false
    var noteDate : String = ""
    var hotSpot : Bool = false
    var isHotspotRejected : Bool = false
    var landMark : String = ""
    
    init(responseDict: Dictionary<String, AnyObject>){
        if let result = responseDict["favoriteId"] as? Int{
            self.favoriteId = result
        }
        if let result = responseDict["userRating"] as? Int{
            self.userRating = result
        }
        if let result = responseDict["count"] as? Int{
            self.count = result
        }
        if let result = responseDict["commentsCount"] as? Int{
            self.commentsCount = result
        }
        if let result = responseDict["favoriteStatus"] as? Bool{
            self.favoriteStatus = result
        }
        if let result = responseDict["status"] as? Bool{
            self.status = result
        }
        if let result = responseDict["weight"] as? Int{
            self.weight = result
        }
        if let result = responseDict["reported"] as? Bool{
            self.reported = result
        }
        if let result = responseDict["hotspotRejected"] as? Bool{
            self.hotspotRejected = result
        }
        if let result = responseDict["published"] as? Bool{
            self.published = result
        }
        if let result = responseDict["deletable"] as? Bool{
            self.deletable = result
        }
        if let result = responseDict["editable"] as? Bool{
            self.editable = result
        }
        if let result = responseDict["noteDate"] as? String{
            self.noteDate = result
        }
        if let result = responseDict["hotSpot"] as? Bool{
            self.hotSpot = result
        }
        if let result = responseDict["isHotspotRejected"] as? Bool{
            self.isHotspotRejected = result
        }
        if let result = responseDict["landMark"] as? String{
            self.landMark = result
        }
        if let result = responseDict["id"] as? Int{
            self.id = result
        }
        if let result = responseDict["address"] as? String{
            self.address = NSString(string: result).removingPercentEncoding!
        }
        if let result = responseDict["avgRating"] as? Double{
            self.avgRating = result
        }
        if let result = responseDict["coverPicId"] as? String{
            self.coverPicId = result
        }
        if let result = responseDict["description"] as? String{
            self.description = NSString(string: result).removingPercentEncoding!
        }
        if let result = responseDict["headLine"] as? String{
            self.headLine = NSString(string: result).removingPercentEncoding!
        }
        if let result = responseDict["suggestedAsAdvertisedHotspot"] as? Bool{
            self.suggestedAsAdvertisedHotspot = result
        }
        if let result = responseDict["hotSpotUserStatus"] as? Bool{
            self.hotSpotUserStatus = result
        }
        if let result = responseDict["noteForHotSpotLocation"] as? Bool{
            self.noteForHotSpotLocation = result
        }
        if let result = responseDict["isPublished"] as? Bool{
            self.isPublished = result
        }
        if let result = responseDict["latitude"] as? Double{
            self.latitude = result
        }
        if let result = responseDict["longitude"] as? Double{
            self.longitude = result
        }
        if let result = responseDict["postedDate"] as? String{
            self.postedDate = result
        }
        if let result = responseDict["privacy"] as? Int{
            self.privacy = result
        }
        if let result = responseDict["shareable"] as? Bool{
            self.shareable = result
        }
        if let result = responseDict["updatedDate"] as? String{
            self.updatedDate = result
        }
        if let result = responseDict["regionId"] as? Int{
            self.regionId = result
        }
        if let result = responseDict["isDeletable"] as? Bool{
            self.isDeletable = result
        }
        if let result = responseDict["isEditable"] as? Bool{
            self.isEditable = result
        }
        if let result = responseDict["notePoint"] as? Double{
            self.notePoint = result
        }
        if let array = responseDict["tags"] as? NSArray{
            for dict in array {
                if let respDict:NSDictionary = dict as? NSDictionary{
                    if let respModal = respDict as? [String : AnyObject]{
                        self.tags.append(Tag.init(responseDict: respModal))
                    }
                }
            }
        }
        if let array = responseDict["uploads"] as? NSArray{
            for dict in array {
                if let respDict:NSDictionary = dict as? NSDictionary{
                    if let respModal = respDict as? [String : AnyObject]{
                        self.uploads.append(Uploads.init(responseDict: respModal))
                    }
                }
            }
        }
        if let respVal = responseDict["coverPic"] as? NSDictionary{
            self.coverPic = CoverPic.init(responseDict: (respVal as? [String : AnyObject])!)
        }
        if let respVal = responseDict["userDetails"] as? NSDictionary{
            self.userDetails = UserDetails.init(responseDict: (respVal as? [String : AnyObject])!)
        }
        if let array = responseDict["noteLike"] as? NSArray{
            for dict in array {
                if let respDict:NSDictionary = dict as? NSDictionary{
                    if let respModal = respDict as? [String : AnyObject]{
                        self.noteLike.append(NoteLike.init(responseDict: respModal))
                    }
                }
            }
        }
    }
}
struct Tag: ParsableProtocol {
    var id: Int = 0
    var name: String = ""
    
    init(responseDict: Dictionary<String, AnyObject>) {
        if let result = responseDict["id"] as? Int{
            self.id = result
        }
        if let result = responseDict["name"] as? String{
            self.name = NSString(string: result).removingPercentEncoding!
        }
    }
}
struct Uploads: ParsableProtocol {
    var id: Int = 0
    var contentType: String = ""
    var createdDate: String = ""
    var description: String = ""
    var fileName: String = ""
    var fileSize: Int = 0
    var updatedDate: String = ""
    var url: String = ""
    var thumbnailUrl: String = ""
    var orderNo: Int = 0
    
    init(responseDict: Dictionary<String, AnyObject>) {
        if let result = responseDict["id"] as? Int{
            self.id = result
        }
        if let result = responseDict["contentType"] as? String{
            self.contentType = result
        }
        if let result = responseDict["createdDate"] as? String{
            self.createdDate = result
        }
        if let result = responseDict["description"] as? String{
            self.description = result
        }
        if let result = responseDict["fileName"] as? String{
            self.fileName = result
        }
        if let result = responseDict["fileSize"] as? Int{
            self.fileSize = result
        }
        if let result = responseDict["updatedDate"] as? String{
            self.updatedDate = result
        }
        if let result = responseDict["url"] as? String{
            self.url = result
        }
        if let result = responseDict["thumbnailUrl"] as? String{
            self.thumbnailUrl = result
        }
        if let result = responseDict["orderNo"] as? Int{
            self.orderNo = result
        }
    }
}
struct CoverPic: ParsableProtocol {
    var id: Int = 0
    var contentType: String = ""
    var createdDate: String = ""
    var description: String = ""
    var fileName: String = ""
    var fileSize: Int = 0
    var updatedDate: String = ""
    var url: String = ""
    
    init(responseDict: Dictionary<String, AnyObject>) {
        if let result = responseDict["id"] as? Int{
            self.id = result
        }
        if let result = responseDict["contentType"] as? String{
            self.contentType = result
        }
        if let result = responseDict["createdDate"] as? String{
            self.createdDate = result
        }
        if let result = responseDict["description"] as? String{
            self.description = result
        }
        if let result = responseDict["fileName"] as? String{
            self.fileName = result
        }
        if let result = responseDict["fileSize"] as? Int{
            self.fileSize = result
        }
        if let result = responseDict["updatedDate"] as? String{
            self.updatedDate = result
        }
        if let result = responseDict["url"] as? String{
            self.url = result
        }
    }
}

struct UserDetails: ParsableProtocol {
    var id: Int = 0
    var aboutUs: String = ""
    var activationStatus: Bool = false
    var userActivationStatus: Bool = false
    var additionalDetails: String = ""
    var createdDate: String = ""
    var updatedDate: String = ""
    var dob: String = ""
    var email: String = ""
    var mobile: Int = 0
    var favCuisines: String = ""
    var fbId: String = ""
    var friendsVisiblityStatus: Bool = false
    var gender: String = ""
    var googleId: String = ""
    var interests: String = ""
    var location: String = ""
    var name: String = ""
    var uploadId: Int = 0
    var userType: Int = 0
    var userPrefrenceStatus: Int = 0
    var userPrivacy: Int = 0
    var wifiOnly: Bool = false
    var notificationTone: Bool = false
    var vibration: Bool = false
    var userPoint: Int = 0
    var totalFriends: Int = 0
    var hasPassword: Bool = false
    var firstTimeRegistration: Bool = false
    var reported: Bool = false
    var deviceId: String = ""
    
    init(responseDict: Dictionary<String, AnyObject>) {
        if let result = responseDict["mobile"] as? Int{
            self.mobile = result
        }
        if let result = responseDict["id"] as? Int{
            self.id = result
        }
        if let result = responseDict["aboutUs"] as? String{
            self.aboutUs = NSString(string: result).removingPercentEncoding!
        }
        if let result = responseDict["activationStatus"] as? Bool{
            self.activationStatus = result
        }
        if let result = responseDict["userActivationStatus"] as? Bool{
            self.userActivationStatus = result
        }
        if let result = responseDict["additionalDetails"] as? String{
            self.additionalDetails = result
        }
        if let result = responseDict["createdDate"] as? String{
            self.createdDate = result
        }
        if let result = responseDict["updatedDate"] as? String{
            self.updatedDate = result
        }
        if let result = responseDict["dob"] as? String{
            self.dob = result
        }
        if let result = responseDict["email"] as? String{
            self.email = NSString(string: result).removingPercentEncoding!
        }
        if let result = responseDict["favCuisines"] as? String{
            self.favCuisines = result
        }
        if let result = responseDict["fbId"] as? String{
            self.fbId = result
        }
        if let result = responseDict["friendsVisiblityStatus"] as? Bool{
            self.friendsVisiblityStatus = result
        }
        if let result = responseDict["gender"] as? String{
            self.gender = result
        }
        if let result = responseDict["igoogleIdd"] as? String{
            self.googleId = result
        }
        if let result = responseDict["interests"] as? String{
            self.interests = result
        }
        if let result = responseDict["location"] as? String{
            self.location = result
        }
        if let result = responseDict["name"] as? String{
            self.name = NSString(string: result).removingPercentEncoding!
        }
        if let result = responseDict["uploadId"] as? Int{
            self.uploadId = result
        }
        if let result = responseDict["userType"] as? Int{
            self.userType = result
        }
        if let result = responseDict["userPrefrenceStatus"] as? Int{
            self.userPrefrenceStatus = result
        }
        if let result = responseDict["userPrivacy"] as? Int{
            self.userPrivacy = result
        }
        if let result = responseDict["wifiOnly"] as? Bool{
            self.wifiOnly = result
        }
        if let result = responseDict["notificationTone"] as? Bool{
            self.notificationTone = result
        }
        if let result = responseDict["vibration"] as? Bool{
            self.vibration = result
        }
        if let result = responseDict["userPoint"] as? Int{
            self.userPoint = result
        }
        if let result = responseDict["deviceId"] as? String{
            self.deviceId = result
        }
        if let result = responseDict["reported"] as? Bool{
            self.reported = result
        }
        if let result = responseDict["firstTimeRegistration"] as? Bool{
            self.firstTimeRegistration = result
        }
        if let result = responseDict["hasPassword"] as? Bool{
            self.hasPassword = result
        }
        if let result = responseDict["totalFriends"] as? Int{
            self.totalFriends = result
        }
    }
}

struct NoteLike: ParsableProtocol {
    var id: Int = 0
    var userDetails = [UserDetails]()
    init(responseDict: Dictionary<String, AnyObject>) {
        if let result = responseDict["id"] as? Int{
            self.id = result
        }
        if let array = responseDict["userDetails"] as? NSArray{
            for dict in array {
                if let respDict:NSDictionary = dict as? NSDictionary{
                    if let respModal = respDict as? [String : AnyObject]{
                        self.userDetails.append(UserDetails.init(responseDict: respModal))
                    }
                }
            }
        }
    }
}
