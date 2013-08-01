define ["jquery", "underscore", "backbone",'supermodel', 'backbone-query'], ($, _, Backbone,Supermodel, query) ->

#  SkynetApp = require('app')
  class Admin extends Supermodel.Model
    paramRoot: 'admin'

  class Admins extends Backbone.Collection
    model: (attrs, options) ->
      Admin.create(attrs, options)
    url: '/admins'

  ################################################

  class College extends Supermodel.Model
    urlRoot: 'colleges'

  class Colleges extends Backbone.Collection
    model: (attrs, options) ->
      College.create(attrs, options)
    url: 'colleges'

  ################################################

  class Department extends Supermodel.Model
    urlRoot: 'departments'

  class Departments extends Backbone.QueryCollection
    model: (attrs, options) ->
      Department.create(attrs, options)
    url: 'departments'

  ################################################

  class Student extends Supermodel.Model
    urlRoot: 'students'

    active_streams: ->
      undefined

  class Students extends Backbone.Collection
    model: (attrs, options) ->
      Student.create(attrs, options)
    url: 'students'


  ################################################


  class Teacher extends Supermodel.Model
    urlRoot: 'teachers'

    active_stream: ->
      undefined


  class Teachers extends Backbone.QueryCollection
    model: (attrs, options) ->
      Teacher.create(attrs, options)
    url: 'teachers'

  ################################################

  class User extends Supermodel.Model
    urlRoot: 'users'

    person: ->
      @student() || @teacher() || @staff() || @admin()

  class Users extends Backbone.Collection
    model: (attrs, options) ->
      User.create(attrs, options)
    url: 'users'

  ################################################

  class UserSession extends Supermodel.Model
    urlRoot: 'user_sessions'

  class UserSessions extends Backbone.Collection
    model: (attrs, options) ->
      UserSession.create(attrs, options)
    url: 'user_sessions'

  ################################################

  class Feed extends Supermodel.Model
    urlRoot: 'feeds'


  class Feeds extends Backbone.QueryCollection
    model: (attrs, options) ->
      Feed.create(attrs, options)

    comparator: (model) ->
      -model.id

    url: 'feeds'
#    comparator: (model) ->
#      model.id

  ################################################

  class FeedComment extends Supermodel.Model
    urlRoot: 'feed_comments'

  class FeedComments extends Backbone.Collection
    model: (attrs, options) ->
      FeedComment.create(attrs, options)
    url: 'feed_comments'

  ################################################

  class ChatThread extends Supermodel.Model
    url: "chat_threads"

  class ChatThreads extends Backbone.Collection
    model: (attrs, options) ->
      ChatThread.create(attrs, options)
    url: 'chat_threads'


  ################################################

  class ChatMessage extends Supermodel.Model
    url: "chat_messages"

  class ChatMessages extends Backbone.Collection
    model: (attrs, options) ->
      ChatMessage.create(attrs, options)
    url: 'chat_messages'

  ################################################

  class InboxItem extends Supermodel.Model
#    url: "inbox_items"
    urlRoot: "inbox_items"

  class InboxItems extends Backbone.Collection
    model: (attrs, options) ->
      InboxItem.create(attrs, options)
    url: 'inbox_items'

  ################################################

  class Message extends Supermodel.Model
    url: "messages"

  class Messages extends Backbone.Collection
    model: (attrs, options) ->
      Message.create(attrs, options)
    url: 'messages'

  ################################################

  class Stream extends Supermodel.Model
