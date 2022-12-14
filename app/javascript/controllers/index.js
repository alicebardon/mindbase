// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import CreateCategoryController from "./create_category_controller"
application.register("create-category", CreateCategoryController)

import FlashesController from "./flashes_controller"
application.register("flashes", FlashesController)

import HighlightController from "./highlight_controller"
application.register("highlight", HighlightController)

import ModalController from "./modal_controller"
application.register("modal", ModalController)

import NoteController from "./note_controller"
application.register("note", NoteController)

import NoteEditController from "./note_edit_controller"
application.register("note-edit", NoteEditController)

import PopupController from "./popup_controller"
application.register("popup", PopupController)

import SearchController from "./search_controller"
application.register("search", SearchController)

import ShowDesktopController from "./show_desktop_controller"
application.register("show-desktop", ShowDesktopController)

import ShowGithubController from "./show_github_controller"
application.register("show-github", ShowGithubController)

import TurboController from "./turbo_controller"
application.register("turbo", TurboController)
