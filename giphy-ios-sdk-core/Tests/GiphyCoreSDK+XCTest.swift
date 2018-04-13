//
//  GiphyCoreSDK+XCTest.swift
//  GiphyCoreSDK
//
//  Created by Cem Kozinoglu, Gene Goykhman, Giorgia Marenda on 4/24/17.
//  Copyright © 2017 Giphy. All rights reserved.
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.
//

import XCTest
@testable import GiphyCoreSDK


/// Extension for NSKeyedArchiver/NSKeyedUnarchiver
///
extension XCTestCase {
    
    
    /// Function to test Archiving&Unarchiving an object
    ///
    /// - parameter root: object to archive and unarchive.
    /// - returns: The root object it self, after archiving and unachiving it.
    ///
    func cloneViaCoding<T: NSCoding>(root: T) throws -> T {
        let data = NSKeyedArchiver.archivedData(withRootObject: root)
        guard let res = NSKeyedUnarchiver.unarchiveObject(with: data) as? T else {
            throw NSError(domain: "com.giphy.sdk", code: 100, userInfo: [NSLocalizedDescriptionKey: "Can not unarchive object"])
        }
        return res
    }
}

/// Extension for GPHMedia JSON<>Obj roundtrip check
///
extension XCTestCase {
    
   
    /// Function to test Archiving&Unarchiving an object
    ///
    /// - parameter root: object to check mapping.
    /// - parameter media: sticker/gif to take into account type while serializing/deserializing.
    ///
    func validateJSONForMedia(_ obj: GPHMedia, media: GPHMediaType, request: String) throws {
        
        XCTAssertNotNil(obj.jsonRepresentation, "JSON representation can not be nil")
                       
        XCTAssertEqual(obj.id,
                       obj.jsonRepresentation!["id"] as? String,
                       "Id won't match")

        XCTAssertEqual(obj.url,
                       obj.jsonRepresentation!["url"] as? String,
                       "Url won't match")

        XCTAssertEqual(obj.type.rawValue,
                       media.rawValue,
                       "Media type won't match")
        
        XCTAssertEqual(obj.rating,
                       GPHMedia.parseRating(obj.jsonRepresentation!["rating"] as? String),
                       "Ratings won't match")
        
        XCTAssertEqual(obj.caption,
                       obj.jsonRepresentation!["caption"] as? String,
                       "Caption won't match")
        
        XCTAssertEqual(obj.slug,
                       obj.jsonRepresentation!["slug"] as? String,
                       "Slug won't match")
        
        XCTAssertEqual(obj.importDate,
                       GPHMedia.parseDate(obj.jsonRepresentation!["import_datetime"] as? String),
                       "Import dates won't match")

        XCTAssertEqual(obj.trendingDate,
                       GPHMedia.parseDate(obj.jsonRepresentation!["trending_datetime"] as? String),
                       "Trending dates won't match")
        
        XCTAssertEqual(obj.updateDate,
                       GPHMedia.parseDate(obj.jsonRepresentation!["update_datetime"] as? String),
                       "Update dates won't match")
        
        XCTAssertEqual(obj.createDate,
                       GPHMedia.parseDate(obj.jsonRepresentation!["create_datetime"] as? String),
                       "Create dates won't match")
        
        XCTAssertEqual(obj.indexable,
                       obj.jsonRepresentation!["indexable"] as? String,
                       "Indexable won't match")
        
        XCTAssertEqual(obj.contentUrl,
                       obj.jsonRepresentation!["content_url"] as? String,
                       "Content won't match")
        
        XCTAssertEqual(obj.bitlyUrl,
                       obj.jsonRepresentation!["bitly_url"] as? String,
                       "Bitly won't match")
        
        XCTAssertEqual(obj.bitlyGifUrl,
                       obj.jsonRepresentation!["bitly_gif_url"] as? String,
                       "Bitly Gif won't match")
        
        XCTAssertEqual(obj.embedUrl,
                       obj.jsonRepresentation!["embed_url"] as? String,
                       "Embed won't match")

        XCTAssertEqual(obj.source,
                       obj.jsonRepresentation!["source"] as? String,
                       "Source won't match")
        
        XCTAssertEqual(obj.sourceTld,
                       obj.jsonRepresentation!["source_tld"] as? String,
                       "Source TLD won't match")
        
        XCTAssertEqual(obj.sourcePostUrl,
                       obj.jsonRepresentation!["source_post_url"] as? String,
                       "Source Post Url won't match")
        
        if obj.tags != nil && obj.jsonRepresentation!["tags"] != nil {
            XCTAssertEqual(obj.tags!,
                           (obj.jsonRepresentation!["tags"] as? [String])!,
                           "Tags won't match")
        } else {
            XCTAssertNil(obj.tags, "Tags won't match, expecting a nil")
            XCTAssertNil(obj.jsonRepresentation!["tags"] as? [String], "Tags won't match, expecting a nil")
        }
        
        if obj.featuredTags != nil && obj.jsonRepresentation!["featured_tags"] != nil {
            XCTAssertEqual(obj.featuredTags!,
                           (obj.jsonRepresentation!["featured_tags"] as? [String])!,
                           "Featured tags won't match")
        } else {
            XCTAssertNil(obj.featuredTags, "Featured tags won't match, expecting a nil")
            XCTAssertNil(obj.jsonRepresentation!["featured_tags"] as? [String], "Featured tags won't match, expecting a nil")
        }
        
        XCTAssertEqual(obj.isHidden,
                       obj.jsonRepresentation!["is_hidden"] as? Bool ?? false,
                       "is Hidden won't match")

        XCTAssertEqual(obj.isRemoved,
                       obj.jsonRepresentation!["is_removed"] as? Bool ?? false,
                       "is Removed won't match")
        
        XCTAssertEqual(obj.isCommunity,
                       obj.jsonRepresentation!["is_community"] as? Bool ?? false,
                       "is Community won't match")
        
        XCTAssertEqual(obj.isAnonymous,
                       obj.jsonRepresentation!["is_anonymous"] as? Bool ?? false,
                       "is Anonymous won't match")
        
        XCTAssertEqual(obj.isFeatured,
                       obj.jsonRepresentation!["is_featured"] as? Bool ?? false,
                       "is Featured won't match")
        
        XCTAssertEqual(obj.isRealtime,
                       obj.jsonRepresentation!["is_realtime"] as? Bool ?? false,
                       "is Realtime won't match")

        XCTAssertEqual(obj.isIndexable,
                       obj.jsonRepresentation!["is_indexable"] as? Bool ?? false,
                       "is Indexable won't match")

        XCTAssertEqual(obj.isSticker,
                       obj.jsonRepresentation!["is_sticker"] as? Bool ?? false,
                       "is Sticker won't match")
        
        if obj.jsonRepresentation!["user"] != nil {
            try? self.validateJSONForUser(obj.user!, request: request)
        }

        if obj.jsonRepresentation!["bottle_data"] != nil {
            try? self.validateJSONForBottleData(obj.bottleData!, request: request)
        }
        
        XCTAssertNotNil(obj.images, "Images can not be nil")
        try? self.validateJSONForImages(obj.images!, mediaId: obj.id, media: media, request: request)
        
    }
}


