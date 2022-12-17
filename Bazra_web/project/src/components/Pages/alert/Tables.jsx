import React from 'react'
import './alert.css';
import { FaUserAlt } from "react-icons/fa";
import "antd/dist/antd"
import { useState, useEffect } from 'react';
import { Pagination } from 'antd';

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


      <div className='alert_vehicle_tables' id='myTable'>  
        <p>{title}</p>

        <table class="vehicle_table" id="myTable">

          <thead>
            <tr>
              <th>Profile</th>
              <th>Driver</th>
              <th>Plate Number</th>
              <th>Alert Location</th>
              <th>Alert Type</th>
              <th>Owner</th>
            </tr>
          </thead>
          <tbody>
          {currentPage.map(item => (
              <tr className='active_row'>

                <td><FaUserAlt className='next' size="1.5rem" color='rgb(63, 63, 63)'></FaUserAlt></td>
                <td>{item.Driver}</td>
                <td>{item.Plate_number}</td>
                <td>{item.Alert_location}</td>
                <td>{item.Alert_type}</td>
                <td>{item.Owner}</td>
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