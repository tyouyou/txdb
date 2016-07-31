class DisatanceAndTimesController < ApplicationController
  before_action :set_disatance_and_time, only: [:show, :edit, :update, :destroy]

  # GET /disatance_and_times
  # GET /disatance_and_times.json
  def index
    @disatance_and_times = DisatanceAndTime.all
  end

  # GET /disatance_and_times/1
  # GET /disatance_and_times/1.json
  def show
  end

  # GET /disatance_and_times/new
  def new
    @disatance_and_time = DisatanceAndTime.new
  end

  # GET /disatance_and_times/1/edit
  def edit
  end

  # POST /disatance_and_times
  # POST /disatance_and_times.json
  def create
    @disatance_and_time = DisatanceAndTime.new(disatance_and_time_params)

    respond_to do |format|
      if @disatance_and_time.save
        format.html { redirect_to @disatance_and_time, notice: 'Disatance and time was successfully created.' }
        format.json { render :show, status: :created, location: @disatance_and_time }
      else
        format.html { render :new }
        format.json { render json: @disatance_and_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /disatance_and_times/1
  # PATCH/PUT /disatance_and_times/1.json
  def update
    respond_to do |format|
      if @disatance_and_time.update(disatance_and_time_params)
        format.html { redirect_to @disatance_and_time, notice: 'Disatance and time was successfully updated.' }
        format.json { render :show, status: :ok, location: @disatance_and_time }
      else
        format.html { render :edit }
        format.json { render json: @disatance_and_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /disatance_and_times/1
  # DELETE /disatance_and_times/1.json
  def destroy
    @disatance_and_time.destroy
    respond_to do |format|
      format.html { redirect_to disatance_and_times_url, notice: 'Disatance and time was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_disatance_and_time
      @disatance_and_time = DisatanceAndTime.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def disatance_and_time_params
      params.require(:disatance_and_time).permit(:start_id, :end_id, :cost_time, :distance)
    end
end
