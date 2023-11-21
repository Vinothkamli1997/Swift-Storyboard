

import Foundation

struct SchoolsData {
    var schoolName: String
    var isExpanded: Bool
    var studentsData: [StudentsData]
}

struct StudentsData {
    var name: String
    var age: String
    var gender: String
    var percentage: String
}
