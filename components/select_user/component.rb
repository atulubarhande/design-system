# frozen_string_literal: true

class SelectUser::Component < ApplicationViewComponent
  include ApplicationHelper

  option :users
  option :billing_contact
  option :name

  def selected_user
    billing_contact&.user
  end

  def selected_user_name
    selected_user.present? ? "#{selected_user.name} (#{selected_user.email})" : t('common.select_user_from_list')
  end

end
