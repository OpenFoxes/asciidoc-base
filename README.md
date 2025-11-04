# Asciidoc Base Project

This project contains an empty, ready to use Asciidoc project.
Just clone the project, download the required Gems and execute the `generate-docs.rb`-file.

## Generated Project

The pdf files are generated under `target/docs`.
They keep the same directory structure as the original `.adoc` files under `src/docs`.

## Custom Theming

The PDF generator uses other theming configuration files than the orignal HTML one, which uses `.css`-files.
Here, a `.yml`-format defines different properties of the resulting PDF.
More information can be found under [the official Asciidoc-documentation](https://docs.asciidoctor.org/pdf-converter/latest/theme/create-theme/).
