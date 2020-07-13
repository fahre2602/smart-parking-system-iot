<?php

class DbOperation
{
    //Database connection link
    private $con;

    //Class constructor
    function __construct()
    {
        //Getting the DbConnect.php file
        require_once dirname(__FILE__) . '/DbConnect.php';

        //Creating a DbConnect object to connect to the database
        $db = new DbConnect();

        //Initializing our connection link of this class
        //by calling the method connect of DbConnect class
        $this->con = $db->connect();
    }

  /*
	* Fungsi getListSlot()
	* Deskripsi : Mendapatkan data seluruh slot parkir yang terdapat dalam storage
  * Input parameter : -
  * Output : list slot
	*/
	function getListSlot(){
		$stmt = $this->con->prepare("SELECT * FROM parkslot_list_list");
		$stmt->execute();
		$stmt->bind_result($id, $slotid, $status, $lock);

		$slots = array();

		while($stmt->fetch()){
			$slot  = array();
			$slot['id'] = $id;
			$slot['slot'] = $slotid;
			$slot['status'] = $status;
			$slot['lock'] = $lock;

			array_push($slots, $slot);
		}

		return $slots;
	}

  /*
  * Fungsi createBooking()
  * Deskripsi : melakukan proses booking
  * Input parameter : bookfromtime, bookfromdate, bookuntildate, bookuntiltime, slotid, userid
  * Output : Boolean
  */
  function createBooking($bookfromdate, $bookfromtime, $bookuntildate, $bookuntiltime, $slotid, $userid){
    date_default_timezone_set("Asia/Bangkok");
    $bookfromstring = $bookfromdate." ".$bookfromtime;
    $bookfromstringtodate =  date_create_from_format('m/d/Y H:i:s', $bookfromstring);
    $bookfrom = date_format($bookfromstringtodate, 'Y-m-d H:i:s');
    $bookuntilstring = $bookuntildate." ".$bookuntiltime;
    $bookuntilstringtodate =  date_create_from_format('m/d/Y H:i:s', $bookuntilstring);
    $bookuntil = date_format($bookuntilstringtodate, 'Y-m-d H:i:s');
    $booktime = date("Y-m-d H:i:s");

    $stmt = $this->con->prepare("SELECT id FROM parkslot_list_akun WHERE username = '$userid'");
    $stmt->execute();
    $stmt->bind_result($id_user);
    while($stmt->fetch()){
      $user  = array();
      $user['id_user'] = $id_user;
    }

    $stmt6 = $this->con->prepare("SELECT nama FROM parkslot_list_akun WHERE username = '$userid'");
    $stmt6->execute();
    $stmt6->bind_result($nama);
    while($stmt6->fetch()){
      $user['nama'] = $nama;
    }

		$stmt2 = $this->con->prepare("INSERT INTO parkslot_list_booking (booktime, bookfrom, bookuntil, slot_id, user_id) VALUES (?, ?, ?, ?, ?)");
		$stmt2->bind_param("sssis", $booktime, $bookfrom, $bookuntil, $slotid, $user['id_user']);

		if($stmt2->execute()){
      $sql = "UPDATE `parkslot_list_list` SET `lock` = 1 WHERE `id` = $slotid";
      $this->con->query($sql);
      //ambil slot berdasarkan slotid
      $stmt3 = $this->con->prepare("SELECT slot FROM parkslot_list_list WHERE id = '$slotid'");
      $stmt3->execute();
      $stmt3->bind_result($slotname);
      //
      $slot  = array();
      $slot['name'] = "";
      while($stmt3->fetch()){
        $slot['name'] = $slotname;
      }

      $stmt4 = $this->con->prepare("INSERT INTO parkslot_list_historybooking (booktime, bookfrom, bookuntil, slot, username) VALUES (?, ?, ?, ?, ?)");
  		$stmt4->bind_param("sssss", $booktime, $bookfrom, $bookuntil, $slot['name'], $user['nama']);
      $stmt4->execute();

      $stmt5 = $this->con->prepare("INSERT INTO parkslot_list_historyslot (tanggal, slot, status) VALUES (?, ?, ?)");
      $lock = "Lock";
      $stmt5->bind_param("sss", $booktime, $slot['name'], $lock);
      if($stmt5->execute()){
        return true;
      }
      else{
        return false;
      }
    }
    else{
      return false;
    }
	}