/// Extension for GPHBottleData JSON<>Obj roundtrip check
///
extension XCTestCase {
    
    /// Function to test Archiving&Unarchiving an object
    ///
    /// - parameter obj: object to check mapping.
    /// - parameter request: request type.
    ///
    func validateJSONForBottleData(_ obj: GPHBottleData, request: String) throws {
        
        XCTAssertNotNil(obj.jsonRepresentation, "JSON representation can not be nil")
        
        XCTAssertEqual(obj.tid,
                       obj.jsonRepresentation!["tid"] as? String,
                       "Tid's won't match")
        
    }
    
}

/// Extension for GPHUser JSON<>Obj roundtrip check
///
extension XCTestCase {

    /// Function to test Archiving&Unarchiving an object
    ///
    /// - parameter obj: object to check mapping.
    /// - parameter request: request type.
    ///
    func validateJSONForUser(_ obj: GPHUser, request: String) throws {
        
        XCTAssertNotNil(obj.jsonRepresentation, "JSON representation can not be nil")
        
        XCTAssertEqual(obj.username,
                       obj.jsonRepresentation!["username"] as? String,
                       "Username won't match")
        
        XCTAssertEqual(obj.userId,
                       obj.jsonRepresentation!["id"] as? String,
                       "Id won't match")
        
        XCTAssertEqual(obj.isPublic,
                       obj.jsonRepresentation!["is_public"] as? Bool ?? false,
                       "is Public won't match")

        XCTAssertEqual(obj.suppressChrome,
                       obj.jsonRepresentation!["suppress_chrome"] as? Bool ?? false,
                       "is Public won't match")
        
        XCTAssertEqual(obj.name,
                       obj.jsonRepresentation!["name"] as? String,
                       "Name won't match")
        
        XCTAssertEqual(obj.displayName,
                       obj.jsonRepresentation!["display_name"] as? String,
                       "Display name won't match")

        XCTAssertEqual(obj.userDescription,
                       obj.jsonRepresentation!["user_description"] as? String,
                       "User description won't match")
        
        XCTAssertEqual(obj.attributionDisplayName,
                       obj.jsonRepresentation!["attribution_display_name"] as? String,
                       "Attribution display name won't match")

        XCTAssertEqual(obj.twitter,
                       obj.jsonRepresentation!["twitter"] as? String,
                       "Twitter won't match")
        
        XCTAssertEqual(obj.twitterUrl,
                       obj.jsonRepresentation!["twitter_url"] as? String,
                       "Twitter url won't match")
        
        XCTAssertEqual(obj.facebookUrl,
                       obj.jsonRepresentation!["facebook_url"] as? String,
                       "Facebook url won't match")
        
        XCTAssertEqual(obj.instagramUrl,
                       obj.jsonRepresentation!["instagram_url"] as? String,
                       "Instagram url won't match")
        
        XCTAssertEqual(obj.websiteUrl,
                       obj.jsonRepresentation!["website_url"] as? String,
                       "Website url won't match")
        
        XCTAssertEqual(obj.websiteDisplayUrl,
                       obj.jsonRepresentation!["website_display_url"] as? String,
                       "Website display url won't match")
        
        XCTAssertEqual(obj.tumblrUrl,
                       obj.jsonRepresentation!["tumblr_url"] as? String,
                       "Tumblr url won't match")
        
        XCTAssertEqual(obj.avatarUrl,
                       obj.jsonRepresentation!["avatar_url"] as? String,
                       "Avatar url won't match")
        
        XCTAssertEqual(obj.bannerUrl,
                       obj.jsonRepresentation!["banner_url"] as? String,
                       "Banner url won't match")
        
        XCTAssertEqual(obj.profileUrl,
                       obj.jsonRepresentation!["profile_url"] as? String,
                       "Profile url won't match")
        
    }

}

