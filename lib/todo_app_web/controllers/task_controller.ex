defmodule TodoAppWeb.TaskController do
  use TodoAppWeb, :controller

  alias TodoApp.Tasks
  alias TodoApp.Tasks.Task

  def index(conn, _params) do
    tasks = Tasks.list_tasks()
    render(conn, :index, tasks: tasks)
  end

  def new(conn, _params) do
    cs = Tasks.change_task(%Task{})
    render(conn, :new, changeset: cs)
  end

  def create(conn, %{"task" => params}) do
    case Tasks.create_task(params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "タスクを作成しました。")
        |> redirect(to: ~p"/tasks/#{task}")

      {:error, cs} ->
        render(conn, :new, changeset: cs)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    render(conn, :show, task: task)
  end

  def edit(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    cs = Tasks.change_task(task)
    render(conn, :edit, task: task, changeset: cs)
  end

  def update(conn, %{"task" => params, "id" => id}) do
    task = Tasks.get_task!(id)

    case Tasks.update_task(task, params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "タスクを更新しました。")
        |> redirect(to: ~p"/tasks/#{task}")

      {:error, cs} ->
        render(conn, :edit, task: task, changeset: cs)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    {:ok, _task} = Tasks.delete_task(task)

    conn
    |> put_flash(:info, "タスクを削除しました。")
    |> redirect(to: ~p"/tasks")
  end
end
