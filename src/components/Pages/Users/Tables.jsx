import React from 'react'
import './users.css';
import { Link } from 'react-router-dom';
import { Table } from "antd";
import "antd/dist/antd"
import { useState, useEffect } from 'react';
import { Pagination } from 'antd';
import { FaStarOfLife } from 'react-icons/fa';
import { useForm } from 'react-hook-form';
import swal from "sweetalert";
import Popup from './Popup';
import './popup.css';

export default function Cards({ title, data }) {

  const { register, handleSubmit, watch, formState: { errors } } = useForm();

  {/*---------------- handle submit values ----------------- */ }
  const onSubmit = data => console.log(data);

  const [buttonPopup, setButtonPopup] = useState(false);
  const [popup2, setPop2] = useState(false);
  const [popup, setPop] = useState(false);
  const [popup3, setPop3] = useState(false);
  const [popup4, setPop4] = useState(false);
  const [popup5, setPop5] = useState(false);
  const [popup6, setPop6] = useState(false);
  const [popup7, setPop7] = useState(false);
  const [popup8, setPop8] = useState(false);
  const [popup9, setPop9] = useState(false);
  const [popup10, setPop10] = useState(false);

  const handleClickopen = () => {
    setPop({ popup: false });
  }
  if (popup == true) {
    document.body.classList.add("active_modal")
  }
  else {
    document.body.classList.remove("active_modal")
  }
  const handleClickopen2 = () => {
    setPop2(!popup2);
  }
  const handleClickopen3 = () => {
    setPop3(!popup3);
  }
  const handleClickopen4 = () => {
    setPop4(!popup4);
  }
  const handleClickopen5 = () => {
    setPop5(!popup5);
  }
  const handleClickopen6 = () => {
    setPop6(!popup6);
  }
  const handleClickopen7 = () => {
    setPop7(!popup7);
  }
  const handleClickopen8 = () => {
    setPop8(!popup8);
  }

  const handleClickopen9 = () => {
    setPop9(!popup9);
  }

  const handleClickopen10 = () => {
    setPop10(!popup10);
  }

  const handleClickMessage = () => {
    swal("Successful", "Successful Added", "success", {
      buttons: false,
      timer: 2000,
    })

  }


  const closePopup5 = () => {
    setPop10(false);
    setPop9(false);
    setPop8(false);
    setPop7(false);
    setPop6(false);
    setPop5(false);
    setPop4(false);
    setPop3(false);
    setPop2(false);
    setPop(false);
  }


  const jwt = JSON.parse(localStorage.getItem('jwt'));// Getting the token from login api

  const options = {

    headers: {
      'Content-Type': 'application/json',
      "Accept": "application/json",
      "Authorization": `Bearer ${jwt}`
    },

  };
  const url = "http://198.199.67.201:9090/Api/Admin/All/VehicleOwners";

  const [Loading, setLoading] = useState(false)
  const [totalPages, setTotalPage] = useState(1);
  const [dataSource, setDataSource] = useState([])

  useEffect(() => {
    fetch(url, options)
      .then(respnse => respnse.json())
      .then(data => {
        setDataSource(data.vehicleOwners)
        setTotalPage(data.totalPages)

        console.log(dataSource)
      })
  }, [])

  const urlthree = "http://198.199.67.201:9090/Api/Admin/All/VehicleCatagory";
  const [dataSource3, setDataSource3] = useState([])
  useEffect(() => {
    fetch(urlthree, options)
      .then(respnse => respnse.json())
      .then(data => {
        setDataSource3(data.vehicleCatagories)
        console.log(dataSource3)
      })
  }, [])
  const urlFour = "http://198.199.67.201:9090/Api/Admin/All/VehicleCondition";
  const [dataSource4, setDataSource4] = useState([])
  useEffect(() => {
    fetch(urlFour, options)
      .then(respnse => respnse.json())
      .then(data => {
        setDataSource4(data.vehicleConditions)
        console.log(dataSource4)
      })
  }, [])


  return (
    <>
      <div className='outer_vehicle_tables' id='myTable'>
        <p>{title}</p>

        <table class="vehicle_table" id="myTable">

          <thead>
            <tr>
              <th>User</th>
              <th>Company ID</th>
              <th>Company Name</th>
              <th>Number Of Vehicle</th> 
              <th>Number Of Driver</th> 
              <th>Status</th> 
              <th>Detail</th>
              <th>Add Vehicle</th>
            </tr>
          </thead>
          <tbody>
            {dataSource.map(item => (
              <tr className='active_row'>
                <td>{item.firstName}</td>
                <td>{item.companyInfo.id}</td>
                <td>{item.companyInfo.name}</td>
                <td>{item.number_of_vehicle}</td>
                <td>{item.number_of_driver}</td>
                <td>{item.number_of_driver}</td>
                <td><Link to="/user_edit"><button>Detail</button></Link></td>
                <td>  <Link to="#"><button onClick={() => { handleClickopen() }}>Add </button></Link></td>
              </tr>
            ))}
          </tbody>
        </table>


        <div className='page'>
          {popup ?
            <div>
              <div className='popup'>
                <div className='popup-inner'>
                  <lable className="zxc">Add Vehicle 1</lable>
                  <div className='ewq'>
                    <div className='qwe'>
                      <div className='asd'>
                        <button className='close-btn' onClick={closePopup5}>X</button>
                        <lable>Vehicle Cataegory</lable>
                        <select className='select' placeholder='Select Vecicle Catagory'>
                          <option>Select Vecicle Catagory</option>
                          <option>Select Vecicle Catagory</option>
                          <option>Select Vecicle Catagory</option>
                          <option>Select Vecicle Catagory</option>
                          <option>Select Vecicle Catagory</option>
                        </select>
                      </div>

                      <div className='asd'>
                        <lable>Vehicle Name</lable>
                        <input name='vehicleName' type="text"
                          placeholder='Enter Vehicle Name'></input>
                      </div>

                      <div className='asd'>
                        <lable>Vehicle Condition</lable>
                        <select className='select' placeholder='Select Vecicle Catagory'>
                          <option>Select Vecicle Condition</option>
                          <option>Select Vecicle Condition</option>
                          <option>Select Vecicle Condition</option>
                          <option>Select Vecicle Condition</option>
                          <option>Select Vecicle Condition</option>
                        </select>
                      </div>

                      <div className='asd'>
                        <lable>Plate Number</lable>
                        <input placeholder='Please Enter Plate Number'></input>
                      </div>

                      <div className='asd'>
                        <lable>Manufacture Date</lable>
                        <input placeholder='Enter Manufactureing Date'></input>
                      </div>

                      <div className='asd'>
                        <lable>Device ID</lable>
                        <input placeholder='Enter Device ID'></input>
                      </div>
                      <div className='asdy'>
                        {/* <button>Back</button> */}
                      </div>
                      <div className='asdy'>
                        <button onClick={() => {
                          handleClickMessage()
                          closePopup5()
                        }}>Submit </button>
                      </div>
                      <div className='asdy'>
                        <button onClick={() => { handleClickopen2() }}>Add Vehicle</button>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div> : ""}

          {popup2 ?
            <div>
              <div className='popup2'>
                <div className='popup-inner'>
                  <lable className="zxc">Add Vehicle 2</lable>
                  <div className='ewq'>
                    <div className='qwe'>
                      <div className='asd'>
                        <button className='close-btn' onClick={closePopup5}>X</button>
                        <lable>Vehicle Cataegory</lable>
                        <select className='select' placeholder='Select Vecicle Catagory'>
                          <option>Select Vecicle Catagory</option>
                          <option>Select Vecicle Catagory</option>
                          <option>Select Vecicle Catagory</option>
                          <option>Select Vecicle Catagory</option>
                          <option>Select Vecicle Catagory</option>
                        </select>
                      </div>

                      <div className='asd'>
                        <lable>Vehicle Name</lable>
                        <input name='vehicleName' type="text"
                          placeholder='Enter Vehicle Name'></input>
                      </div>

                      <div className='asd'>
                        <lable>Vehicle Condition</lable>
                        <select className='select' placeholder='Select Vecicle Catagory'>
                          <option>Select Vecicle Condition</option>
                          <option>Select Vecicle Condition</option>
                          <option>Select Vecicle Condition</option>
                          <option>Select Vecicle Condition</option>
                          <option>Select Vecicle Condition</option>
                        </select>
                      </div>

                      <div className='asd'>
                        <lable>Plate Number</lable>
                        <input placeholder='Please Enter Plate Number'></input>
                      </div>

                      <div className='asd'>
                        <lable>Manufacture Date</lable>
                        <input placeholder='Enter Manufactureing Date'></input>
                      </div>

                      <div className='asd'>
                        <lable>Device ID</lable>
                        <input placeholder='Enter Device ID'></input>
                      </div>
                      <div className='asdy'>
                        <button onClick={() => { handleClickopen2() }}>Back</button>
                      </div>
                      <div className='asdy'>
                        <button onClick={() => {
                          handleClickMessage()
                          closePopup5()
                        }}>Submit </button>
                      </div>
                      <div className='asdy'>
                        <button onClick={() => { handleClickopen3() }}>Add Vehicle</button>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div> : ""}

          {popup3 ?
            <div>
              <div className='popup2'>
                <div className='popup-inner'>
                  <lable className="zxc">Add Vehicle 3</lable>
                  <div className='ewq'>
                    <div className='qwe'>
                      <div className='asd'>
                        <button className='close-btn' onClick={closePopup5}>X</button>
                        <lable>Vehicle Cataegory</lable>
                        <select className='select' placeholder='Select Vecicle Catagory'>
                          <option>Select Vecicle Catagory</option>
                          <option>Select Vecicle Catagory</option>
                          <option>Select Vecicle Catagory</option>
                          <option>Select Vecicle Catagory</option>
                          <option>Select Vecicle Catagory</option>
                        </select>
                      </div>

                      <div className='asd'>
                        <lable>Vehicle Name</lable>
                        <input name='vehicleName' type="text"
                          placeholder='Enter Vehicle Name'></input>
                      </div>

                      <div className='asd'>
                        <lable>Vehicle Condition</lable>
                        <select className='select' placeholder='Select Vecicle Catagory'>
                          <option>Select Vecicle Condition</option>
                          <option>Select Vecicle Condition</option>
                          <option>Select Vecicle Condition</option>
                          <option>Select Vecicle Condition</option>
                          <option>Select Vecicle Condition</option>
                        </select>
                      </div>

                      <div className='asd'>
                        <lable>Plate Number</lable>
                        <input placeholder='Please Enter Plate Number'></input>
                      </div>

                      <div className='asd'>
                        <lable>Manufacture Date</lable>
                        <input placeholder='Enter Manufactureing Date'></input>
                      </div>

                      <div className='asd'>
                        <lable>Device ID</lable>
                        <input placeholder='Enter Device ID'></input>
                      </div>
                      <div className='asdy'>
                        <button onClick={() => { handleClickopen3() }}>Back</button>
                      </div>
                      <div className='asdy'>
                        <button onClick={() => {
                          handleClickMessage()
                          closePopup5()
                        }}>Submit </button>
                      </div>
                      <div className='asdy'>
                        <button onClick={() => { handleClickopen4() }}>Add Vehicle</button>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div> : ""}


          {popup4 ?
            <div>
              <div className='popup2'>
                <div className='popup-inner'>
                  <lable className="zxc">Add Vehicle 4</lable>
                  <div className='ewq'>
                    <div className='qwe'>
                      <div className='asd'>
                        <button className='close-btn' onClick={closePopup5}>X</button>
                        <lable>Vehicle Cataegory</lable>
                        <select className='select' placeholder='Select Vecicle Catagory'>
                          <option>Select Vecicle Catagory</option>
                          <option>Select Vecicle Catagory</option>
                          <option>Select Vecicle Catagory</option>
                          <option>Select Vecicle Catagory</option>
                          <option>Select Vecicle Catagory</option>
                        </select>
                      </div>

                      <div className='asd'>
                        <lable>Vehicle Name</lable>
                        <input name='vehicleName' type="text"
                          placeholder='Enter Vehicle Name'></input>
                      </div>

                      <div className='asd'>
                        <lable>Vehicle Condition</lable>
                        <select className='select' placeholder='Select Vecicle Catagory'>
                          <option>Select Vecicle Condition</option>
                          <option>Select Vecicle Condition</option>
                          <option>Select Vecicle Condition</option>
                          <option>Select Vecicle Condition</option>
                          <option>Select Vecicle Condition</option>
                        </select>
                      </div>

                      <div className='asd'>
                        <lable>Plate Number</lable>
                        <input placeholder='Please Enter Plate Number'></input>
                      </div>

                      <div className='asd'>
                        <lable>Manufacture Date</lable>
                        <input placeholder='Enter Manufactureing Date'></input>
                      </div>

                      <div className='asd'>
                        <lable>Device ID</lable>
                        <input placeholder='Enter Device ID'></input>
                      </div>
                      <div className='asdy'>
                        <button onClick={() => { handleClickopen4() }}>Back</button>
                      </div>
                      <div className='asdy'>
                        <button onClick={() => {
                          handleClickMessage()
                          closePopup5()
                        }}>Submit </button>
                      </div>
                      <div className='asdy'>
                        <button onClick={() => { handleClickopen5() }}>Add Vehicle</button>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div> : ""}

          {popup5 ?
            <div>
              <div className='popup2'>
                <div className='popup-inner'>
                  <lable className="zxc">Add Vehicle 5</lable>
                  <div className='ewq'>
                    <div className='qwe'>
                      <div className='asd'>
                        <button className='close-btn' onClick={closePopup5}>X</button>
                        <lable>Vehicle Cataegory</lable>
                        <select className='select' placeholder='Select Vecicle Catagory'>
                          <option>Select Vecicle Catagory</option>
                          <option>Select Vecicle Catagory</option>
                          <option>Select Vecicle Catagory</option>
                          <option>Select Vecicle Catagory</option>
                          <option>Select Vecicle Catagory</option>
                        </select>
                      </div>

                      <div className='asd'>
                        <lable>Vehicle Name</lable>
                        <input name='vehicleName' type="text"
                          placeholder='Enter Vehicle Name'></input>
                      </div>

                      <div className='asd'>
                        <lable>Vehicle Condition</lable>
                        <select className='select' placeholder='Select Vecicle Catagory'>
                          <option>Select Vecicle Condition</option>
                          <option>Select Vecicle Condition</option>
                          <option>Select Vecicle Condition</option>
                          <option>Select Vecicle Condition</option>
                          <option>Select Vecicle Condition</option>
                        </select>
                      </div>

                      <div className='asd'>
                        <lable>Plate Number</lable>
                        <input placeholder='Please Enter Plate Number'></input>
                      </div>

                      <div className='asd'>
                        <lable>Manufacture Date</lable>
                        <input placeholder='Enter Manufactureing Date'></input>
                      </div>

                      <div className='asd'>
                        <lable>Device ID</lable>
                        <input placeholder='Enter Device ID'></input>
                      </div>
                      <div className='asdy'>
                        <button onClick={() => { handleClickopen5() }}>Back</button>
                      </div>
                      <div className='asdy'>
                        <button onClick={() => {
                          handleClickMessage()
                          closePopup5()
                        }}>Submit </button>
                      </div>
                      <div className='asdy'>
                        <button onClick={() => { handleClickopen6() }}>Add Vehicle</button>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div> : ""}

          {popup6 ?
            <div>
              <div className='popup2'>
                <div className='popup-inner'>
                  <lable className="zxc">Add Vehicle 6</lable>
                  <div className='ewq'>
                    <div className='qwe'>
                      <div className='asd'>
                        <button className='close-btn' onClick={closePopup5}>X</button>
                        <lable>Vehicle Cataegory</lable>
                        <select className='select' placeholder='Select Vecicle Catagory'>
                          <option>Select Vecicle Catagory</option>
                          <option>Select Vecicle Catagory</option>
                          <option>Select Vecicle Catagory</option>
                          <option>Select Vecicle Catagory</option>
                          <option>Select Vecicle Catagory</option>
                        </select>
                      </div>

                      <div className='asd'>
                        <lable>Vehicle Name</lable>
                        <input name='vehicleName' type="text"
                          placeholder='Enter Vehicle Name'></input>
                      </div>

                      <div className='asd'>
                        <lable>Vehicle Condition</lable>
                        <select className='select' placeholder='Select Vecicle Catagory'>
                          <option>Select Vecicle Condition</option>
                          <option>Select Vecicle Condition</option>
                          <option>Select Vecicle Condition</option>
                          <option>Select Vecicle Condition</option>
                          <option>Select Vecicle Condition</option>
                        </select>
                      </div>

                      <div className='asd'>
                        <lable>Plate Number</lable>
                        <input placeholder='Please Enter Plate Number'></input>
                      </div>

                      <div className='asd'>
                        <lable>Manufacture Date</lable>
                        <input placeholder='Enter Manufactureing Date'></input>
                      </div>

                      <div className='asd'>
                        <lable>Device ID</lable>
                        <input placeholder='Enter Device ID'></input>
                      </div>
                      <div className='asdy'>
                        <button onClick={() => { handleClickopen6() }}>Back</button>
                      </div>
                      <div className='asdy'>
                        <button onClick={() => {
                          handleClickMessage()
                          closePopup5()
                        }}>Submit </button>
                      </div>
                      <div className='asdy'>
                        <button onClick={() => { handleClickopen7() }}>Add Vehicle</button>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div> : ""}

          {popup7 ?
            <div>
              <div className='popup2'>
                <div className='popup-inner'>
                  <lable className="zxc">Add Vehicle 7</lable>
                  <div className='ewq'>
                    <div className='qwe'>
                      <div className='asd'>
                        <button className='close-btn' onClick={closePopup5}>X</button>
                        <lable>Vehicle Cataegory</lable>
                        <select className='select' placeholder='Select Vecicle Catagory'>
                          <option>Select Vecicle Catagory</option>
                          <option>Select Vecicle Catagory</option>
                          <option>Select Vecicle Catagory</option>
                          <option>Select Vecicle Catagory</option>
                          <option>Select Vecicle Catagory</option>
                        </select>
                      </div>

                      <div className='asd'>
                        <lable>Vehicle Name</lable>
                        <input name='vehicleName' type="text"
                          placeholder='Enter Vehicle Name'></input>
                      </div>

                      <div className='asd'>
                        <lable>Vehicle Condition</lable>
                        <select className='select' placeholder='Select Vecicle Catagory'>
                          <option>Select Vecicle Condition</option>
                          <option>Select Vecicle Condition</option>
                          <option>Select Vecicle Condition</option>
                          <option>Select Vecicle Condition</option>
                          <option>Select Vecicle Condition</option>
                        </select>
                      </div>

                      <div className='asd'>
                        <lable>Plate Number</lable>
                        <input placeholder='Please Enter Plate Number'></input>
                      </div>

                      <div className='asd'>
                        <lable>Manufacture Date</lable>
                        <input placeholder='Enter Manufactureing Date'></input>
                      </div>

                      <div className='asd'>
                        <lable>Device ID</lable>
                        <input placeholder='Enter Device ID'></input>
                      </div>
                      <div className='asdy'>
                        <button onClick={() => { handleClickopen7() }}>Back</button>
                      </div>
                      <div className='asdy'>
                        <button onClick={() => {
                          handleClickMessage()
                          closePopup5()
                        }}>Submit </button>
                      </div>
                      <div className='asdy'>
                        <button onClick={() => { handleClickopen8() }}>Add Vehicle</button>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div> : ""}

          {popup8 ?
            <div>
              <div className='popup2'>
                <div className='popup-inner'>
                  <lable className="zxc">Add Vehicle 8</lable>
                  <div className='ewq'>
                    <div className='qwe'>
                      <div className='asd'>
                        <button className='close-btn' onClick={closePopup5}>X</button>
                        <lable>Vehicle Cataegory</lable>
                        <select className='select' placeholder='Select Vecicle Catagory'>
                          <option>Select Vecicle Catagory</option>
                          <option>Select Vecicle Catagory</option>
                          <option>Select Vecicle Catagory</option>
                          <option>Select Vecicle Catagory</option>
                          <option>Select Vecicle Catagory</option>
                        </select>
                      </div>

                      <div className='asd'>
                        <lable>Vehicle Name</lable>
                        <input name='vehicleName' type="text"
                          placeholder='Enter Vehicle Name'></input>
                      </div>

                      <div className='asd'>
                        <lable>Vehicle Condition</lable>
                        <select className='select' placeholder='Select Vecicle Catagory'>
                          <option>Select Vecicle Condition</option>
                          <option>Select Vecicle Condition</option>
                          <option>Select Vecicle Condition</option>
                          <option>Select Vecicle Condition</option>
                          <option>Select Vecicle Condition</option>
                        </select>
                      </div>

                      <div className='asd'>
                        <lable>Plate Number</lable>
                        <input placeholder='Please Enter Plate Number'></input>
                      </div>

                      <div className='asd'>
                        <lable>Manufacture Date</lable>
                        <input placeholder='Enter Manufactureing Date'></input>
                      </div>

                      <div className='asd'>
                        <lable>Device ID</lable>
                        <input placeholder='Enter Device ID'></input>
                      </div>
                      <div className='asdy'>
                        <button onClick={() => { handleClickopen8() }}>Back</button>
                      </div>
                      <div className='asdy'>
                        <button onClick={() => {
                          handleClickMessage()
                          closePopup5()
                        }}>Submit </button>
                      </div>
                      <div className='asdy'>
                        <button onClick={() => { handleClickopen9() }}>Add Vehicle</button>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div> : ""}

          {popup9 ?
            <div>
              <div className='popup2'>
                <div className='popup-inner'>
                  <lable className="zxc">Add Vehicle 9</lable>
                  <div className='ewq'>
                    <div className='qwe'>
                      <div className='asd'>
                        <button className='close-btn' onClick={closePopup5}>X</button>
                        <lable>Vehicle Cataegory</lable>
                        <select className='select' placeholder='Select Vecicle Catagory'>
                          <option>Select Vecicle Catagory</option>
                          <option>Select Vecicle Catagory</option>
                          <option>Select Vecicle Catagory</option>
                          <option>Select Vecicle Catagory</option>
                          <option>Select Vecicle Catagory</option>
                        </select>
                      </div>

                      <div className='asd'>
                        <lable>Vehicle Name</lable>
                        <input name='vehicleName' type="text"
                          placeholder='Enter Vehicle Name'></input>
                      </div>

                      <div className='asd'>
                        <lable>Vehicle Condition</lable>
                        <select className='select' placeholder='Select Vecicle Catagory'>
                          <option>Select Vecicle Condition</option>
                          <option>Select Vecicle Condition</option>
                          <option>Select Vecicle Condition</option>
                          <option>Select Vecicle Condition</option>
                          <option>Select Vecicle Condition</option>
                        </select>
                      </div>

                      <div className='asd'>
                        <lable>Plate Number</lable>
                        <input placeholder='Please Enter Plate Number'></input>
                      </div>

                      <div className='asd'>
                        <lable>Manufacture Date</lable>
                        <input placeholder='Enter Manufactureing Date'></input>
                      </div>

                      <div className='asd'>
                        <lable>Device ID</lable>
                        <input placeholder='Enter Device ID'></input>
                      </div>
                      <div className='asdy'>
                        <button onClick={() => { handleClickopen9() }}>Back</button>
                      </div>
                      <div className='asdy'>
                        <button onClick={() => {
                          handleClickMessage()
                          closePopup5()
                        }}>Submit </button>
                      </div>
                      <div className='asdy'>
                        <button onClick={() => { handleClickopen10() }}>Add Vehicle</button>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div> : ""}

          {popup10 ?
            <div>
              <div className='popup2'>
                <div className='popup-inner'>
                  <lable className="zxc">Add Vehicle 10</lable>
                  <div className='ewq'>
                    <div className='qwe'>
                      <div className='asd'>
                        <button className='close-btn' onClick={closePopup5}>X</button>
                        <lable>Vehicle Cataegory</lable>
                        <select className='select' placeholder='Select Vecicle Catagory'>
                          <option>Select Vecicle Catagory</option>
                          <option>Select Vecicle Catagory</option>
                          <option>Select Vecicle Catagory</option>
                          <option>Select Vecicle Catagory</option>
                          <option>Select Vecicle Catagory</option>
                        </select>
                      </div>

                      <div className='asd'>
                        <lable>Vehicle Name</lable>
                        <input name='vehicleName' type="text"
                          placeholder='Enter Vehicle Name'></input>
                      </div>

                      <div className='asd'>
                        <lable>Vehicle Condition</lable>
                        <select className='select' placeholder='Select Vecicle Catagory'>
                          <option>Select Vecicle Condition</option>
                          <option>Select Vecicle Condition</option>
                          <option>Select Vecicle Condition</option>
                          <option>Select Vecicle Condition</option>
                          <option>Select Vecicle Condition</option>
                        </select>
                      </div>

                      <div className='asd'>
                        <lable>Plate Number</lable>
                        <input placeholder='Please Enter Plate Number'></input>
                      </div>

                      <div className='asd'>
                        <lable>Manufacture Date</lable>
                        <input placeholder='Enter Manufactureing Date'></input>
                      </div>

                      <div className='asd'>
                        <lable>Device ID</lable>
                        <input placeholder='Enter Device ID'></input>
                      </div>
                      <div className='asdy'>
                        <button onClick={() => { handleClickopen10() }}>Back</button>
                      </div>
                      <div className='asdy'>
                        <button onClick={() => {
                          handleClickMessage()
                          closePopup5()
                        }}>Submit </button>
                      </div>
                      <div className='asdy'>
                        {/* <button onClick={() => { handleClickopen3() }}>Add Vehicle</button> */}
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div> : ""}



        </div>


      </div>






    </>






  )
}