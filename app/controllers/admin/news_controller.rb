module Admin
  class NewsController < Admin::ApplicationController
      skip_before_action :verify_authenticity_token
      after_action :change_question, only: [:create, :update]
    # Overwrite any of the RESTful controller actions to implement custom behavior
    # For example, you may want to send an email after a foo is updated.
    #
    # def update
    #   super
    #   send_foo_updated_email(requested_resource)
    # end

    # Override this method to specify custom lookup behavior.
    # This will be used to set the resource for the `show`, `edit`, and `update`
    # actions.
    #
    # def find_resource(param)
    #   Foo.find_by!(slug: param)
    # end

    # The result of this lookup will be available as `requested_resource`

    # Override this if you have certain roles that require a subset
    # this will be used to set the records shown on the `index` action.
    #
    # def scoped_resource
    #   if current_user.super_admin?
    #     resource_class
    #   else
    #     resource_class.with_less_stuff
    #   end
    # end

    # Override `resource_params` if you want to transform the submitted
    # data before it's persisted. For example, the following would turn all
    # empty values into nil values. It uses other APIs such as `resource_class`
    # and `dashboard`:
    #
    # def resource_params
    #   params.require(resource_class.model_name.param_key).
    #     permit(dashboard.permitted_attributes).
    #     transform_values { |value| value == "" ? nil : value }
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information

    

    def news_question
        Question.create!(question_name: params[:question], answer_type: params[:ans_type], news_title: params[:title])
    end

    def destroy_avatar
      news = News.find(params[:id])
      news.media.destroy
      redirect_to admin_news_url(params[:id])
    end

    private
    def change_question
        news = News.find_by(title: params[:news][:title])
        question = Question.find_by(news_title: params[:news][:title])
        if question.present?
            question.update(news_id: news.id)
            news.update(news_type: "Poll")
        end

    end

  end
end
