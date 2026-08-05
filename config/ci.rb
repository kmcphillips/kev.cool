# Run using bin/ci

CI.run do
  run_setup = ARGV.delete("--setup")
  run_all = ARGV.delete("--all")
  update = ARGV.delete("--update")

  if run_setup
    step "Setup", "bin/setup --skip-server"
  end

  step "Tests: RSpec", "bin/rspec"
  step "Style: Ruby", "bin/standard"

  if update
    step "Update: Gem audit", "bin/bundler-audit update"
  end

  if run_all
    step "Security: Gem audit", "bin/bundler-audit"
    step "Security: Importmap vulnerability audit", "bin/importmap audit"
    step "Security: Brakeman code analysis", "bin/brakeman --quiet --no-pager --exit-on-warn --exit-on-error"
  end
end
