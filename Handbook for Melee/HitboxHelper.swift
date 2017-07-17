//  Created by Ivan Martinez on 12/28/16.
//  Copyright © 2016 Ivan Martinez. All rights reserved.
//

import Foundation

class HitboxHelper {

    static func getMoveTitle(name: String) -> String {
        switch (name) {
			case "bair":
				return "Back air"
			case "dair":
				return "Down air"
			case "uair":
				return "Up air"
			case "nair":
				return "Neutral air"
			case "fair":
				return "Forward air"
			case "dtilt":
				return "Down tilt"
			case "ftilt":
				return "Forward tilt"
			case "ftiltdown":
				return "Downward forward tilt"
			case "ftiltup":
				return "Upward forward tilt"
			case "utilt":
				return "Up tilt"
			case "dsmash":
				return "Down smash"
			case "fsmash":
				return "Forward smash"
			case "usmash":
				return "Up smash"
			case "dash":
				return "Dash"
			case "dgrab":
				return "Dash grab"
			case "grab":
				return "Grab"
			case "jabone":
				return "Jab one"
			case "jabthree":
				return "Jab three"
			case "jabtwo":
				return "Jab two"
			case "rapid":
				return "Rapid"
			case "downb":
				return "Down special"
			case "neutb":
				return "Neutral special"
			case "sideb":
				return "Side special"
			case "upb":
				return "Up special"
			default:
				return getFullMarthSideB(move: name)
        }
    }
    
    static func getShortTitle(name: String) -> String {
        switch (name) {
        case "Back air":
            return "bair"
        case "Down air":
            return "dair"
        case "Up air":
            return "uair"
        case "Neutral air":
            return "nair"
        case "Forward air":
            return "fair"
        case "Down tilt":
            return "dtilt"
        case "Forward tilt":
            return "ftilt"
        case "Downward forward tilt":
            return "ftiltdown"
        case "Upward forward tilt":
            return "ftiltup"
        case "Up tilt":
            return "utilt"
        case "Down smash":
            return "dsmash"
        case "Forward smash":
            return "fsmash"
        case "Up smash":
            return "usmash"
        case "Dash":
            return "dash"
        case "Dash grab":
            return "dgrab"
        case "Grab":
            return "grab"
        case "Jab one":
            return "jabone"
        case "Jab three":
            return "jabthree"
        case "Jab two":
            return "jabtwo"
        case "Rapid":
            return "rapid"
        case "Down special":
            return "downb"
        case "Neutral special":
            return "neutb"
        case "Side special":
            return "sideb"
        case "Up special":
            return "upb"
        default:
            return getMarthSideB(move: name)
        }
    }
    
	static func getFullMarthSideB(move: String) -> String {
        switch(move) {
            case "sb1":
                return "Side-B 1"
            case "sb2s":
                return "Side-B 2 Side/Down"
            case "sb2u":
                return "Side-B 2 Up"
            case "sb3s":
                return "Side-B 3 Side"
            case "sb3u":
                return "Side-B 3 Up"
            case "sb3d":
                return "Side-B 3 Down"
            case "sb4s":
                return "Side-B 4 Side"
            case "sb4u":
                return "Side-B 4 Up"
            case "sb4d":
                return "Side-B 4 Down"
            default:
                return ""
        }
    }
    
	static func getMarthSideB(move: String) -> String {
        switch(move) {
            case "Side-B 1":
                return "sb1"
            case "Side-B 2 Side/Down":
                return "sb2s"
            case "Side-B 2 Up":
                return "sb2u"
            case "Side-B 3 Side":
                return "sb3s"
            case "Side-B 3 Up":
                return "sb3u"
            case "Side-B 3 Down":
                return "sb3d"
            case "Side-B 4 Side":
                return "sb4s"
            case "Side-B 4 Up":
                return "sb4u"
            case "Side-B 4 Down":
                return "sb4d"
            default:
                return ""
        }
    }

