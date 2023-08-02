import React, { Component } from 'react'
import styles from './Post_market.module.css';
import { useForm } from 'react-hook-form';
import { Link, useParams, useNavigate } from 'react-router-dom';
import { useState, useEffect } from 'react';
import Header from '../../Header/Header';
import Navigation from '../Navigation/Navigation';
import axios from "axios";
import swal from "sweetalert";

export default function Market_Progress() {
const send = false
const { id } = useParams()
    const {
        register,
        handleSubmit,
        watch, 
        formState: { errors }, 
    } = useForm();
    
    const onSubmit = (e) => {
        e.preventDefault();
        handleClick();
    };


    const handleClick = async () => {
        
        console.log('Im on submit function');
        const options = {
            method: "POST",
            headers: {
                'Content-Type': 'application/json',
                "Accept": "application/json",
                "Authorization": `Bearer ${jwt}`
            },
           
        };
        const url =`http://164.90.174.113:9090/Api/Admin/AcceptedCargo/${id}`; 
        try {
            const response = await fetch(url, options);
            const result = await response.json();
            console.log(result);
            localStorage.setItem("message", JSON.stringify(result["message"])); 
            const mess = localStorage.getItem("message");
            console.log(mess);
            if (response.ok) {
                console.log("Posted successful");
                swal("Successfully Posted to cargo owner", `${mess}`, "success", {
                    button: true,
                    timer: 60000,
                });
               
            } else {
                console.log("failed");
                swal(`Failed To Post ${mess}`, "Error", "error");
            }
        } catch (error) {
            console.error(error);
        }
    }



    const [state, setState] = useState(false);

    const toggle = () => {
        setState(!state);
    };

    const [diabled, setPop] = useState(true);
    const handleChange = () => {
        setPop(!diabled);
    }

    const [popup, setPop1] = useState(false);
    const handleClickopen = () => {
        setPop1(!popup);
    }

    const jwt = JSON.parse(localStorage.getItem('jwt'));// Getting the token from login api
    const options = {
        headers: {
            'Content-Type': 'application/json',
            "Accept": "application/json",
            "Authorization": `Bearer ${jwt}`
        },
      
    };
    
    const [reloadKey, setReloadKey] = useState(0);

    const handleReload = () => {
    setReloadKey((prevKey) => prevKey + 1);
    };
   
    const url2 = `http://164.90.174.113:9090/Api/Admin/All/CargoDrivers/${id}`;

    const [dataSource, setDataSource] = useState([]);
    const [error, setError] = useState(null);
    
    useEffect(() => {
      fetch(url2, options)
            .then(response => {
                localStorage.setItem("message", JSON.stringify(response["message"])); 
                const mess = localStorage.getItem("message");
                console.log(response.status)
          if (response.status == 500) {
            throw new Error('Failed to get the drivers');
          }
          return response.json();
        })
        .then(data => {
          setDataSource(data && data.cargoDriversINFs);
        })
        .catch(error => {

          setError(error.message);
          swal(`Failed ${error}`, "Error", "error");
        });
    }, [reloadKey]);
    // }, [])
 const url1 = `http://164.90.174.113:9090/Api/Admin/All/Cargos/${id}`;

 const [dataSource1, setDataSource1] = useState([])
 useEffect(() => {
     // setLoading(true);
     fetch(url1, options)
         .then(response => {
            localStorage.setItem("message", JSON.stringify(response["message"])); 
            const mess = localStorage.getItem("message");
            console.log(response.status)
      if (response.status == 500) {
        throw new Error('Failed to get  Cargo');
      }
      return response.json();
    })
    .then(data => {
        setDataSource1(data);
    })
    .catch(error => {

      setError(error.message);
      swal(`Failed ${error}`, "Error", "error");
    });
 }, [reloadKey])
console.log(dataSource1);
console.log(dataSource)

    const navigate = useNavigate();
    const goBack = () => {
        navigate(-1);
    }
  /****************** payment*********/
  const [weybill, setWybill] = useState('')
  const [f1Form,setF1Form]=useState('')
  const [amount, setPayment]=useState('')
//   const [driverPhone,setDriverPhone]=useState('')
  const [cargoId,setCargoId] = useState(dataSource.cargo)
    const remaining = dataSource1.remaining == dataSource1.weight ? 0 : dataSource1.remaining == 0 ? dataSource1.weight : dataSource1.remaining
    let percent = (remaining/dataSource1.weight) * 100;


    const payForDriver = async (phone) => 
    {

            const formData = new FormData();
            formData.append("weybill", weybill);
            formData.append("f1Form", f1Form);
            formData.append("amount", amount);
            formData.append("driverPhone", phone);
            formData.append("cargoId", cargoId);
            console.log(formData)

        try{
            const response = await axios.post(
                'http://164.90.174.113:9090Api/Payment/ToDriver',
                formData,
                {
                    headers: {
                        'Content-Type': 'multipart/form-data',
                        "Authorization": `Bearer ${jwt}`,
                    },
                    }
                );
              localStorage.setItem("message", JSON.stringify(response.data["message"]));
                const mess = localStorage.getItem("message");
                console.log(response);
                swal("Successfully ", `${mess}`, "success", {
                    button: true,
                });
        } catch (error) {
          if (error.response) {
            localStorage.setItem('message', JSON.stringify(error.response.data['message']));
            const messx = localStorage.getItem('message');
            console.log('message', messx);
            console.log(error.response.data);
            swal("Error", `${messx}`, "error", {
              button: true,
            });
            console.log(error.response.status);
            console.log(error.response.headers);
          } else if (error.request) {
            console.log(error.request);
          } else {
            console.log('Error', error.message);
          }
        }
    }


    return (

        <div>

          {dataSource1.status ='ACTIVE' ?<Navigation path="/marketing" title="Post progress" link="/marketing" past="marketing"></Navigation>:
           <Navigation path="/marketing" title="Post progress" link={`/Post_market/${id}`} past="post marketing"></Navigation>}

            <div className={styles.main_content}>

                <div className={styles.tripHeader}>
                    <p><h1 className={styles.avaliableVehicles}>Post cargo Detail</h1></p>
                    <p ><h4>Cargo Owner Name : {dataSource1.cargoOwner} <br /> Pakaging : {dataSource1.packaging}</h4></p>
                </div>
                <div className={styles.allDiv}>
                   
                    <form onSubmit={onSubmit}>


                        <div className={styles.forms}>
                        <div>
                                        <p>Total Weight</p>
                                        <input  value={dataSource1.weight} type="text" disabled={diabled}></input>
                                </div> 
                                <div>
                                        <p>Date</p>
                                        <input  value={dataSource1.date} type="text" disabled={diabled}></input>
                                </div> 
                                <div>
                                        <p>Work Status</p>
                                        <input  value={dataSource1.status} type="text" disabled={diabled}></input>
                                </div> 
                                <div>
                                        <p>weybill</p>
                                        <input 
                                        name='weybill'
                                         onChange={(e)=>setWybill(e.target.files[0])}
                                          type="file"></input>
                                </div>   
                                <div>
                                        <p>F1 form</p>
                                        <input 
                                        name='f1Form'
                                         onChange={(e)=>setF1Form(e.target.files[0])}
                                        type="file" 
                                        ></input>
                                </div>  
                                <div>
                                        <p>payment</p>
                                        <input  
                                        onChange={(e)=>setPayment(e.target.value)}
                                        // value={dataSource1.payemt} 
                                        placeholder='Enter pyment for driver'
                                        type="text"></input>
                                </div>          
                        </div>  
                       {/* {dataSource1.status == 'ACCEPTED' ? <p  className={styles.button3}>already send to cargo owner</p>: <button className={styles.button3}>Send to Cargo Owner</button>} */}
                    </form>
                 </div>

                        
            {/*---------------- table ------------------- */}

            <div className={styles.outer_vehicle_table} id='myTable'>
              <p>Vihecles list</p>
              <table className={styles.vehicle_table} id="myTable">
                                            <thead>
                                                <tr>
                                                <th>cargo Id</th>
                                                    <th>vihicle owner Name</th>
                                                    <th>Driver Name</th>
                                                    <th>Plate number</th>
                                                    <th>State</th>
                                                    <th>paid/Unpaid</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                              {dataSource.map(item =>(
                                                    <tr className={styles.active_row} key={item.id}>
                                                        <td>{item.cargo}</td>
                                                        <td>{item.vehicleOwner}</td>
                                                        <td>{item.driver}</td>
                                                        <td>{item.plateNumber}</td>
                                                        <td>{item.driverState}</td> 
                                                        <td>
                                                            <button
                                                            onClick={()=>payForDriver(item.driverPhone)} 
                                                            >Pay</button> </td>                          
                                                    </tr>
                                              ))}
                                            </tbody>
                                        </table>
            </div>
            <div className={styles.page}>
              {/* <Pagination 
                onChange={(page) => setCurentPage(page)}
                pageSize={postPerPage}
                current={page}
                total={totalPages}
              showQuickJumper
              showSizeChanger
              onShowSizeChange={onShowSizeChange} 
               /> */}
           
                 
            </div>

            

            {/* ---------------end Registaration--------------- */}
        </div>
 </div>
    )
}
