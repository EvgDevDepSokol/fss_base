class DbmGenerator
  include ActiveRecord::Validations
  include ActiveRecord::AutosaveAssociation
  include ActiveRecord::Reflection
  extend ActiveModel::Naming

  ATTRIBUTE_LIST = %i[mod delimiter predecessor variables
                      systems project_id type].freeze

  INPUT_TYPES = %w[MOD ADD OMOD].freeze
  VARIABLES = ['remote function', 'malfunctions', 'detectors',
               'peds', 'ppc', 'announcicator', 'time step', 'valves', 'power sections'].freeze
  DELIMITER = [',' ';'].freeze

  attr_accessor *ATTRIBUTE_LIST

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def new_record?
    false
  end

  def as_json(options = {})
    super.slice(*ATTRIBUTE_LIST.map(&:to_s))
  end
end
