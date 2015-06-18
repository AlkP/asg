class PostDispatchesController < ApplicationController
  def index
    #@post_dispatch = PostDispatch.new
    @post_dispatches_once = PostDispatch.where('periodicity = ?', 'once')
    @post_dispatches_many = PostDispatch.where('periodicity != ?', 'once')
  end
  def new
    @post_dispatch = PostDispatch.create(periodicity: 'once',
                                         whom: 'my_list',
                                         subject: 'Тема',
                                         body: 'Письмо',
                                         date: Date.today() + 1,
                                         time: Time.now())
    unless params[:who].nil?
      if params[:who] == 'client'
        @whom = 'client'
        @post_dispatch.whom = 'client'
        @list = Client.all_alkp(session[:filter]).order('updated_at DESC')
        arr = []
        @list.each do |ll|
          arr += [ll.id]
        end
        @post_dispatch.list = arr.join(", ")
      else
        @whom = 'staff'
        @post_dispatch.whom = 'staff'
        @list = Staff.accept_filter(session[:filter_staff])
        #@list = session[:filter_staff]
        arr = []
        @list.each do |ll|
          arr += [ll.id]
        end
        @post_dispatch.list = arr.join(", ")
      end
    end
    @post_dispatch.save
    @post_dispatches_once = PostDispatch.where('periodicity = ?', 'once')
    @post_dispatches_many = PostDispatch.where('periodicity != ?', 'once')
  end
  def show
    @post_dispatch = PostDispatch.find(params[:id])
    #@whom = @post_dispatch.whom if ((@post_dispatch.whom == 'client') or (@post_dispatch.whom == 'staff'))
    @whom = @post_dispatch.whom
    if (@post_dispatch.whom == 'client')
      list = @post_dispatch.list.split(', ')
      @list = Client.where('id in (?)', list)
    end
    if (@post_dispatch.whom == 'staff')
      list = @post_dispatch.list.split(', ')
      @list = Staff.where('id in (?)', list)
    end
  end
  def creat
    #UserMailer.send_to_client(session[:filter], params[:subject], params[:body]).deliver
  end
  def destroy
    post_dispatch = PostDispatch.find(params[:id])
    post_dispatch.destroy

    @post_dispatches_once = PostDispatch.where('periodicity = ?', 'once')
    @post_dispatches_many = PostDispatch.where('periodicity != ?', 'once')

    respond_to do |format|
      format.js
    end
  end
  def update
    puts "suka * " * 500
    puts params
    post_dispatch = PostDispatch.find(params[:id])
    params[:p_d][:time] = params[:post_dispatch]['time(4i)'] + ':' + params[:post_dispatch]['time(5i)']
    post_dispatch.update(post_dispatches)
    @post_dispatches_once = PostDispatch.where('periodicity = ?', 'once')
    @post_dispatches_many = PostDispatch.where('periodicity != ?', 'once')
    respond_to do |format|
      format.js
    end
  end
  private
  def post_dispatches
    params.require(:p_d).permit( :subject,
                                 :body,
                                 :whom,
                                 :periodicity,
                                 :date,
                                 :time)
  end
end
