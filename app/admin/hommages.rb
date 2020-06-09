ActiveAdmin.register Hommage do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
 permit_params do
   permitted = [:permitted, :attributes]
   permitted << :other if params[:action] == 'create' && current_user.admin?
   permitted
 end

 # le controlleur se trouve dans applicaitoncontroller il faut ajouter ce code car il y avait une erreur pour l'affichage

 # controller do
 #   skip_before_action :set_search
 # end

end
