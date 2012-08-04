# encoding: utf-8
require 'spec_helper'

describe 'AwesomeGrid' do

  include AwesomeGridSpecHelper

  before do
    @output_buffer = ''
    mock_everything
  end

  it 'should have full table' do
    grid_for(@posts) do |grid|
      grid.column(:id)
      grid.column(:title)
    end
    output_buffer.should have_tag('table')
    output_buffer.should have_tag('thead')
    output_buffer.should have_tag('tfoot')
  end

  describe 'when header option is false' do
    it 'should have no header section' do
      grid_for(@posts, :header => false) do |grid|
        grid.column(:id)
        grid.column(:title)
      end
      output_buffer.should have_tag('table')
      output_buffer.should_not have_tag('thead')
      output_buffer.should have_tag('tfoot')
    end
  end

  describe 'when footer option is false' do
    it 'should have no footer section' do
      grid_for(@posts, :footer => false) do |grid|
        grid.column(:id)
        grid.column(:title)
      end
      output_buffer.should have_tag('table')
      output_buffer.should have_tag('thead')
      output_buffer.should_not have_tag('tfoot')
    end
  end

end

