const retrieveHostels = "SELECT * FROM hostels";
const insertHostel = "INSERT INTO hostels (name, gender) VALUES ($1, $2)";
const checkNameExists = "SELECT * FROM hostels WHERE name = $1";
const deleteHostel = "DELETE FROM hostels WHERE id = $1";

const retrieveRooms = "SELECT * FROM room WHERE hid = $1";
const deleteRooms = "DELETE FROM room WHERE hid = $1";

module.exports = {
    retrieveHostels,
    insertHostel,
    checkNameExists,
    deleteHostel,
    retrieveRooms,
    deleteRooms
};

