module CommentsHelper
    def display_comments
        list_item = content_tag(:div, class: '') do
        end
        if @comments.any?
          @comments.order_desc.each do |comment|
            list_item +=
              div(
                cloud(user_path(comment.user), 'image m-4', comment.user.avatar) +
                div(
                  paragraph(comment.user.fullname, 'user') +
                  paragraph(comment.body, 'comment'),
                  'd-flex flex-column justify-content-center'
                ), 'd-flex flex-row'
              )
          end
        end
        div(paragraph(@tag, 'head') + list_item, 'talk')
      end
    
      def set_lists
        case params[:list]
        when '1'
          @comments = current_user.comments.includes([:user])
          @ids = User.with_attached_avatar.fans(current_user).select(:id)
          @comments = Comment.all.order_desc.where(user_id: @ids).includes([:user])
          @tag = 'commentS FROM FOLLOWERS'
    
        when '2'
          @ids = current_user.followings.select(:id).includes([:comments])
          @comments = Comment.all.order_desc.where(user_id: @ids).includes([:user])
          @tag = 'commentS FROM PEOPLE WHO YOU ARE FOLLOWING'
    
        else
          @comments = Comment.all.includes([:user])
          @tag = 'ALL commentS FROM ALL USERS'
        end
      end
    
      private
    
      def set_comment
        @comment = Comment.find(params[:id])
      end
    
      def comment_params
        params.require(:comment).permit(:body)
      end
    end
    
