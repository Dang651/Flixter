class Instructor::CoursesController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @course = Course.new
  end
  
  def create
    @course = current_user.courses.create(course_params)
    if @course.valid?
      redirect_to instructor_course_path(@course)
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def show
    @course = Course.find(params[:id])
  end
  
  private
  
  # course_params sucks the fields out of the entry form
  # This is where course.title, course.description and course.cost originates.
  def course_params            
    params.require(:course).permit(:title, :description, :cost)
  end
end
