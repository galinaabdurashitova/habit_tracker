//
//  HabitListViewModelTests.swift
//  HabitTrackerTests
//
//  Created by Galina Abdurashitova on 22.06.2025.
//

import XCTest
@testable import HabitTracker

final class HabitListViewModelTests: XCTestCase {
    private final class HabitStorageMock: HabitStorageProtocol {
        private var mockHabits: [Habit] = [
            Habit(title: "Run"),
            Habit(title: "Read")
        ]
        
        func fetchHabits() -> [Habit] { return mockHabits }
        func addHabit(_ habit: Habit) { mockHabits.append(habit) }
        func deleteHabit(_ habit: Habit) { mockHabits.removeAll(where: { $0 == habit }) }
        func markHabit(_ habit: Habit, doneAt date: Date) {
            if let index = mockHabits.firstIndex(of: habit) {
                if mockHabits[index].completedDates.contains(date.startOfDay) {
                    mockHabits[index].completedDates.remove(date.startOfDay)
                } else {
                    mockHabits[index].completedDates.insert(date.startOfDay)
                }
            }
        }
    }
    
    private final class DelegateMock: HabitListViewModelDelegate {
        var didUpdateCalled = false
        func didUpdateHabits(_ habits: [Habit]) {
            didUpdateCalled = true
        }
    }
    
    func test_init() {
        let vm = HabitListViewModel(storage: HabitStorageMock())
        XCTAssertEqual(vm.habits.count, 0)
        XCTAssert(vm.selectedDate.startOfDay == Date().startOfDay)
    }
    
    func test_loadHabits() {
        let vm = HabitListViewModel(storage: HabitStorageMock())
        let delegate = DelegateMock()
        vm.delegate = delegate
        vm.loadHabits()
        XCTAssertEqual(vm.habits.count, 2)
        XCTAssertTrue(vm.habits.contains(where: { $0.title == "Run" }))
        XCTAssertTrue(delegate.didUpdateCalled)
    }
    
    func test_addHabit() {
        let vm = HabitListViewModel(storage: HabitStorageMock())
        vm.addHabit(title: "Test")
        XCTAssertEqual(vm.habits.count, 3)
        XCTAssertTrue(vm.habits.contains(where: { $0.title == "Test" }))
    }
    
    func test_deleteHabit_whenIndexValid_success() {
        let vm = HabitListViewModel(storage: HabitStorageMock())
        vm.loadHabits()
        vm.deleteHabit(at: 0)
        XCTAssertEqual(vm.habits.count, 1)
        XCTAssertTrue(vm.habits.contains(where: { $0.title == "Read" }))
        XCTAssertFalse(vm.habits.contains(where: { $0.title == "Run" }))
    }
    
    func test_deleteHabit_whenIndexNotValid_empty() {
        let vm = HabitListViewModel(storage: HabitStorageMock())
        vm.loadHabits()
        vm.deleteHabit(at: 2)
        XCTAssertEqual(vm.habits.count, 2)
        XCTAssertTrue(vm.habits.contains(where: { $0.title == "Read" }))
        XCTAssertTrue(vm.habits.contains(where: { $0.title == "Run" }))
    }
    
    func test_updateDate() {
        let vm = HabitListViewModel(storage: HabitStorageMock())
        let delegate = DelegateMock()
        vm.delegate = delegate
        vm.loadHabits()
        let newDate = Date().advanced(by: TimeInterval(60 * 60 * 24))
        vm.updateDate(to: newDate)
        XCTAssertEqual(vm.selectedDate.startOfDay, newDate.startOfDay)
        XCTAssertNotEqual(vm.selectedDate.startOfDay, Date().startOfDay)
        XCTAssertTrue(delegate.didUpdateCalled)
    }
    
    func test_toggleHabitCompletion_withCurrentDate_whenIndexValid_success() {
        let vm = HabitListViewModel(storage: HabitStorageMock())
        vm.loadHabits()
        vm.toggleHabitCompletion(at: 0, for: Date())
        XCTAssertEqual(vm.habits.count, 2)
        XCTAssertTrue(vm.habits[0].completedDates.contains(Date().startOfDay))
        XCTAssertFalse(vm.habits[0].completedDates.contains(Date().advanced(by: TimeInterval(60 * 60 * 24)).startOfDay))
        XCTAssertTrue(vm.habits[1].completedDates.isEmpty)
        
        vm.toggleHabitCompletion(at: 0, for: Date())
        XCTAssertFalse(vm.habits[0].completedDates.contains(Date().startOfDay))
    }
    
    func test_toggleHabitCompletion_withCurrentDate_whenIndexNonValid_empty() {
        let vm = HabitListViewModel(storage: HabitStorageMock())
        vm.loadHabits()
        vm.toggleHabitCompletion(at: 2, for: Date())
        XCTAssertEqual(vm.habits.count, 2)
        XCTAssertTrue(vm.habits[0].completedDates.isEmpty)
        XCTAssertTrue(vm.habits[1].completedDates.isEmpty)
    }

    func test_toggleHabitCompletion_withSelectedDate_whenIndexValid_success() {
        let vm = HabitListViewModel(storage: HabitStorageMock())
        vm.loadHabits()
        let newDate = Date().advanced(by: TimeInterval(60 * 60 * 24))
        vm.updateDate(to: newDate)
        vm.toggleHabitCompletion(at: 0)
        XCTAssertEqual(vm.habits.count, 2)
        XCTAssertTrue(vm.habits[0].completedDates.contains(newDate.startOfDay))
        XCTAssertFalse(vm.habits[0].completedDates.contains(Date().startOfDay))
        XCTAssertTrue(vm.habits[1].completedDates.isEmpty)
        
        vm.toggleHabitCompletion(at: 0)
        XCTAssertFalse(vm.habits[0].completedDates.contains(newDate.startOfDay))
    }
    
    func test_toggleHabitCompletion_withSelectedDate_whenIndexNonValid_empty() {
        let vm = HabitListViewModel(storage: HabitStorageMock())
        vm.loadHabits()
        let newDate = Date().advanced(by: TimeInterval(60 * 60 * 24))
        vm.updateDate(to: newDate)
        vm.toggleHabitCompletion(at: 2)
        XCTAssertEqual(vm.habits.count, 2)
        XCTAssertTrue(vm.habits[0].completedDates.isEmpty)
        XCTAssertTrue(vm.habits[1].completedDates.isEmpty)
    }
    
}
