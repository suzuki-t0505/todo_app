alias TodoApp.Repo
alias TodoApp.Tasks.Task

tasks =
  ~w(
    買い物をする
    本を読む
    部屋の掃除をする
  )

Enum.each(tasks, fn task ->
  Repo.insert(%Task{title: task, date: Date.utc_today()})
end)
