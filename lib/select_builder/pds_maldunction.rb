class SelectBuilder::PdsRF < SelectBuilder
  include ActiveRecord::Validations
  include ActiveRecord::AutosaveAssociation
  include ActiveRecord::Reflection

  ATTRIBUTE_LIST = %i[input_type delimiter preprocessor variables
                      systems project_id].freeze

  INPUT_TYPES = %w[MOD ADD OMOD].freeze
  VARIALBES = ['remote function', 'malfunctions', 'detectors',
               'peds', 'ppc', 'announcicator', 'time step', 'valves', 'power sections'].freeze

  attr_accessor *ATTRIBUTE_LIST

  def initialize(attributes)
    ATTRIBUTE_LIST.each { |key| send("#{key}=", attributes[key.to_s]) if attributes[key.to_s] }
  end

  def new_record?
    false
  end

  def as_json(options = {})
    super.slice(*ATTRIBUTE_LIST.map(&:to_s))
  end
end
