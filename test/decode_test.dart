import 'dart:typed_data';

import 'package:app_f1_telemetry/packet/header.dart';
import 'package:app_f1_telemetry/packet/packet_car_status_data.dart';
import 'package:app_f1_telemetry/packet/packet_car_telemetry_data.dart';
import 'package:app_f1_telemetry/packet/packet_lap_data.dart';
import 'package:app_f1_telemetry/packet/participant_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

//    var session = [1,1,1,1,2,1,1,1,2,2,1,1,1,1,1,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
//    var sessionLabels = ['weather', 'trackTemperature', 'airTemperature', 'totalLaps', 'trackLength', 'sessionType', 'trackId', 'formula', 'sessionTimeLeft', 'sessionDuration', 'pitSpeedLimit', 'gamePaused', 'isSpectating', 'spectatorCarIndex', 'sliProNativeSupport', 'numMarshalZones', 'zoneStart', 'zoneFlag', 'zoneStart', 'zoneFlag', 'zoneStart', 'zoneFlag', 'zoneStart', 'zoneFlag', 'zoneStart', 'zoneFlag', 'zoneStart', 'zoneFlag', 'zoneStart', 'zoneFlag', 'zoneStart', 'zoneFlag', 'zoneStart', 'zoneFlag', 'zoneStart', 'zoneFlag', 'zoneStart', 'zoneFlag', 'zoneStart', 'zoneFlag', 'zoneStart', 'zoneFlag', 'zoneStart', 'zoneFlag', 'zoneStart', 'zoneFlag', 'zoneStart', 'zoneFlag', 'zoneStart', 'zoneFlag', 'zoneStart', 'zoneFlag', 'zoneStart', 'zoneFlag', 'zoneStart', 'zoneFlag', 'zoneStart', 'zoneFlag', 'safetyCarStatus', 'networkGame', 'numWeatherForecastSamples', 'sessionType', 'timeOffset', 'weather', 'trackTemperature', 'airTemperature', 'sessionType', 'timeOffset', 'weather', 'trackTemperature', 'airTemperature', 'sessionType', 'timeOffset', 'weather', 'trackTemperature', 'airTemperature', 'sessionType', 'timeOffset', 'weather', 'trackTemperature', 'airTemperature', 'sessionType', 'timeOffset', 'weather', 'trackTemperature', 'airTemperature', 'sessionType', 'timeOffset', 'weather', 'trackTemperature', 'airTemperature', 'sessionType', 'timeOffset', 'weather', 'trackTemperature', 'airTemperature', 'sessionType', 'timeOffset', 'weather', 'trackTemperature', 'airTemperature', 'sessionType', 'timeOffset', 'weather', 'trackTemperature', 'airTemperature', 'sessionType', 'timeOffset', 'weather', 'trackTemperature', 'airTemperature', 'sessionType', 'timeOffset', 'weather', 'trackTemperature', 'airTemperature', 'sessionType', 'timeOffset', 'weather', 'trackTemperature', 'airTemperature', 'sessionType', 'timeOffset', 'weather', 'trackTemperature', 'airTemperature', 'sessionType', 'timeOffset', 'weather', 'trackTemperature', 'airTemperature', 'sessionType', 'timeOffset', 'weather', 'trackTemperature', 'airTemperature', 'sessionType', 'timeOffset', 'weather', 'trackTemperature', 'airTemperature', 'sessionType', 'timeOffset', 'weather', 'trackTemperature', 'airTemperature', 'sessionType', 'timeOffset', 'weather', 'trackTemperature', 'airTemperature', 'sessionType', 'timeOffset', 'weather', 'trackTemperature', 'airTemperature', 'sessionType', 'timeOffset', 'weather', 'trackTemperature', 'airTemperature'];
//
//    var carSetup = [1, 1, 1, 1, 4, 4, 4, 4, 1, 1, 1, 1, 1, 1, 1, 1, 4, 4, 4, 4, 1, 4];
//    var carSetupLabels = ['frontWing', 'rearWing', 'onThrottle', 'offThrottle', 'frontCamber', 'rearCamber', 'frontToe', 'rearToe', 'frontSuspension', 'rearSuspension', 'frontAntiRollBar', 'rearAntiRollBar', 'frontSuspensionHeight', 'rearSuspensionHeight', 'brakePressure', 'brakeBias', 'rearLeftTyrePressure', 'rearRightTyrePressure', 'frontLeftTyrePressure', 'frontRightTyrePressure', 'ballast', 'fuelLoad'];
//
//    var carStatus = [1, 1, 1, 1, 1, 4, 4, 4, 2, 2, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 4, 1, 4, 4, 4];
//    var carStatusLabels = ['tractionControl', 'antiLockBrakes', 'fuelMix', 'frontBrakeBias', 'pitLimiterStatus', 'fuelInTank', 'felCapacity', 'fuelRemainingLaps', 'maxRPM', 'idleRPM', 'maxGears', 'drsAllowed', 'drsActivationDistance', 'tyresWear1', 'tyresWear2', 'tyresWear3', 'tyresWear4', 'actualTyreCompound', 'visualTyreCompound', 'tyresAgeLaps', 'tyresDamage1', 'tyresDamage2', 'tyresDamage3', 'tyresDamage4', 'frontLeftWingDamage', 'frontRightWingDamage', 'rearWingDamage', 'drsFault', 'engineDamage', 'gearBoxDamage', 'vehicleFiaFlags', 'ersStoreEnergy', 'ersDeployMode', 'ersHarvestedThisLapMGUK', 'ersHarvestedThisLapMGUH', 'ersDeployedThisLap'];


  var motion = Uint8List.fromList([228, 7, 1, 7, 1, 0, 75, 6, 82, 139, 6, 45, 67, 248, 187, 111, 182, 66, 149, 9, 0, 0, 19, 255, 254, 104, 32, 67, 241, 157, 151, 64, 77, 50, 56, 64, 52, 219, 132, 194, 93, 245, 148, 62, 247, 9, 24, 65, 84, 129, 216, 0, 87, 18, 176, 237, 62, 3, 93, 129, 245, 11, 236, 62, 87, 222, 22, 63, 63, 146, 154, 60, 191, 174, 182, 191, 128, 184, 38, 60, 173, 155, 207, 188, 78, 36, 236, 65, 239, 48, 198, 64, 253, 70, 244, 65, 67, 42, 142, 194, 75, 201, 182, 63, 153, 26, 175, 65, 216, 133, 197, 2, 28, 38, 242, 217, 165, 2, 211, 133, 185, 71, 91, 63, 144, 40, 162, 62, 118, 163, 227, 189, 161, 103, 162, 191, 192, 206, 219, 60, 214, 100, 169, 188, 177, 72, 17, 67, 38, 120, 154, 64, 122, 245, 150, 64, 231, 208, 132, 194, 62, 84, 137, 62, 181, 201, 40, 65, 161, 129, 213, 0, 76, 20, 186, 235, 17, 3, 169, 129, 9, 228, 253, 62, 157, 154, 11, 63, 91, 127, 54, 60, 37, 179, 180, 191, 0, 220, 39, 60, 218, 109, 196, 188, 104, 197, 115, 195, 136, 216, 25, 64, 5, 8, 185, 66, 134, 178, 135, 193, 194, 213, 120, 62, 208, 206, 169, 65, 46, 175, 56, 1, 62, 99, 220, 156, 3, 5, 52, 175, 45, 104, 228, 63, 127, 67, 131, 63, 16, 230, 226, 61, 188, 22, 47, 191, 96, 39, 21, 61, 23, 133, 32, 189, 161, 18, 53, 67, 163, 3, 149, 64, 187, 69, 140, 62, 30, 69, 130, 194, 134, 81, 96, 62, 146, 53, 253, 64, 248, 128, 181, 0, 164, 15, 97, 240, 235, 2, 255, 128, 168, 193, 223, 62, 200, 93, 36, 63, 224, 211, 49, 61, 192, 101, 185, 191, 0, 148, 7, 60, 206, 252, 186, 188, 128, 6, 113, 195, 12, 125, 34, 64, 195, 95, 64, 67, 179, 42, 103, 65, 159, 83, 60, 190, 118, 127, 78, 66, 113, 34, 194, 255, 70, 123, 198, 132, 107, 3, 112, 34, 219, 57, 18, 62, 237, 36, 154, 63, 220, 76, 227, 189, 221, 140, 139, 62, 128, 41, 215, 60, 184, 5, 219, 188, 35, 71, 10, 195, 238, 106, 112, 64, 166, 135, 209, 66, 58, 233, 13, 194, 176, 209, 79, 191, 81, 154, 57, 65, 59, 134, 230, 252, 79, 39, 186, 216, 6, 254, 50, 134, 35, 101, 215, 191, 39, 189, 252, 191, 66, 157, 219, 188, 145, 32, 161, 191, 192, 218, 227, 188, 149, 5, 125, 60, 210, 208, 217, 66, 26, 254, 158, 64, 190, 26, 58, 65, 184, 79, 136, 194, 9, 133, 28, 63, 62, 216, 87, 65, 127, 130, 103, 1, 21, 25, 244, 230, 238, 2, 132, 130, 143, 228, 1, 63, 52, 211, 249, 62, 103, 4, 16, 62, 164, 216, 175, 191, 128, 225, 121, 60, 120, 194, 187, 188, 198, 90, 147, 67, 248, 59, 146, 64, 55, 45, 164, 192, 221, 25, 54, 194, 62, 17, 9, 62, 78, 20, 136, 192, 147, 128, 184, 0, 253, 243, 7, 12, 158, 3, 160, 128, 177, 183, 149, 63, 73, 86, 149, 63, 184, 93, 214, 190, 254, 27, 213, 191, 0, 86, 65, 59, 156, 181, 231, 188, 213, 209, 145, 193, 18, 208, 206, 64, 195, 96, 67, 66, 6, 183, 144, 194, 129, 239, 218, 190, 154, 183, 215, 65, 97, 136, 157, 255, 135, 45, 122, 210, 188, 2, 104, 136, 45, 166, 141, 63, 246, 210, 152, 62, 196, 152, 175, 190, 205, 131, 154, 191, 0, 229, 155, 59, 158, 47, 175, 188, 25, 134, 224, 193, 51, 164, 204, 64, 21, 60, 82, 66, 173, 80, 143, 194, 137, 8, 82, 191, 231, 160, 230, 65, 122, 137, 3, 255, 78, 48, 175, 207, 72, 2, 127, 137, 133, 235, 132, 63, 254, 161, 185, 62, 253, 56, 73, 190, 206, 131, 151, 191, 0, 160, 220, 185, 10, 55, 146, 188, 221, 12, 74, 195, 45, 24, 54, 64, 90, 53, 167, 66, 39, 208, 197, 193, 252, 81, 121, 191, 245, 187, 65, 193, 35, 142, 80, 251, 187, 197, 74, 58, 139, 0, 13, 142, 196, 116, 225, 63, 177, 152, 4, 190, 32, 168, 211, 188, 28, 208, 2, 192, 64, 151, 13, 189, 235, 104, 139, 187, 30, 252, 82, 195, 217, 242, 34, 64, 216, 248, 160, 66, 165, 223, 209, 193, 133, 146, 46, 191, 52, 151, 176, 192, 81, 131, 152, 252, 73, 227, 182, 28, 130, 0, 69, 131, 60, 38, 6, 64, 52, 65, 191, 190, 75, 193, 203, 61, 138, 8, 230, 191, 128, 227, 219, 188, 126, 162, 130, 187, 178, 223, 253, 194, 79, 58, 128, 64, 169, 202, 200, 66, 122, 224, 20, 194, 98, 203, 78, 191, 62, 16, 133, 65, 78, 139, 32, 253, 127, 52, 140, 203, 172, 253, 70, 139, 83, 229, 177, 191, 254, 148, 63, 192, 93, 73, 169, 188, 93, 253, 146, 191, 64, 2, 229, 188, 183, 10, 149, 60, 220, 167, 92, 195, 52, 98, 24, 64, 200, 224, 159, 66, 91, 41, 205, 193, 167, 72, 136, 190, 185, 209, 18, 64, 82, 128, 145, 254, 218, 8, 35, 247, 251, 0, 81, 128, 164, 159, 2, 64, 138, 184, 150, 190, 33, 5, 101, 61, 181, 48, 192, 191, 0, 215, 46, 188, 62, 143, 251, 187, 80, 118, 117, 67, 73, 176, 144, 64, 179, 163, 183, 192, 19, 224, 100, 194, 61, 200, 129, 188, 49, 23, 30, 64, 33, 128, 49, 0, 166, 5, 91, 250, 36, 3, 43, 128, 132, 137, 137, 62, 128, 54, 94, 63, 108, 231, 37, 189, 51, 106, 195, 191, 0, 252, 40, 59, 131, 59, 201, 188, 244, 32, 124, 195, 201, 134, 46, 64, 113, 8, 226, 66, 168, 209, 170, 192, 194, 166, 201, 62, 199, 141, 2, 66, 201, 236, 136, 1, 137, 126, 183, 129, 240, 7, 186, 236, 232, 250, 192, 63, 96, 169, 150, 63, 231, 69, 143, 189, 72, 165, 26, 190, 176, 88, 129, 61, 105, 47, 126, 189, 245, 240, 130, 66, 22, 213, 175, 64, 138, 17, 165, 65, 15, 99, 142, 194, 158, 168, 142, 63, 31, 252, 140, 65, 218, 131, 64, 2, 14, 31, 255, 224, 194, 2, 217, 131, 42, 237, 33, 63, 113, 213, 194, 62, 166, 115, 7, 61, 20, 188, 169, 191, 64, 162, 182, 60, 77, 194, 176, 188, 115, 209, 105, 67, 28, 135, 144, 64, 74, 213, 136, 192, 183, 126, 104, 194, 153, 211, 250, 60, 54, 56, 122, 64, 77, 128, 86, 0, 173, 8, 86, 247, 24, 3, 86, 128, 67, 65, 161, 62, 107, 11, 80, 63, 149, 96, 172, 61, 136, 99, 192, 191, 0, 17, 140, 59, 199, 18, 198, 188, 2, 140, 141, 67, 79, 98, 143, 64, 62, 122, 58, 192, 175, 178, 66, 194, 113, 204, 133, 188, 230, 176, 124, 192, 102, 128, 4, 0, 254, 245, 1, 10, 200, 3, 116, 128, 84, 233, 166, 62, 60, 252, 144, 63, 224, 107, 12, 58, 196, 19, 211, 191, 0, 168, 14, 187, 32, 45, 242, 188, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23, 45, 96, 65, 42, 113, 123, 65, 5, 42, 93, 64, 80, 103, 145, 64, 202, 27, 243, 65, 45, 149, 127, 193, 111, 146, 165, 65, 36, 108, 92, 193, 42, 13, 75, 195, 197, 207, 4, 195, 150, 24, 137, 195, 242, 43, 34, 67, 99, 24, 69, 66, 125, 145, 69, 66, 136, 247, 66, 66, 134, 127, 67, 66, 50, 200, 39, 60, 100, 70, 40, 60, 181, 124, 28, 186, 253, 75, 243, 185, 194, 127, 4, 190, 145, 73, 219, 188, 55, 86, 67, 66, 172, 102, 30, 189, 249, 113, 157, 61, 18, 171, 21, 187, 158, 94, 238, 192, 49, 198, 89, 192, 88, 88, 76, 191, 0, 0, 0, 128]);
  var session = Uint8List.fromList([228, 7, 1, 7, 1, 1, 135, 94, 39, 50, 254, 149, 197, 207, 46, 146, 164, 66, 181, 3, 0, 0, 19, 255, 0, 30, 22, 5, 227, 16, 10, 17, 0, 212, 27, 32, 28, 80, 0, 0, 255, 0, 13, 79, 167, 125, 63, 0, 146, 45, 162, 61, 0, 133, 15, 6, 62, 0, 59, 246, 89, 62, 0, 197, 63, 151, 62, 0, 93, 8, 175, 62, 0, 94, 91, 221, 62, 0, 227, 40, 10, 63, 0, 95, 153, 23, 63, 0, 75, 244, 43, 63, 0, 211, 97, 63, 63, 0, 6, 254, 76, 63, 0, 42, 94, 88, 63, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 10, 0, 0, 31, 22, 10, 5, 0, 31, 22, 10, 10, 0, 31, 22, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
  var lapData = Uint8List.fromList([228, 7, 1, 7, 1, 2, 104, 85, 233, 142, 161, 92, 243, 142, 157, 230, 155, 67, 246, 32, 0, 0, 19, 255, 22, 17, 171, 66, 189, 72, 51, 66, 197, 110, 0, 0, 140, 99, 170, 66, 2, 7, 110, 169, 89, 25, 133, 7, 110, 2, 66, 89, 1, 192, 132, 1, 96, 3, 42, 69, 28, 128, 145, 70, 0, 0, 0, 128, 1, 4, 0, 1, 0, 0, 2, 4, 2, 130, 48, 172, 66, 73, 23, 33, 66, 252, 111, 0, 0, 103, 193, 171, 66, 2, 163, 110, 230, 90, 235, 133, 163, 110, 2, 134, 90, 3, 235, 133, 2, 168, 2, 28, 69, 5, 192, 143, 70, 0, 0, 0, 128, 5, 4, 0, 1, 0, 0, 4, 4, 2, 190, 158, 171, 66, 248, 164, 39, 66, 148, 115, 0, 0, 63, 236, 170, 66, 2, 52, 110, 116, 89, 44, 134, 52, 110, 2, 116, 89, 2, 168, 133, 3, 16, 42, 30, 69, 242, 4, 144, 70, 0, 0, 0, 128, 4, 4, 0, 1, 0, 0, 5, 4, 2, 252, 205, 176, 66, 144, 130, 4, 66, 158, 119, 0, 0, 184, 151, 175, 66, 2, 25, 113, 88, 91, 130, 138, 25, 113, 2, 88, 91, 2, 130, 138, 2, 32, 30, 237, 68, 146, 17, 139, 70, 0, 0, 0, 128, 12, 4, 0, 1, 0, 0, 13, 4, 2, 124, 186, 171, 66, 177, 195, 41, 66, 222, 116, 0, 0, 18, 240, 170, 66, 2, 60, 110, 187, 89, 228, 133, 60, 110, 2, 50, 89, 1, 82, 133, 1, 216, 12, 31, 69, 75, 33, 144, 70, 0, 0, 0, 128, 3, 4, 0, 1, 0, 0, 3, 4, 2, 156, 134, 171, 66, 131, 110, 46, 66, 58, 112, 0, 0, 15, 109, 170, 66, 2, 26, 110, 149, 89, 45, 133, 26, 110, 2, 116, 89, 1, 45, 133, 2, 48, 101, 36, 69, 86, 204, 144, 70, 0, 0, 0, 128, 2, 4, 0, 1, 0, 0, 1, 4, 2, 148, 213, 176, 66, 175, 14, 1, 66, 197, 116, 0, 0, 87, 142, 175, 66, 2, 120, 113, 74, 91, 31, 138, 120, 113, 2, 74, 91, 2, 31, 138, 2, 32, 7, 236, 68, 34, 0, 139, 70, 0, 0, 0, 128, 13, 4, 0, 1, 0, 0, 14, 4, 2, 174, 207, 174, 66, 130, 72, 15, 66, 57, 114, 0, 0, 89, 72, 174, 66, 2, 122, 112, 58, 91, 176, 136, 122, 112, 2, 249, 90, 3, 176, 136, 2, 112, 137, 3, 69, 222, 176, 140, 70, 0, 0, 0, 128, 9, 4, 0, 1, 0, 0, 10, 4, 2, 64, 183, 176, 66, 181, 18, 3, 66, 133, 116, 0, 0, 122, 167, 175, 66, 2, 139, 113, 129, 91, 6, 138, 139, 113, 2, 129, 91, 2, 6, 138, 2, 128, 195, 239, 68, 232, 59, 139, 70, 0, 0, 0, 128, 11, 4, 0, 1, 0, 0, 12, 4, 2, 180, 71, 176, 66, 144, 32, 239, 65, 55, 114, 0, 0, 180, 71, 176, 66, 3, 67, 114, 231, 91, 32, 138, 30, 114, 2, 132, 91, 2, 32, 138, 3, 144, 175, 224, 68, 169, 74, 138, 70, 0, 0, 0, 128, 18, 4, 0, 1, 0, 0, 16, 4, 2, 232, 146, 176, 66, 82, 25, 251, 65, 182, 114, 0, 0, 73, 225, 175, 66, 2, 217, 113, 13, 91, 156, 138, 217, 113, 2, 231, 90, 3, 156, 138, 2, 192, 178, 233, 68, 220, 218, 138, 70, 0, 0, 0, 128, 15, 4, 0, 1, 0, 0, 19, 4, 2, 188, 229, 176, 66, 123, 163, 5, 66, 179, 115, 0, 0, 194, 99, 175, 66, 2, 39, 113, 130, 91, 229, 137, 39, 113, 2, 130, 91, 2, 229, 137, 2, 96, 199, 243, 68, 38, 124, 139, 70, 0, 0, 0, 128, 10, 4, 0, 1, 0, 0, 11, 4, 2, 242, 118, 176, 66, 217, 229, 233, 65, 0, 0, 0, 0, 242, 118, 176, 66, 3, 178, 114, 157, 91, 88, 138, 168, 114, 2, 157, 91, 3, 88, 138, 3, 224, 197, 217, 68, 14, 220, 137, 70, 0, 0, 0, 128, 19, 4, 0, 0, 0, 0, 18, 4, 2, 44, 175, 174, 66, 31, 130, 18, 66, 118, 113, 0, 0, 164, 82, 174, 66, 2, 73, 112, 17, 91, 30, 137, 73, 112, 2, 17, 91, 2, 163, 136, 3, 16, 12, 7, 69, 50, 33, 141, 70, 0, 0, 0, 128, 6, 4, 0, 1, 0, 0, 7, 4, 2, 166, 60, 176, 66, 221, 72, 244, 65, 182, 114, 0, 0, 217, 57, 176, 66, 2, 26, 114, 52, 92, 226, 137, 26, 114, 2, 232, 90, 3, 226, 137, 2, 112, 183, 228, 68, 39, 139, 138, 70, 0, 0, 0, 128, 17, 4, 0, 1, 0, 0, 20, 4, 2, 220, 195, 176, 66, 205, 110, 253, 65, 35, 115, 0, 0, 167, 235, 175, 66, 2, 168, 113, 1, 92, 238, 137, 168, 113, 2, 184, 91, 3, 238, 137, 2, 64, 237, 234, 68, 132, 238, 138, 70, 0, 0, 0, 128, 14, 4, 0, 1, 0, 0, 17, 4, 2, 198, 135, 171, 66, 64, 61, 38, 66, 137, 135, 0, 0, 82, 1, 171, 66, 2, 141, 110, 159, 89, 209, 133, 141, 110, 2, 99, 89, 3, 209, 133, 2, 48, 233, 4, 69, 214, 220, 140, 70, 0, 0, 0, 128, 8, 4, 0, 1, 0, 0, 6, 4, 2, 192, 147, 174, 66, 44, 255, 16, 66, 174, 113, 0, 0, 39, 100, 174, 66, 2, 73, 112, 204, 91, 134, 136, 73, 112, 2, 178, 90, 3, 134, 136, 2, 144, 39, 6, 69, 162, 4, 141, 70, 0, 0, 0, 128, 7, 4, 0, 1, 0, 0, 9, 4, 2, 172, 82, 176, 66, 57, 243, 246, 65, 215, 114, 0, 0, 43, 28, 176, 66, 2, 8, 114, 135, 91, 103, 138, 8, 114, 2, 135, 91, 2, 103, 138, 2, 64, 201, 230, 68, 68, 172, 138, 70, 0, 0, 0, 128, 16, 4, 0, 1, 0, 0, 15, 4, 2, 188, 6, 255, 66, 72, 11, 51, 66, 249, 141, 0, 0, 188, 6, 255, 66, 2, 38, 242, 216, 99, 25, 156, 249, 141, 3, 42, 98, 1, 25, 156, 2, 240, 67, 7, 69, 60, 123, 71, 70, 0, 0, 0, 128, 20, 3, 0, 1, 0, 0, 8, 4, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
  var event = Uint8List.fromList([228, 7, 1, 7, 1, 3, 75, 6, 82, 139, 6, 45, 67, 248, 253, 141, 210, 66, 236, 11, 0, 0, 19, 255, 70, 84, 76, 80, 5, 185, 94, 146, 66, 0, 0]);
  var participants = Uint8List.fromList([228, 7, 1, 7, 1, 4, 135, 94, 39, 50, 254, 149, 197, 207, 46, 146, 164, 66, 181, 3, 0, 0, 19, 255, 20, 1, 58, 1, 16, 53, 76, 69, 67, 76, 69, 82, 67, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 6, 9, 7, 27, 82, 195, 132, 73, 75, 75, 195, 150, 78, 69, 78, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 12, 7, 8, 28, 71, 82, 79, 83, 74, 69, 65, 78, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 62, 2, 23, 81, 65, 76, 66, 79, 78, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 9, 2, 33, 22, 86, 69, 82, 83, 84, 65, 80, 80, 69, 78, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 13, 1, 5, 29, 86, 69, 84, 84, 69, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 17, 5, 31, 28, 79, 67, 79, 78, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 74, 9, 99, 41, 71, 73, 79, 86, 73, 78, 65, 90, 90, 73, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 19, 4, 18, 13, 83, 84, 82, 79, 76, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 50, 3, 63, 10, 82, 85, 83, 83, 69, 76, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 6, 26, 68, 75, 86, 89, 65, 84, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 15, 0, 77, 27, 66, 79, 84, 84, 65, 83, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 63, 3, 6, 13, 76, 65, 84, 73, 70, 73, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 8, 55, 78, 83, 65, 73, 78, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 14, 4, 11, 52, 80, 69, 82, 69, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 54, 8, 4, 10, 78, 79, 82, 82, 73, 83, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 7, 0, 44, 10, 72, 65, 77, 73, 76, 84, 79, 78, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 59, 6, 10, 28, 71, 65, 83, 76, 89, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 11, 7, 20, 21, 77, 65, 71, 78, 85, 83, 83, 69, 78, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 2, 5, 3, 3, 82, 73, 67, 67, 73, 65, 82, 68, 79, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
  var carSetups = Uint8List.fromList([228, 7, 1, 7, 1, 5, 135, 94, 39, 50, 254, 149, 197, 207, 46, 146, 164, 66, 181, 3, 0, 0, 19, 255, 5, 6, 70, 65, 0, 0, 64, 192, 0, 0, 192, 191, 206, 204, 204, 61, 52, 51, 179, 62, 5, 3, 6, 5, 5, 7, 100, 58, 0, 0, 172, 65, 0, 0, 172, 65, 0, 0, 184, 65, 0, 0, 184, 65, 6, 0, 0, 16, 65, 5, 6, 70, 65, 0, 0, 64, 192, 0, 0, 192, 191, 206, 204, 204, 61, 52, 51, 179, 62, 5, 3, 6, 5, 5, 7, 100, 58, 0, 0, 172, 65, 0, 0, 172, 65, 0, 0, 184, 65, 0, 0, 184, 65, 6, 0, 0, 16, 65, 5, 6, 70, 65, 0, 0, 64, 192, 0, 0, 192, 191, 206, 204, 204, 61, 52, 51, 179, 62, 5, 3, 6, 5, 5, 7, 100, 58, 0, 0, 172, 65, 0, 0, 172, 65, 0, 0, 184, 65, 0, 0, 184, 65, 6, 0, 0, 16, 65, 5, 6, 70, 65, 0, 0, 64, 192, 0, 0, 192, 191, 206, 204, 204, 61, 52, 51, 179, 62, 5, 3, 6, 5, 5, 7, 100, 58, 0, 0, 172, 65, 0, 0, 172, 65, 0, 0, 184, 65, 0, 0, 184, 65, 6, 0, 0, 16, 65, 5, 6, 70, 65, 0, 0, 64, 192, 0, 0, 192, 191, 206, 204, 204, 61, 52, 51, 179, 62, 5, 3, 6, 5, 5, 7, 100, 58, 0, 0, 172, 65, 0, 0, 172, 65, 0, 0, 184, 65, 0, 0, 184, 65, 6, 0, 0, 16, 65, 5, 6, 70, 65, 0, 0, 64, 192, 0, 0, 192, 191, 206, 204, 204, 61, 52, 51, 179, 62, 5, 3, 6, 5, 5, 7, 100, 58, 0, 0, 172, 65, 0, 0, 172, 65, 0, 0, 184, 65, 0, 0, 184, 65, 6, 0, 0, 16, 65, 5, 6, 70, 65, 0, 0, 64, 192, 0, 0, 192, 191, 206, 204, 204, 61, 52, 51, 179, 62, 5, 3, 6, 5, 5, 7, 100, 58, 0, 0, 172, 65, 0, 0, 172, 65, 0, 0, 184, 65, 0, 0, 184, 65, 6, 0, 0, 16, 65, 5, 6, 70, 65, 0, 0, 64, 192, 0, 0, 192, 191, 206, 204, 204, 61, 52, 51, 179, 62, 5, 3, 6, 5, 5, 7, 100, 58, 0, 0, 172, 65, 0, 0, 172, 65, 0, 0, 184, 65, 0, 0, 184, 65, 6, 0, 0, 16, 65, 5, 6, 70, 65, 0, 0, 64, 192, 0, 0, 192, 191, 206, 204, 204, 61, 52, 51, 179, 62, 5, 3, 6, 5, 5, 7, 100, 58, 0, 0, 172, 65, 0, 0, 172, 65, 0, 0, 184, 65, 0, 0, 184, 65, 6, 0, 0, 16, 65, 5, 6, 70, 65, 0, 0, 64, 192, 0, 0, 192, 191, 206, 204, 204, 61, 52, 51, 179, 62, 5, 3, 6, 5, 5, 7, 100, 58, 0, 0, 172, 65, 0, 0, 172, 65, 0, 0, 184, 65, 0, 0, 184, 65, 6, 0, 0, 16, 65, 5, 6, 70, 65, 0, 0, 64, 192, 0, 0, 192, 191, 206, 204, 204, 61, 52, 51, 179, 62, 5, 3, 6, 5, 5, 7, 100, 58, 0, 0, 172, 65, 0, 0, 172, 65, 0, 0, 184, 65, 0, 0, 184, 65, 6, 0, 0, 16, 65, 5, 6, 70, 65, 0, 0, 64, 192, 0, 0, 192, 191, 206, 204, 204, 61, 52, 51, 179, 62, 5, 3, 6, 5, 5, 7, 100, 58, 0, 0, 172, 65, 0, 0, 172, 65, 0, 0, 184, 65, 0, 0, 184, 65, 6, 0, 0, 16, 65, 5, 6, 70, 65, 0, 0, 64, 192, 0, 0, 192, 191, 206, 204, 204, 61, 52, 51, 179, 62, 5, 3, 6, 5, 5, 7, 100, 58, 0, 0, 172, 65, 0, 0, 172, 65, 0, 0, 184, 65, 0, 0, 184, 65, 6, 0, 0, 16, 65, 5, 6, 70, 65, 0, 0, 64, 192, 0, 0, 192, 191, 206, 204, 204, 61, 52, 51, 179, 62, 5, 3, 6, 5, 5, 7, 100, 58, 0, 0, 172, 65, 0, 0, 172, 65, 0, 0, 184, 65, 0, 0, 184, 65, 6, 0, 0, 16, 65, 5, 6, 70, 65, 0, 0, 64, 192, 0, 0, 192, 191, 206, 204, 204, 61, 52, 51, 179, 62, 5, 3, 6, 5, 5, 7, 100, 58, 0, 0, 172, 65, 0, 0, 172, 65, 0, 0, 184, 65, 0, 0, 184, 65, 6, 0, 0, 16, 65, 5, 6, 70, 65, 0, 0, 64, 192, 0, 0, 192, 191, 206, 204, 204, 61, 52, 51, 179, 62, 5, 3, 6, 5, 5, 7, 100, 58, 0, 0, 172, 65, 0, 0, 172, 65, 0, 0, 184, 65, 0, 0, 184, 65, 6, 0, 0, 16, 65, 5, 6, 70, 65, 0, 0, 64, 192, 0, 0, 192, 191, 206, 204, 204, 61, 52, 51, 179, 62, 5, 3, 6, 5, 5, 7, 100, 58, 0, 0, 172, 65, 0, 0, 172, 65, 0, 0, 184, 65, 0, 0, 184, 65, 6, 0, 0, 16, 65, 5, 6, 70, 65, 0, 0, 64, 192, 0, 0, 192, 191, 206, 204, 204, 61, 52, 51, 179, 62, 5, 3, 6, 5, 5, 7, 100, 58, 0, 0, 172, 65, 0, 0, 172, 65, 0, 0, 184, 65, 0, 0, 184, 65, 6, 0, 0, 16, 65, 5, 6, 70, 65, 0, 0, 64, 192, 0, 0, 192, 191, 206, 204, 204, 61, 52, 51, 179, 62, 5, 3, 6, 5, 5, 7, 100, 58, 0, 0, 172, 65, 0, 0, 172, 65, 0, 0, 184, 65, 0, 0, 184, 65, 6, 0, 0, 16, 65, 5, 6, 70, 65, 0, 0, 64, 192, 0, 0, 192, 191, 206, 204, 204, 61, 52, 51, 179, 62, 5, 3, 6, 5, 5, 7, 100, 58, 0, 0, 172, 65, 0, 0, 172, 65, 0, 0, 184, 65, 0, 0, 184, 65, 6, 0, 0, 16, 65, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
  var carTelemetry = Uint8List.fromList([228, 7, 1, 7, 1, 6, 75, 6, 82, 139, 6, 45, 67, 248, 221, 42, 181, 66, 121, 9, 0, 0, 19, 255, 226, 0, 0, 0, 128, 63, 231, 81, 131, 188, 0, 0, 0, 0, 0, 6, 160, 40, 0, 0, 215, 2, 216, 2, 136, 2, 139, 2, 92, 97, 88, 96, 92, 92, 92, 92, 89, 0, 205, 204, 168, 65, 205, 204, 168, 65, 0, 0, 184, 65, 0, 0, 184, 65, 0, 0, 0, 0, 3, 1, 0, 0, 128, 63, 109, 221, 132, 188, 0, 0, 0, 0, 0, 7, 200, 40, 0, 0, 117, 2, 118, 2, 11, 2, 14, 2, 89, 94, 85, 92, 92, 92, 92, 92, 89, 0, 205, 204, 168, 65, 205, 204, 168, 65, 0, 0, 184, 65, 0, 0, 184, 65, 0, 0, 0, 0, 228, 0, 0, 0, 128, 63, 233, 229, 111, 188, 0, 0, 0, 0, 0, 6, 231, 40, 0, 0, 198, 2, 199, 2, 116, 2, 120, 2, 91, 96, 87, 96, 92, 92, 92, 92, 89, 0, 205, 204, 168, 65, 205, 204, 168, 65, 0, 0, 184, 65, 0, 0, 184, 65, 0, 0, 0, 0, 92, 0, 0, 0, 0, 0, 3, 154, 1, 191, 0, 0, 0, 0, 0, 2, 120, 33, 0, 0, 142, 3, 141, 3, 124, 3, 121, 3, 85, 87, 90, 95, 92, 92, 92, 92, 89, 0, 205, 204, 168, 65, 205, 204, 168, 65, 0, 0, 184, 65, 0, 0, 184, 65, 0, 0, 0, 0, 220, 0, 0, 0, 128, 63, 63, 192, 126, 188, 0, 0, 0, 0, 0, 5, 113, 45, 0, 70, 227, 2, 229, 2, 153, 2, 156, 2, 94, 100, 89, 99, 92, 92, 92, 92, 89, 0, 205, 204, 168, 65, 205, 204, 168, 65, 0, 0, 184, 65, 0, 0, 184, 65, 0, 0, 0, 0, 169, 0, 0, 0, 128, 63, 114, 243, 95, 189, 0, 0, 0, 0, 0, 4, 44, 41, 0, 0, 60, 3, 59, 3, 9, 3, 7, 3, 90, 94, 88, 100, 92, 92, 92, 92, 89, 0, 205, 204, 168, 65, 205, 204, 168, 65, 0, 0, 184, 65, 0, 0, 184, 65, 0, 1, 0, 1, 188, 0, 0, 0, 0, 0, 231, 211, 181, 60, 35, 127, 22, 63, 0, 4, 56, 45, 0, 84, 170, 3, 171, 3, 200, 3, 200, 3, 84, 88, 84, 88, 92, 92, 92, 92, 89, 0, 205, 204, 168, 65, 205, 204, 168, 65, 0, 0, 184, 65, 0, 0, 184, 65, 0, 0, 0, 0, 237, 0, 0, 0, 128, 63, 158, 111, 119, 188, 0, 0, 0, 0, 0, 6, 149, 42, 0, 0, 168, 2, 169, 2, 78, 2, 81, 2, 87, 91, 84, 89, 92, 92, 92, 92, 89, 0, 205, 204, 168, 65, 205, 204, 168, 65, 0, 0, 184, 65, 0, 0, 184, 65, 0, 0, 0, 0, 141, 0, 233, 62, 68, 63, 215, 52, 66, 190, 0, 0, 0, 0, 0, 3, 136, 42, 0, 0, 53, 3, 55, 3, 13, 3, 16, 3, 91, 95, 96, 102, 92, 92, 92, 92, 89, 0, 205, 204, 168, 65, 205, 204, 168, 65, 0, 0, 184, 65, 0, 0, 184, 65, 0, 0, 0, 0, 14, 1, 0, 0, 128, 63, 0, 91, 59, 188, 0, 0, 0, 0, 0, 7, 128, 42, 0, 0, 92, 2, 93, 2, 231, 1, 233, 1, 88, 93, 84, 90, 92, 92, 92, 92, 89, 0, 205, 204, 168, 65, 205, 204, 168, 65, 0, 0, 184, 65, 0, 0, 184, 65, 0, 0, 0, 0, 14, 1, 0, 0, 128, 63, 230, 225, 162, 188, 0, 0, 0, 0, 0, 7, 112, 42, 0, 0, 83, 2, 84, 2, 221, 1, 225, 1, 87, 91, 85, 90, 92, 92, 92, 92, 89, 0, 205, 204, 168, 65, 205, 204, 168, 65, 0, 0, 184, 65, 0, 0, 184, 65, 0, 0, 0, 0, 104, 0, 0, 0, 0, 0, 202, 201, 62, 190, 0, 0, 0, 0, 0, 2, 238, 37, 0, 0, 187, 3, 186, 3, 185, 3, 183, 3, 87, 87, 93, 90, 92, 92, 92, 92, 89, 0, 205, 204, 168, 65, 205, 204, 168, 65, 0, 0, 184, 65, 0, 0, 184, 65, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 70, 158, 57, 190, 0, 0, 0, 0, 0, 2, 128, 36, 0, 0, 181, 3, 180, 3, 177, 3, 175, 3, 87, 86, 93, 90, 92, 92, 92, 92, 89, 0, 205, 204, 168, 65, 205, 204, 168, 65, 0, 0, 184, 65, 0, 0, 184, 65, 0, 0, 0, 0, 204, 0, 0, 0, 0, 0, 217, 159, 161, 58, 0, 0, 128, 63, 0, 5, 131, 41, 0, 0, 148, 3, 149, 3, 175, 3, 176, 3, 86, 91, 85, 90, 92, 92, 92, 92, 89, 0, 205, 204, 168, 65, 205, 204, 168, 65, 0, 0, 184, 65, 0, 0, 184, 65, 1, 0, 1, 0, 98, 0, 114, 223, 35, 62, 15, 195, 222, 190, 0, 0, 0, 0, 0, 2, 23, 36, 0, 0, 170, 3, 168, 3, 165, 3, 162, 3, 87, 87, 93, 91, 92, 92, 92, 92, 89, 0, 205, 204, 168, 65, 205, 204, 168, 65, 0, 0, 184, 65, 0, 0, 184, 65, 0, 0, 0, 0, 185, 0, 232, 100, 0, 63, 168, 207, 149, 189, 0, 0, 0, 0, 0, 5, 77, 45, 0, 77, 21, 3, 22, 3, 220, 2, 223, 2, 95, 100, 92, 101, 92, 92, 92, 92, 89, 0, 205, 204, 168, 65, 205, 204, 168, 65, 0, 0, 184, 65, 0, 0, 184, 65, 0, 1, 0, 1, 101, 0, 30, 236, 28, 63, 108, 247, 21, 191, 0, 0, 0, 0, 0, 2, 127, 39, 0, 0, 118, 3, 117, 3, 94, 3, 91, 3, 87, 89, 91, 99, 92, 92, 92, 92, 89, 0, 205, 204, 168, 65, 205, 204, 168, 65, 0, 0, 184, 65, 0, 0, 184, 65, 0, 0, 0, 0, 254, 0, 0, 0, 128, 63, 250, 242, 116, 188, 0, 0, 0, 0, 0, 6, 155, 45, 0, 75, 142, 2, 143, 2, 42, 2, 46, 2, 89, 94, 85, 92, 92, 92, 92, 92, 89, 0, 205, 204, 168, 65, 205, 204, 168, 65, 0, 0, 184, 65, 0, 0, 184, 65, 0, 0, 0, 0, 189, 0, 0, 0, 128, 63, 32, 99, 119, 189, 0, 0, 0, 0, 0, 4, 185, 45, 0, 76, 6, 3, 7, 3, 204, 2, 209, 2, 92, 97, 91, 100, 92, 92, 92, 92, 89, 0, 205, 204, 168, 65, 205, 204, 168, 65, 0, 0, 184, 65, 0, 0, 184, 65, 0, 0, 0, 0, 147, 0, 0, 0, 128, 63, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 126, 43, 0, 11, 157, 3, 158, 3, 112, 3, 117, 3, 103, 111, 104, 118, 92, 92, 92, 92, 112, 0, 0, 0, 172, 65, 0, 0, 172, 65, 0, 0, 184, 65, 0, 0, 184, 65, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 16, 0, 0, 255, 255, 0]);
  var carStatus = Uint8List.fromList([228, 7, 1, 7, 1, 7, 4, 199, 133, 169, 94, 1, 25, 107, 53, 230, 33, 65, 118, 0, 0, 0, 19, 255, 0, 1, 2, 58, 0, 138, 32, 215, 66, 0, 0, 220, 66, 128, 67, 70, 64, 200, 50, 204, 16, 9, 0, 0, 0, 0, 0, 0, 0, 18, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 36, 116, 74, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 58, 0, 101, 111, 219, 66, 0, 0, 220, 66, 80, 151, 147, 64, 200, 50, 204, 16, 9, 0, 0, 0, 0, 0, 0, 0, 18, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 36, 116, 74, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 58, 0, 109, 255, 213, 66, 0, 0, 220, 66, 0, 192, 45, 64, 200, 50, 215, 14, 9, 0, 0, 0, 0, 0, 0, 0, 18, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 36, 116, 74, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 58, 0, 241, 35, 214, 66, 0, 0, 220, 66, 32, 102, 50, 64, 200, 50, 171, 13, 9, 0, 0, 0, 0, 0, 0, 0, 18, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 36, 116, 74, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 58, 0, 240, 191, 219, 66, 0, 0, 220, 66, 80, 146, 150, 64, 200, 50, 204, 16, 9, 0, 0, 0, 0, 0, 0, 0, 18, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 36, 116, 74, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 58, 0, 48, 195, 219, 66, 0, 0, 220, 66, 48, 156, 150, 64, 200, 50, 204, 16, 9, 0, 0, 0, 0, 0, 0, 0, 18, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 36, 116, 74, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 58, 0, 9, 130, 212, 66, 0, 0, 220, 66, 96, 166, 13, 64, 200, 50, 215, 14, 9, 0, 0, 0, 0, 0, 0, 0, 18, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 36, 116, 74, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 58, 0, 109, 75, 214, 66, 0, 0, 220, 66, 64, 139, 51, 64, 200, 50, 204, 16, 9, 0, 0, 0, 0, 0, 0, 0, 20, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 36, 116, 74, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 58, 0, 76, 122, 214, 66, 0, 0, 220, 66, 32, 35, 57, 64, 200, 50, 215, 14, 9, 0, 0, 0, 0, 0, 0, 0, 18, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 36, 116, 74, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 58, 0, 128, 252, 217, 66, 0, 0, 220, 66, 80, 154, 130, 64, 200, 50, 204, 16, 9, 0, 0, 0, 0, 0, 0, 0, 18, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 36, 116, 74, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 58, 0, 170, 106, 211, 66, 0, 0, 220, 66, 128, 91, 233, 63, 200, 50, 204, 16, 9, 0, 0, 0, 0, 0, 0, 0, 18, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 36, 116, 74, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 58, 0, 116, 196, 219, 66, 0, 0, 220, 66, 128, 103, 150, 64, 200, 50, 171, 13, 9, 0, 0, 0, 0, 0, 0, 0, 19, 17, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 36, 116, 74, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 58, 0, 145, 87, 206, 66, 0, 0, 220, 66, 0, 212, 157, 61, 200, 50, 204, 16, 9, 0, 0, 0, 0, 0, 0, 0, 18, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 36, 116, 74, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 58, 0, 242, 38, 203, 66, 0, 0, 220, 66, 0, 115, 130, 191, 200, 50, 204, 16, 9, 0, 0, 0, 0, 0, 0, 0, 18, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 36, 116, 74, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 58, 0, 81, 181, 204, 66, 0, 0, 220, 66, 0, 99, 242, 190, 200, 50, 204, 16, 9, 0, 0, 0, 0, 0, 0, 0, 18, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 36, 116, 74, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 58, 0, 238, 166, 219, 66, 0, 0, 220, 66, 128, 139, 149, 64, 200, 50, 215, 14, 9, 0, 0, 0, 0, 0, 0, 0, 18, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 36, 116, 74, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 58, 0, 253, 157, 219, 66, 0, 0, 220, 66, 112, 116, 149, 64, 200, 50, 204, 16, 9, 0, 0, 0, 0, 0, 0, 0, 18, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 36, 116, 74, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 58, 0, 239, 103, 202, 66, 0, 0, 220, 66, 192, 12, 162, 191, 200, 50, 171, 13, 9, 0, 0, 0, 0, 0, 0, 0, 18, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 36, 116, 74, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 58, 0, 86, 168, 203, 66, 0, 0, 220, 66, 0, 99, 91, 191, 200, 50, 171, 13, 9, 0, 0, 0, 0, 0, 0, 0, 19, 17, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 36, 116, 74, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 58, 0, 102, 102, 213, 66, 0, 0, 220, 66, 128, 62, 33, 64, 200, 50, 204, 16, 9, 0, 0, 0, 0, 0, 0, 0, 18, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 36, 116, 74, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
  var finalClassification = Uint8List.fromList([228, 7, 1, 7, 1, 8, 75, 6, 82, 139, 6, 45, 67, 248, 206, 220, 232, 66, 197, 13, 0, 0, 19, 255, 20, 11, 36, 14, 0, 1, 3, 31, 19, 149, 66, 0, 0, 0, 192, 180, 85, 165, 64, 0, 0, 2, 18, 20, 0, 0, 0, 0, 0, 0, 16, 18, 0, 0, 0, 0, 0, 0, 17, 35, 11, 0, 1, 3, 146, 218, 150, 66, 0, 0, 0, 106, 33, 244, 164, 64, 0, 0, 2, 18, 20, 0, 0, 0, 0, 0, 0, 16, 18, 0, 0, 0, 0, 0, 0, 18, 35, 17, 0, 1, 3, 67, 65, 151, 66, 0, 0, 0, 133, 248, 2, 165, 64, 0, 0, 2, 18, 20, 0, 0, 0, 0, 0, 0, 16, 18, 0, 0, 0, 0, 0, 0, 3, 36, 2, 15, 1, 3, 224, 190, 146, 66, 0, 0, 0, 128, 201, 241, 164, 64, 0, 0, 2, 18, 20, 0, 0, 0, 0, 0, 0, 16, 18, 0, 0, 0, 0, 0, 0, 14, 36, 16, 0, 1, 3, 128, 3, 150, 66, 0, 0, 0, 32, 79, 116, 165, 64, 0, 0, 2, 18, 20, 0, 0, 0, 0, 0, 0, 16, 18, 0, 0, 0, 0, 0, 0, 1, 36, 1, 25, 1, 3, 36, 95, 146, 66, 0, 0, 0, 64, 45, 226, 164, 64, 0, 0, 2, 18, 20, 0, 0, 0, 0, 0, 0, 16, 18, 0, 0, 0, 0, 0, 0, 7, 36, 7, 6, 1, 3, 133, 237, 147, 66, 0, 0, 0, 192, 170, 63, 165, 64, 0, 0, 2, 20, 19, 0, 0, 0, 0, 0, 0, 18, 17, 0, 0, 0, 0, 0, 0, 9, 36, 13, 2, 1, 3, 238, 166, 146, 66, 0, 0, 0, 128, 17, 73, 165, 64, 0, 0, 2, 20, 18, 0, 0, 0, 0, 0, 0, 18, 16, 0, 0, 0, 0, 0, 0, 12, 36, 19, 0, 1, 3, 190, 17, 149, 66, 0, 0, 0, 32, 166, 94, 165, 64, 0, 0, 2, 19, 20, 0, 0, 0, 0, 0, 0, 17, 18, 0, 0, 0, 0, 0, 0, 10, 36, 12, 1, 1, 3, 73, 3, 149, 66, 0, 0, 0, 0, 251, 79, 165, 64, 0, 0, 2, 18, 20, 0, 0, 0, 0, 0, 0, 16, 18, 0, 0, 0, 0, 0, 0, 16, 35, 9, 0, 1, 3, 96, 184, 150, 66, 0, 0, 0, 253, 230, 242, 164, 64, 0, 0, 2, 19, 20, 0, 0, 0, 0, 0, 0, 17, 18, 0, 0, 0, 0, 0, 0, 2, 36, 6, 19, 1, 3, 247, 43, 146, 66, 0, 0, 0, 128, 208, 230, 164, 64, 0, 0, 2, 18, 20, 0, 0, 0, 0, 0, 0, 16, 18, 0, 0, 0, 0, 0, 0, 5, 36, 5, 10, 1, 3, 16, 60, 147, 66, 0, 0, 0, 128, 127, 1, 165, 64, 0, 0, 2, 18, 20, 0, 0, 0, 0, 0, 0, 16, 18, 0, 0, 0, 0, 0, 0, 8, 36, 8, 4, 1, 3, 119, 179, 148, 66, 0, 0, 0, 192, 99, 66, 165, 64, 0, 0, 2, 18, 20, 0, 0, 0, 0, 0, 0, 16, 18, 0, 0, 0, 0, 0, 0, 4, 36, 4, 12, 1, 3, 91, 241, 146, 66, 0, 0, 0, 64, 214, 251, 164, 64, 0, 0, 2, 18, 20, 0, 0, 0, 0, 0, 0, 16, 18, 0, 0, 0, 0, 0, 0, 13, 36, 20, 0, 1, 3, 238, 123, 149, 66, 0, 0, 0, 128, 23, 101, 165, 64, 0, 0, 2, 18, 20, 0, 0, 0, 0, 0, 0, 16, 18, 0, 0, 0, 0, 0, 0, 6, 36, 3, 8, 1, 3, 111, 105, 147, 66, 0, 0, 0, 128, 74, 12, 165, 64, 0, 0, 2, 18, 20, 0, 0, 0, 0, 0, 0, 16, 18, 0, 0, 0, 0, 0, 0, 15, 35, 15, 0, 1, 3, 34, 54, 150, 66, 0, 0, 0, 80, 114, 226, 164, 64, 0, 0, 2, 18, 20, 0, 0, 0, 0, 0, 0, 16, 18, 0, 0, 0, 0, 0, 0, 19, 35, 18, 0, 1, 3, 250, 36, 152, 66, 0, 0, 0, 135, 152, 41, 165, 64, 0, 0, 2, 19, 20, 0, 0, 0, 0, 0, 0, 17, 18, 0, 0, 0, 0, 0, 0, 20, 1, 10, 0, 0, 4, 21, 135, 174, 66, 0, 0, 0, 96, 16, 18, 100, 64, 0, 0, 1, 19, 0, 0, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);

  test('celsius_to_fahrenheit', () {
    int t = 96;
    int f = ((t * (9/5)) + 32).toInt();

    expect(f, 204);
  });

  test('current_lap_time', () {
    double lap = 85.45933211;
    int minutes = (lap.floor() / 60).floor();
    int seconds = lap.floor() - (minutes * 60);
    int millis = ((lap - lap.floor()) * 1000).toInt();

    minutes.toString().padLeft(2, '0');

    String currentLapTime = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.${millis.toString().padLeft(3, '0')}';
    expect(currentLapTime, '01:25.459');
  });

  test('test_decoder_header', (){
    var header = Header(Uint8List.fromList(carStatus));

    print("\n\npacket format: " + header.packetFormat.toString() +
        "\ngameMajorVersion: " + header.gameMajorVersion.toString() +
        "\ngameMinorVersion: " + header.gameMinorVersion.toString() +
        "\npacketVersion: " + header.packetVersion.toString() +
        "\npacketId: " + header.packetId.toString() +
        "\nsessionUID: " + header.sessionUID.toString() +
        "\nsessionTime: " + header.sessionTime.toString() +
        "\nframeIdentifier: " + header.frameIdentifier.toString() +
        "\nplayerCarIndex: " + header.playerCarIndex.toString() +
        "\nsecondaryPlayer: " + header.secondaryPlayerCarIndex.toString() +
        "\n\n\n"
    );
  });

  test('test_decoder_car_status', () {
    var list = carStatus;

    Header header = Header(list);
    PacketCarStatusData packet = PacketCarStatusData(header, list);
  });

  test('test_decoder_lap_data', () {
    var list = lapData;

    Header header = Header(list);
    PacketLapData packet = PacketLapData(header, list);
  });

  test('test_decoder_car_telemetry', () {
    var list = carTelemetry;
    Header header = Header(list);

    PacketCarTelemetryData packet = PacketCarTelemetryData(header, list);
  });

  test('test_decoder_participant_data', (){
    var list = participants;

    print("numActiveCars: ${list[24]}");

    var subList = list.sublist(25);
    int i = 0;
    int listIndex = 0;

    var participantDataList = [];
    int byteSize = ParticipantData.participantData.reduce((a, b) => a + b);

    while(i < 22){
      var p = subList.sublist(listIndex, listIndex + byteSize);
      listIndex += byteSize ;

      participantDataList.add(ParticipantData(p));
      i++;
    }
  });
}
