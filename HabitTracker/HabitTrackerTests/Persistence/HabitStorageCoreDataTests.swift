//
//  HabitStorageCoreDataTests.swift
//  HabitTrackerTests
//
//  Created by Galina Abdurashitova on 22.06.2025.
//

import XCTest
import CoreData
@testable import HabitTracker

final class HabitStorageCoreDataTests: XCTestCase {
    private func getMockPersistentContainer() -> NSManagedObjectContext {
        let container = NSPersistentContainer(name: "Habit")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]

        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load in-memory store: \(error)")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
        
        return container.viewContext
    }
    
    func test_fetchAndAddHabits() {
        let coreData = HabitStorageCoreData(context: getMockPersistentContainer())
        let habits1 = coreData.fetchHabits()
        XCTAssertEqual(habits1.count, 0)
        
        coreData.addHabit(Habit(title: "Run"))
        let habits2 = coreData.fetchHabits()
        XCTAssertEqual(habits2.count, 1)
        XCTAssertEqual(habits2[0].title, "Run")
        XCTAssertTrue(habits2[0].completedDates.isEmpty)
    }
    
    func test_deleteHabit_withValidHabit_success() {
        let coreData = HabitStorageCoreData(context: getMockPersistentContainer())
        let newHabit = Habit(title: "Run")
        coreData.addHabit(newHabit)
        let habits1 = coreData.fetchHabits()
        XCTAssertEqual(habits1.count, 1)
        coreData.deleteHabit(newHabit)
        let habits2 = coreData.fetchHabits()
        XCTAssertEqual(habits2.count, 0)
    }
    
    func test_deleteHabit_withNotValidHabit_empty() {
        let coreData = HabitStorageCoreData(context: getMockPersistentContainer())
        coreData.addHabit(Habit(title: "Run"))
        let habits1 = coreData.fetchHabits()
        XCTAssertEqual(habits1.count, 1)
        coreData.deleteHabit(Habit(title: "Run1"))
        let habits2 = coreData.fetchHabits()
        XCTAssertEqual(habits2.count, 1)
    }
    
    func test_markHabit_withValidHabit_success() {
        let coreData = HabitStorageCoreData(context: getMockPersistentContainer())
        let newHabit = Habit(title: "Run")
        coreData.addHabit(newHabit)
        coreData.markHabit(newHabit, doneAt: Date().startOfDay)
        let habits1 = coreData.fetchHabits()
        XCTAssertEqual(habits1.count, 1)
        XCTAssertEqual(habits1[0].completedDates.count, 1)
        XCTAssertTrue(habits1[0].completedDates.contains(Date().startOfDay))
        
        coreData.markHabit(newHabit, doneAt: Date().startOfDay)
        let habits2 = coreData.fetchHabits()
        XCTAssertEqual(habits2.count, 1)
        XCTAssertEqual(habits2[0].completedDates.count, 0)
        XCTAssertFalse(habits2[0].completedDates.contains(Date().startOfDay))
    }
    
    func test_markHabit_withNotValidHabit_empty() {
        let coreData = HabitStorageCoreData(context: getMockPersistentContainer())
        coreData.addHabit(Habit(title: "Run"))
        coreData.markHabit(Habit(title: "Run1"), doneAt: Date().startOfDay)
        let habits1 = coreData.fetchHabits()
        XCTAssertEqual(habits1.count, 1)
        XCTAssertEqual(habits1[0].completedDates.count, 0)
    }
}