#    url: "streams"
    urlRoot: "streams"

  class Streams extends Backbone.Collection
    model: (attrs, options) ->
      Stream.create(attrs, options)
    url: 'streams'

  ################################################

  class ActiveStream extends Supermodel.Model
    url: "active_streams"

  class ActiveStreams extends Backbone.Collection
    model: (attrs, options) ->
      ActiveStream.create(attrs, options)
    url: 'active_streams'

  ################################################

  class QuickLink extends Supermodel.Model
    url: "quick_links"

  class QuickLinks extends Backbone.Collection
    model: (attrs, options) ->
      QuickLink.create(attrs, options)
    url: "quick_links"

  ################################################

  class NewsItem extends Supermodel.Model
    url: "news"

  class NewsCollection extends Backbone.Collection
    model: (attrs, options) ->
      NewsItem.create(attrs, options)
    url: "news"

  ################################################

  class Subject extends Supermodel.Model
    urlRoot: "subjects"

  class Subjects extends Backbone.QueryCollection
    model: (attrs, options) ->
      Subject.create(attrs, options)
    url: "subjects"

  ################################################

  class StudentSubscription extends Supermodel.Model
#    url: "student_subscriptions"
    urlRoot: "student_subscriptions"

  class StudentSubscriptions extends Backbone.QueryCollection
    model: (attrs, options) ->
      StudentSubscription.create(attrs, options)
    url: "student_subscriptions"

  ################################################

  class SubjectSubscription extends Supermodel.Model
    urlRoot: "subject_subscriptions"

  class SubjectSubscriptions extends Backbone.QueryCollection
    model: (attrs, options) ->
      SubjectSubscription.create(attrs, options)
    url: "subject_subscriptions"

  ################################################

  class Book extends Supermodel.Model
    urlRoot: "books"

  class Books extends Backbone.Collection
    model: (attrs, options) ->
      Book.create(attrs, options)
    url: "books"

  ################################################

  class Asset extends Supermodel.Model
    urlRoot: "assets"

  class Assets extends Backbone.QueryCollection
    model: (attrs, options) ->
      Asset.create(attrs, options)
    url: "assets"

  ################################################

  class Event extends Supermodel.Model
    urlRoot: "events"

  class Events extends Backbone.QueryCollection
    model: (attrs, options) ->
      Event.create(attrs, options)
    url: "events"

  ################################################

  class EventParticipant extends Supermodel.Model
    urlRoot: "event_participants"

  class EventParticipants extends Backbone.QueryCollection
    model: (attrs, options) ->
      EventParticipant.create(attrs, options)
    url: "event_participants"

  ################################################

  class EventOrganizer extends Supermodel.Model
    urlRoot: "event_organizers"

  class EventOrganizers extends Backbone.QueryCollection
    model: (attrs, options) ->
      EventOrganizer.create(attrs, options)
    url: "event_organizers"

  ################################################

  class CollegeLocation extends Supermodel.Model
    urlRoot: "college_locations"
    toString: ->
      @.get('name')

  class CollegeLocations extends Backbone.QueryCollection
    model: (attrs, options) ->
      CollegeLocation.create(attrs, options)
    url: "college_locations"

  ################################################

  class Gallery extends Supermodel.Model
    urlRoot: "galleries"

  class Galleries extends Backbone.QueryCollection
    model: (attrs, options) ->
      Gallery.create(attrs, options)
    url: "galleries"

  ################################################

  class Album extends Supermodel.Model
    urlRoot: "albums"
    toString: ->
      @.get('name')

  class Albums extends Backbone.QueryCollection
    model: (attrs, options) ->
      Album.create(attrs, options)
    url: "albums"

  ################################################

  class AlbumImage extends Supermodel.Model
    urlRoot: "album_images"

  class AlbumImages extends Backbone.QueryCollection
    model: (attrs, options) ->
      AlbumImage.create(attrs, options)
    url: "album_images"

  ################################################

  class ImageComment extends Supermodel.Model
    urlRoot: "image_comments"

  class ImageComments extends Backbone.QueryCollection
    model: (attrs, options) ->
      ImageComment.create(attrs, options)
    url: "image_comments"

  ################################################

  class Following extends Supermodel.Model
    urlRoot: "subscriptions"

  class FollowingCollection extends Backbone.QueryCollection
    model: (attrs, options) ->
      Following.create(attrs, options)
    url: "subscriptions"

  ################################################

  class Follower extends Supermodel.Model
    urlRoot: "subscriptions"

  class FollowerCollection extends Backbone.QueryCollection
    model: (attrs, options) ->
      Follower.create(attrs, options)
    url: "subscriptions"

  ################################################

  class Page extends Supermodel.Model
    urlRoot: "pages"

  class Pages extends Backbone.QueryCollection
    model: (attrs, options) ->
      Page.create(attrs, options)
    url: "pages"

  ################################################

  class PageMember extends Supermodel.Model
    urlRoot: "page_members"

  class PageMembers extends Backbone.QueryCollection
    model: (attrs, options) ->
      PageMember.create(attrs, options)
    url: "page_members"

  ################################################

  class Logo extends Supermodel.Model
    urlRoot: "logos"

  class Logos extends Backbone.QueryCollection
    model: (attrs, options) ->
      Logo.create(attrs, options)
    url: "logos"


  ################################################

  class Notification extends Supermodel.Model
    urlRoot: "notifications"

  class Notifications extends Backbone.QueryCollection
    model: (attrs, options) ->
      Notification.create(attrs, options)
    url: "notifications"


  ################################################

  class CustomFeeder extends Supermodel.Model
    urlRoot: "custom_feeders"

  class CustomFeeders extends Backbone.QueryCollection
    model: (attrs, options) ->
      CustomFeeder.create(attrs, options)
    url: "custom_feeders"

  ################################################

  class Staff extends Supermodel.Model
    urlRoot: "staffs"

  class Staffs extends Backbone.QueryCollection
    model: (attrs, options) ->
      Staff.create(attrs, options)
    url: "staffs"

  ################################################

  class EmailAttachment extends Supermodel.Model
    urlRoot: "email_attachments"

  class EmailAttachments extends Backbone.QueryCollection
    model: (attrs, options) ->
      EmailAttachment.create(attrs, options)
    url: "email_attachments"



  ################################################

  class Mailbox extends Supermodel.Model
    urlRoot: 'mailboxes'

  class Mailboxes extends Backbone.QueryCollection
    model: (attrs, options) ->
      Mailbox.create(attrs, options)
    url: 'mailboxes'

  ################################################

  class Container extends Supermodel.Model
    urlRoot: 'containers'

  class Containers extends Backbone.QueryCollection
    model: (attrs, options) ->
      Container.create(attrs, options)
    url: 'containers'


  ################################################

  class App extends Supermodel.Model
    urlRoot: 'apps'

  class Apps extends Backbone.QueryCollection
    model: (attrs, options) ->
      App.create(attrs, options)
    url: 'apps'

  ################################################

  class BugFeed extends Supermodel.Model
    urlRoot: 'bug_feeds'

  class BugFeeds extends Backbone.QueryCollection
    model: (attrs, options) ->
      BugFeed.create(attrs, options)
    url: 'bug_feeds'


  ################################################

  class SchedulerTask extends Supermodel.Model
    urlRoot: 'skynet_apps/scheduler_app/scheduler_tasks'

  class SchedulerTasks extends Backbone.QueryCollection
    model: (attrs, options) ->
      SchedulerTask.create(attrs, options)
    url: 'skynet_apps/scheduler_app/scheduler_tasks'


  ################################################

  class CustomItem extends Supermodel.Model

  class CustomItems extends Backbone.QueryCollection
    model: (attrs, options) ->
      CustomItem.create(attrs, options)


  ################################################

  class Semester extends Supermodel.Model
    urlRoot: 'semesters'

  class Semesters extends Backbone.QueryCollection
    model: (attrs, options) ->
      Semester.create(attrs, options)
    url: 'semesters'


  ################################################

  class SkynetAuthorization extends Supermodel.Model
    urlRoot: 'skynet_authorizations'

  class SkynetAuthorizations extends Backbone.QueryCollection
    model: (attrs, options) ->
      SkynetAuthorization.create(attrs, options)
    url: 'skynet_authorizations'

  ################################################

  class MailingList extends Supermodel.Model
    urlRoot: 'mailing_lists'
    toString: ->
      @.get('name')

  class MailingLists extends Backbone.QueryCollection
    model: (attrs, options) ->
      MailingList.create(attrs, options)
    url: 'mailing_lists'

  ################################################

  class HelpSection extends Supermodel.Model
    urlRoot: 'help_sections'
    toString: ->
      @.get('name')

  class HelpSections extends Backbone.QueryCollection
    model: (attrs, options) ->
      HelpSection.create(attrs, options)
    url: 'help_sections'



  ################################################

  class HelpArticle extends Supermodel.Model
    urlRoot: 'help_articles'

  class HelpArticles extends Backbone.QueryCollection
    model: (attrs, options) ->
      HelpArticle.create(attrs, options)
    url: 'help_articles'

  ################################################

  class SkynetForm extends Supermodel.Model
    urlRoot: 'skynet_apps/shared/skynet_forms'
    toString: ->
      @.get('form_type')

  class SkynetForms extends Backbone.QueryCollection
    model: (attrs, options) ->
      SkynetForm.create(attrs, options)
    url: 'skynet_apps/shared/skynet_forms'

  ################################################

  class SkynetFormField extends Supermodel.Model
    urlRoot: 'skynet_apps/shared/skynet_form_fields'

  class SkynetFormFields extends Backbone.QueryCollection
    model: (attrs, options) ->
      SkynetFormField.create(attrs, options)
    url: 'skynet_apps/shared/skynet_form_fields'

  ################################################


  College.has().many "departments",
    collection: Departments
    inverse: "college"

  College.has().many "students",
    collection: Students
    inverse: "college"

  College.has().many "teachers",
    collection: Teachers
    inverse: "college"

  College.has().many "staff",
    collection: Staffs
    inverse: "college"

  College.has().many "college_locations",
    collection: CollegeLocations
    inverse: "college"

  User.has().one "student",
    model: Student
    inverse: "user"

  User.has().one "teacher",
    model: Teacher
    inverse: "user"

  User.has().one "admin",
    model: Admin
    inverse: "user"

  User.has().one "staff",
    model: Staff
    inverse: "user"

