class Ability
  include CanCan::Ability

  def initialize(user)

    # Types of users only for beta testing, will roll a more in depth permission
    # system with later releases

    # USER - Read Access to issues  
    # CREATOR - Can create and edit issues
    # ADMIN - Will have access to all objects that directly relate to the owing business
    # GODMODE - Have access to every thing in app

    # need to have a user_id column on the issue to record the user that created it
    # avoid using :manage as it will authenticate every method in the controller

    can :read, Issue
    can :search, Issue
    can :update, Issue, :user_id => user.id 

    can :show_solutions, Issue
    can :show_workarounds, Issue
    can :show_steps, Issue

    can :index, Review
    can :index, Medium
    can :show, Medium
    
    # can :show, Image
    can :get_images, Image
    # can :index, Image

    can :profile, User
    can :activity_feed, :notification

    if user.role?("creator")
        can :write, Issue
        can :create, Issue
        can :edit, Issue

        can :new, Review
        can :create, Review
        can :edit, Review
        can :update, Review

        can :new, Medium
        can :create, Medium
        can :edit, Medium
        can :update, Medium

        can :edit_workaround, Issue
        can :edit_solutions, Issue
        can :edit_images, Issue
        can :edit_attempted_solutions, Issue

    end

    if user.role?("admin")

        # puts "user is the admin"
        can :update, Issue

        can :destroy, Issue
        can :destroy, Review
        can :destroy, Medium

        can :show, Image
        can :edit, Image
        can :update, Image
        can :new, Image
        can :create, Image
        can :destroy, Image
        can :index, Image

        can :manindex, Image
        # can :get_images, Image


        can :read, DetailedStep
        can :write, DetailedStep

        # will only create a detailed step if issue has howto selected to true 
        can :create, DetailedStep, :issue => { :howTo => "true" }
        # can :create, DetailedStep

        can :update, DetailedStep
        can :destroy, DetailedStep

        can :show, Location
        can :new, Location
        can :create, Location
        can :edit, Location
        can :update, Location
        can :destroy, Location
        can :index, Location

        can :users, :admin
        can :index, :admin
        can :new, User
        can :create, User
        can :update, User
        can :destroy, User

        can :index, Impact
        can :new, Impact
        can :create, Impact
        can :edit, Impact
        can :update, Impact
        can :destroy, Impact

        can :index, Department
        can :create, Department
        can :update, Department
        can :destroy, Department

        can :index, Area
        can :create, Area
        can :update, Area
        can :destroy, Area

        can :index, DepartmentArea
        can :create, DepartmentArea
        can :update, DepartmentArea
        can :destroy, DepartmentArea


        can :update, :admin_business

        can :index, :issue_management
        can :view, :issue_management
        can :show, :issue_management
        can :create, :issue_management
        can :update, :issue_management
        can :destroy, :issue_management
        can :edit_workaround, :issue_management
        can :edit_solutions, :issue_management
        can :show_workarounds, :issue_management
        can :show_solutions, :issue_management
        can :show_steps, :issue_management

        can :draft_to_review, Issue
        can :review_to_draft, Issue
        can :review_to_publish, Issue
        can :publish_to_review, Issue
        can :publish_to_draft, Issue


        
    else
        can :read, Issue
        # cannot :search, Issue
    end


    # can :write, Issue

    # can :update, Issue
    # can :destroy, Issue
    # can :manage, Issue #user can perform all actions


    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
