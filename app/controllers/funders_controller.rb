class FundersController < ApplicationController
  before_filter :require_logged_in

  # GET /funders
  # GET /funders.xml
  def index
    @funders = Funder.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @funders }
    end
  end

  # GET /funders/1
  # GET /funders/1.xml
  def show
    @funder = Funder.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @funder }
    end
  end

  # GET /funders/new
  # GET /funders/new.xml
  def new
    @funder = Funder.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @funder }
    end
  end

  # GET /funders/1/edit
  def edit
    @funder = Funder.find(params[:id])
  end

  # POST /funders
  # POST /funders.xml
  def create
    @funder = Funder.new(params[:funder])

    respond_to do |format|
      if @funder.save
        format.html { redirect_to(@funder, :notice => 'Funder was successfully created.') }
        format.xml  { render :xml => @funder, :status => :created, :location => @funder }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @funder.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /funders/1
  # PUT /funders/1.xml
  def update
    @funder = Funder.find(params[:id])

    respond_to do |format|
      if @funder.update_attributes(params[:funder])
        format.html { redirect_to(@funder, :notice => 'Funder was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @funder.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /funders/1
  # DELETE /funders/1.xml
  def destroy
    @funder = Funder.find(params[:id])
    @funder.destroy

    respond_to do |format|
      format.html { redirect_to(funders_url) }
      format.xml  { head :ok }
    end
  end
end