/// Extension for GPHImages JSON<>Obj roundtrip check
///
extension XCTestCase {
    
    /// Function to test Archiving&Unarchiving an object
    ///
    /// - parameter obj: object to check mapping.
    /// - parameter request: request type.
    ///
    func validateJSONForChannelTag(_ obj: GPHChannelTag, request: String) throws {
        
        XCTAssertNotNil(obj.jsonRepresentation, "JSON representation can not be nil")
        
        XCTAssertEqual(obj.id,
                       obj.jsonRepresentation!["id"] as? Int,
                       "Id won't match")
        
        XCTAssertEqual(obj.tag,
                       obj.jsonRepresentation!["tag"] as? String,
                       "tag field won't match")
        
        XCTAssertEqual(obj.channel,
                       obj.jsonRepresentation!["channel"] as? Int,
                       "channel field won't match")
        
        XCTAssertEqual(obj.rank,
                       obj.jsonRepresentation!["rank"] as? Int,
                       "rank field won't match")
    }
    
}

/// Extension for GPHImages JSON<>Obj roundtrip check
///
extension XCTestCase {
    
    /// Function to test Archiving&Unarchiving an object
    ///
    /// - parameter obj: object to check mapping.
    /// - parameter media: media type.
    /// - parameter request: request type.
    ///
    func validateJSONForChannel(_ obj: GPHChannel, channelId: Int, media: GPHMediaType, request: String) throws {
        
        XCTAssertNotNil(obj.jsonRepresentation, "JSON representation can not be nil")
        
        XCTAssertEqual(obj.id,
                       channelId,
                       "Media Id won't match")
        
        XCTAssertEqual(obj.id,
                       obj.jsonRepresentation!["id"] as? Int,
                       "id field won't match")
        
        XCTAssertEqual(obj.slug,
                       obj.jsonRepresentation!["slug"] as? String,
                       "slug field won't match")
        
        XCTAssertEqual(obj.type,
                       obj.jsonRepresentation!["type"] as? String,
                       "type field won't match")
        
        XCTAssertEqual(obj.contentType,
                       obj.jsonRepresentation!["content_type"] as? String,
                       "content_type field won't match")
        
        XCTAssertEqual(obj.bannerImage,
                       obj.jsonRepresentation!["banner_image"] as? String,
                       "banner_image field won't match")
        
        XCTAssertEqual(obj.displayName,
                       obj.jsonRepresentation!["display_name"] as? String,
                       "display_name field won't match")
        
        XCTAssertEqual(obj.shortDisplayName,
                       obj.jsonRepresentation!["short_display_name"] as? String,
                       "short_display_name field won't match")
        
        XCTAssertEqual(obj.descriptionText,
                       obj.jsonRepresentation!["description"] as? String,
                       "description field won't match")
        
        if obj.jsonRepresentation!["tags"] != nil {
            if let tagsJSON = obj.jsonRepresentation!["tags"] as? [GPHChannelTag] {
                XCTAssertEqual(obj.tags!.count,
                               tagsJSON.count,
                               "Tags count is not matching")
                obj.tags?.forEach({ tag in
                    try? self.validateJSONForChannelTag(tag, request: request)
                })
            }
        }
        
        if obj.jsonRepresentation!["user"] != nil {
            try? self.validateJSONForUser(obj.user!, request: request)
        }
    }
    
}

