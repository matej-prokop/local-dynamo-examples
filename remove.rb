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
  dynamodb.delete_item(params)
  puts 'Deleted movie'
rescue  Aws::DynamoDB::Errors::ServiceError => error
  puts 'Unable to delete movie:'
  puts error.message
end
