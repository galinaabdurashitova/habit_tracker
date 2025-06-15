//
//  HabitStorageCoreData.swift
//  HabitTracker
//
//  Created by Galina Abdurashitova on 15.06.2025.
//

import Foundation
import CoreData

protocol HabitStorageProtocol {
    func fetchHabits() -> [Habit]
    func addHabit(_ habit: Habit)
    func deleteHabit(_ habit: Habit)
    func markHabit(_ habit: Habit, doneAt date: Date)
}

class HabitStorageCoreData: HabitStorageProtocol {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
    }

    func fetchHabits() -> [Habit] {
        let request = HabitEntity.fetchRequest()
        let results = (try? context.fetch(request)) ?? []
        return results.map { HabitMapper.from(entity: $0) }
    }

    func addHabit(_ habit: Habit) {
        _ = HabitMapper.toEntity(from: habit, context: context)
        try? context.save()
    }

    func deleteHabit(_ habit: Habit) {
        let request = HabitEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", habit.id as CVarArg)
        if let result = try? context.fetch(request), let entity = result.first {
            context.delete(entity)
            try? context.save()
        }
    }

    func markHabit(_ habit: Habit, doneAt date: Date) {
        let request = HabitEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", habit.id as CVarArg)

        guard let entity = try? context.fetch(request).first else { return }

        let completions = entity.completions as? Set<HabitCompletionEntity> ?? []
        if let existing = completions.first(where: { $0.date == date.startOfDay }) {
            context.delete(existing)
        } else {
            let completion = HabitCompletionEntity(context: context)
            completion.date = date.startOfDay
            completion.habit = entity
        }

        try? context.save()
    }

}

