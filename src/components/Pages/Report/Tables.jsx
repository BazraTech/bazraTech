import React from 'react'
import './Report.css';
import { Link } from 'react-router-dom';
import "antd/dist/antd"
import { useState, useEffect } from 'react';
import { Pagination } from 'antd';
// import { total } from './data/jsonData';

const PAGE_SIZE = 3

export default function Table({ title, datas }) {

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