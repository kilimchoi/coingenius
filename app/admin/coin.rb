ActiveAdmin.register Coin do
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
  permit_params :symbol, :description, :pros, :cons, :website, :where_to_buy, :image_url, :name, :category, 
                exchange_ids: []
  form do |f| 
    f.actions
    f.inputs 
    f.inputs 'Exchanges' do 
      f.input :exchanges, as: :check_boxes, :input_html => {:multiple => true}
    end
    f.actions
  end
end
