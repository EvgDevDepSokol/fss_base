# frozen_string_literal: true

module SelectorControllerHelper
  # Helper for selectors

  private

  def project
    @project ||= PdsProject.find_by(ProjectID: params[:pds_project_id])
  end

  def do_format(hash)
    hash = hash.each.map do |tmp|
      { value: tmp[0], label: tmp[1] }
    end

    respond_to do |format|
      format.json { render json: Oj.dump(hash) }
    end
  end
end
