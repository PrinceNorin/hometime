class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :render_validation_error
  rescue_from PayloadParser::NoParserError, with: :render_invalid_payload

  protected

  def render_not_found
    render json: { code: 404 }, status: :not_found
  end

  def render_validation_error(ex)
    render json: {
      code: 422,
      error: ex.record.errors
    }, status: :unprocessable_entity
  end

  def render_invalid_payload
    render json: { code: 400, error: 'invalid payload' }, status: :bad_request
  end
end