#  Teacher.has().one "user",
#    model: User
#    inverse: "teacher"

  Student.has().one "active_stream",
    model: ActiveStream
    inverse: "student"

#  Teacher.has().many "active_streams",
#    collection: ActiveStreams
#    inverse: "teacher"

  Teacher.has().many "subject_subscriptions",
    collection: SubjectSubscriptions
    inverse: "teacher"

  User.has().many "feeds",
    collection: Feeds
    inverse: "feed"

  Feed.has().many "feed_comments",
    collection: FeedComments
    inverse: "feed"

  ChatThread.has().many "chat_messages",
    collection: ChatMessages
    inverse: "chat_thread"

  InboxItem.has().one "message",
    model: Message
    inverse: "inbox_item"

  College.has().many "streams",
    collection: Streams
    inverse: "college"

  Stream.has().many "news_items",
    collection: NewsCollection
    inverse: "stream"

  Stream.has().many "quick_links",
    collection: QuickLinks
    inverse: "stream"


  Stream.has().many "student_subscriptions",
    collection: StudentSubscriptions
    inverse: "stream"

  Stream.has().many "subject_subscriptions",
    collection: SubjectSubscriptions
    inverse: "stream"

  StudentSubscription.has().one "student",
    model: Student
    inverse: "student_subscription"

  SubjectSubscription.has().one "subject",
    model: Subject
    inverse: "subject_subscription"

  ActiveStream.has().one "stream",
    model: Stream
    inverse: "active_stream"

  Stream.has().many "feeds",
    collection: Feeds
    inverse: "feed"

  Subject.has().many "quick_links",
    collection: QuickLinks
    inverse: "subject"

  Subject.has().many "feeds",
    collection: Feeds
    inverse: "subject"

  Subject.has().many "books",
    collection: Books
    inverse: "subject"

  Subject.has().many "assets",
    collection: Assets
    inverse: "subject"

  Department.has().many "news_items",
    collection: NewsCollection
    inverse: "department"

  Department.has().many "subjects",
    collection: Subjects
    inverse: "department"

  Department.has().many "teachers",
    collection: Teachers
    inverse: "department"

  Department.has().many "staff",
    collection: Staffs
    inverse: "department"

  Department.has().many "events",
    collection: Events
    inverse: "department"

  Event.has().many "feeds",
    collection: Feeds
    inverse: "event"

  Event.has().many "event_participants",
    collection: EventParticipants
    inverse: "event"

  Event.has().one "event_organizer",
    model: EventOrganizer
    inverse: "event"

  EventOrganizer.has().one "teacher",
    model: Teacher
    inverse: "event_organizer"

  Event.has().many "college_locations",
    collection: CollegeLocations
    inverse: "event"

  Event.has().one "gallery",
    model: Gallery
    inverse: "event"

  Gallery.has().many "albums",
    collection: Albums
    inverse: "gallery"

  Album.has().many "album_images",
    collection: AlbumImages
    inverse: "album"

  AlbumImage.has().many "image_comments",
    collection: ImageComments
    inverse: "album_image"

  Department.has().one "gallery",
    model: Gallery
    inverse: "event"

  Album.has().one "gallery",
    model: Gallery
    inverse: "event"

  User.has().many "followers",
    collection: FollowerCollection
    inverse: "user"

  User.has().many "following",
    collection: FollowingCollection
    inverse: "user"

  User.has().many "pages",
    collection: Pages
    inverse: "user"

  Page.has().many "feeds",
    collection: Feeds
    inverse: "page"

  Page.has().one "gallery",
    model: Gallery
    inverse: "page"

  Page.has().many "page_members",
    collection: PageMembers
    inverse: "page"

  Page.has().many "events",
    collection: Events
    inverse: "page"


  Department.has().one "logo",
    model: Logo
    inverse: "department"

  Event.has().one "logo",
    model: Logo
    inverse: "event"

  User.has().many "notifications",
    collection: Notifications
    inverse: "user"

  College.has().many "news_items",
    collection: NewsCollection
    inverse: "college"

  Event.has().many "news_items",
    collection: NewsCollection
    inverse: "event"

  Notification.has().one "news_item",
    model: NewsItem
    inverse: "notification"

  Feed.has().one "custom_feeder",
    model: CustomFeeder
    inverse: "feed"

  CustomFeeder.has().one "event_participant",
    model: EventParticipant
    inverse: "custom_feeder"

  Department.has().one "album",
    model: Album
    inverse: "department"

  Page.has().one "logo",
    model: Logo
    inverse: "page"

  Page.has().one "album",
    model: Album
    inverse: "page"

  User.has().one "gallery",
    model: Gallery
    inverse: "user"

  Message.has().many "email_attachments",
    collection: EmailAttachments
    inverse: "message"

  Student.has().one "department",
    model: Department
    inverse: "student"

  Teacher.has().one "department",
    model: Department
    inverse: "teacher"

  Staff.has().one "department",
    model: Department
    inverse: "staff"

  User.has().many "owned_events",
    collection: Events
    inverse: "user"

  College.has().one "logo",
     model: Logo
     inverse: "college"

  Teacher.has().one "user",
    model: User
    inverse: "teacher"

  Staff.has().one "user",
    model: User
    inverse: "staff"

  User.has().many "containers",
    collection: Containers
    inverse: "user"

  Container.has().many "messages",
    collection: Messages
    inverse: "container"

  Mailbox.has().many "users",
    collection: Users
    inverse: "mailbox"

  College.has().one "mailbox",
    model: Mailbox
    inverse: "college"

  College.has().many "skynet_apps",
     collection: Apps
     inverse: "college"

  BugFeed.has().many "feeds",
     collection: Feeds
     inverse: "bug_feed"

  User.has().many "scheduler_tasks",
    collection: SchedulerTasks
    inverse: "user"

  College.has().many "semesters",
    collection: Semesters
    inverse: "college"

  User.has().one "skynet_authorization",
    model: SkynetAuthorization
    inverse: "user"

  College.has().one "bug_feed",
    model: BugFeed
    inverse: "college"

  College.has().many "mailing_lists",
    collection: MailingLists
    inverse: "college"

  HelpSection.has().many "help_articles",
    collection: HelpArticles
    inverse: "help_section"

  SkynetForm.has().many "skynet_form_fields",
    collection: SkynetFormFields
    inverse: "skynet_form"

  Department.has().one "skynet_form",
    model: SkynetForm
    inverse: "department"

  Subject.has().one "skynet_form",
    model: SkynetForm
    inverse: "subject"

  Event.has().one "skynet_form",
    model: SkynetForm
    inverse: "event"

  Page.has().one "skynet_form",
    model: SkynetForm
    inverse: "page"

  ################################################

  Models = {
    Admin: Admin
    Admins: Admins
    College: College
    Colleges: Colleges
    Department: Department
    Departments: Departments
    Student: Student
    Students: Students
    Teacher: Teacher
    Teachers: Teachers
    User: User
    Users: Users
    Feed: Feed
    Feeds: Feeds
    FeedComment: FeedComment
    FeedComments: FeedComments
    ChatThread: ChatThread
    ChatThreads: ChatThreads
    ChatMessage: ChatMessage
    ChatMessages: ChatMessages
    InboxItem: InboxItem
    InboxItems: InboxItems
    Message: Message
    Messages: Messages
    Stream: Stream
    Streams: Streams
    ActiveStream: ActiveStream
    ActiveStreams: ActiveStreams
    QuickLink: QuickLink
    QuickLinks: QuickLinks
    NewsItem: NewsItem
    NewsCollection: NewsCollection
    Subject: Subject
    Subjects: Subjects
    StudentSubscription: StudentSubscription
    StudentSubscriptions: StudentSubscriptions
    SubjectSubscription: SubjectSubscription
    SubjectSubscriptions: SubjectSubscriptions
    Book: Book
    Books: Books
    Asset: Asset
    Assets: Assets
    Event: Event
    Events: Events
    EventParticipant: EventParticipant
    EventParticipants: EventParticipants
    EventOrganizer: EventOrganizer
    EventOrganizers: EventOrganizers
    CollegeLocation: CollegeLocation
    CollegeLocations: CollegeLocations
    Gallery: Gallery
    Galleries: Galleries
    Album: Album
    Albums: Albums
    AlbumImage: AlbumImage
    AlbumImages: AlbumImages
    ImageComment: ImageComment
    ImageComments: ImageComments
    Following: Following
    FollowingCollection: FollowingCollection
    Follower: Follower
    FollowerCollection: FollowerCollection
    Page: Page
    Pages: Pages
    PageMember: PageMember
    PageMembers: PageMembers
    Logo: Logo
    Logos: Logos
    Notification: Notification
    Notifications: Notifications
    CustomFeeder: CustomFeeder
    CustomFeeders: CustomFeeders
    Staff: Staff
    Staffs: Staffs
    UserSession: UserSession
    UserSessions: UserSessions
    EmailAttachment: EmailAttachment
    EmailAttachments: EmailAttachments
    Container: Container
    Containers: Containers
    Mailbox: Mailbox
    Mailboxes: Mailboxes
    App: App
    Apps: Apps
    BugFeed: BugFeed
    BugFeeds: BugFeeds
    SchedulerTask: SchedulerTask
    SchedulerTasks: SchedulerTasks
    CustomItem: CustomItem
    CustomItems: CustomItems
    Semester: Semester
    Semesters: Semesters
    SkynetAuthorization: SkynetAuthorization
    SkynetAuthorizations: SkynetAuthorizations
    MailingList: MailingList
    MailingLists: MailingLists
    HelpArticle: HelpArticle
    HelpArticles: HelpArticles
    HelpSection: HelpSection
    HelpSections: HelpSections
    SkynetForm: SkynetForm
    SkynetForms: SkynetForms
    SkynetFormField: SkynetFormField
    SkynetFormFields: SkynetFormFields
  }

  Models


