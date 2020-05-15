require 'aws-sdk-dynamodb'  # v2: require 'aws-sdk'

# Create dynamodb client in us-west-2 region
dynamodb = Aws::DynamoDB::Client.new(
  region: 'us-west-2',
  endpoint: "http://localhost:8000",
  access_key_id: 'your_access_key_id',
  secret_access_key: 'your_secret_access_key'
)

params = {
    table_name: 'Movies',
    key: {
        year: 2015,
        title: 'The Big New Movie'
    }
}

begin
  result = dynamodb.get_item(params)

  if result.item == nil
    puts 'Could not find movie'
    exit 0
  end

  puts 'Found movie:'
  puts '  Year:   ' + result.item['year'].to_i.to_s
  puts '  Title:  ' + result.item['title']
  puts '  Plot:   ' + result.item['info']['plot']
  puts '  Rating: ' + result.item['info']['rating'].to_f.to_s
rescue  Aws::DynamoDB::Errors::ServiceError => error
  puts 'Unable to find movie:'
  puts error.message
end
