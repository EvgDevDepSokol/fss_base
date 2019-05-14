# frozen_string_literal: true

module ActiveRecord
  module Timestamp
    private

    def timestamp_attributes_for_update #:nodoc:
      %i[updated_at updated_on modified_at]
    end

    def timestamp_attributes_for_create #:nodoc:
      %i[created_at t]
    end
  end
end
