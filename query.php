<?php
    require __DIR__ . '/MinecraftQuery.class.php';

    $Query = new MinecraftQuery( );

    try
    {
        $Query->Connect( 'insert.server.he.re', 27015, 1 );

        print_r( $Query->GetInfo( ) );
        print_r( $Query->GetPlayers( ) );
    }
    catch( MinecraftQueryException $e )
    {
        echo $e->getMessage( );
    }
?>
