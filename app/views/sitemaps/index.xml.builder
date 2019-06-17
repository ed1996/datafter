xml.instruct! :xml, version: '1.0'
xml.tag! 'sitemapindex', 'xmlns' => "http://www.sitemaps.org/schemas/sitemap/0.9" do

  xml.tag! 'url' do
    xml.tag! 'loc', root_url
  end

  xml.tag! 'url' do
    xml.tag! 'loc', contact_url
  end

  @hommages.each do |hommage|
    xml.tag! 'url' do
      xml.tag! 'loc', hommage_url(hommage)
      xml.lastmod hommage.updated_at.strftime("%F")
    end
  end

end
view raw