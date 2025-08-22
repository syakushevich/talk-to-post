// Import and register all your controllers in the importmap under controllers/*
import { application } from "./application"

// Eager load all controllers defined in the import map under the controllers folder
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)
