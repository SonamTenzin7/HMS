const pool = require('../../db');
const queries = require('./queries');

const getHostels = (req, res) =>{
    pool.query(queries.retrieveHostels, (error, results) => {
        if(error) throw error;
            res.status(200).json(results.rows);
    });
};

const addHostel = (req, res) => {
    const {name, gender} = req.body;
        pool.query(
            queries.insertHostel,
            [name, gender],
            (error, results) => {
                if(error) throw error;
                res.status(201).send("Hostel Added Successfully!");
            }                
        );
};

const delHostel = (req, res) => {
    const id = parseInt(req.params.id);
    
    pool.query(queries.deleteHostel, [id], (error, results) =>{
        // const noHostelFound = !results.rows.length;
        if(error) throw error;
        res.status(200).send("Hostel deleted.")
        }
    );
};


const getRooms = (req, res) =>{
    const id = parseInt(req.params.id);
    pool.query(queries.retrieveRooms, [id], (error, results) => {
        if(error) throw error;
            res.status(200).json(results.rows);
    });
};

const delRooms = (req, res) => {
    const id = parseInt(req.params.id);
    pool.query(queries.deleteRooms, [id], (error, results) =>{
        // const noHostelFound = !results.rows.length;
        if(error) throw error;
        res.status(200).send("Rooms deleted.")
        }
    );
};

module.exports = {
    getHostels,
    addHostel,
    delHostel,
    getRooms,
    delRooms
};