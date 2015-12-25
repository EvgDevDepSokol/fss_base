json.array!(@pds_drs) do |pds_dr|
  json.extract! pds_dr, :id, :sys, :Project, :drNum, :stage, :drAuthor_text, :drAuthor, :rfr, :closed, :createDate, :expRespDate, :query, :reply, :sentForRev, :replyAuthor_text, :replyAuthor, :closedBy, :openedDate, :inprogressDate, :replyDate, :closedDate, :NameDr, :Status, :IC, :PowerState, :Priority, :Disparity, :CommingResult
  json.url pds_dr_url(pds_dr, format: :json)
end
