source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

# Specify your gem's dependencies in phone_to_word.gemspec
group :development do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pronto'
	gem 'pronto-rubocop', require: false
	gem 'pronto-flay', require: false
end

group :testing do
	gem 'rspec', '~> 3.4'
	gem 'rspec-core', '~> 3.8', '>= 3.8.1'
	gem 'rspec-expectations', '~> 3.8', '>= 3.8.4'
	gem 'rspec-support', '~> 3.8', '>= 3.8.2'
	gem 'rspec-mocks', '~> 3.8', '>= 3.8.1'
end


gemspec
