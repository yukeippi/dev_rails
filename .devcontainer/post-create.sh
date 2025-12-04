#!/bin/bash
set -e

echo "Setting up bundle configuration..."
bundle config set --local path 'vendor/bundle'

echo "Installing gems..."
bundle install

echo "Setting up database..."
bin/rails db:create db:migrate

echo "Dev container setup complete!"
