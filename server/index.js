//imports from packages
const express = require('express');
const mongoose = require('mongoose');
//imports from other files in project
const authRouter = require('./routes/auth'); 
const adminRouter = require('./routes/admin');
const albumRouter = require('./routes/album');
const userRouter = require('./routes/user');

//init
const PORT = 3000;
const app = express();
const DB = 'mongodb+srv://paprikaparty33:Futroyesiivan18@cluster0.rc3d7pd.mongodb.net/?retryWrites=true&w=majority';
//middleware
app.use(express.json()); 
app.use(authRouter);
app.use(adminRouter);
app.use(albumRouter);
app.use(userRouter);


//connections
mongoose.connect(DB).then(() => {
console.log('db here');
}).catch((e) =>{
    console.log(e);
});


app.listen(PORT, "0.0.0.0", () => {
    console.log('connected '+PORT);
});

// Импортируется модуль express.
// Импортируется маршрутизатор authRouter из файла ./routes/auth.
// Задается порт PORT (в данном случае 3000).
// Создается экземпляр приложения Express с помощью вызова express(), и его результат присваивается переменной app.
// Далее происходит использование authRouter в качестве middleware с помощью app.use(authRouter). Это означает, что все запросы, поступающие на сервер, будут передаваться через authRouter для обработки соответствующих маршрутов.
// Затем, в коде файла ./routes/auth:

// Определяется маршрутизатор authRouter с помощью express.Router().
// На маршруте /user с помощью метода get определяется обработчик запроса, который отправляет JSON-ответ с сообщением "riivan" (res.json({msg: 'riivan'})).
// Наконец, экспортируется authRouter с помощью module.exports = authRouter, чтобы он мог быть использован в основном файле index.js.
// В последней части кода:

// app.listen(PORT, "0.0.0.0", ...) запускает сервер на указанном порту, прослушивая входящие запросы.
// При успешном запуске сервера выводится сообщение "connected" вместе с портом в консоль.
// Таким образом, код настраивает Express-сервер, подключает маршрутизатор authRouter, который обрабатывает запросы на маршрут /user и отправляет ответ в виде JSON-сообщения "riivan". После этого сервер запускается и начинает прослушивать входящие запросы на указанном порту.