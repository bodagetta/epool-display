class PointsController < ApplicationController
  before_action :set_point, only: [:show, :edit, :update, :destroy]

  def home
    @last_measurement = Point.last

    data_table = GoogleVisualr::DataTable.new
    # Add Column Headers
    data_table.new_column('datetime', 'DateTime' )
    data_table.new_column('number', 'Pool Temperature')
    data_table.new_column('number', 'Outside Temperature')
    @myPoints = Point.from(
           Point.select("max(unix_timestamp(created_at)) as max_timestamp")
                .group("HOUR(created_at)") # subquery
          )
     .joins("INNER JOIN points ON subquery.max_timestamp = unix_timestamp(created_at)")
    dataArray = Array.new
    Point.all.each do |point|
      elementArray = Array.new
      elementArray.push(point.created_at - 5.hours)
      elementArray.push(point.temperature*-0.1367 + 167.31)
      elementArray.push(point.outside_temp)
      dataArray.push(elementArray)
    end

    data_table.add_rows(dataArray)

    option = { width: 1000, height: 400, title: 'Pool Temperature Data' }
    @chart = GoogleVisualr::Interactive::AreaChart.new(data_table, option)

    #pH charts
    data_table_ph = GoogleVisualr::DataTable.new
    # Add Column Headers
    data_table_ph.new_column('datetime', 'DateTime' )
    data_table_ph.new_column('number', 'pH')
    dataArray_ph = Array.new
    Point.all.each do |point|
      elementArray_ph = Array.new
      elementArray_ph.push(point.created_at - 5.hours)
      if point.ph
        elementArray_ph.push((point.ph * -0.0168 + 15.699).round(2))
      else 
        elementArray_ph.push(0)
      end
      dataArray_ph.push(elementArray_ph)
    end

    data_table_ph.add_rows(dataArray_ph)

    option_ph = { width: 1000, height: 400, title: 'Pool pH Data' }
    @chart_ph = GoogleVisualr::Interactive::AreaChart.new(data_table_ph, option_ph)

    #ORP charts
    data_table_orp = GoogleVisualr::DataTable.new
    # Add Column Headers
    data_table_orp.new_column('datetime', 'DateTime' )
    data_table_orp.new_column('number', 'ORP (mV)')
    dataArray_orp = Array.new
    Point.all.each do |point|
      elementArray_orp = Array.new
      elementArray_orp.push(point.created_at - 5.hours)
      if point.orp
        elementArray_orp.push(point.orp - 520)
      else 
        elementArray_orp.push(0)
      end
      dataArray_orp.push(elementArray_orp)
    end

    data_table_orp.add_rows(dataArray_orp)

    option_orp = { width: 1000, height: 400, title: 'Pool ORP Data' }
    @chart_orp = GoogleVisualr::Interactive::AreaChart.new(data_table_orp, option_orp)
  end

  # GET /points
  # GET /points.json
  def index
    @points = Point.all

    data_table = GoogleVisualr::DataTable.new
    # Add Column Headers
    data_table.new_column('datetime', 'DateTime' )
    data_table.new_column('number', 'Temperature')
    dataArray = Array.new
    Point.all.each do |point|
      elementArray = Array.new
      elementArray.push(point.created_at - 5.hours)
      elementArray.push(point.temperature*-0.1367 + 167.31)
      dataArray.push(elementArray)
    end

    data_table.add_rows(dataArray)

    option = { width: 800, height: 400, title: 'Raw Temperature Data' }
    @chart = GoogleVisualr::Interactive::AreaChart.new(data_table, option)

  end

  # GET /points/1
  # GET /points/1.json
  def show
  end

  # GET /points/new
  def new
    @point = Point.new
  end

  # GET /points/1/edit
  def edit
  end

  # POST /points
  # POST /points.json
  def create
    @point = Point.new(point_params)
    w_api = Wunderground.new("ad4183bab05ee8de")
    current_conditions = w_api.conditions_for("35757")
    @point.outside_temp = current_conditions["current_observation"]["temp_f"]

    respond_to do |format|
      if @point.save
        format.html { redirect_to @point, notice: 'Point was successfully created.' }
        format.json { render action: 'show', status: :created, location: @point }
      else
        format.html { render action: 'new' }
        format.json { render json: @point.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /points/1
  # PATCH/PUT /points/1.json
  def update
    respond_to do |format|
      if @point.update(point_params)
        format.html { redirect_to @point, notice: 'Point was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @point.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /points/1
  # DELETE /points/1.json
  def destroy
    @point.destroy
    respond_to do |format|
      format.html { redirect_to points_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_point
      @point = Point.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def point_params
      params.require(:point).permit(:shortAddr, :extAddr, :nodeType, :temperature, :softVersion, :battery, :light, :messageType, :workingChannel, :sensorsSize, :lqi, :rssi, :parentShortAddr, :panID, :channelMask, :ph, :orp) if params[:point]
    end
end
