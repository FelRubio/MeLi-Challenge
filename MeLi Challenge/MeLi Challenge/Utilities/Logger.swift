//
//  Logger.swift
//  MeLi Challenge
//
//  Created by Felipe on 2/06/24.
//

import Foundation
/// Represents the different levels of loggin.
enum LogLevel: String {
    case debug, info, error
}

/// A utility class for loggin messages with different levels of severity.
class Logger {
    /// The current allowed log level, determined by environment variables or build configuration.
    static var logLevel: LogLevel = {
        // Sets the log level based on the environment variable "LOG_LEVEL" that is on the .xconfig file
        if let logLevel: String = try? Configuration.value(for: "LOG_LEVEL"),
               let level = LogLevel(rawValue: logLevel.lowercased()) {
            return level
        }

        // Sets the log level based on the current build configuration.
        // A fail safe if the key or the .xconfig file is missing.
        #if DEBUG
        return .debug
        #elseif RELEASE_DEV
        return .debug
        #elseif RELEASE_QA
        return .info
        #elseif RELEASE_PROD
        return .error
        #else
        // Return the minimum log level by default.
        return .error
        #endif
    }()

    /// Logs a message with the specified log level.
    ///
    /// - Parameters:
    ///   - message: The message to be logged.
    ///   - level: The level of the log message. Defaults to `.debug`.
    static func log(_ message: String, level: LogLevel = .debug) {
        guard shouldLog(level: level) else { return }
        print("[\(level.rawValue.uppercased())] \(message)")
    }

    /// Determines whether a message with the specified log level should be logged.
    ///
    /// - Parameter level: The level of the log message.
    /// - Returns: A boolean indicating whether the message should be logged.
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
