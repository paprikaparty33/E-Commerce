const mongoose = require('mongoose');

const albumSchema = mongoose.Schema({
    name: {
        required: true,
        type: String,
        trim: true,
    },
    price: {
        required: true,
        type: Number,
    },
    location: {
        required: true,
        type: String,
    },
    quantity: {
        required: true,
        type: Number,
    },
    description: {
        type: String,
        required: true,
        trim: true,
    },
    status: {
        type: String,
        default: "",
    },
    images: [
        {
            type: String,
            required: true,
        },
    ],
    isNewArrival: {
        type: Boolean,
        required: true,
    },
    isPopular: {
        type: Boolean,
        required: true,
    },
    category: {
        type: String,
        required: true,
    },
//rating

});

const Album = mongoose.model('Album', albumSchema);
module.exports = {Album, albumSchema};