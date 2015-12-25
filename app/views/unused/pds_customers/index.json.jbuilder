json.array!(@pds_customers) do |pds_customer|
  json.extract! pds_customer, :id, :Project, :AgreeName, :t, :AgreeJobTitle, :AgreeJobTitle_EN, :AcceptedName1, :AcceptedJobTitle1, :AcceptedJobTitle1_EN, :AcceptedName2, :AcceptedJobTitle2, :AcceptedJobTitle2_EN, :Name
  json.url pds_customer_url(pds_customer, format: :json)
end
