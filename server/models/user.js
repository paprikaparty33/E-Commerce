const mongoose = require('mongoose');
const { albumSchema } = require('./album');

const userSchema = mongoose.Schema({
    name: {
        required: true,
        type: String,
        trim: true,
    },
    email: {
        required: true,
        type: String,
        trim: true,
        validate: {
            validator: (value) => {
                const re =
  /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
            return value.match(re);
},
            message: "Please enter a valid email adress",
        },
    },
    password: {
        required: true,
        type: String,
    },
    phone: {
        required: true,
        type: String,
    },
    address: {
        type: String,
        default: "",
    },
    type: {
        type: String,
        default: "user",
    },
    cart:[
        {
            album: albumSchema,
            quantity: {
                type: Number,
                required: true
            }
        }
    ]


});

const User = mongoose.model('User', userSchema);
module.exports = User;