/// Extension for GPHImages JSON<>Obj roundtrip check
///
extension XCTestCase {
    
    /// Function to test Archiving&Unarchiving an object
    ///
    /// - parameter obj: object to check mapping.
    /// - parameter media: media type.
    /// - parameter request: request type.
    ///
    func validateJSONForImages(_ obj: GPHImages, mediaId: String, media: GPHMediaType, request: String) throws {
        
        XCTAssertNotNil(obj.jsonRepresentation, "JSON representation can not be nil")
        
        XCTAssertEqual(obj.mediaId,
                       mediaId,
                       "Media Id won't match")
        
        switch request {
        case "search", "get", "getAll", "translate", "categoryContent", "channel", "channelContent", "channelChildren":
            try? self.validateJSONForImage(obj.original!, mediaId: mediaId, rendition: .original, media: media, request: request)
            try? self.validateJSONForImage(obj.originalStill!, mediaId: mediaId, rendition: .originalStill, media: media, request: request)
            try? self.validateJSONForImage(obj.preview!, mediaId: mediaId, rendition: .preview, media: media, request: request)
            try? self.validateJSONForImage(obj.looping!, mediaId: mediaId, rendition: .looping, media: media, request: request)
            try? self.validateJSONForImage(obj.fixedHeight!, mediaId: mediaId, rendition: .fixedHeight, media: media, request: request)
            try? self.validateJSONForImage(obj.fixedHeightStill!, mediaId: mediaId, rendition: .fixedHeightStill, media: media, request: request)
            try? self.validateJSONForImage(obj.fixedHeightDownsampled!, mediaId: mediaId, rendition: .fixedHeightDownsampled, media: media, request: request)
            try? self.validateJSONForImage(obj.fixedHeightSmall!, mediaId: mediaId, rendition:.fixedHeightSmall, media: media, request: request)
            try? self.validateJSONForImage(obj.fixedHeightSmallStill!, mediaId: mediaId, rendition: .fixedHeightSmallStill, media: media, request: request)
            try? self.validateJSONForImage(obj.fixedWidth!, mediaId: mediaId, rendition: .fixedWidth, media: media, request: request)
            try? self.validateJSONForImage(obj.fixedWidthStill!, mediaId: mediaId, rendition: .fixedWidthStill, media: media, request: request)
            try? self.validateJSONForImage(obj.fixedWidthDownsampled!, mediaId: mediaId, rendition: .fixedWidthDownsampled, media: media, request: request)
            try? self.validateJSONForImage(obj.fixedWidthSmall!, mediaId: mediaId, rendition: .fixedWidthSmall, media: media, request: request)
            try? self.validateJSONForImage(obj.fixedWidthSmallStill!, mediaId: mediaId, rendition: .fixedWidthSmallStill, media: media, request: request)
            try? self.validateJSONForImage(obj.downsized!, mediaId: mediaId, rendition: .downsized, media: media, request: request)
            try? self.validateJSONForImage(obj.downsizedSmall!, mediaId: mediaId, rendition: .downsizedSmall, media: media, request: request)
            try? self.validateJSONForImage(obj.downsizedMedium!, mediaId: mediaId, rendition: .downsizedMedium, media: media, request: request)
            try? self.validateJSONForImage(obj.downsizedLarge!, mediaId: mediaId, rendition: .downsizedLarge, media: media, request: request)
            try? self.validateJSONForImage(obj.downsizedStill!, mediaId: mediaId, rendition: .downsizedStill, media: media, request: request)
        case "trending":
            try? self.validateJSONForImage(obj.original!, mediaId: mediaId, rendition: .original, media: media, request: request)
            try? self.validateJSONForImage(obj.originalStill!, mediaId: mediaId, rendition: .originalStill, media: media, request: request)
            try? self.validateJSONForImage(obj.looping!, mediaId: mediaId, rendition: .looping, media: media, request: request)
            try? self.validateJSONForImage(obj.fixedHeight!, mediaId: mediaId, rendition: .fixedHeight, media: media, request: request)
            try? self.validateJSONForImage(obj.fixedHeightStill!, mediaId: mediaId, rendition: .fixedHeightStill, media: media, request: request)
            try? self.validateJSONForImage(obj.fixedHeightDownsampled!, mediaId: mediaId, rendition: .fixedHeightDownsampled, media: media, request: request)
            try? self.validateJSONForImage(obj.fixedHeightSmall!, mediaId: mediaId, rendition:.fixedHeightSmall, media: media, request: request)
            try? self.validateJSONForImage(obj.fixedHeightSmallStill!, mediaId: mediaId, rendition: .fixedHeightSmallStill, media: media, request: request)
            try? self.validateJSONForImage(obj.fixedWidth!, mediaId: mediaId, rendition: .fixedWidth, media: media, request: request)
            try? self.validateJSONForImage(obj.fixedWidthStill!, mediaId: mediaId, rendition: .fixedWidthStill, media: media, request: request)
            try? self.validateJSONForImage(obj.fixedWidthDownsampled!, mediaId: mediaId, rendition: .fixedWidthDownsampled, media: media, request: request)
            try? self.validateJSONForImage(obj.fixedWidthSmall!, mediaId: mediaId, rendition: .fixedWidthSmall, media: media, request: request)
            try? self.validateJSONForImage(obj.fixedWidthSmallStill!, mediaId: mediaId, rendition: .fixedWidthSmallStill, media: media, request: request)
            try? self.validateJSONForImage(obj.downsized!, mediaId: mediaId, rendition: .downsized, media: media, request: request)
            try? self.validateJSONForImage(obj.downsizedMedium!, mediaId: mediaId, rendition: .downsizedMedium, media: media, request: request)
            try? self.validateJSONForImage(obj.downsizedLarge!, mediaId: mediaId, rendition: .downsizedLarge, media: media, request: request)
            try? self.validateJSONForImage(obj.downsizedStill!, mediaId: mediaId, rendition: .downsizedStill, media: media, request: request)
        case "random":
            try? self.validateJSONForImage(obj.original!, mediaId: mediaId, rendition: .original, media: media, request: request)
            try? self.validateJSONForImage(obj.fixedHeightDownsampled!, mediaId: mediaId, rendition: .fixedHeightDownsampled, media: media, request: request)
            try? self.validateJSONForImage(obj.fixedWidthDownsampled!, mediaId: mediaId, rendition: .fixedWidthDownsampled, media: media, request: request)
            try? self.validateJSONForImage(obj.fixedHeightSmall!, mediaId: mediaId, rendition:.fixedHeightSmall, media: media, request: request)
            try? self.validateJSONForImage(obj.fixedWidthSmall!, mediaId: mediaId, rendition: .fixedWidthSmall, media: media, request: request)
        default:
            XCTFail("Failed due to an unsupported request type")
        }
        
    }
    
}