  /*
	* Fungsi Unlock Slot
	* Deskripsi : Melakukan proses unlock dengan mengupdate data slot pada miniDB dan menghapus data booking.
  * Input parameter : id_slot
  * Output : Boolean
	*/
	function unlockSlot($id){
    date_default_timezone_set("Asia/Bangkok");
    $sql = "UPDATE `parkslot_list_list` SET `lock` = 0 WHERE `id` = $id";
		if($this->con->query($sql)){
      $stmt = $this->con->prepare("DELETE FROM parkslot_list_booking WHERE slot_id = '$id'");
      $stmt->execute();

      $unlock = "Unlock";
      $datetime = date("Y-m-d H:i:s");
      //ambil slot berdasarkan slotid
      $stmt3 = $this->con->prepare("SELECT slot FROM parkslot_list_list WHERE id = '$id'");
      $stmt3->execute();
      $stmt3->bind_result($slotname);
      //
      $slot  = array();
      $slot['name'] = "";
      while($stmt3->fetch()){
        $slot['name'] = $slotname;
      }
      $stmt2 = $this->con->prepare("INSERT INTO parkslot_list_historyslot (tanggal, slot, status) VALUES (?, ?, ?)");
      $stmt2->bind_param("sss", $datetime, $slot['name'], $unlock);
      $stmt2->execute();
      return true;
    }
    else{
      return false;
    }
	}

  /*
  * Fungsi cekuser()
  * Deskripsi : Mengecek ketersediaan akun dengan userid pada storage
  * Input parameter : userid
  * Output : Boolean
  */
  function cekuser($userid){
    $stmt = $this->con->prepare("SELECT id FROM parkslot_list_akun WHERE username = '$userid'");
    $stmt->execute();
    $stmt->bind_result($id_user);
    //
    $user  = array();
    $user['id'] = "";
    while($stmt->fetch()){
      $user['id'] = $id_user;
    }

    if($user['id'] == ""){
      return false;
    }
    else{
      return true;
    }
  }

  /*
  * Fungsi cekBooking()
  * Deskripsi : Mengecek userid tertentu apakah ada dalam storage booking
  * Input parameter : userid, slotid
  * Output : Boolean
  */
  function cekBooking($userid, $slotid){
    $stmt = $this->con->prepare("SELECT id FROM parkslot_list_akun WHERE username = '$userid'");
    $stmt->execute();
    $stmt->bind_result($id_user);
    //
    $user  = array();
    while($stmt->fetch()){
      $user['id'] = $id_user;
    }
    $id_user = $user['id'];

    if($id_user != ""){
      $stmt2 = $this->con->prepare("SELECT slot_id FROM parkslot_list_booking WHERE user_id = '$id_user'");
      $stmt2->execute();
      $stmt2->bind_result($slot_id);
      //

      $booking  = array();
      $booking['slot_id'] = "";
      while($stmt2->fetch()){
        $booking['slot_id'] = $slot_id;
      }

      if($booking['slot_id'] == $slotid)
        return true;

      return false;
      print "error1";
    }
    else{
      return false;
      print "error2";
    }

  }

  /*
  * Fungsi cekIsBooking()
  * Deskripsi : mengecek apakah userid tertentu sedang membooking
  * Input parameter : userid
  * Output : Boolean
  */
  function cekIsBooking($userid){
    $stmt = $this->con->prepare("SELECT id FROM parkslot_list_akun WHERE username = '$userid'");
    $stmt->execute();
    $stmt->bind_result($id_user);
    print $id_user;
    //
    $user  = array();
    while($stmt->fetch()){
      $user['id'] = $id_user;
    }
    $id_user = $user['id'];

    $stmt2 = $this->con->prepare("SELECT id FROM parkslot_list_booking WHERE user_id = '$id_user'");
    $stmt2->execute();
    $stmt2->bind_result($id_booking);
    //
    $booking  = array();
    $booking['id'] = "";
    while($stmt2->fetch()){
      $booking['id'] = $id_booking;
    }
    if($booking['id'] == ""){
      return false;
    }
    else{
      return true;
    }
  }

  /*
  * Fungsi login()
  * Deskripsi : Melakukan proses login dengan mengecek userid serta password pada storage
  * Input parameter : userid, password
  * Output : Boolean
  */
	function login($userid, $password){
    $password_enc = md5($password);
    $stmt = $this->con->prepare("SELECT password FROM parkslot_list_akun WHERE username = '$userid'");
    $stmt->execute();
    $stmt->bind_result($password_user);
    //

    $user  = array();
    while($stmt->fetch()){
      $user['password_user'] = $password_user;
    }

    if($password_enc == $user['password_user'])
      return true;

    return false;
  }
}
