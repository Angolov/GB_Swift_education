// Блок 16
// Задание 1-6
//MARK: - ITCompany class declaration
class ITCompany {
    
    //MARK: - Public properties
    var name: String {
        didSet {
            
        }
    }
    let jobRole: String
    var jobExperience: Int
    var salary: Int
    
    var bugs = 0 {
        didSet {
            if oldValue < bugs {
                print("New bugs require fixing")
            } else if oldValue > bugs {
                print("Another bug was fixed")
            }
        }
    }
    
    //MARK: - Initializer
    init(name: String,
         jobRole: String,
         jobExperience: Int,
         salary: Int) {
        
        self.name = name
        self.jobRole = jobRole
        self.jobExperience = jobExperience
        self.salary = salary
    }
    
    //MARK: - Public methods
    func writeCode(using prototype: Designer) {
        print("\(name) writes code")
        prototype.prototypes.removeFirst()
        
        if prototype.prototypes.count == 0 {
            print("Project is ready")
        }
    }
    
    func testABug() {
        print("\(name) test bugs")
    }
    
    func createAdesign() {
        print("\(name) creates design")
    }
    
    func callToClients() {
        print("\(name) calls to clients")
    }
    
    func catchBugs() {
        print("\(name) caught a bug")
        bugs += 1
    }
    
    func fixBugs() {
        print("\(name) fixed a bug")
        bugs -= 1
    }
    
    
}

// Задание 7-11
//MARK: - Designer class declaration
class Designer: ITCompany {
    
    //MARK: - Public property
    override var name: String {
        didSet {
            if name != oldValue {
                name = oldValue
            }
        }
    }
    
    var prototypes: [Int] {
        didSet {
            if prototypes.count > 10 {
                print("Design is ready, programmer get to work!")
            }
            if prototypes.count == 0 {
                createAdesign()
            }
        }
    }
    
    //MARK: - Initializer
    
    init(name: String,
         jobRole: String,
         jobExperience: Int,
         salary: Int,
         prototypes: [Int]) {
        
        self.prototypes = prototypes
        
        super.init(name: name,
                   jobRole: jobRole,
                   jobExperience:
                    jobExperience,
                   salary: salary)
    }
    
    //MARK: - Public methods
    override func createAdesign() {
        prototypes.append(1)
        print("\(name) creates design")
    }
}
