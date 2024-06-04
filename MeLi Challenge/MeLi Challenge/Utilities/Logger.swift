//
//  Logger.swift
//  MeLi Challenge
//
//  Created by Felipe on 2/06/24.
//

import Foundation

enum LogLevel: String {
    case debug, info, error
}

class Logger {
    static var logLevel: LogLevel = {
        if let logLevel: String = try? Configuration.value(for: "LOG_LEVEL"),
               let level = LogLevel(rawValue: logLevel.lowercased()) {
            return level
        }

        #if DEBUG
        return .debug
        #elseif RELEASE_DEV
        return .debug
        #elseif RELEASE_QA
        return .info
        #elseif RELEASE_PROD
        return .error
        #else
        return .error
        #endif
    }()

    static func log(_ message: String, level: LogLevel = .debug) {
        guard shouldLog(level: level) else { return }
        print("[\(level.rawValue.uppercased())] \(message)")
    }

    private static func shouldLog(level: LogLevel) -> Bool {
        switch (logLevel, level) {
        case (.debug, _),
             (.info, .info), (.info, .error),
             (.error, .error):
            return true
        default:
            return false
        }
    }
}
