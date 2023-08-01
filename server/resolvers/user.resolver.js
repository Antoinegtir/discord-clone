const User = require('../models/user.model')
const jwt = require('jsonwebtoken')
const bcrypt = require('bcrypt')
const {
  generateUniqueUsername,
  validateEmail,
  uploadProfilePic,
} = require('../services/user.service')

const userResolver = {
  user: async ({ id }) => {
    try {
      const user = await User.findById(id)
      return user
    } catch (error) {
      throw new Error('User not found')
    }
  },

  updateUser: async ({ id, displayName, bio, status, profilePic }) => {
    try {
      const user = await User.findById(id)
      if (!user) {
        throw new Error('User not found')
      }

      if (displayName) {
        user.displayName = displayName
      }

      if (bio) {
        user.bio = bio
      }

      if (status) {
        user.status = status
      }

      if (profilePic) {
        await uploadProfilePic(profilePic)
      }

      await user.save()

      return { ...user._doc, password: null }
    } catch (error) {
      throw new Error(error)
    }
  },

  createUser: async ({ email, password, displayName, birthday }) => {
    if (!validateEmail(email)) {
      throw new Error('Invalid email format')
    }

    if (password.length < 6) {
      throw new Error('Password must be at least 6 characters long')
    }

    const existingUser = await User.findOne({ email })
    if (existingUser) {
      throw new Error('Email already exists')
    }

    const username = await generateUniqueUsername(displayName)

    try {
      const hashedPassword = await bcrypt.hash(password, 10)

      const user = new User({
        email,
        password: hashedPassword,
        displayName,
        username,
        birthday,
      })

      await user.save()

      return { ...user._doc, password: null }
    } catch (error) {
      throw new Error(error)
    }
  },

  deleteUser: async ({ id }) => {
    try {
      const user = await User.findById(id)
      if (!user) {
        throw new Error('User not found')
      }

      await User.deleteOne({ _id: id })

      return `User with ID ${id} has been deleted successfully.`
    } catch (error) {
      console.error('Error deleting user:', error)
      throw new Error('Error deleting user')
    }
  },

  signIn: async ({ email, password }) => {
    const user = await User.findOne({ email })
    if (!user) {
      throw new Error('User not found')
    }

    const isEqual = await bcrypt.compare(password, user.password)
    if (!isEqual) {
      throw new Error('Invalid password')
    }

    const token = jwt.sign(
      { userId: user.id, email: user.email },
      process.env.JWT_SECRET,
      { expiresIn: '1h' },
    )
    return {
      userId: user.id,
      token,
      tokenExpiration: 1,
      displayName: user.displayName,
      username: user.username,
      birthday: user.birthday,
      email: user.email,
      createdAt: user.createdAt,
      profilePic: user.profilePic,
      status: user.status,
    }
  },
}

module.exports = userResolver
