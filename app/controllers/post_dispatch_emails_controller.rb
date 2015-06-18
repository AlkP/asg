class PostDispatchEmailsController < ApplicationController
  def new

  end
  def create
    PostDispatchEmail.create(post_dispatch_id: params[:id], email: params[:email])
    @post_dispatch = PostDispatch.find(params[:id])
  end
  def destroy
    pde = PostDispatchEmail.find(params[:id])
    @post_dispatch = PostDispatch.find(pde.post_dispatch_id)
    pde.destroy
  end
end
