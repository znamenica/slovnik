# frozen_string_literal: true

Redisize.adapter_kind = :inline if Rails.env.production? || Rails.env.staging?
