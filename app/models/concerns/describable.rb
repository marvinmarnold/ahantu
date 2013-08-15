class Describable < ActiveRecord::Base
  self.abstract_class = true

  has_many :descriptions,
    as: :describable

  has_many :languages,
    through: :descriptions

  accepts_nested_attributes_for :descriptions,
    :allow_destroy => true

  # validate :one_description
  validate :one_per_language

  def description
    locate(:description)
  end

  def name
    locate(:name)
  end

  def unused_languages
    #TODO
  end

private
  def one_description
    errors[:descriptions] << I18n.t('descriptions.form.errors.atleast_one') if descriptions.blank?
  end

  def one_per_language
    language_present = {}
    descriptions.each do |description|
      language_present[description.language_id] = (language_present[description.language_id].blank?) ? true :
                      errors[:descriptions] << I18n.t('descriptions.form.errors.duplicate_language')
    end
  end

  def locate(atr)
    return nil unless descriptions.present?
    description = descriptions.find_by_language_id(Language.current.id)
    (description.blank?) ? descriptions.first.send(atr) : description.send(atr)
  end

end
