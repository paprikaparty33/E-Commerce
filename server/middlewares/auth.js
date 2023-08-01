const jwt = require('jsonwebtoken');

const auth = async (req, res, next) => {
    //next - continue the route, cuz its a middleware
    try{
        const token = req.header('x-auth-token');
        if(!token) return res.status(401).json({msg: "No auth token, access denied"});
        const verified = jwt.verify(token, "passwordKey");
    if(!verified) return res.status(401).json({msg: "Token verification failed, authorization denied"});

    req.user = verified.id;
    

    //if token passed all validation, we store it in req.user
    //далее в коде используя ауф(да) мидлваре мы можем использовать в функции res.user(??)
    //and that will fetch user`s id to it
    
    req.token = token;
    //and now we can access token as well the same way 
    next();
    }catch (err){
        res.status(500).json({error: err.message});
    }
}

module.exports = auth;