ThinkingSphinx::Index.define :post, with: :active_record do
  indexes title
  indexes body
  set_property morphology: stem_en
  set_property enable_star: true
  set_property min_infix_len: 3
  set_property min_stemming_len: 3
  has created_at, updated_at
end
