ThinkingSphinx::Index.define :post, with: :active_record do
  indexes title
  indexes body
=begin
  set_property morphology: stem_en
  set_property min_infix_len: 2
  has created_at, updated_at
=end
end
