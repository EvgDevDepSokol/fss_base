module SelectorControllerHelper
  def do_format(hash)
    hash = hash.each.map do |tmp|
      tmp1 = {}
      tmp1['value'] = tmp[0]
      tmp1['label'] = tmp[1]
      tmp = tmp1
    end

    respond_to do |format|
      format.json { render json: Oj.dump(hash) }
    end
  end

  def project
    @project ||= PdsProject.find_by(ProjectID: params[:pds_project_id])
  end
end
