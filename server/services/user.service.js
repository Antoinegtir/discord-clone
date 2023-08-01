const admin = require('firebase-admin')
const User = require('../models/user.model')

admin.initializeApp({
  credential: admin.credential.cert(require('../key.json')),
  storageBucket: 'gs://discord-antoine.appspot.com',
})

const bucket = admin.storage().bucket()

const uploadProfilePic = async (user, file) => {
  try {
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1e9)
    const filename = 'profile-' + uniqueSuffix + path.extname(file.originalname)

    const fileUpload = bucket.file(filename)
    const stream = fileUpload.createWriteStream({
      metadata: {
        contentType: file.mimetype,
      },
    })

    stream.on('error', (error) => {
      console.error(
        'Error uploading profile picture to Firebase Storage:',
        error,
      )
      throw new Error('Error uploading profile picture')
    })

    stream.on('finish', async () => {
      const downloadUrl = `https://storage.googleapis.com/${bucket.name}/${filename}`
      user.profilePic = downloadUrl
      await user.save()
    })

    file.stream.pipe(stream)
  } catch (error) {
    console.error('Error updating profile picture:', error)
    throw new Error('Error updating profile picture')
  }
}

async function generateUniqueUsername(displayName) {
  const username = displayName.toLowerCase().replace(/\s+/g, '')

  const existingUser = await User.findOne({ username })

  if (existingUser) {
    let count = 0
    let uniqueUsername = `${username}#${count.toString().padStart(4, '0')}`

    while (await User.findOne({ username: uniqueUsername })) {
      count++
      uniqueUsername = `${username}#${count.toString().padStart(4, '0')}`
    }

    return uniqueUsername
  }

  return username
}

function validateEmail(email) {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
  return emailRegex.test(email)
}

module.exports = { generateUniqueUsername, validateEmail, uploadProfilePic }
