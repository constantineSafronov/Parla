//
//  String+Localized.swift
//  Parla
//
//  Created by Konstantin Safronov on 22.10.2025.
//

import Foundation

protocol Localizable: RawRepresentable where RawValue == String {}

extension Localizable {
    var localized: String {
        NSLocalizedString(rawValue, bundle: .main, comment: "")
    }
}

enum LocalizedStrings {
  
  enum TabBar: String, Localizable {
    case setList = "tabBar.setList"
    case learning = "tabBar.learning"
    case settings = "tabBar.settings"
  }
  
  enum Common: String, Localizable {
    case cancel = "common.cancel"
    case create = "common.create"
    case delete = "common.delete"
    case deleteConfirmationDialog = "common.delete_confirmation_dialog"
  }
  
  enum CreateWord: String, Localizable {
    case word = "create_word.word"
    case translation = "create_word.translation"
    case title = "create_word.title"
  }
  
  enum CreateWordSet: String, Localizable {
    case name = "create_word_set.name"
    case description = "create_word_set.description"
    case title = "create_word_set.title"
  }
  
  enum EmojiPicker: String, Localizable {
    case title = "emoji_picker.title"
  }
  
  enum SetList: String, Localizable {
    case deleteConfirmationDialogTitle = "set_list.delete_confirmation_dialog.title"
  }
  
  enum WordList: String, Localizable {
    case deleteConfirmationDialogTitle = "word_list.delete_confirmation_dialog.title"
  }
  
  enum Learning: String, Localizable {
    case title = "learining.title"
    case pickerTitle = "learning.picker_title"
    case finishedViewTitle = "learning.finished_view.title"
    case finishedViewStartTitle = "learning.finished_view.start.title"
    case emptyStateText = "learning.empty_state.text"
  }
  
  enum Settings: String, Localizable {
    case title = "settings.title"
    case appearanceTitle = "settings.appearance_section.title"
    case appearanceThemePickerTitle = "settings.appearance_section.theme_picker_title"
    case learningTitle = "settings.learning_section.title"
    case learningHiddenSidePickerTitle = "settings.learning_section.hiden_side_picker_title"
    case learningDescription = "settings.learning_section.description"
    case learningHiddenSideHideWord = "settings.learning_section.hiden_side_hide_word"
    case learningHiddenSideHideTranslation = "settings.learning_section.hiden_side_hide_translation"
    case learningRepeatingIntervalPickerTitle = "settings.learning_section.repeating_period_picker_title"
    case learningRepeatingPeriodThreeMonths = "settings.learning_section.repeating_period_three_month"
    case learningRepeatingPeriodSixMonths = "settings.learning_section.repeating_period_six_month"
    case learningRepeatingPeriodNever = "settings.learning_section.repeating_period_never"
    case learningRepeatingDescription = "settings.learning_section.repeating_description"
  }
  
  enum AppTheme: String, Localizable {
    case dark = "theme.dark"
    case light = "theme.light"
    case system = "theme.system"
  }
}
