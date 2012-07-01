class MmbrainsController < ApplicationController
  def index
    params[:id]="c9e115a6-9c85-4e1e-a2f1-857e0bf3c3fc"
    @mbid = params[:id]
    @result=MusicBrainz::Query.new({:release=>@mbid},{:entity=>'release'},{:fetch=>'recordings'}).results
  end
end