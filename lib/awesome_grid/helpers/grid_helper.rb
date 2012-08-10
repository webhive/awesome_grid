module AwesomeGrid
  module Helpers
    module GridHelper
      def grid_for(model_or_array, params={})
        builder = GridBuilder.new
        params = {
          :header => true,
          :footer => true
        }.merge(params)

        html_params = params.delete(:html) || {}

        data_source = model_or_array

        yield(builder) if block_given?

        (content_tag(:table, html_params) do

          builder.header if params[:header] and builder.headers.empty?
          builder.headers.map do |header|
            header_for(builder, header)
          end

          body_for(builder, data_source)

          builder.footer if params[:footer] and builder.footers.empty?
          builder.footers.map do |footer|
            footer_for(builder, footer)
          end

          concat('')

        end)

      end

      def body_for(builder, data_source)
           concat(content_tag(:tbody) do
            data_source.each_with_index do |item, index|
              row = Row.new(item)
              # build row cells array
              cells = builder.columns.map do |column|
                if column.block.nil?
                  cell_content = item.send(column.id) rescue nil
                else
                  cell = Cell.new(row, column)
                  cell_content = capture{column.block.call(cell)}
                end
                content_tag(:td, cell_content, :class => column.id.to_s.downcase.dasherize)
              end

              # build row
              row_id = [item.class.to_s, item.id].join('-').downcase.dasherize
              row_class = index.even? ? 'even' : 'odd'
              concat(content_tag(:tr, :id => row_id, :class => row_class ) do
                cells.each do |cell|
                  concat(cell)
                end
              end)
            end
          end)
     end

      def footer_for(builder, footer=nil, params={})
        concat(content_tag(:tfoot) do
          content_tag(:tr) do
            builder.columns.map do |column|
              unless footer.nil?
                footer_column = footer.columns.reject{|c| c.id.to_s != column.id.to_s}.first
                cell_content = footer_column.block.call unless footer_column.nil? or footer_column.block.nil?
              else
                cell_content = ''
              end
              concat(content_tag(:td, cell_content, :class => column.id.to_s.downcase.dasherize))
            end
          end
        end)
      end

      def header_for(builder, header=nil, params={})
        concat(content_tag(:thead) do
          content_tag(:tr) do
            builder.columns.map do |column|
              concat(content_tag(:th, I18n.t(column.id, :scope => [:grid, :columns]), :class => column.id.to_s.downcase.dasherize))
            end
          end
        end)
      end

      class Row
        attr_reader :object
        def initialize(object, params = {})
          @object, @params = object, params
        end
      end

      class Cell
        attr_reader :row, :column
        def initialize(row, column, params = {})
          @row, @column, @params = row, column, params
        end
      end

      class Column
        attr_reader :id, :options, :block

        def initialize(id, options, block=nil)
          @id, @block = id, block
          @options = {

          }.merge(options)
        end
      end

      class Header
        attr_reader :options, :block, :columns

        def initialize(options={}, block=nil)
          @block, @columns = block, []
          @options = {

          }.merge(options)
        end

        def column(id, options={}, &block)
          @columns << Column.new(id, options, block)
        end
      end

      class Footer
        attr_reader :options, :block, :columns

        def initialize(options={})
          @columns = []
          @options = {

          }.merge(options)
        end

        def column(id, options={}, &block)
          @columns << Column.new(id, options, block)
        end

      end

      class GridBuilder
        attr_reader :columns, :headers, :footers

        def initialize
          @columns, @headers, @footers = [], [], []
        end

        def column(id, options={}, &block)
          @columns << Column.new(id, options, block)
          ''
        end

        def header(options={}, &block)
          header = Header.new(options)
          yield(header) if block_given?
          @headers << header
          ''
        end

        def footer(options={})
          footer = Footer.new(options)
          yield(footer) if block_given?
          @footers << footer
          ''
        end

      end
    end
  end
end
