//: Playground - noun: a place where people can play

import AppKit



class RegexLiteral : NSRegularExpression {
    
    override init(pattern: String, options: NSRegularExpressionOptions) throws {
        try super.init(pattern: pattern, options: options)
    }
    
    init(pattern: String, options: RegexLiteralOptions) throws {
            try  super.init(pattern: pattern, options: options.opt)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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

class MalformedRegexLiteral : RegexLiteral {
    
}



let syntaxMSG = "Missing postfix operator on attempted regex-literal construction with string:"


prefix operator / {}
prefix func / (reg:MalformedRegexLiteral) -> RegexLiteral {
    return reg as RegexLiteral
}

postfix operator / {}
postfix func / (str:String) -> RegexLiteral.RegexLiteralOptions -> MalformedRegexLiteral {
        return { option in return try! MalformedRegexLiteral(pattern: str, options: option) }
}

postfix func / (str:String) -> NSRegularExpressionOptions -> MalformedRegexLiteral {
        return { option in return try! MalformedRegexLiteral(pattern: str, options: option) }
}

postfix func / (str:String) -> MalformedRegexLiteral {
    return try! MalformedRegexLiteral(pattern: str, options:.g)
}

let a:RegexLiteral = /"(\\./a)"/ (.g)

    typealias Index = String.CharacterView.Index

    infix operator =~ {associativity right precedence 0}

    func =~ (str: String, regex: RegexLiteral) -> Range<Index>? {
        guard let match = str.rangeOfString(regex.pattern, options:.RegularExpressionSearch, range: nil, locale: nil) else {
            return nil
        }
        return match
    }


let testttt = [3,2].map { print($0); $0 + 1 }

    let b = "string.m" =~ /"(\\.m)$"/
    let c = "g.m" =~ /"(\\.m)$"/

    extension String {
       func split(str:String) -> [String] {
          return  self.componentsSeparatedByString(str)
       }
    }

    prefix operator % {}
    prefix func % (str:String) {
       let task = NSTask()

       let args = str.split(" ")

       task.launchPath = "/bin/sh"
       task.arguments = args
       task.launch()
    }
