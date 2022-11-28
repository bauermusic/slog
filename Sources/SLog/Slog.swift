//
//  Logger.swift
//  DevicePosition6O6Rod
//
//  Created by Rod Bauer on 08/11/2022.
//

import Foundation

public class SLog {
    
    /// If true, will print the function signature at the end, otherwise, will end with the class name.
    private static let printFunc = false
    
    /// If true, will print the time stamp at the begining.
    private static let printTimestamp = true
    
    //STAGE - Log print. On release, logPrintsToFile should be false
    /// If true, will write logs to a file in the documents directory.
    static private var dateFormatter: DateFormatter = {
        
        let _dateFormatter = DateFormatter()
        _dateFormatter.dateFormat = "HH:mm:ss.SSS"
        
        return _dateFormatter
    }()
    
    public static func p(_ any: Any?..., line: Int = #line, file: String = #file, strFunc: String = #function) {
        SLog.pExp(any, line: line, file: file, strFunc: strFunc)
    }
    
    static private func pExp(_ any: [Any?], line: Int, file: String, strFunc: String) {
        
#if DEBUG
#else
        return
#endif
        
        let callStr = printFunc ? "\(file.shortFileName): \(strFunc)" : file.shortFileName
        
        let timeStamp = SLog.printTimestamp ? "[\(SLog.dateFormatter.string(from: Date()))]" : ""
        
        var printString: String
        
        let message = stringDescription(message: any)
        printString = "LOG\(timeStamp): \"\(message)\". \(callStr) (\(line))"
        
        print(printString)
    }
    
    private static func stringDescription(message: [Any?]) -> String {
        message
            .map({ $0 ?? "nil" })
            .reduce("", { "\($0)" == "" ? "\($1)" : "\($0) \($1)" })
    }
}

private extension String {
    
    var shortFileName: Self {
        let fn = self.split(separator: "/").last ??  "-"
        
        if fn.count > 6 {
            // Cut out '.swift'
            return String(fn[..<fn.index(fn.endIndex, offsetBy: -6)])
        }
        return String(fn)
    }
}
