require 'aws-sdk-dynamodb'  # v2: require 'aws-sdk'

# Create dynamodb client in us-west-2 region
dynamodb = Aws::DynamoDB::Client.new(
  region: 'us-west-2',
  endpoint: "http://localhost:8000",
  access_key_id: 'your_access_key_id',
  secret_access_key: 'your_secret_access_key'
)

# Create table Movies with year (integer) and title (string)
params = {
    table_name: 'Movies',
    key_schema: [
        {
            attribute_name: 'year',
            key_type: 'HASH'  #Partition key
        },
        {
            attribute_name: 'title',
            key_type: 'RANGE' #Sort key
        }
    ],
    attribute_definitions: [
        {
            attribute_name: 'year',
            attribute_type: 'N'
        },
        {
            attribute_name: 'title',
            attribute_type: 'S'
        },

    ],
    provisioned_throughput: {
        read_capacity_units: 10,
        write_capacity_units: 10
  }
}

begin
    result = dynamodb.create_table(params)

    puts 'Created table. Status: ' +
        result.table_description.table_status;
rescue  Aws::DynamoDB::Errors::ServiceError => error
    puts 'Unable to create table:'
    puts error.message
end
