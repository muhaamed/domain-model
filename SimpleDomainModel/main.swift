//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
  return "I have been tested"
}

open class TestMe {
  open func Please() -> String {
    return "I have been tested"
  }
}

////////////////////////////////////
// Money
//
public struct Money {
    public var amount : Int
    public var currency : String
    
    // convert
    public func convert(_ to: String) -> Money {
        
        // Dollar to Pound
        func USDtoGBP () -> Int{
            var value:Double = Double(amount)
            value = (value)*0.5
            return Int(value)
        }
        
        // Dollar to Euro
        func USDtoEUR () -> Int{
            var value:Double = Double(amount)
            value = value*1.5
            return Int(value)
        }
        
        // Dollar to Candian Dollar
        func USDtoCAN () -> Int{
            var value:Double = Double(amount)
            value = value*1.25
            return Int(value)
        }
        
        // Pound to USD
        func GBPtoUSD () -> Int{
            var value:Double = Double(amount)
            value = value/0.5
            return Int(value)
        }
        
        // Euro to USD
        func EURtoUSD () -> Int{
            var value:Double = Double(amount)
            value = value/1.5
            return Int(value)
        }
        
        // Canadian Dollar to USD
        func CANtoUSD () -> Int{
            var value:Double = Double(amount)
            value = value/1.25
            return Int(value)
        }
        
        
        var newAmount = 0
        var newCurrency = ""
        
        if (currency == "USD"){
            switch to {
            case "GBP":
                newAmount = USDtoGBP()
                newCurrency = "GBP"
            case "CAN":
                newAmount = USDtoCAN()
                newCurrency = "CAN"
            case "EUR":
                newAmount = USDtoEUR()
                newCurrency = "EUR"
            default:
                print("Sorry we do not convert this currency")
            }
        }
        if (currency == "GBP"){
            switch to {
            case "USD":
                newAmount = GBPtoUSD()
                newCurrency = "USD"
            case "CAN":
                newAmount = GBPtoUSD()
                newAmount = USDtoCAN()
                newCurrency = "CAN"
            case "EUR":
                newAmount = GBPtoUSD()
                newAmount = USDtoEUR()
                newCurrency = "EUR"
            default:
                print("Sorry we do not convert this currency")
            }
        }
        if (currency == "CAN"){
            switch to {
            case "USD":
                newAmount = CANtoUSD()
                newCurrency = "USD"
            case "GBP":
                newAmount = CANtoUSD()
                newAmount = USDtoGBP()
                newCurrency = "GBP"
            case "EUR":
                newAmount = CANtoUSD()
                newAmount = USDtoEUR()
                newCurrency = "EUR"
            default:
                print("Sorry we do not convert this currency")
            }
        }
        if (currency == "EUR"){
            switch to {
            case "USD":
                newAmount = EURtoUSD()
                newCurrency = "USD"
            case "GBP":
                newAmount = EURtoUSD()
                newAmount = USDtoGBP()
                newCurrency = "GBP"
            case "CAN":
                newAmount = EURtoUSD()
                newAmount = USDtoCAN()
                newCurrency = "CAN"
            default:
                print("Sorry we do not convert this currency")
            }
        }
        
        
        
        let ConvertedMoney = Money(amount:newAmount, currency:newCurrency)
        return ConvertedMoney
    }
    

// add
  public func add(_ to: Money) -> Money {
    var addedAmount = 0
    var newCurrency = ""
    if(currency == to.currency){
        addedAmount = amount + to.amount
        newCurrency = currency
    }
    else{
        var convertedValue = convert(to.currency)
        convertedValue.amount = convertedValue.amount + to.amount
        addedAmount = convertedValue.amount
        newCurrency = convertedValue.currency
    }
    let addedMoney = Money(amount:addedAmount, currency:newCurrency)
    return addedMoney
  }
    
// subtract
  public func subtract(_ from: Money) -> Money {
    var balance = 0
    var newCurrency = ""
    if(currency == from.currency){
        balance = amount - from.amount
        newCurrency = currency
    }
    else{
        var convertedValue = convert(from.currency)
        convertedValue.amount = convertedValue.amount - from.amount
        balance = convertedValue.amount
        newCurrency = convertedValue.currency
    }
    let balanceMoney = Money(amount:balance, currency:newCurrency)
    return balanceMoney

  }
}




////////////////////////////////////
// Job
//
open class Job {
  fileprivate var title : String
  fileprivate var type : JobType

  public enum JobType {
    case Hourly(Double)
    case Salary(Int)
    
    // function to access values
    func returnsValue() -> Any {
        switch self {
        case .Hourly(let Rate):
            return Rate
        case .Salary(let salary):
            return salary
                }
    }
    //Function to change salary/hourly
    mutating func adjust(raise:Double) {
        switch self{
        case let .Hourly(rate):
            
            self = .Hourly(rate + raise)
        case let .Salary(salary):
            let value = Int(raise)
            self = .Salary(salary + value)
            
        }
    }
    
  }
  
  public init(title : String, type : JobType) {
    self.title = title
    self.type = type
  }
  
  open func calculateIncome(_ hours: Double) -> Int {
    if case .Salary(_) = type {
        let salary = self.type.returnsValue() as! Int
        return salary
        
    }else{
        let rate = self.type.returnsValue() as! Double
        let wage = rate*hours
        return Int(wage)
    }
  }
  
  open func raise(_ amt : Double) {
        self.type.adjust(raise: amt)
  }
    
}

//let value = Job(title: "manager", type: Job.JobType.Salary(600))
//print(value.calculateIncome(50))
////////////////////////////////////
// Person
//
open class Person {
  open var firstName : String = ""
  open var lastName : String = ""
  open var age : Int = 0

  fileprivate var _job : Job? = nil
  open var job : Job? {
    get {
        return _job
    }
    set(value) {
        if self.age >= 16 {
            _job = value
        }
        
    }
  }
  
  fileprivate var _spouse : Person? = nil
  open var spouse : Person? {
    get { return _spouse}
    set(value) {
        if self.age >= 18 {
            _spouse = value
        }
        
    }
  }
  
  public init(firstName : String, lastName: String, age : Int) {
    self.firstName = firstName
    self.lastName = lastName
    self.age = age
  }
  
  open func toString() -> String {
    return "[Person: firstName:\(self.firstName) lastName:\(self.lastName) age:\(self.age) job:\(self._job?.title) spouse:\(self._spouse)]"
  }
}

////////////////////////////////////
// Family
//
open class Family {
  fileprivate var members : [Person] = []
  
  public init(spouse1: Person, spouse2: Person) {
    if spouse1.spouse == nil && spouse2.spouse == nil{
        members.append(spouse1)
        members.append(spouse2)
        spouse1.spouse = Person(firstName: spouse2.firstName, lastName: spouse2.lastName, age: spouse2.age)
        spouse2.spouse = Person(firstName: spouse1.firstName, lastName: spouse1.lastName, age: spouse1.age)
    }
    
  }
  
  open func haveChild(_ child: Person) -> Bool {
    members.append(child)
    //false return
    return true
  }
  
  open func householdIncome() -> Int {
    var sum = 0
    for individual in members{
        if individual._job != nil{
           sum = sum + (individual._job?.calculateIncome(2000))!
        }
    }
    return sum
  }
}





























