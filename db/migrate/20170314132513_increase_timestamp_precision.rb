class IncreaseTimestampPrecision < ActiveRecord::Migration
  def up
    ActiveRecord::Base.connection.tables.each do |table_name|
      columns = ActiveRecord::Base.connection.columns(table_name)

      # set the precision to microseconds(changed 6 to 4) for each datetime column on the table
      columns.select {|col| col.type == :datetime }.each do |column|
        change_column table_name, column.name, :datetime, limit: 3
      end
    end
  end
end
