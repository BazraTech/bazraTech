import React from 'react'
import './users.css';
import { Link } from 'react-router-dom';
import { FaHome } from 'react-icons/fa';
import { AiFillCar } from "react-icons/ai";
import { RiGpsFill } from "react-icons/ri";
import { MdMonitor } from "react-icons/md";
import { FaUsers } from "react-icons/fa";
import { HiBellAlert } from "react-icons/hi2";
import { HiDocumentReport } from "react-icons/hi";
import { FaRegIdCard } from 'react-icons/fa';
import { BsFillChatDotsFill } from "react-icons/bs";
import { FaUserAlt } from "react-icons/fa";
import { AiFillSetting } from "react-icons/ai";
import { FiLogOut } from "react-icons/fi";
import { FaRoute } from "react-icons/fa";
import { BsSearch } from "react-icons/bs";
import { AiFillFilter } from "react-icons/ai";
import { AiFillCaretDown } from "react-icons/ai";
import { GrFormNext } from "react-icons/gr";
import { GrFormPrevious } from "react-icons/gr";
import { FaParking } from "react-icons/fa";
import { GrSettingsOption } from "react-icons/gr";
import { HiMenuAlt1 } from "react-icons/hi";
import {Table} from "antd";
import "antd/dist/antd"
import { render } from '@testing-library/react';
import { useState, useEffect } from 'react';

export default function Cards({ title, data }) {

  const [loading, setLoading] = useState(false)
  const [dataSource, setDataSource] = useState([])

  useEffect(() => {
    setLoading(true)
    fetch("")
    .then(response => response.json())
    .then(data =>{
      setDataSource(data)
    }).catch(err => {
      console.log(err)
    }).finally(() =>{
      setLoading(false)
    })
  }, 
  [])

  const columns = [
    {
      key:"1",
      title:'id',
      dataIndex:'id'
    },

    {
      key:"2",
      title:'Assigned Driver',
      dataIndex:'id'
    },

    {
      key:"3",
      title:'Vehicle ID',
      dataIndex:'id'
    },

    {
      key:"4",
      title:'Vehicle Type',
      dataIndex:'id',
    },

    {
      key:"5",
      title:'Plate Number',
      dataIndex:'id'
    },
 
    {
      key:"3",
      title:"Status",
      dataIndex:"completed",
      render:(complated) => {
        return<p>{complated ? 'Active':'Offline'}</p>
      },
      filters:[
        {text:'Active', value:true},
        {text:'Offline', value:false}
      ],

      onFilter:(value, record)=>{
        return record.completed === value
      }
     
    },
   
  ]

  return (
    <>


    <div className='outer_vehicle_tables' id='myTable'>
        <p>{title}</p>
       
        <table class="vehicle_table" id="myTable">

          <thead>
            <tr>
              <th>User</th>
              <th>Company ID</th>
              <th>Coumpany Name</th>
              <th>Number Of Vegicle</th>
              <th>Number Of Driver</th>
              <th>Status</th>
              <th>Detail</th>
            </tr>
          </thead>
          <tbody>
            {data[0].map(item => (
              <tr className='active_row'>
                <td>{item.user}</td>
                <td>{item.Company_id}</td>
                <td>{item.Company_name}</td>
                <td>{item.number_of_vehicle}</td>
                <td>{item.number_of_driver}</td>
                <td>{item.number_of_driver}</td>
                <td><Link to="/user_edit"><button>Detail</button></Link></td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
      <div className='page'>
        <p>Row per page</p><p className='num'>3</p>
        <p><AiFillCaretDown className='sel' size="0.8rem" color='rgb(63, 63, 63)'></AiFillCaretDown></p>
        <p>1-8 of 12</p>
        <p><GrFormPrevious className='next' size="1rem" color='rgb(63, 63, 63)'></GrFormPrevious></p>
        <p><GrFormNext className='next' size="1rem" color='rgb(63, 63, 63)'></GrFormNext></p>
      </div>





    </>






  )
}