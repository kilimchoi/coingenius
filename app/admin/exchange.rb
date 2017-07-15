ActiveAdmin.register Exchange do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
  permit_params :name, :website, :pros, :cons, :cc_supported, :verification_required, :deposit_withdrawal_limit, :fees, :description, :rank
  controller do
    # clear blank attr on save
    def save_resource(object)
      if object.pros == ''
        object.pros = nil
      end
      super
    end
  end
end