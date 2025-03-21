<?php

declare(strict_types=1);
session_start();

class Database
{
  private $hostname = 'localhost';
  private $username = 'root';
  private $password = '';
  private $database = "infiniteskyvf";

  public function connect_to_db(): mysqli
  {
    return mysqli_connect($this->hostname, $this->username, $this->password, $this->database);
  }
}