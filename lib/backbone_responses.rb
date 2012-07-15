module BackboneResponses

  def self.included(base)
    base.send :include, InstanceMethods
    base.send :extend, ClassMethods
  end

  module ClassMethods
    # Add class methods here
  end

  module InstanceMethods
    # Add instance methods here

    def index
      collection_public_attributes

      respond_to do |format|
        format.html
        format.json { render :json => instance_variable_get("@#{controller_name}") }
      end
    end

    def update
      update! do |format|
        format.json do
          render :json => resource_public_attributes
        end
      end
    end

    def create
      create! do |format|
        format.json do
          render :json => resource_public_attributes
        end
      end
    end

    def show
      respond_to do |format|
        format.json do
          render :json => resource_public_attributes
        end
      end
    end

    protected

      def collection
        c         = collection_scopes
        resources = c.respond_to?(:scoped) ? c.scoped : c.all
        instance_variable_set("@#{controller_name}" , resources)
      end

      def collection_scopes
        end_of_association_chain
      end

      def resource_public_attributes
        model  = end_of_association_chain
        object = reload_resource ? resource.reload : resource

        if model.respond_to?(:acts_as_api?) and model.acts_as_api? and model.respond_to?(:"api_accessible_#{api_resource_template}")
          object.as_api_response(:"#{api_resource_template}")
        else
          object
        end
      end

      def collection_public_attributes
        if paginate?
          instance_variable_set("@#{controller_name}" , resources_with_pagination(collection))
        else
          instance_variable_set("@#{controller_name}" , resources_without_pagination(collection))
        end
      end

    end

    def resources_with_pagination(*args)
      model        = end_of_association_chain
      resources    = args.first.paginate(:page => (params[:page] || 1), :per_page => resources_per_page)

      options      = args.second || {}
      template     = options[:template] || api_collection_template
      path         = options[:path] || ""
      query_params = options[:params] || params #{}

      query_params.delete(:page)

      if model.respond_to?(:acts_as_api?) and model.acts_as_api? and model.respond_to?(:"api_accessible_#{template}")
        allowed_keys = resources.as_api_response(:"#{template}")
      else
        allowed_keys = resources
      end

      per_page      = resources.per_page
      total_entries = resources.total_entries
      total_pages   = (total_entries.to_f / per_page.to_f).ceil

      {
        :resources => allowed_keys,
        :pagination => {
          :current_page  => resources.current_page,
          :per_page      => per_page,
          :total_entries => total_entries,
          :total_pages   => total_pages,
          :params        => query_params,
          :path         => path
        }
      }
    end

    def resources_without_pagination(*args)
      model        = end_of_association_chain
      resources    = args.first

      options      = args.second || {}
      template     = options[:template] || api_collection_template
      path         = options[:path] || ""
      query_params = options[:params] || params #{}

      query_params.delete(:page)

      if model.respond_to?(:acts_as_api?) and model.acts_as_api? and model.respond_to?(:"api_accessible_#{template}")
        allowed_keys = resources.as_api_response(:"#{template}")
      else
        allowed_keys = resources
      end
    end

    def api_collection_template
      params[:api_template] || "list"
    end

    def api_resource_template
      params[:api_template] || "public"
    end

    def paginate?
      true
    end

    def resources_per_page
      50
    end

    def reload_resource
      false
    end

end
