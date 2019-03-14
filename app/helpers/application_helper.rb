module ApplicationHelper
  
  def flash_class(level)
    case level
      when 'notice' then "alert alert-info"
      when 'success' then "alert alert-success"
      when 'error' then "alert alert-danger"
      when 'alert' then "alert alert-warning"
    end
  end

  def current_year
    DateTime.current.year
  end
  
  def github_url(author, repo, project_name)
    link_to "#{project_name}", "https://github.com/#{author}/#{repo}", target: '_blank'
  end

  def show_button(path)
    link_to path, {class: 'btn btn-outline-success', title: 'Show', 'data-toggle' => 'tooltip'} do
      yield
    end
  end

  def edit_button(path)
    link_to path, {class: 'btn btn-outline-warning', title: 'Edit', 'data-toggle' => 'tooltip'} do
      yield
    end
  end
  
  def delete_button(path)
    link_to path, {method: :delete, data: { confirm: 'Are you sure?' }, class: 'btn btn-outline-danger', title: 'Delete', 'data-toggle' => 'tooltip'} do
      yield
    end
  end


end
