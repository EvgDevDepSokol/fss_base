# coding: utf-8

namespace :temp do
  task get_table_list: :environment do
    tables = File.open 'public/data/hw_ic.html' do |file|
      doc = Nokogiri::HTML(file)
      array = doc.css('body table .gvList tr').map { |a| b = a.children[1]; { text: b.text, attribute: a.attribute('onmouseover').try(:value) } }
      array.select { |a| a[:attribute] }.map do |hash|
        table = hash[:attribute].match(/ShowToolTip\('ToolTip','(.*)'\);/)[1]
        { table: table, russian: hash[:text] }
      end.reduce({}) do |hash, t|
        hash.merge(t[:table].to_sym => t[:russian])
      end
    end

    File.open('public/data/tables.yml', 'w') { |f| f.write tables.to_yaml }
  end

  task get_tables_with_columns: :environment do
    Rails.application.eager_load!

    tables = ActiveRecord::Base.descendants
                               .reduce({}) do |hash, model|
      table = model.table_name
      p model.to_s
      attributes = model.attribute_names.reduce({}) { |h, a| h.merge(a => a) }
      hash.merge(table => attributes)
    end

    File.open('public/data/table_translations.yml', 'w') { |f| f.write tables.to_yaml }
  end
end