    static func getLandLag(character: String, move: String) -> String {
        switch(character) {
            case "Captain Falcon":
                return getFalconLandLag(move: move)
            case "Falco":
                return getFalcoLandLag(move: move)
            case "Fox":
                return getFalcoLandLag(move: move)
            case "Marth":
                return getMarthLandLag(move: move)
            case "Sheik":
                return getSheikLandLag(move: move)
            case "Ice Climbers":
                return getClimbersLandLag(move: move)
            case "Jigglypuff":
                return getJiggsLandLag(move: move)
            case "Samus":
                return getSamusLandLag(move: move)
            case "Ganondorf":
                return getGanonLandLag(move: move)
            case "Pikachu":
                return getPikaLandLag(move: move)
            case "Yoshi":
                return getYoshiLandLag(move: move)
            case "Dr. Mario":
                return getDoctorLandLag(move: move)
            case "Princess Peach":
                return getPeachLandLag(move: move)
            case "Luigi":
                return getLuigiLandLag(move: move)
            default:
                return ""
        }
    }

    static func getIASA(character: String, move: String) -> String {
        switch(character) {
            case "Captain Falcon":
                return getFalconIASA(move: move)
            case "Falco":
                return getFalcoIASA(move: move)
            case "Fox":
                return getFalcoIASA(move: move)
            case "Marth":
                return getMarthIASA(move: move)
            case "Sheik":
                return getSheikIASA(move: move)
            case "Ice Climbers":
                return getClimbersIASA(move: move)
            case "Jigglypuff":
                return getJiggsIASA(move: move)
            case "Samus":
                return getSamusIASA(move: move)
            case "Ganondorf":
                return getGanonIASA(move: move)
            case "Pikachu":
                return getPikaIASA(move: move)
            case "Yoshi":
                return getYoshiIASA(move: move)
            case "Dr. Mario":
                return getDoctorIASA(move: move)
            case "Princess Peach":
                return getPeachIASA(move: move)
            case "Luigi":
                return getLuigiIASA(move: move)
            default:
                return ""
        }
    }

    static func getFalconIASA(move: String ) -> String {
        switch(move) {
            case "fair":
                return "IASA: 36"
            case "bair":
                return "IASA: 29"
            case "uair":
                return "IASA: 30"
            case "dair":
                return "IASA: 38"
            case "jabthree":
                return "IASA: 23"
            case "dash", "utilt":
                return "IASA: 38"
            case "dtilt":
                return "IASA: 35"
            case "fsmash":
                return "IASA: 60"
            case "usmash":
                return "IASA: 40"
            case "dsmash":
                return "IASA: 49"
            default:
                return "  "
        }
    }

    static func getFalconLandLag(move: String ) -> String {
        switch(move) {
            case "dair":
                return "Landing lag: 24"
            case "fair":
                return "Landing lag: 19"
            case "nair", "uair":
                return "Landing lag: 15"
            case "bair":
                return "Landing lag: 18"
            default:
                return ""
        }
    }

    static func getFalcoLandLag(move: String) -> String {
        switch(move) {
            case "dair","uair":
                return "Landing lag: 18"
            case "fair":
                return "Landing lag: 22"
            case "nair":
                return "Landing lag: 15"
            case "bair", "sideb":
                return "Landing lag: 20"
            case "upb":
                return "Landing lag: 6"
            case "downb":
                return "Landing lag: 45"
            default:
                return ""
        }
    }

    static func getFalcoIASA(move: String) -> String{
        switch(move) {
            case "fair":
                return "IASA: 53"
            case "bair":
                return "IASA: 38"
            case "uair":
                return "IASA: 36"
            case "nair":
                return "IASA: 42"
            case "jabone":
                return "IASA: 16"
            case "jabtwo":
                return "IASA: 19"
            case "dash":
                return "IASA: 36"
            case "utilt":
                return "IASA: 23"
            case "dtilt":
                return "IASA: 28"
            case "dsmash":
                return "IASA: 46"
            default:
                return "  "
        }
    }

    static func getMarthLandLag(move: String) -> String {
        switch(move) {
            case "dair":
                return "Landing lag: 32"
            case "fair", "nair", "uair":
                return "Landing lag: 15"
            case "bair":
                return "Landing lag: 24"
            case "upb":
                return "Landing lag: 34"
            default:
                return ""
        }
    }

    static func getMarthIASA(move: String) -> String {
        switch(move) {
            case "fair":
                return "IASA: 30"
            case "bair":
                return "IASA: 35"
            case "jabone":
                return "IASA: 19"
            case "jabtwo":
                return "IASA: 20"
            case "dash":
                return "IASA: 40"
            case "utilt":
                return "IASA: 32"
            case "dtilt":
                return "IASA: 20"
            case "fsmash":
                return "IASA: 48"
            case "usmash":
                return "IASA: 46"
            case "dsmash":
                return "IASA: 62"
            default:
                return "  "
        }
    }

