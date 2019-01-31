namespace :transform_drs do
  task open_dr: [:environment] do
    pds_drs = PdsDr.all
    pds_drs.each do |pds_dr|
      pds_dr_comment = PdsDrComment.new
      pds_dr_comment.pds_dr_id = pds_dr.id
      pds_dr_comment.Project = pds_dr.Project
      pds_dr_comment.comment_date = pds_dr.createDate
      pds_dr_comment.comment_text = pds_dr.query
      pds_dr_comment.comment_author_id = pds_dr.drAuthor
      pds_dr_comment.status = 1
      pds_dr_comment.save
    end
  end

  task reply_dr: [:environment] do
    pds_drs = PdsDr.all
    pds_drs.each do |pds_dr|
      next unless pds_dr.replyDate

      pds_dr_comment = PdsDrComment.new
      pds_dr_comment.pds_dr_id = pds_dr.id
      pds_dr_comment.Project = pds_dr.Project
      pds_dr_comment.comment_date = pds_dr.replyDate
      pds_dr_comment.comment_text = pds_dr.reply
      pds_dr_comment.comment_author_id = pds_dr.replyAuthor
      pds_dr_comment.status = 2
      pds_dr_comment.save
    end
  end

  task close_dr: [:environment] do
    pds_drs = PdsDr.all
    pds_drs.each do |pds_dr|
      next unless pds_dr.closedDate

      pds_dr_comment = PdsDrComment.new
      pds_dr_comment.pds_dr_id = pds_dr.id
      pds_dr_comment.Project = pds_dr.Project
      pds_dr_comment.comment_date = pds_dr.closedDate
      pds_dr_comment.comment_text = 'Все работает. Молодец.'
      pds_dr_comment.comment_author_id = pds_dr.closedBy
      pds_dr_comment.status = 3
      pds_dr_comment.save
    end
  end

  task delete_comments: [:environment] do
    pds_dr_comment = PdsDrComment.all
    pds_dr_comment.destroy_all
  end
end
