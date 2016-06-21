class Api::MassOperationsController < ApplicationController
  include GeneralControllerHelper

  def update_all
    return unless params[:column] || params[:from] || params[:to]
    querry = model_class

    if querry.respond_to?(:Project)
      querry = querry.where(Project: project.id) if project 
    end

    # querry = querry.where(id: params[:ids]) if params[:ids]

    if params[:ids]
      fromIndex = params[:fromIndex].to_i
      toIndex = params[:toIndex].to_i
      column = params[:column]
      querry = querry.find(params[:ids])
      new_data = []
      if((fromIndex==0) && (toIndex==0))
        querry.each do |row|
          val = row.send(column)
          if (val.nil?||(val==''))
            if ((params[:from].nil?)||(params[:from]==''))
              row.send(column+'=', params[:to])
              new_data.push(row)
            end
          elsif val.is_a? Fixnum # selector 
            if val == params[:from].to_i
              row.send(column+'=', params[:to].to_i)
              new_data.push(row)
            end
          elsif val.is_a? String # string or textEditor
            if ((params[:from].nil?)||(params[:from]==''))
              if row[column]==params[:from]
                row[column]=params[:to]
                new_data.push(row)
              end
            elsif row[column].include? params[:from]
              row[column].gsub!(params[:from],params[:to]) 
              new_data.push(row)
            end
          elsif val.is_a? Float # string or textEditor, when value is float
            valfrom=(Float(params[:from]) rescue nil)
            valto=(Float(params[:to]) rescue nil)
            if Float(row[column])==valfrom
              row[column]=valto
              new_data.push(row)
            end
          end
        end
      elsif((fromIndex==1) && (toIndex==0))
        querry.each do |row|
          val = row.send(column)
          if (val.nil?||(val==''))
            row.send(column+'=', params[:to])
            new_data.push(row)
          end
        end
      elsif((fromIndex==2) && (toIndex==0)) 
        querry.each do |row|
          val = row.send(column)
          if (val.nil?||(val==''))
            row.send(column+'=', params[:to])
            new_data.push(row)
          elsif val.is_a? Fixnum # selector 
            row.send(column+'=', params[:to].to_i)
            new_data.push(row)
          elsif val.is_a? String # string or textEditor
            row[column]=params[:to]
            new_data.push(row)
          elsif val.is_a? Float # string or textEditor, when value is float
            valto=(Float(params[:to]) rescue nil)
            row[column]=valto
            new_data.push(row)
          end
        end
      elsif((fromIndex==2) && (toIndex==1))
        querry.each do |row|
          row.send(column+'=', nil)
          new_data.push(row)
        end
      end 
      # save all changes finally
   #   querry.each do |row|
   #     row.save
   #   end
      render json: { status: :ok, new_data: new_data_oj(new_data)}
    else
      render json: { status: :error }
    end
  end

  def update_all_save
    new_data=params[:new_data]
    column = params[:column]
    ids = []
    new_data.each do |row|
      ids.push(row[1]['id'].to_i)
    end

    querry = model_class

    new_data.each do |row|
      querry_row = querry.find(row[1]['id'])
      querry_row[column] = row[1][column]
      querry_row.save;
    end
    querry = querry.find(ids)

    render json: { status: :ok, data: table_data(querry)}
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
    if (model_class.method_defined? :custom_hash)
      Oj.dump(querry.map(&:custom_hash))
    else
      Oj.dump(querry.map(&:serializable_hash))
    end
  end
end
