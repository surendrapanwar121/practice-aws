WickedPdf.config = {
  layout: 'pdf',
  template: 'application/default_pdf'
}

WickedPdf.config.merge!(exe_path: ENV['WKHTMLTOPDF_PATH'])