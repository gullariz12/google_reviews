# frozen_string_literal: true

require "i18n"

# Load Translations
module Translations
  translations_file = File.expand_path("../../locales/en.yml", __dir__)
  I18n.load_path << translations_file
  I18n.backend.load_translations
  I18n.locale = :en
end
