# frozen_string_literal: true

require 'asciidoctor-pdf'
require 'fileutils'
require 'find'

def extract_file_parts(filepath)
  filepath = filepath.tr('\\', '/')

  unless filepath.include?('/')
    return { filename: filepath, dir: '', path_to_dir_root: './' }
  end

  filepath = filepath.chomp('/')

  directory_depth = filepath.count('/')

  {
    filename: File.basename(filepath),
    dir: File.dirname(filepath).sub(/^\.\/src\/docs/, ''),
    path_to_dir_root: '../' * directory_depth
  }
end

puts 'Generating documentation ... ... ...'

# Find all .adoc-files under src/docs recursively
documents = []
Dir.glob('./src/docs/**/*.adoc') do |path|
  documents << path
end

result_dir = 'target/docs'
theme_dir = 'src/docs/theme'
theme_file = "#{theme_dir}/doc-theme.yml"

puts "#{documents.size} files to generate"

documents.each do |document|
  file_info = extract_file_parts(document)
  puts "Create #{file_info[:filename]} under \"#{file_info[:dir]}\""

  out_dir = File.join(result_dir, file_info[:dir])
  FileUtils.mkdir_p(out_dir)

  Asciidoctor.convert_file(document,
                           backend: 'pdf',
                           safe: :safe,
                           to_dir: out_dir,
                           mkdirs: true,
                           attributes: {
                             'linkcss' => false,
                             'pdf-theme' => theme_file,
                             'pdf-fontsdir' => "#{theme_dir}/fonts;GEM_FONTS_DIR",
                             'source-highlighter' => 'rouge',
                           }
  )
end