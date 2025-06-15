//
//  HabitMapper.swift
//  HabitTracker
//
//  Created by Galina Abdurashitova on 15.06.2025.
//

import Foundation
import CoreData

struct HabitMapper {
    static func from(entity: HabitEntity) -> Habit {
        let completionsSet = entity.completions as? Set<HabitCompletionEntity> ?? []
        let completedDates: Set<Date> = Set(completionsSet.map { $0.date?.startOfDay ?? Date.distantPast })

        return Habit(
            id: entity.id ?? UUID(),
            title: entity.title ?? "",
            completedDates: completedDates
        )
    }

    static func toEntity(from habit: Habit, context: NSManagedObjectContext) -> HabitEntity {
        let entity = HabitEntity(context: context)
        entity.id = habit.id
        entity.title = habit.title
        return entity
    }
}
