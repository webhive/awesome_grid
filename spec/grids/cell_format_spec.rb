# encoding: utf-8
require 'spec_helper'

describe 'AwesomeGrid#cell formatting' do

  include AwesomeGridSpecHelper

  before do
    @output_buffer = ''
    mock_everything
  end

  describe 'when title column wrapped with another HTML' do
    it 'should see formatted cell content' do
      grid_for(@posts) do |grid|
        grid.column(:id)
        grid.column(:title) do |title|
          content_tag(:div, title, :class => 'title-wrapper')
        end
      end
      output_buffer.should have_tag('table')
      output_buffer.should have_tag('thead')
      output_buffer.should have_tag('tfoot')
      output_buffer.should have_tag('div.title-wrapper', :count => @posts.size)
    end
  end

  describe 'when footer title cell has some code' do
    it 'should see formatted cell content' do
      grid_for(@posts) do |grid|
        grid.column(:id)
        grid.column(:title) do |title|
          content_tag(:div, title, :class => 'title-wrapper')
        end
        grid.footer do |footer|
          footer.column(:title) do
            'Bla-Bla-Bla'
          end
        end
        grid.footer do |footer|
          footer.column(:title) do
            'Bla-Bla-Bla'
          end
        end
      end
      output_buffer.should have_tag('table')
      output_buffer.should have_tag('thead')
      output_buffer.should have_tag('tfoot')
      output_buffer.should_not have_tag('div.title-wrapper', :count => @posts.size)
    end
  end

end

