class Candidate < ApplicationRecord
  # We temporarily store campus IDs to validate them, so someone
  # who belongs to another campus cannot be added to an election here.
  # Since this doesn't go into the database, we create an attribute here.
  attr_accessor :campus_ids

  belongs_to :election
  has_many   :votes, dependent: :destroy

  # This callback makes it so the 42 API is queried when we
  # create a new candidate in an election
  before_validation :fetch_42_data, on: :create

  validates_with CampusValidator, on: :create
  validates :username, presence: true

  def profile_url
    "https://profile.intra.42.fr/users/#{self.username}"
  end

  def fetch_42_data
    begin
      # Empty names will lead us to the index page of users at 42, so we
      # should catch that here.
      if self.username.blank?
        errors.add(:username, "is required")
        throw :abort
      end

      api_response = Candidate.api_token.get("/v2/users/#{self.username}").parsed
    rescue OAuth2::Error
      # If we can't get the profile data, we should end the chain here and
      # report back to the user with the error.
      errors.add(:username, "does not appear to be a valid username")
      throw :abort
    end

    self.full_name  = api_response.usual_full_name
    self.photo_url  = api_response.image&.versions&.medium || nil
    self.campus_ids = api_response.campus&.map { |c| c.id } || []
  end

  private

  # We need access to the 42 API to autofill profile details for candidates
  def self.api_client
    @api_client ||= OAuth2::Client.new(ENV.fetch("FORTYTWO_UID"),
                                       ENV.fetch("FORTYTWO_SECRET"),
                                       site: "https://api.intra.42.fr")
  end

  # Get an API token if we don't have one yet or the current one is expired
  def self.api_token
    if !@token || @token.expired?
      @token = self.api_client.client_credentials.get_token
    end

    @token
  end
end
