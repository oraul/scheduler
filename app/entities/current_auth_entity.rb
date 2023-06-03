# frozen_string_literal: true

CurrentAuthEntity = Struct.new(:sub, :name, :exp, :iss, :aud, keyword_init: true)
