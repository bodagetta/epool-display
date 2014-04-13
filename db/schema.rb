# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140412151323) do

  create_table "points", force: true do |t|
    t.integer  "shortAddr"
    t.string   "extAddr"
    t.string   "nodeType"
    t.integer  "temperature"
    t.integer  "softVersion"
    t.integer  "battery"
    t.integer  "light"
    t.integer  "messageType"
    t.integer  "workingChannel"
    t.integer  "sensorsSize"
    t.integer  "lqi"
    t.integer  "rssi"
    t.integer  "parentShortAddr"
    t.integer  "panID"
    t.string   "channelMask"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end