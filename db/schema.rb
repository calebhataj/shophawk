# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_01_18_211840) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "histories", force: :cascade do |t|
    t.integer "hnew_balance"
    t.string "hlast_email"
    t.integer "checkedin"
    t.integer "checkedout"
    t.string "hpart_number"
    t.integer "turninginv_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "date"
    t.integer "millinginv_id"
    t.index ["turninginv_id"], name: "index_histories_on_turninginv_id"
  end

  create_table "millinginvs", force: :cascade do |t|
    t.string "part_number"
    t.string "description"
    t.integer "to_take"
    t.integer "balance"
    t.integer "minumum"
    t.string "location"
    t.string "vendor"
    t.string "buyer"
    t.string "toolinfo"
    t.string "last_received"
    t.string "last_email"
    t.string "employee"
    t.integer "hardwareid"
    t.string "status"
    t.string "orderdate"
    t.integer "to_add"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "number_of_checkouts"
    t.integer "atvendor"
    t.index ["hardwareid"], name: "index_millinginvs_on_hardwareid"
  end

  create_table "runlists", force: :cascade do |t|
    t.string "Job"
    t.integer "Job_Operation"
    t.string "WC_Vendor"
    t.string "Operation_Service"
    t.string "Vendor"
    t.string "Sched_Start"
    t.string "Sched_End"
    t.integer "Sequence"
    t.string "operator"
    t.boolean "materialWaiting"
    t.integer "dots"
    t.string "customer"
    t.integer "quantity"
    t.string "material"
    t.string "description"
    t.string "currentLocation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "Order_Date"
    t.string "Part_Number"
    t.string "Rev"
    t.integer "Order_Quantity"
    t.integer "Extra_Quantity"
    t.integer "Pick_Quantity"
    t.integer "Make_Quantity"
    t.integer "Open_Operations"
    t.integer "Completed_Quantity"
    t.integer "Shipped_Quantity"
    t.integer "FG_Transfer_Qty"
    t.integer "In_Production_Quantity"
    t.boolean "Certs_Required"
    t.integer "Act_Scrap_Quantity"
    t.string "Customer_PO"
  end

  create_table "tempjobs", force: :cascade do |t|
    t.string "Job"
    t.string "Customer"
    t.string "Order_Date"
    t.string "Part_Number"
    t.string "Rev"
    t.string "Description"
    t.integer "Order_Quantity"
    t.integer "Extra_Quantity"
    t.integer "Pick_Quantity"
    t.integer "Make_Quantity"
    t.integer "Open_Operations"
    t.integer "Completed_Quantity"
    t.integer "Shipped_Quantity"
    t.integer "FG_Transfer_Qty"
    t.integer "In_Production_Quantity"
    t.boolean "Certs_Required"
    t.integer "Act_Scrap_Quantity"
    t.string "Customer_PO"
    t.string "Customer_PO_LN"
    t.string "Sched_End"
    t.string "Sched_Start"
    t.string "Note_Text"
    t.string "Released_Date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tempmats", force: :cascade do |t|
    t.string "Job"
    t.string "Material"
    t.string "Vendor"
    t.string "Description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "turninginvs", force: :cascade do |t|
    t.string "part_number"
    t.string "description"
    t.integer "to_take"
    t.integer "balance"
    t.integer "remaining"
    t.integer "minumum"
    t.string "location"
    t.string "vendor"
    t.string "buyer"
    t.string "last_received"
    t.string "last_email"
    t.string "employee"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "number_of_checkouts"
    t.integer "hardwareid"
    t.string "status"
    t.string "orderdate"
    t.integer "to_add"
    t.string "toolinfo"
    t.index ["hardwareid"], name: "index_turninginvs_on_hardwareid"
  end

end
