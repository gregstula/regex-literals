//: Playground - noun: a place where people can play

import AppKit

class RegexLiteral {

    var isPostfixOperatorSet: Bool = false
    let foundationRegex: NSRegularExpression
    
    init(pattern: String, options: RegexLiteralOptions, postfix:Bool) throws {
        do {
            try foundationRegex = NSRegularExpression(pattern: pattern, options: options.opt)
        } catch let err {
            foundationRegex = NSRegularExpression()
            throw err
        }
        isPostfixOperatorSet = postfix
    }
   
    init(pattern: String, options: NSRegularExpressionOptions, postfix:Bool) throws {
        do {
            try foundationRegex = NSRegularExpression(pattern: pattern, options: options)
        } catch let err {
            foundationRegex = NSRegularExpression()
            throw err
        }
        isPostfixOperatorSet = postfix
    }
    
    enum SyntaxError: ErrorType {
        case MissingPostfix(String)
        case BadNSRegularExpression
    }
    
    enum RegexLiteralOptions {
        case g
        case i
        case o
        case x
        case m
        case u
        case e
        case n
        case delivery(NSRegularExpressionOptions)
    }
}

extension RegexLiteral.RegexLiteralOptions {
    enum Error: ErrorType {
       case NotAnOption(NSString)
    }

    init(char:Character) throws {
        switch char {
            case "g":
                self = .g
            case "i":
                self = .i
            case "o":
                self = .o
            case "x":
                self = .x
            case "m":
                self = .m
            case "u":
                self = .u
            case "e":
                self = .e
            case "n":
                self = .n
            default:
                throw Error.NotAnOption("\(char) is not a valid timtowdti-regex-literals flag")
        }
    }
    
    private var char:Character {
        switch self {
            case .g:
                return "g"
            case .i:
                return "i"
             case .o:
                return "o"
            case .x:
                return "x"
            case .m:
                return "m"
            case u:
                return "u"
            case e:
                return "e"
            case n:
                return "n"
            default:
                return " "
        }
    }
    
    private var opt:NSRegularExpressionOptions {
        switch self {
            case .i:
                return .CaseInsensitive
            case .x:
                return .AllowCommentsAndWhitespace
            case .m:
                return .UseUnixLineSeparators
            case .u:
                return .UseUnicodeWordBoundaries
            case .delivery(let package):
                return package
            default:
                return []
        }
    }
}





let syntaxMSG = "Missing postfix operator on attempted regex-literal construction with string:"


prefix operator / {}
prefix func / (reg:RegexLiteral) throws -> RegexLiteral {
    guard reg.isPostfixOperatorSet else {
        throw RegexLiteral.SyntaxError.MissingPostfix(syntaxMSG + " \(reg.foundationRegex.pattern)")
    }
    print ("prefix func / (reg:RegexLiteral) -> RegexLiteral?")
    return reg
}

prefix func / (reg:RegexLiteral) -> RegexLiteral? {
    guard reg.isPostfixOperatorSet else {
        return nil
    }
    print ("prefix func / (reg:RegexLiteral) -> RegexLiteral?")
    return reg
}
postfix operator / {}
postfix func / (str:String) -> RegexLiteral.RegexLiteralOptions -> RegexLiteral {
    print ("postfix func / (str:String) -> RegexLiteral")
        return { option in return try! RegexLiteral(pattern: str, options: option, postfix: true) }
}

postfix func / (str:String) -> NSRegularExpressionOptions -> RegexLiteral {
    print ("postfix func / (str:String) -> RegexLiteral")
        return { option in return try! RegexLiteral(pattern: str, options: option, postfix: true) }
}

postfix func / (str:String) -> Character -> RegexLiteral {
    print ("postfix func / (str:String) -> RegexLiteral")
    return { option in return try! RegexLiteral(pattern: str, options: RegexLiteral.RegexLiteralOptions(char: option), postfix: true) }
}

postfix func / (str:String) -> RegexLiteral {
    print ("postfix func / (str:String) -> RegexLiteral")
    return try! RegexLiteral(pattern: str, options:.g, postfix: true)
}

let a:RegexLiteral? = /"(\\./a)"/ (.g)




//    infix operator =~ {associativity right precedence 0}
//
//    func =~ (input: String, pattern: RegexLiteral) -> Bool {
//       return pattern.test(input)
//    }
//
//    let b = "st" =~ /"string"/ ("g")
//    print (b)
//
//
//    extension String {
//       func split(str:String) -> [String] {
//          return  self.componentsSeparatedByString(str)
//       }
//    }
//
//    prefix operator % {}
//    prefix func % (str:String){
//       let task = NSTask()
//
//       let args = str.split(" ")
//
//       task.launchPath = "/bin/sh"
//       task.arguments = args
//       task.launch()
//    }




