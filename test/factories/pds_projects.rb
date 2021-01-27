# frozen_string_literal: true

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pds_project do
    project_number 1
    project_name 'test'
    Contractor 'test'
  end
end