    static func getSheikLandLag(move: String) -> String {
        switch(move) {
            case "dair":
                return "Landing lag: 20"
            case "bair", "fair", "nair":
                return "Landing lag: 16"
            case "uair":
                return "Landing lag: 24"
            case "upb":
                return "Landing lag: 30"
            default:
                return ""
        }
    }

    static func getSheikIASA(move: String) -> String {
        switch(move) {
            case "nair":
                return "IASA: 42"
            case "uair":
                return "IASA: 37"
            case "jabone":
                return "IASA: 16"
            case "jabtwo":
                return "IASA: 17"
            case "dash":
                return "IASA: 36"
            case "utilt":
                return "IASA: 26"
            case "dtilt":
                return "IASA: 29"
            case "ftilt":
                return "IASA: 27"
            case "fsmash", "usmash", "dsmash":
                return "IASA: 46"
            default:
                return "  "
        }
    }

    static func getClimbersLandLag(move: String) -> String {
        switch(move) {
            case "dair":
                return "Landing lag: 25"
            case "fair", "nair", "bair":
                return "Landing lag: 20"
            case "uair":
                return "Landing lag: 32"
            case "upb":
                return "Landing lag: 25"
            case "sideb":
                return "Landing lag: 4"
            default:
                return ""
        }
    }

    static func getClimbersIASA(move: String) -> String {
        switch(move) {
            case "nair":
                return "IASA: 20"
            case "uair":
                return "IASA: 32"
            case "bair":
                return "IASA: 36"
            case "dair":
                return "IASA: 55"
            case "jabone":
                return "IASA: 16"
            case "jabtwo":
                return "IASA: 18"
            case "dash":
                return "IASA: 38"
            case "utilt":
                return "IASA: 42"
            case "dtilt":
                return "IASA: 29"
            case "ftilt":
                return "IASA: 28"
            case "ftiltup":
                return "IASA: 28"
            case "ftiltdown":
                return "IASA: 28"
            case "fsmash":
                return "IASA: 47"
            case "usmash":
                return "IASA: 44"
            case "dsmash":
                return "IASA: 36"
            default:
                return "  "
        }
    }

    static func getJiggsLandLag(move: String) -> String{
        switch(move) {
            case "dair":
                return "Landing lag: 30"
            case "fair", "nair", "uair", "bair":
                return "Landing lag: 20"
            default:
                return ""
        }
    }

    static func getJiggsIASA(move: String) -> String {
        switch(move) {
            case "uair":
                return "IASA: 38"
            case "bair":
                return "IASA: 31"
            case "fair":
                return "IASA: 35"
            case "jabone":
                return "IASA: 16"
            case "jabtwo":
                return "IASA: 17"
            case "dash":
                return "IASA: 39"
            case "dtilt":
                return "IASA: 30"
            case "usmash":
                return "IASA: 45"
            case "dsmash":
                return "IASA: 48"
            default:
                return "  "
        }
    }

    static func getSamusLandLag(move: String) -> String {
        switch(move) {
            case "dair", "fair", "nair", "uair", "bair":
                return "Landing lag: 15"
            case "upb":
                return "Landing lag: 24"
            default:
                return ""
        }
    }

    static func getSamusIASA(move: String) -> String {
        switch(move) {
            case "uair":
                return "IASA: 39"
            case "bair":
                return "IASA: 37"
            case "fair":
                return "IASA: 50"
            case "dair":
                return "IASA: 49"
            case "nair":
                return "IASA: 40"
            case "utilt":
                return "IASA: 35"
            case "ftilt", "ftiltup", "ftiltdown":
                return "IASA: 30"
            case "usmash":
                return "IASA: 58"
            case "dsmash":
                return "IASA: 45"
            default:
                return "  "
        }
    }

    static func getGanonLandLag(move: String) -> String {
        switch(move) {
            case "dair":
                return "Landing lag: 38"
            case "fair", "nair", "bair":
                return "Landing lag: 25"
            case "uair", "upb":
                return "Landing lag: 30"
            case "sideb":
                return "Landing lag: 20"
            case "downb":
                return "Landing lag: 57"
            default:
                return ""
        }
    }

