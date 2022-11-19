# frozen_string_literal: true

module TagIds
   extend ActiveSupport::Concern

   included do
      scope :by_tags, -> (tag_names_in) do
         tag_names_in.reduce(self.where("FALSE")) do |q, tag_names|
            pos_names = tag_names.split(",").select { |x| x !~ /^!/ }
            neg_names = tag_names.split(",").filter_map { |x| x.match(/^!(?<name>.*)/)&.[](:name) }
            pos_tag_ids = Tag.by_name(pos_names).select("array_agg(tags.id)")
            neg_tag_ids = Tag.by_name(neg_names).select("array_agg(tags.id)")
            pos_q = pos_names.any? && self.where("tag_ids @> (#{pos_tag_ids.to_sql})") || self
            neg_q = neg_names.any? && pos_q.where("NOT tag_ids @> (#{neg_tag_ids.to_sql})") || pos_q

            q.or(neg_q)
         end
      end
   end

   def tags
      Tag.where(id: tag_ids)
   end

   def tags= tags_in
      self.tag_ids =
         case tags_in[0]
         when String, Integer
            Tag.by_name(tags_in)
         else
            tag_names = tags_in&.map(&:name) || []
            Tag.by_name(tag_names)
         end.select(:id).pluck(:id)
   end
end
