const { graphqlHTTP } = require('express-graphql')
const { buildSchema } = require('graphql')
const { graphqlUploadExpress } = require('graphql-upload')
const userResolver = require('./resolvers/user.resolver')
const bodyParser = require('body-parser')
const mongoose = require('mongoose')
const express = require('express')
const path = require('path')
require('dotenv').config()
const fs = require('fs')

mongoose.connect(process.env.MONGODB_URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
})

const schemaPath = path.join(`${__dirname}/graphql`, 'user.graphql')
const schemaContent = fs.readFileSync(schemaPath, 'utf-8')

const schema = buildSchema(schemaContent)

const root = {
  ...userResolver,
}

const app = express()
const port = 3000

app.use(bodyParser.json())
app.use(
  '/graphql',
  graphqlUploadExpress({ maxFileSize: 10000000, maxFiles: 10 }),
)
app.use(
  '/graphql',
  graphqlHTTP({
    schema,
    rootValue: root,
    graphiql: true,
  }),
)

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}/graphql`)
})
