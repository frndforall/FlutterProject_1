const Employee = require('../models/employee');

exports.getSecret = function (req, res) {
  return res.json({secret: 'I am secret Message'})
}

exports.getEmployees = function(req, res) {
  Employee.find({})
        .exec((errors, users) => {

    if (errors) {
      return res.status(422).send({errors});
    }

    return res.json(users);
  });
}

exports.updateEmployee = (req, res) => {
  const id = req.query.id;
  const userData = req.body;
  console.log(id);
  console.log(userData);
    // new: bool - true to return the modified document rather than the original. defaults to false
    Employee.findByIdAndUpdate(id, { $set: userData}, { new: true }, (errors, updatedUser) => {
      if (errors) return res.status(422).send({errors});

      return res.json(updatedUser);
    });
}


exports.deleteEmployee = (req,res) => {
  const empId = req.query.id;
  console.log(empId);
	Employee.findByIdAndDelete(empId, (errors, empId) => {
      if (errors) return res.status(422).send({errors});
	  console.log("Employee Deleted");
      return res.sendStatus(200);
    });
}


exports.createEmployee = function(req, res) {
  const registerData = req.body

  if (!registerData.name) {
    return res.status(422).json({
      errors: {
        name: 'is required',
        message: 'Name is required'
      }
    })
  }

  const emp = new Employee(registerData);

  return emp.save((errors, savedUser) => {
    if (errors) {
      return res.status(422).json({errors})
    }

    return res.json(savedUser)
  })
}

getMeetupByIdQuery = function(id, callback) {
  Employee.findById(id)
        .exec(callback);
}

exports.getEmployeeById = function(req, res) {
  const id = req.query.id;
  console.log(id);

  getMeetupByIdQuery(id, (errors, meetup) => {
    if (errors) {
      return res.status(422).send({errors});
    }

    return res.json(meetup);
  });
}