/// Extension for GPHImage JSON<>Obj roundtrip check
///
extension XCTestCase {
    
    /// Function to test Archiving&Unarchiving an object
    ///
    /// - parameter obj: object to check mapping.
    /// - parameter mediaId: media id.
    /// - parameter rendition: media rendition.
    /// - parameter media: media type.
    /// - parameter request: request type.
    ///
    func validateJSONForImage(_ obj: GPHImage, mediaId: String, rendition: GPHRenditionType, media: GPHMediaType, request: String) throws {
        
        XCTAssertNotNil(obj.jsonRepresentation, "JSON representation can not be nil")
        
        XCTAssertEqual(obj.mediaId,
                       mediaId,
                       "Media Id won't match")

        XCTAssertEqual(obj.rendition,
                       rendition,
                       "Rendition type won't match")
        
        XCTAssertEqual(obj.gifUrl,
                       obj.jsonRepresentation!["url"] as? String,
                       "Url won't match")
        
        XCTAssertEqual(obj.stillGifUrl,
                       obj.jsonRepresentation!["still_url"] as? String,
                       "Still Gif Url won't match")
        
        XCTAssertEqual(obj.gifSize,
                       GPHImage.parseInt(obj.jsonRepresentation!["size"] as? String) ?? 0,
                       "Gif size won't match")

        XCTAssertEqual(obj.width,
                       GPHImage.parseInt(obj.jsonRepresentation!["width"] as? String) ?? 0,
                       "Gif width won't match")
        
        XCTAssertEqual(obj.height,
                       GPHImage.parseInt(obj.jsonRepresentation!["height"] as? String) ?? 0,
                       "Gif height won't match")
        
        XCTAssertEqual(obj.frames,
                       GPHImage.parseInt(obj.jsonRepresentation!["frames"] as? String) ?? 0,
                       "Gif frames won't match")
        
        XCTAssertEqual(obj.webPUrl,
                       obj.jsonRepresentation!["webp"] as? String,
                       "WebP url won't match")
        
        XCTAssertEqual(obj.webPSize,
                       GPHImage.parseInt(obj.jsonRepresentation!["webp_size"] as? String) ?? 0,
                       "WebP size won't match")
        
        XCTAssertEqual(obj.mp4Url,
                       obj.jsonRepresentation!["mp4"] as? String,
                       "Mp4 url won't match")
        
        XCTAssertEqual(obj.mp4Size,
                       GPHImage.parseInt(obj.jsonRepresentation!["mp4_size"] as? String) ?? 0,
                       "Mp4 size frames won't match")
        
    }
    
}

