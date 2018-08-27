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
    attributes['gen_tag'] = attributes['gen_tag'] == 'true'
  end

  def new_record?
    false
  end

  def as_json(options = {})
    super.slice(*ATTRIBUTE_LIST.map(&:to_s))
  end

  def systems_all?
    systems_all == 'true'
  end

  def rus?(project_id)
    PdsProject.find(project_id).project_properties.language == 'Русский'
  end

  def project_encoding(project_id)
    enc = PdsProject.find(project_id).project_properties.Encoding
    return 'KOI8-R' if enc == 'koi8r'
    return 'Windows-1251' if enc == 'cp1251'
    'UTF-8'
  end

  def project_ssh(project_id)
    prop = PdsProject.find(project_id).project_properties
    { ip: prop.HostIP, pass: prop.LoadPass, remote_path: '/home/' + prop.SimDir + 'load/pds_sel_test/' }
  end
end
