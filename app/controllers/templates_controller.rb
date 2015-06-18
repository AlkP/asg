class TemplatesController < ApplicationController
  def index
    @templates = Template.all.order('updated_at DESC')
  end
  def new
    @template = Template.new
  end
  def create
    template = Template.create(templates_params)
    template.save
    @templates = Template.all.order('updated_at DESC')
    redirect_to templates_path
  end
  def destroy
    template = Template.find(params[:id])
    template.destroy
    @templates = Template.all.order('updated_at DESC')
  end
  def show
    @template = Template.find(params[:id])
  end
  def update
    template = Template.find(params[:id])
    template.update(templates_params)
    @templates = Template.all.order('updated_at DESC')
    redirect_to templates_path
  end
  private
  def templates_params
    params.require(:template).permit( :name, :att_file )
  end
end
