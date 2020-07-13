<?php

	//getting the dboperation class
	require_once '../includes/DbOperation.php';
	require_once '../includes/phpMQTT.php';

	$server = "192.168.1.73";
	$port = 1883;
	$username = "";
	$password = "";
	$client_id = "phpMQTT-subscriber";

	/*
	* onMessage()
	* Deskripsi : Inisialisasi koneksi MQTT dan callback jika terdapat pesan masuk
	* Input parameter : -
	* Output : -
	*/
	$mqtt = new phpMQTT($server, $port, $client_id);

	if(!$mqtt->connect(true, NULL, $username, $password)) {
		exit(1);
	}

	$topics['sps'] = array("qos" => 0, "function" => "procmsg");
	$mqtt->subscribe($topics, 0);

	function procmsg($topic, $msg){
		$pesan = explode("_", $msg);
		if ($pesan[1] == "server"){
			if ($pesan[2] == "dbsync"){
				$mqtt->publish("sps", "masuk dbsync nya", 0);
			}
		}

	}


	/*
	* Fungsi isTheseParametersAvailable()
	* Deskripsi : validasi parameter pada pesan yang masuk ke API
	* Input parameter : parameter
	* Output : -
	*/
	function isTheseParametersAvailable($params){
		$available = true;
		$missingparams = "";

		foreach($params as $param){
			if(!isset($_POST[$param]) || strlen($_POST[$param])<=0){
				$available = false;
				$missingparams = $missingparams . ", " . $param;
			}
		}

		if(!$available){
			$response = array();
			$response['error'] = true;
			$response['message'] = 'Parameters ' . substr($missingparams, 1, strlen($missingparams)) . ' missing';

			echo json_encode($response);

			die();
		}
	}

	$response = array();

	//if it is an api call
	//that means a get parameter named api call is set in the URL
	//and with this parameter we are concluding that it is an api call
	/*
	* Fungsi getApiCall()
	* Deskripsi : melaksanakan perintah apicall yang diterima
	* Input parameter : apicall
	* Output : json
	*/
	if(isset($_GET['apicall'])){

		switch($_GET['apicall']){

			case 'createbooking':
				isTheseParametersAvailable(array('bookfromdate','bookfromtime','bookuntildate','bookuntiltime','slotid','userid'));

				$db = new DbOperation();

				if($db->cekIsBooking($_POST['userid'])){
					$response['error'] = true;
					$response['message'] = 'User telah membooking slot lain';
				}
				else{
					$result = $db->createBooking(
					$_POST['bookfromdate'],
					$_POST['bookfromtime'],
					$_POST['bookuntildate'],
					$_POST['bookuntiltime'],
					$_POST['slotid'],
					$_POST['userid']
				);

				if($result){
					$response['error'] = false;

					$response['message'] = 'Booking request addedd successfully';

					$response['slots'] = $db->getListSlot();

					$messagelock = "server_pi_lock_".$_POST['slotid'];
					$mqtt->publish("sps", $messagelock, 0);
				}else{

					$response['error'] = true;

					$response['message'] = 'Some error occurred please try again';
				}
			}


			break;

			case 'getslots':
				$db = new DbOperation();
				$response['error'] = false;
				$response['message'] = 'Request successfully completed';
				$response['slots'] = $db->getListSlot();
			break;

			case 'unlockslot':

				if((isset($_GET['slotid']))&&(isset($_GET['userid']))){
					$db = new DbOperation();
					if($db->cekBooking($_GET['userid'],$_GET['slotid'])){
						if($db->unlockSlot($_GET['slotid'])){
							$response['error'] = false;
							$response['message'] = 'Slot unlocked successfully';
							$response['slots'] = $db->getListSlot();


							$messageunlock = "server_pi_unlock_".$_GET['slotid'];
							$mqtt->publish("sps", $messageunlock, 0);

							// $mqtt->publish("sps", "server_pi_unlock_1", 0);
						}else{
							$response['error'] = true;
							$response['message'] = 'Some error occurred please try again';
						}
					}
					else{
						$response['error'] = true;
						$response['message'] = 'Gagal unlock, user tidak membooking slot yang dipilih';
					}
				}
				else{
					$response['error'] = true;
					$response['message'] = 'Nothing to unlock, provide an id please';
				}
			break;

			case 'login':
				isTheseParametersAvailable(array('userid','password'));

				$db = new DbOperation();

				if($db->cekuser($_POST['userid'])){
					$result = $db->login(
						$_POST['userid'],
						$_POST['password']
					);

					if($result){
						$response['error'] = false;

						$response['message'] = 'Login success';

					}else{

						$response['error'] = true;

						$response['message'] = 'Some error occurred please try again';
					}
				}
				else{
					$response['error'] = true;
					$response['message'] = 'Userid tidak terdaftar';
				}

			break;
		}

	}else{
		$response['error'] = true;
		$response['message'] = 'Invalid API Call';
	}

	echo json_encode($response);
