class CoursesController < ApplicationController
  def index
    matching_courses=Course.all
    @courses = matching_courses.order({ :created_at => :desc })

    render({ :template => "courses/index" })
  end

  def show
    the_id = params.fetch("path_id")
    matching_courses=Course.where({:id=>the_id})
    @course = matching_courses.at(0)

    render({ :template => "courses/show" })
  end

  def create
    course = Course.new
    course.title = params.fetch("query_title")
    course.term_offered = params.fetch("query_term")
    course.department_id = params.fetch("query_department_id")

    if course.valid?
      course.save
      redirect_to("/courses", { :notice => "Course created successfully." })
    else
      redirect_to("/courses", { :notice => "Course failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    matching_courses=Course.where({:id=>the_id})
    the_course=matching_courses.at(0)
    the_course.title = params.fetch("query_title")
    the_course.term_offered = params.fetch("query_term_offered")
    the_course.department_id = params.fetch("query_department_id")

    if the_course.valid?
      the_course.save
      redirect_to("/courses/#{the_course.id}", { :notice => "Course updated successfully."} )
    else
      redirect_to("/courses/#{the_course.id}", { :alert => "Course failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    matching_records=Course.where(:id=>the_id)
    the_course = matching_records.at(0)
    the_course.destroy

    redirect_to("/courses", { :notice => "Course deleted successfully."} )
  end
end
