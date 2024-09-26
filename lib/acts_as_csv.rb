require 'csv'

module ActsAsCsv
  def self.included(klass)
    klass.extend ClassMethods
  end

  module ClassMethods
    def acts_as_csv(*attrs)
      @csv_attrs = attrs
    end

    def csv_attrs
      @csv_attrs
    end

    def create_csv
      records = all
      CSV.generate(headers: true) do |csv|
        csv << csv_header

        records.each { |record| csv << csv_row(record) }
      end
    end

    def csv_header
      csv_attrs.map do |attr|
        if attr.is_a?(Hash)
          attr[:new_attr_name] || attr[:attr_name]
        else
          attr
        end
      end
    end

    def csv_row(record)
      csv_attrs.map do |attr|
        if attr.is_a?(Symbol)
          record.send(attr)
        else
          attr[:value].call(record.send(attr[:attr_name]))
        end
      end
    end

    def find_name_by_id(klass, id, default_name = '')
      klass.find_by(id: id).try(:name) || default_name
    end
  end
end

# ActiveRecord::Base.include ActsAsCsv
