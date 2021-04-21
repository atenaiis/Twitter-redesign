class CommentsController < ApplicationController
  include CommentsHelper
  before_action :authenticate_user!
  before_action :set_comment, only: %i[show edit update destroy]

  def index
    set_lists
    @comment = Comment.new
    @whotofollow = User.with_attached_avatar.who_to_follow(current_user)
  end

  def show
    set_lists
  end

  def new
    @comment = Comment.new
    @comments = current_user.comments.order_desc
  end

  def edit; end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = User.find_by(username: current_user.username.to_s).id
    respond_to do |format|
      if @comment.save
        format.html { redirect_to new_comment_path, notice: 'comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to new_comment_path, notice: 'comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end
end
