const express = require('express');
const userRouter = express.Router();
const auth = require('../middlewares/auth');
const User = require('../models/user');
const {Album} = require('../models/album');


userRouter.post('/api/add-to-cart/:quantity', auth, async (req, res) => {
    try {
      const {id} = req.body;
      const{quantity} = req.params;
      const album = await Album.findById(id);
      let user = await User.findById(req.user);

      if(user.cart.length == 0){
        user.cart.push({album, quantity: quantity });
      }else{
        let isAlbumFound = false;
        for(let i=0; i< user.cart.length; i++ ){
            if(user.cart[i].album._id.equals(album._id)){
                isAlbumFound = true;
            }
        }

        if(isAlbumFound == true){
            let albummm = user.cart.find((albumm) => albumm.album._id.equals(album._id));

            albummm.quantity+= 1;
        }else{
            user.cart.push({album, quantity: quantity});
        }
      }
      user = await user.save();
      res.json(user);
    } catch (e) {
       res.status(500).json({error: e.message}); 
    }
 } );


 userRouter.delete("/api/remove-from-cart/:id", auth, async (req, res) => {
    try {
      const { id } = req.params;
      const album = await Album.findById(id);
      let user = await User.findById(req.user);
  
      for (let i = 0; i < user.cart.length; i++) {
        if (user.cart[i].album._id.equals(album._id)) {
          if (user.cart[i].quantity == 1) {
            user.cart.splice(i, 1);
          } else {
            user.cart[i].quantity -= 1;
          }
        }
      }
      user = await user.save();
      res.json(user);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });

 module.exports = userRouter;