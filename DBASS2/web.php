<?php
$serverName = "127.0.0.1,1434";
$uid = "Long";
$pwd = "123456789";
$databaseName = "ASS2";
$connectionInfo = array("UID" => $uid, "PWD" => $pwd, "Database" => $databaseName);
$conn = sqlsrv_connect($serverName, $connectionInfo);
if ($conn) {
    $query = "";
    if (isset($_POST['delete']) && isset($_POST['MSMH']))
    {
        $msmh = $_POST['MSMH'];
        $query = "DELETE FROM dbo.MatHang WHERE MSMH='$msmh'";
    }
    if (isset($_POST['MSMH']) &&
        isset($_POST['TenMH']) &&
        isset($_POST['Mota']) &&
        isset($_POST['DVT']) &&
        isset($_POST['MSLoai'])) {
        $MSMH = $_POST['MSMH'];
        $TenMH = $_POST['TenMH'];
        $Mota = $_POST['Mota'];
        $DVT = $_POST['DVT'];
        $MSLoai = $_POST['MSLoai'];
        $query = "INSERT INTO [dbo].[MatHang] ([MSMH]
           ,[TenMH]
           ,[Mota]
           ,[DVT]
           ,[MSLoai]) VALUES " .
            "('$MSMH', '$TenMH', '$Mota', '$DVT', '$MSLoai');";
    }
        print $query."<br />";
        $result = sqlsrv_query($conn, $query, array(), array("Scrollable" => 'static'));;
        if( $result === false)
        {
            if( ($errors = sqlsrv_errors() ) != null) {
                foreach( $errors as $error ) {
                    echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
                    echo "code: ".$error[ 'code']."<br />";
                    echo "message: ".$error[ 'message']."<br />";
                }
            }
        }

    echo <<<_END
  <form action="test.php" method="post"><pre>
    MSMH <input type="text" name="MSMH">
     TenMH <input type="text" name="TenMH">
  Mota <input type="text" name="Mota">
      DVT <input type="text" name="DVT">
      MSLoai <input type="text" name="MSLoai">
           <input type="submit" value="ADD RECORD">
  </pre></form>
_END;

    $stmt = "SELECT * FROM dbo.MatHang";
    $result = sqlsrv_query($conn, $stmt, array(), array("Scrollable" => 'static'));;
    $rows = sqlsrv_num_rows($result);

    for ($j = 0; $j < $rows; ++$j) {
        $row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC);
        $r0 = htmlspecialchars($row['MSMH']);
        $r1 = htmlspecialchars($row['TenMH']);
        $r2 = htmlspecialchars($row['Mota']);
        $r3 = htmlspecialchars($row['DVT']);
        $r4 = htmlspecialchars($row['MSLoai']);

        echo <<<_END
  <pre>
    MSMH $r0
     TenMH $r1
  Mota $r2
      DVT $r3
      MSLoai $r4
  </pre>
  <form action='test.php' method='post'>
  <input type='hidden' name='delete' value='yes'>
  <input type='hidden' name='MSMH' value='$r0'>
  <input type='submit' value='DELETE RECORD'></form>
_END;
    }




} else {
    echo "Connection could not be established.\n";
    die(print_r(sqlsrv_errors(), true));
}
sqlsrv_close($conn);
function get_post($conn, $var)
{
    return $conn->quote($_POST[$var]);
}

?>