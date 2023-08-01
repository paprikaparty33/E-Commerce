const express = require('express');
const adminRouter = express.Router();
const admin = require('../middlewares/admin');
const {Album} = require('../models/album');

//Add product
 adminRouter.post('/admin/add-album', admin, async (req, res) => {
    try {
        const {name, description, price, location, status, quantity, images, isNewArrival, isPopular, category } = req.body;
        let album = new Album({
            name, description, images, quantity, description, location, price, status, isNewArrival, isPopular, category
        });
        album = await album.save();
        res.json(album);
    } catch (e) {
       res.status(500).json({error: e.message}); 
    }
 } );

 //Update product
 adminRouter.put('/admin/update-album', admin, async (req, res) => {
    try {
        const {_id, name, description, price, location, status, quantity, isNewArrival, isPopular, category, images } = req.body;
        

   
      
        let oldAlbum = await Album.findByIdAndUpdate(_id, {
            name,
            quantity,
            price,
            description,
            location,
            status,
            isNewArrival,
            isPopular,
            category
        });
       
        // try {
        //     await oldAlbum.save();
        //     res.json(oldAlbum);
        // } catch(e){
        //     res.status(500).json({ error: e.message });
        // }
   res.json('good!');
        
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});


  
 //TODO: добавить проверку на колво айтемов в нью арривалс (возможно сделать в самой функции fetch в 
 // admin service так, чтобы ретурн из функции был только предположим последних 10
 //айтемов листа)
 //TODO: Убрать проверку на админа с гет ол

 

  //Delete product
 adminRouter.post('/admin/delete-album', admin, async (req, res) => {
    try {
        const {_id} = req.body;
        let album = await Album.findByIdAndDelete(_id);
        res.json(album); //just to get 200 status code
    } catch (e) {
       res.status(500).json({error: e.message}); 
    }
 } );



 module.exports = adminRouter;


