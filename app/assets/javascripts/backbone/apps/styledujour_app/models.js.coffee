define ["jquery", "underscore", "backbone",'supermodel', 'backbone-query',
        'models'], ($, _, Backbone,Supermodel, query, Models) ->

          ################################################

          class AdmissionUser extends Supermodel.Model
            urlRoot: 'external_skynet_apps/admissions_app/admissions_app_users'

          class AdmissionUsers extends Backbone.Collection
            model: (attrs, options) ->
              AdmissionUser.create(attrs, options)
            url: 'external_skynet_apps/admissions_app/admissions_app_users'

          ################################################

#          models.ExternalApp.has().many "admission_users",
#            collection: AdmissionUsers
#            inverse: "external_app"

          #          User.has().one "student",
          #            model: Student
          #            inverse: "user"


          Models = {
            AdmissionUser: AdmissionUser
            AdmissionUsers: AdmissionUsers
          }

          Models


