class GenerateCsvController < ApplicationController
  CSV_MODELS = [Account, User, Post, Role].freeze

  def index
    @csv_models = CSV_MODELS
  end

  def download_csv
    model = safe_constantize_model(params[:model])

    if model
      csv_data = model.create_csv
      timestamp = Time.now.strftime("%Y-%m-%d_%H-%M-%S")
      filename = "#{model.name.pluralize}-#{timestamp}.csv"

      respond_to do |format|
        format.csv { send_data csv_data, filename: filename }
      end
    else
      redirect_to csv_list_path, alert: "Invalid model selected"
    end
  end

  private

  def safe_constantize_model(model_name)
    CSV_MODELS.find { |m| m.name == model_name }
  end
end