/// Extension for GPHCategory JSON<>Obj roundtrip check
///
extension XCTestCase {
    
    /// Function to test Archiving&Unarchiving an object
    ///
    /// - parameter obj: object to check mapping.
    /// - parameter root: root object to check mapping.
    /// - parameter request: request type.
    ///
    func validateJSONForCategory(_ obj: GPHCategory, root: GPHCategory?, request: String) throws {
        
        XCTAssertNotNil(obj.jsonRepresentation, "JSON representation can not be nil")
        
        XCTAssertEqual(obj.name,
                       obj.jsonRepresentation!["name"] as? String,
                       "Names won't match")
        
        XCTAssertEqual(obj.nameEncoded,
                       obj.jsonRepresentation!["name_encoded"] as? String,
                       "Encoded names won't match")
        
        
        if obj.jsonRepresentation!["gif"] != nil {
            try? self.validateJSONForMedia(obj.gif!, media: .gif, request: "search")
        }
        
        switch request {
        case "categories":
            
            XCTAssertNotNil(obj.encodedPath, "Encoded path is nil")
            XCTAssertEqual(obj.encodedPath,
                           obj.nameEncoded,
                           "Encoded name and path won't match")
            
            if let subCategoriesJSON = obj.jsonRepresentation!["subcategories"] as? [GPHJSONObject] {
                
                XCTAssertNotNil(obj.subCategories, "Subcategories can not be nil")
                XCTAssertEqual(obj.subCategories!.count,
                               subCategoriesJSON.count,
                               "Subcategory count is not matching")
                
                
                obj.subCategories?.forEach({ subcat in
                    try? self.validateJSONForCategory(subcat, root: obj, request: "subCategories")
                })
                
            }
            
        case "subCategories":
            if let root = root {
                XCTAssertEqual(obj.encodedPath,
                              root.nameEncoded + "/" + obj.nameEncoded,
                               "Encoded paths won't match")
                
            } else {
                XCTFail("You need to root category to get sub-categories")
            }
            
        default:
            XCTFail("Request type is not valid for Categories")
        }
        
    }
    
}

/// Extension for GPHTermSuggestion JSON<>Obj roundtrip check
///
extension XCTestCase {
    
    /// Function to test Archiving&Unarchiving an object
    ///
    /// - parameter obj: object to check mapping.
    /// - parameter request: request type.
    ///
    func validateJSONForTerm(_ obj: GPHTermSuggestion, request: String) throws {
        
        XCTAssertNotNil(obj.jsonRepresentation, "JSON representation can not be nil")
        
        XCTAssertEqual(obj.term,
                       obj.jsonRepresentation!["name"] as? String,
                       "Terms won't match")
        
    }
    
}



// Including this to trick XCode, so we can get to see this class listed in Tests menu
class GiphyCoreSDKExtensions: XCTestCase { }
