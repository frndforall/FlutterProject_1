const express = require('express');
const router = express.Router();

const EmployeeCtrl = require('../controllers/employees');

router.get('', EmployeeCtrl.getEmployees);
router.post('/create', EmployeeCtrl.createEmployee);
router.post('/update', EmployeeCtrl.updateEmployee);
router.post('/delete', EmployeeCtrl.deleteEmployee);
router.get('/employeesDetails', EmployeeCtrl.getEmployeeById);

module.exports = router;
