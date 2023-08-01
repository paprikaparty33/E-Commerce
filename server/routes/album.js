const express = require('express');
const albumRouter = express.Router();
const {Album} = require('../models/album');


//Get all
albumRouter.get('/get-all', async (req,res) =>
 {
    try {
        const albums = await Album.find({});
        res.json(albums);
    } catch (e) {
        res.status(500).json({error: e.message});
        
    }

 });


//Get new arrivals
albumRouter.get('/get-new-arrivals', async (req,res) =>
{
   try {
       const newAlbums = await Album.find({isNewArrival: true});
       res.json(newAlbums);
   } catch (e) {
       res.status(500).json({error: e.message});
       
   }  

});

//Get popular
albumRouter.get('/get-popular',async (req,res) =>
{
   try {
       const newAlbums = await Album.find({isPopular: true});
       res.json(newAlbums);
   } catch (e) {
       res.status(500).json({error: e.message});
       
   }  

});

//Get Albums
albumRouter.get('/get-category',async (req,res) =>
{
   try {
    console.log(req.query.category);
       const albums = await Album.find({category: req.query.category});
       res.json(albums);
   } catch (e) {
       res.status(500).json({error: e.message});
       
   }  

});

//Get search
albumRouter.get('/albums/search/:name',async (req,res) =>
{
   try {
    console.log(req.query.category);
       const albums = await Album.find({name: {$regex: req.params.name, $options: "i"},});
       res.json(albums);
   } catch (e) {
       res.status(500).json({error: e.message});
       
   }  

});

//Get search in category
albumRouter.get('/albums/search/:name/:category',async (req,res) =>
{
   try {
    console.log(req.query.category);
       const albums = await Album.find({name: {$regex: req.params.name, $options: "i"}, category: req.params.category});
       res.json(albums);
   } catch (e) {
       res.status(500).json({error: e.message});
       
   }  

});

module.exports = albumRouter;