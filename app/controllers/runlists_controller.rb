class RunlistsController < ApplicationController
  before_action :set_runlist, only: %i[ show edit update destroy  ]
  require 'date'

  def teststream
  end
  # GET /runlists or /runlists.json
  def index
    #Runlist.importcsv #updates DB with current CSV file. OLD: now done with rake task
    @runlists = Runlist.all
    @wc = [] #define empty array
    @wcs = Workcenter.all
    @wcs.each do |a| 
      @wc << a.workCenter #creates array of just workcenters 
    end
    @wc.uniq! #narrows down array to only be unique workcenters
    @wc.sort! { |a,b| a && b ? a <=> b : a ? -1 : 1 } #sorts workcenter alphbetically
    @departments = []
    @d = Department.all
    @d.each do |a|
      @departments << a.department
    end
    @departments.sort! { |a,b| a && b ? a <=> b : a ? -1 : 1 }

  end

  def activerunlist #loads up selected Workcenter for Runlist
    @wc = Runlist.where(WC_Vendor: params[:wc]) #loads all workcenters that match the select field chosen sent over using runlist_controller.js
    @wc = @wc.sort { |a,b| (a.Sched_Start == b.Sched_Start) ? a.Job <=> b.Job : a.Sched_Start <=> b.Sched_Start } #sorts items by schedule start date, then job # within
    #puts @wc
    @today = Date.today#.strftime('%m-%d-%Y')
  end

  def changedepartment
    dep = Department.where(department: params[:department]) #gets department object that matches data sent form frontend
    depID = dep.ids #saves the ID number of department
    @department = Department.find_by(id: depID) #gets the exact object needed for model association
    #puts @dep.workcenters #model containing all objects for that department
    @wclist = [] #initiate array
    @department.workcenters.each do |a| #for the department, add the associated workCenters to the array
      @wclist << a.workCenter
    end
    @wc = Runlist.where(WC_Vendor: @wclist) #call all workcenters from the array
    @wc = @wc.sort { |a,b| (a.Sched_Start == b.Sched_Start) ? a.Job <=> b.Job : a.Sched_Start <=> b.Sched_Start } #sorts items by schedule start date, then job # within
    @wc = @wc.sort { |a,b| (a.Sched_Start == b.Sched_Start) ? a.WC_Vendor <=> b.WC_Vendor : a.Sched_Start <=> b.Sched_Start } #sorts items by schedule start date, then job # within
    @today = Date.today#.strftime('%m-%d-%Y')
  end

  def checkboxsubmit #updates checkbox value when toggled
    @runlist = Runlist.find_by_id params[:id]
    if @runlist.matWaiting == nil 
      @runlist.matWaiting = false
    end
    @runlist.matWaiting = !@runlist.matWaiting #toggles between true and false
    @matchingJobs = Runlist.where(Job: @runlist.Job) #get every other job with same job number
    @matchingJobs.each do |job| 
      job.matWaiting = true #set the material waiting boolean to be the same of initial checkbox
      job.save 
    end
    @runlist.save #updates DB with new value
  end

  # GET /runlists/1 or /runlists/1.json
  def show
  end

  # GET /runlists/new
  def new
    @runlist = Runlist.new
  end

  # GET /runlists/1/edit
  def edit
  end

  # POST /runlists or /runlists.json
  def create
    @runlist = Runlist.new(runlist_params)
    respond_to do |format|
      if @runlist.save
        format.html { redirect_to runlist_url(@runlist), notice: "Runlist was successfully created." }
        format.json { render :show, status: :created, location: @runlist }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @runlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /runlists/1 or /runlists/1.json
  def update
    @runlist = Runlist.find_by_id params[:id]
    @runlist.update runlist_params
    @runlist.save
    respond_to do |format|
      if @runlist.update(runlist_params)
        format.html { redirect_to runlist_url(@runlist), notice: "Runlist was successfully updated." }
        format.json { render :show, status: :ok, location: @runlist }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @runlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /runlists/1 or /runlists/1.json
  def destroy
    @runlist.destroy

    respond_to do |format|
      format.html { redirect_to runlists_url, notice: "Runlist was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_runlist
      @runlist = Runlist.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def runlist_params
      params.require(:runlist).permit(:Job, :Job_Operation, :WC_Vendor, :Operation_Service, :Vendor, :Sched_Start, :Sched_End, :Sequence, :Customer, :Order_Date, :Part_Number, :Rev, :Description, :Order_Quantity, :Extra_Quantity, :Pick_Quantity, :Job, :Open_Operations, :Completed_Quantity, :Shipped_Quantity, :FG_Transfer_Qty, :In_Production_Quantity, :Certs_Required, :Act_Scrap_Quantity, :Customer_PO, :Customer_PO_LN, :Job_Sched_End, :Job_Sched_Start, :Note_Text, :Released_Date, :Material, :Mat_Vendor, :Mat_Description, :employee, :dots, :currentOp, :matWaiting)
    end
end
