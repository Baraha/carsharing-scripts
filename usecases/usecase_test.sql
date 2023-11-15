-- Active: 1699882456276@@127.0.0.1@5432@carsharing


CALL BookingCar(3);

CALL UnBookingCar(2);


SELECT * FROM GetCarHistoryInfo(2);


CALL AddNewRepairOrder(2,1,1,1,1,'http://test/link/photo2','Ремонт левой части бампера');