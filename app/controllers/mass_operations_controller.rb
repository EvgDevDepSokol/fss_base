class MassOperationsController < ApplicationController
  # Replace some values using web-interface
  include GeneralControllerHelper

  def replace_prepare
    return unless params[:column] || params[:from] || params[:to]
    querry = model_class

    if querry.respond_to?(:Project)
      querry = querry.where(Project: project.id) if project
    end

    if params[:ids]
      fromIndex = params[:fromIndex].to_i
      toIndex = params[:toIndex].to_i
      column = params[:column]
      querry = querry.find(params[:ids])
      new_data = []
      if fromIndex.zero? && toIndex.zero? # value to value
        querry.each do |row|
          val = row.send(column)
          if val.nil? || (val == '')
            if params[:from].nil? || (params[:from] == '')
              row.send(column + '=', params[:to])
              new_data.push(row)
            end
          elsif val.is_a? Integer # selector
            if val == params[:from].to_i
              row.send(column + '=', params[:to].to_i)
              new_data.push(row)
            end
          elsif val.is_a? String # string or textEditor
            if params[:from].nil? || (params[:from] == '')
              if row[column] == params[:from]
                row[column] = params[:to]
                new_data.push(row)
              end
            elsif row[column].include? params[:from]
              row[column].gsub!(params[:from], params[:to])
              new_data.push(row)
            end
          elsif val.is_a? Float # string or textEditor, when value is float
            valfrom = (begin
                       Float(params[:from])
                     rescue
                       nil
                     end)
            valto = (begin
                     Float(params[:to])
                   rescue
                     nil
                   end)
            if Float(row[column]) == valfrom
              row[column] = valto
              new_data.push(row)
            end
          elsif (val.is_a? TrueClass) || (val.is_a? FalseClass) # Boolean Selector
            if val == !params[:from].to_i.zero?
              row[column] = !params[:to].to_i.zero?
              new_data.push(row)
            end
          end
        end
      elsif (fromIndex == 1) && toIndex.zero? # empty selected to value
        querry.each do |row|
          val = row.send(column)
          if val.nil? || (val == '')
            row.send(column + '=', params[:to])
            new_data.push(row)
          end
        end
      elsif (fromIndex == 2) && toIndex.zero? # all selected to value
        querry.each do |row|
          val = row.send(column)
          if val.nil? || (val == '')
            row.send(column + '=', params[:to])
            new_data.push(row)
          elsif val.is_a? Integer # selector
            row.send(column + '=', params[:to].to_i)
            new_data.push(row)
          elsif val.is_a? String # string or textEditor
            row[column] = params[:to]
            new_data.push(row)
          elsif val.is_a? Float # string or textEditor, when value is float
            valto = (begin
                     Float(params[:to])
                   rescue
                     nil
                   end)
            row[column] = valto
            new_data.push(row)
          elsif (val.is_a? TrueClass) || (val.is_a? FalseClass) # Boolean Selector
            row[column] = !params[:to].to_i.zero?
            new_data.push(row)
          end
        end
      elsif (fromIndex == 2) && (toIndex == 1) # all selected to empty
        querry.each do |row|
          row.send(column + '=', nil)
          new_data.push(row)
        end
      end
      render json: { status: :ok, new_data: new_data_oj(new_data) }
    else
      render json: { status: :error }
    end
  end

  def replace_finish
    new_data = params[:new_data]
    column = params[:column]
    ids = []
    new_data.each do |_i, row|
      ids.push(row[:id].to_i)
    end

    querry = model_class

    new_data.each do |_i, row|
      querry_row = querry.find(row[:id])
      querry_row.attributes.each do |attr_name, _attr_value|
        querry_row[attr_name] = row[attr_name]
      end
      querry_row.save
    end
    querry = querry.find(ids)

    render json: { status: :ok, data: table_data(querry) }
  end

  private

  def project
    @project ||= PdsProject.find(params[:pds_project_id]) if params[:pds_project_id]
  end

  def new_data_oj(new_data)
    Oj.default_options = { mode: :compat }
    Oj.dump(new_data.map(&:serializable_hash))
  end

  def table_data(querry)
    Oj.default_options = { mode: :compat }
    if model_class.method_defined? :custom_hash
      Oj.dump(querry.map(&:custom_hash))
    else
      Oj.dump(querry.map(&:serializable_hash))
    end
  end
end
