class SelectBuilder::Settings < SelectBuilder
  include ActiveRecord::Validations
  include ActiveRecord::AutosaveAssociation
  include ActiveRecord::Reflection
  extend ActiveModel::Naming

  ATTRIBUTE_LIST = %i[input_type delimiter preprocessor variables
                      systems project_id type].freeze

  INPUT_TYPES = %w[MOD ADD OMOD].freeze
  VARIALBES = ['remote function', 'malfunctions', 'detectors',
               'peds', 'ppc', 'announcicator', 'time step', 'valves', 'power sections'].freeze

  attr_accessor *ATTRIBUTE_LIST

  def initialize(attributes = {})
    ATTRIBUTE_LIST.each { |key| send("#{key}=", attributes[key.to_s]) if attributes[key.to_s] }
  end

  def new_record?
    false
  end

  def as_json(options = {})
    super.slice(*ATTRIBUTE_LIST.map(&:to_s))
  end

  # хак чтобы заработала simple_form для класса
  def to_key
    [1]
  end

  class << self
    def default_pds_rf
      a = { project_id: 79, input_type: 'MOD', delimiter: ';', preprocessor: 'globalyp',
            variables: 'remote function', systems: [], type: 'pds_rf' }
      SelectBuilder::Settings.new(a.as_json)
    end
  end
end
