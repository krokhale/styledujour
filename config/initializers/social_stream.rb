SocialStream.setup do |config|
  # List the models that are social entities. These will have ties between them.
  # Remember you must add an "actor_id" foreign key column to your migration!
  #
  config.subjects = [:user, :group, :stylist ]

  # Include devise modules in User. See devise documentation for details.
  # Others available are:
  # :confirmable, :lockable, :timeoutable, :validatable
  # config.devise_modules = :database_authenticatable, :registerable,
  #                         :recoverable, :rememberable, :trackable,
  #                         :omniauthable, :token_authenticatable
  
  # Type of activities managed by actors
  # Remember you must add an "activity_object_id" foreign key column to your migration!
  #
  config.objects = [ :post, :comment, :clothing_item, :linked_clothing_item, :outfit]
  
  # Form for activity objects to be loaded 
  # You can write your own activity objects
  #
  config.activity_forms = [ :post, :document, :clothing_item, :linked_clothing_item ]

  # Config the relation model of your network
  #
  # :custom - users define their own relation types, and post with privacy, like Google+
  # :follow - user just follow other users, like Twitter
  #
  # config.relation_model = :custom

  # Expose resque interface to manage background tasks at /resque
  #
  # config.resque_access = true
 
  # Quick search (header) and Extended search models and its order. Remember to create
  # the indexes with thinking-sphinx if you are using customized models.
  # 
  # config.quick_search_models = [:user, :group]
  # config.extended_search_models = [:user, :group]

  # Cleditor controls. It is used in new message editor, for example
  # config.cleditor_controls = "bold italic underline strikethrough subscript superscript | size style | bullets | image link unlink"
end


ActiveSupport.on_load(:user) do
  load 'lib/models/user.rb'
  include UserExtended
end

ActiveSupport.on_load(:channel) do
  Channel.class_eval do
    attr_accessible :author_id, :owner_id, :user_author_id
  end
end

ActiveSupport.on_load(:actor) do
  load 'lib/models/actor.rb'
  include ActorExtended
end

ActiveSupport.on_load(:activity) do
  Activity.class_eval do
      # The title for this activity in the stream
    def title view
      case verb
      when "follow", "make-friend", "like"
        I18n.t "activity.verb.#{ verb }.#{ receiver.subject_type }.title",
        :subject => view.link_name(sender_subject),
        :contact => view.link_name(receiver_subject)
      when "post", "update"
        if sender == receiver
          view.link_name sender_subject
        else
          I18n.t "activity.verb.post.title.other_wall",
                 :sender => view.link_name(sender_subject),
                 :receiver => view.link_name(receiver_subject)
        end
      else
        I18n.t "activity.verb.#{ verb }.title",
        :subject => view.link_name(sender_subject)
      end.html_safe
    end
    
  end
end
# ActiveSupport.on_load(:linked_clothing_item) do
# SocialStream::Ability.class_eval do
  # can [:create, :destroy], LinkedClothingItem
# end
# end
if defined?(WillPaginate)
  module WillPaginate
    module ActiveRecord
      module RelationMethods
        def per(value = nil) per_page(value) end
        def total_count() count end
      end
    end
    module CollectionMethods
      alias_method :num_pages, :total_pages
    end
  end
end