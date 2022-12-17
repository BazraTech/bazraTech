import React from 'react'
import './Report.css';
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
import { Table } from "antd";
import "antd/dist/antd"
import { render } from '@testing-library/react';
import { useState, useEffect } from 'react';

import { Axios } from 'axios';
import { Pagination } from 'antd';
// import { total } from './data/jsonData';

const PAGE_SIZE = 3

export default function Cards({ title, datas }) {

  const [list, setList] = useState([datas[0]]);
  const [total, setTotal] = useState(datas[0].length);
  const [page, setCurentPage] = useState(1);
  const [postPerPage, setpostPerPage] = useState(10);

  const onShowSizeChange=( current, pageSize) => {
    setpostPerPage(pageSize);
  }

    useEffect(() => {
      setTotal([datas[0].length])
  }, []);


  const indexOfLastPage = page + postPerPage;
  const indexOfFirstPage = indexOfLastPage - postPerPage;
  const currentPage = list[0].slice(indexOfFirstPage, indexOfLastPage);

  return (
    <>

      <div className='outer_vehicle_tables' id='myTable'>
        <p>{title}</p>

        <table class="vehicle_table" id="myTable">

          <thead>
            <tr>
              <th>Profile</th>
              <th>Assigned Driver</th>
              <th>Vehicle ID</th>
              <th>Vehicle Type</th>
              <th>Plate Number</th>
              <th>Report</th>
            </tr>
          </thead>
          <tbody>
            {currentPage.map(item => (
              <tr className='active_row'>

                <td>{item.user}</td>
                <td>{item.assignedDriver}</td>
                <td>{item.vehicleId}</td>
                <td>{item.vehicleType}</td>
                <td>{item.planeNumber}</td>
                <td><Link to="/report_detail"><button>Report</button></Link></td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      <div className='page'>
        <Pagination
          onChange= {(page) => setCurentPage(page)}
          pageSize={postPerPage}
          current={page}
          total={total}
          showQuickJumper
          showSizeChanger
          onShowSizeChange ={onShowSizeChange}
        
        />
      </div>

    </>

  )
}