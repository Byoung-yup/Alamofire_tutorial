import UIKit

enum SEGUE_ID {
    static let USER_LIST_VC = "goToUserListVC"
    static let PHOTO_COLLECTION_VC = "goToPhotoCollectionVC"
}

enum API {
    static let BASIC_URL : String = "https://api.unsplash.com/"
    static let CLIENT_ID: String = "7tzh8wmNbmc2lhU3fbiJCZ_NiqX_GszUtWiP_NzpbqI"
}

enum NOTIFICATION {
    enum API {
        static let AUTO_FAIL = "autentication_fail"
    }
}
