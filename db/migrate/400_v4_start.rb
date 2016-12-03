class V4Start < ActiveRecord::Migration
  def change
    execute (IO.read File.expand_path('../400.sql', __FILE__))
  end
end
