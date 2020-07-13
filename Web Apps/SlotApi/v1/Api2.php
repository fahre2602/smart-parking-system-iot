<?php

	//getting the dboperation class
	require_once '../includes/DbOperation.php';

	//function validating all the paramters are available
	//we will pass the required parameters to this function
	function isTheseParametersAvailable($params){
		//assuming all parameters are available
		$available = true;
		$missingparams = "";

		foreach($params as $param){
			if(!isset($_POST[$param]) || strlen($_POST[$param])<=0){
				$available = false;
				$missingparams = $missingparams . ", " . $param;
			}
		}

		//if parameters are missing
		if(!$available){
			$response = array();
			$response['error'] = true;
			$response['message'] = 'Parameters ' . substr($missingparams, 1, strlen($missingparams)) . ' missing';

			//displaying error
			echo json_encode($response);

			//stopping further execution
			die();
		}
	}

	//an array to display response
	$response = array();

	//if it is an api call
	//that means a get parameter named api call is set in the URL
	//and with this parameter we are concluding that it is an api call
	if(isset($_GET['apicall'])){

		switch($_GET['apicall']){

			//the CREATE operation
			//if the api call value is 'createhero'
			//we will create a record in the database
			case 'createbooking':
				//first check the parameters required for this request are available or not
				isTheseParametersAvailable(array('bookfromdate','bookfromtime','bookuntildate','bookuntiltime','slotid','userid'));

				//creating a new dboperation object
				$db = new DbOperation();

				//creating a new record in the database
				if($db->cekIsBooking($_POST['userid'])){
					//record is created means there is no error
					$response['error'] = true;
					//in message we have a success message
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

				//if the record is created adding success to response
				if($result){
					//record is created means there is no error
					$response['error'] = false;

					//in message we have a success message
					$response['message'] = 'Booking request addedd successfully';

					//and we are getting all the heroes from the database in the response
					$response['slots'] = $db->getListSlot();
				}else{

					//if record is not added that means there is an error
					$response['error'] = true;

					//and we have the error message
					$response['message'] = 'Some error occurred please try again';
				}
			}


			break;

			//the READ operation
			//if the call is getheroes
			case 'getslots':
				$db = new DbOperation();
				$response['error'] = false;
				$response['message'] = 'Slot list successfully loaded';
				$response['slots'] = $db->getListSlot();
			break;


			case 'login':
				//first check the parameters required for this request are available or not
				isTheseParametersAvailable(array('userid','password'));

				//creating a new dboperation object
				$db = new DbOperation();

				//creating a new record in the database
				if($db->cekuser($_POST['userid'])){
					$result = $db->login(
						$_POST['userid'],
						$_POST['password']
					);

					if($result){
						//record is created means there is no error
						$response['error'] = false;

						//in message we have a success message
						$response['message'] = 'Login success';

					}else{

						//if record is not added that means there is an error
						$response['error'] = true;

						//and we have the error message
						$response['message'] = 'Some error occurred please try again';
					}
				}
				else{
					$response['error'] = true;
					$response['message'] = 'Userid tidak terdaftar';
				}

			break;

			case 'unlockslot':

				//for the delete operation we are getting a GET parameter from the url having the id of the record to be deleted
				if((isset($_GET['slotid']))&&(isset($_GET['userid']))){
					$db = new DbOperation();
					if($db->cekBooking($_GET['userid'],$_GET['slotid'])){
						if($db->unlockSlot($_GET['slotid'])){
							$response['error'] = false;
							$response['message'] = 'Slot unlocked successfully';
							$response['slots'] = $db->getListSlot();


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
		}

	}else{
		//if it is not api call
		//pushing appropriate values to response array
		$response['error'] = true;
		$response['message'] = 'Invalid API Call';
	}

	//displaying the response in json structure
	echo json_encode($response);
