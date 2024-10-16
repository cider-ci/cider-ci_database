class V4Start < ActiveRecord::Migration[4.2]
  def up
    execute(IO.read(File.expand_path("../400.sql", __FILE__)))
  end
end