    static func getGanonIASA(move: String) -> String {
        switch(move) {
            case "jabone":
                return "IASA: 19"
            case "uair":
                return "IASA: 30"
            case "bair":
                return "IASA: 29"
            case "fair":
                return "IASA: 35"
            case "dair":
                return "IASA: 38"
            case "utilt":
                return "IASA: 113"
            case "usmash":
                return "IASA: 40"
            case "dsmash":
                return "IASA: 47"
            case "fsmash":
                return "IASA: 60"
            case "dash":
                return "IASA: 38"
            default:
                return "  "
        }
    }

    static func getPikaLandLag(move: String) -> String {
        switch(move) {
            case "dair":
                return "Landing lag: 40"
            case "fair":
                return "Landing lag: 20"
            case "nair":
                return "Landing lag: 15"
            case "uair":
                return "Landing lag: 26"
            case "bair":
                return "Landing lag: 30"
            case "upb":
                return "Landing lag: 24"
            default:
                return ""
        }
    }

    static func getPikaIASA(move: String) -> String {
        switch(move) {
            case "dair":
                return "IASA: 30"
            case "dtilt":
                return "IASA: 19"
            case "usmash":
                return "IASA: 41"
            case "dsmash":
                return "IASA: 51"
            default:
                return "  "
        }
    }

    static func getYoshiLandLag(move: String) -> String {
        switch(move) {
            case "dair":
                return "Landing lag: 26"
            case "fair":
                return "Landing lag: 21"
            case "nair":
                return "Landing lag: 15"
            case "uair":
                return "Landing lag: 19"
            case "bair":
                return "Landing lag: 15"
            default:
                return ""
        }
    }

    static func getYoshiIASA(move: String) -> String {
        switch(move) {
            case "uair":
                return "IASA: 39"
            case "bair":
                return "IASA: 38"
            case "fair":
                return "IASA: 35"
            case "dair":
                return "IASA: 53"
            case "nair":
                return "IASA: 45"
            case "dash":
                return "IASA: 42"
            default:
                return "  "
        }
    }

    static func getDoctorLandLag(move: String) -> String {
        switch(move) {
            case "dair":
                return "Landing lag: 24"
            case "fair":
                return "Landing lag: 25"
            case "nair","uair", "bair":
                return "Landing lag: 18"
            case "upb":
                return "Landing lag: 30"
            default:
                return ""
        }
    }

    static func getDoctorIASA(move: String) -> String {
        switch(move) {
            case "dair":
                return "IASA: 38"
            case "fair":
                return "IASA: 60"
            case "utilt":
                return "IASA: 30"
            case "dash":
                return "IASA: 38"
            default:
                return "  "
        }
    }

    static func getPeachLandLag(move: String) -> String {
        switch(move) {
            case "dair":
                return "Landing lag: 15"
            case "fair":
                return "Landing lag: 25"
            case "nair":
                return "Landing lag: 17"
            case "uair", "bair":
                return "Landing lag: 15"
            case "upb":
                return "Landing lag: 30"
            case "sideb":
                return "Landing lag: 33"
            default:
                return ""
        }
    }

    static func getPeachIASA(move: String) -> String {
        switch(move) {
            case "jabtwo":
                return "IASA: 17"
            case "uair":
                return "IASA: 34"
            case "bair":
                return "IASA: 38"
            case "fair":
                return "IASA: 51"
            case "dair":
                return "IASA: 36"
            case "nair":
                return "IASA: 42"
            case "utilt":
                return "IASA: 37"
            case "ftilt":
                return "IASA: 37"
            case "dtilt":
                return "IASA: 26"
            case "fsmash":
                return "IASA: 40"
            case "dash":
                return "IASA: 36"
            default:
                return "  "
        }
    }


    static func getLuigiLandLag(move: String) -> String {
        switch(move) {
            case "dair":
                return "Landing lag: 18"
            case "fair":
                return "Landing lag: 25"
            case "nair", "uair", "bair":
                return "Landing lag: 15"
            case "upb":
                return "Landing lag: 40"
            case "sideb":
                return "Landing lag: 41"
            default:
                return ""
        }
    }

    static func getLuigiIASA(move: String) -> String {
        switch(move) {
            case "dair":
                return "IASA: 29"
            case "uair":
                return "IASA: 30"
            case "fair":
                return "IASA: 33"
            case "utilt":
                return "IASA: 30"
            case "ftilt":
                return "IASA: 32"
            case "dash":
                return "IASA: 59"
            default:
                return "  "
        }
    }
}
