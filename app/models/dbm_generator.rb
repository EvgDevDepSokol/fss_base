class DbmGenerator
  include ActiveRecord::Validations
  include ActiveRecord::AutosaveAssociation
  include ActiveRecord::Reflection
  extend ActiveModel::Naming

  ATTRIBUTE_LIST = %i[mod predecessor variables
                      systems systems_all project_id gen_type gen_tag].freeze

  INPUT_TYPES = %w[MDD ADD OMOD].freeze
  VARIABLES = ['remote function', 'malfunctions', 'detectors',
               'peds', 'ppc', 'announcicator', 'time step', 'valves', 'power sections'].freeze

  attr_accessor *ATTRIBUTE_LIST

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
    byebug
    attributes['gen_tag'] = attributes['gen_tag'] == 'true'
    @project = PdsProject.find(attributes['project_id'])
    @properties = project.project_properties
  end

  attr_reader :project

  attr_reader :properties

  def new_record?
    false
  end

  def as_json(options = {})
    super.slice(*ATTRIBUTE_LIST.map(&:to_s))
  end

  def systems_all?
    systems_all == 'true'
  end

  def rus?(_project_id)
    properties.language == 'Русский'
  end

  def project_encoding(_project_id)
    enc = properties.Encoding
    return 'KOI8-R' if enc == 'koi8r'
    return 'Windows-1251' if enc == 'cp1251'

    'UTF-8'
  end

  def project_ssh(_project_id)
    { ip: properties.HostIP, pass: properties.LoadPass, remote_path: '/home/' + properties.SimDir ? properties.SimDir : '' + 'load/pds_sel_test/' }
  end
end
