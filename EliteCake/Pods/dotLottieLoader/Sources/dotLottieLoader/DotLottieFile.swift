//
//  DotLottieFile.swift
//  LottieFiles
//
//  Created by Evandro Harrison Hoffmann on 27/06/2020.
//  Copyright © 2020 LottieFiles. All rights reserved.
//

import Foundation
import Zip

/// Detailed .lottie file structure
public struct DotLottieFile {
    public let remoteUrl: URL
    public let localUrl: URL
    
    public static let manifestFileName: String = "manifest.json"
    public static let animationsFolderName: String = "animations"
    public static let imagesFolderName: String = "images"
    
    /// Manifest.json file loading
    public var manifest: DotLottieManifest? {
        let path = localUrl.appendingPathComponent(DotLottieFile.manifestFileName)
        return try? DotLottieManifest.load(from: path)
    }
    
    /// Animation url for main animation
    public var animationUrl: URL? {
        guard let animationId = manifest?.animations.first?.id else { return nil }
        let dotLottieJson = "\(DotLottieFile.animationsFolderName)/\(animationId).json"
        return localUrl.appendingPathComponent(dotLottieJson)
    }
    
    /// Animations folder url
    public var animationsUrl: URL {
        localUrl.appendingPathComponent("\(DotLottieFile.animationsFolderName)")
    }
    
    /// All files in animations folder
    public var animations: [URL] {
        FileManager.default.urls(for: animationsUrl) ?? []
    }
    
    /// Images folder url
    public var imagesUrl: URL {
        localUrl.appendingPathComponent("\(DotLottieFile.imagesFolderName)")
    }
    
    /// All images in images folder
    public var images: [URL] {
        FileManager.default.urls(for: imagesUrl) ?? []
    }
    
    /// Constructor with url.
    /// Returns nil if is not a .lottie file and decompression failed
    /// - Parameters:
    ///   - url: URL to .lottie file
    ///   - cache: Cache type 
    public init?(url: URL, cache: DotLottieCache) {
        self.remoteUrl = url
        self.localUrl = DotLottieUtils.animationsDirectoryURL(for: url)
        
        guard url.isDotLottieFile else { return nil }
        guard decompress(from: url, in: localUrl, cache: cache) else { return nil }
    }
    
    /// Decompresses .lottie file and saves to local temp folder
    /// - Parameters:
    ///   - url: url to .lottie file
    ///   - directory: url to destination of decompression contents
    ///   - cache: Cache type   
    /// - Returns: success true/false
    private func decompress(from url: URL, in directory: URL, cache: DotLottieCache) -> Bool {
        do {
            try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)
            Zip.addCustomFileExtension(DotLottieUtils.dotLottieExtension)
            try Zip.unzipFile(url, destination: directory, overwrite: true, password: nil)
            DotLottieUtils.log("File decompressed to \(directory.path)")
            return true
        } catch {
            DotLottieUtils.log("Extraction of dotLottie archive failed with error: \(error)")
            return false
        }
    }
}

