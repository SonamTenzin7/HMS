const { Router } = require('express');
const controller = require('./controller')

const router = Router();

router.get("/allhostels", controller.getHostels);

router.post("/addhostel", controller.addHostel);

router.delete("/delhostel/:id", controller.delHostel);

router.get("/allrooms/:id", controller.getRooms);

router.delete("/delrooms/:id", controller.delRooms);

module.exports = router;