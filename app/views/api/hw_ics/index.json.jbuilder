json.array!(@hw_ics) do |hw_ic|
  json.extract! hw_ic, :id, :Project, :ref, :ped, :rev, :tag_no, :UniquePTAG, :un, :bv, :coord, :scaleMin, :scaleMax, :Unit, :Description, :Type, :sys, :Description_EN, :panel_id, :suffix, :version, :mark
end
