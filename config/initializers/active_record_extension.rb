module ActiveRecordExtension

  extend ActiveSupport::Concern

  # в таблицах id могут быть названы как угодно, но нам важно
  # чтобы при сериализаци всегда присутствавал id
  # в стандартном виде
  def serializable_hash(options={})
    super options.merge(methods: :id)
  end

  # add your static(class) methods here
  module ClassMethods

  end
end

# include the extension
ActiveRecord::Base.send(:include, ActiveRecordExtension)