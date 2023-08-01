const express = require('express');
const bycryptjs = require('bcryptjs');
const User = require('../models/user');
const authRouter = express.Router();
const jwt = require('jsonwebtoken');
const auth = require('../middlewares/auth');

//Sign up Route
authRouter.post('/api/signup', async (req, res) =>{

    try{ 
        const {name, email, password, phone} = req.body;

        const existingUser = await User.findOne({email}); //find one предоставляет mongoose
        //ищем юзера по имейлу (сокращенная форма)
        if(existingUser){
            return res.status(400).json({msg: 'User with same email already exists'});
        }else{
            const existingUser = await User.findOne({phone});
            if(existingUser){
                return res.status(400).json({msg: 'User with same phone number already exists'});
            }
        }
    
const hashedPassword = await bycryptjs.hash(password, 8);

       let user = new User({
           name,
           email,
           password: hashedPassword,
           phone
        });
    
        user = await user.save();
        res.json(user);
    
    }catch(e){
        res.status(500).json({error: e.message});
    }
  
});

//Sign in Route
authRouter.post('/api/signin', async (req, res) => {
    try{ 
        const {email, password} = req.body;

        const user = await User.findOne({email});
        if(!user){
            return res.status(400).json({msg: 'User with this email does not exist'});
        }

        const isMatch = await bycryptjs.compare(password, user.password);
        if(!isMatch){
            return res.status(400).json({msg: 'Incorrect password'});
        }

        const token = jwt.sign({id: user._id}, "passwordKey");
        res.json({token, ...user._doc});

        //TODO: ШО ЭТО ЗА ДОК И ШО ЭТО ВООБЩЕ // ОТВЕТ ЕСТЬ!!!
        //Токен является уникальным идентификатором, 
        //который будет использоваться для дальнейшей аутентификации клиента
        //Приведенный фрагмент кода является примером генерации
        // JSON Web Token (JWT) с использованием библиотеки jwt.
        
//В строке const token = jwt.sign({id: user._id}, "passwordKey"); 
//создается токен. Эта функция jwt.sign принимает два параметра: объект, 
//который содержит информацию, которую вы хотите включить в токен (в данном 
//случае объект с полем id, содержащим значение user._id), и секретный ключ 
//("passwordKey"), который используется для подписи токена.
// После генерации токена, он сохраняется в переменной token.
// В строке res.json({token, ...user._doc}); токен отправляется клиенту 
//вместе с другими данными пользователя в формате JSON. res.json() 
//отправляет JSON-ответ с указанными данными.

    }catch(e){
        res.status(500).json({error: e.message});
    }
});

//checking if token is valid
authRouter.post('/tokenIsValid', async (req, res) => {
    // определяет маршрут POST '/tokenIsValid', который будет 
    //обрабатывать запросы на проверку валидности токена.
    try{

       const token = req.header('x-auth-token');
 //получаем значение токена из заголовка запроса с именем 'x-auth-token'.
       if (!token) return res.json(false);
      // выполняем проверку наличия токена. Если токен отсутствует,
       // возвращаем ответ в формате JSON со значением false.
        const verified = jwt.verify(token, "passwordKey");
    if(!verified) return res.json(false);
//(у токена может быть срок действия и на него так же нужна проверка)
        const user = await User.findById(verified.id);
        //т.к. User это модель бд монгуса, у него автоматически есть метод 
        //findById
        //verified содержит id потому что по id создавался токен,
        //но мне все еще не понятно что это за объект verified, как он
        // может содержать в себе поле id
        if(!user) return res.json(false);
        res.json(true);
    }catch(e){
        res.status(500).json({error: e.message});
    }
});


//get user data
authRouter.get('/', auth, async (req, res) => {
    const user = await User.findById(req.user);
    print(req.token);
    res.json({...user._doc, token: req.token});
});
//auth - middleware, which will make sure what you are authorized,
//cuz you can access this route only if you signed in
module.exports = authRouter;
//short form of exporting objects (?) 