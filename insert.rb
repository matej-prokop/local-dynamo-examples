require 'aws-sdk-dynamodb'  # v2: require 'aws-sdk'

# Create dynamodb client in us-west-2 region
dynamodb = Aws::DynamoDB::Client.new(
  region: 'us-west-2',
  endpoint: "http://localhost:8000",
  access_key_id: 'your_access_key_id',
  secret_access_key: 'your_secret_access_key'
)

item = {
    year: 2015,
    title: 'The Big New Movie',
    info: {
        plot: 'Nothing happens at all.',
        rating: 0
    }
}

params = {
    table_name: 'Movies',
    item: item
}

begin
  dynamodb.put_item(params)
  puts 'Added movie!'
rescue  Aws::DynamoDB::Errors::ServiceError => error
  puts 'Unable to add movie:'
  puts error.message
end
