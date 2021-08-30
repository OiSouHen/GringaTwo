vRP.prepare("vRP/get_infos","SELECT * FROM infos WHERE steam = @steam")
vRP.prepare("vRP/get_characters","SELECT id,registration,phone,name,name2,bank FROM users WHERE steam = @steam and deleted = 0")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE RACES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/get_winrace","SELECT user_id,raceid FROM races WHERE user_id = @user_id and raceid = @raceid")
vRP.prepare("vRP/update_winrace","UPDATE races SET vehicle = @vehicle, points = @points WHERE user_id = @user_id and raceid = @raceid")
vRP.prepare("vRP/insert_winrace","INSERT INTO races(user_id,vehicle,raceid,points) VALUES(@user_id,@vehicle,@raceid,@points)")
vRP.prepare("vRP/show_winrace","SELECT * FROM races WHERE raceid = @id ORDER BY points DESC LIMIT 13")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE USERS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/get_users","SELECT * FROM users WHERE id = @id")
vRP.prepare("vRP/get_registration","SELECT id FROM users WHERE registration = @registration")
vRP.prepare("vRP/get_phone","SELECT id FROM users WHERE phone = @phone")
vRP.prepare("vRP/create_characters","INSERT INTO users(steam,name,name2) VALUES(@steam,@name,@name2)")
vRP.prepare("vRP/remove_characters","UPDATE users SET deleted = 1 WHERE id = @id")
vRP.prepare("vRP/update_characters","UPDATE users SET registration = @registration, phone = @phone WHERE id = @id")
vRP.prepare("vRP/rename_characters","UPDATE users SET name = @name, name2 = @name2 WHERE id = @id")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE BANK
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/set_bank","UPDATE users SET bank = @bank WHERE id = @id")
vRP.prepare("vRP/add_bank","UPDATE users SET bank = bank + @bank WHERE id = @id")
vRP.prepare("vRP/del_bank","UPDATE users SET bank = bank - @bank WHERE id = @id")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE USERS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/create_user","INSERT INTO infos(steam) VALUES(@steam)")
vRP.prepare("vRP/set_banned","UPDATE infos SET banned = @banned WHERE steam = @steam")
vRP.prepare("vRP/set_whitelist","UPDATE infos SET whitelist = @whitelist WHERE steam = @steam")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE USER_DATA
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/set_userdata","REPLACE INTO user_data(user_id,dkey,dvalue) VALUES(@user_id,@key,@value)")
vRP.prepare("vRP/get_userdata","SELECT dvalue FROM user_data WHERE user_id = @user_id AND dkey = @key")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE SRV_DATA
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/set_srvdata","REPLACE INTO srv_data(dkey,dvalue) VALUES(@key,@value)")
vRP.prepare("vRP/get_srvdata","SELECT dvalue FROM srv_data WHERE dkey = @key")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE PERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/get_perm","SELECT * FROM permissions WHERE user_id = @user_id")
vRP.prepare("vRP/get_group","SELECT * FROM permissions WHERE user_id = @user_id AND permiss = @permiss")
vRP.prepare("vRP/add_group","INSERT INTO permissions(user_id,permiss) VALUES(@user_id,@permiss)")
vRP.prepare("vRP/del_group","DELETE FROM permissions WHERE user_id = @user_id AND permiss = @permiss")
vRP.prepare("vRP/cle_group","DELETE FROM permissions WHERE user_id = @user_id")
vRP.prepare("vRP/upd_group","UPDATE permissions SET permiss = @newpermiss WHERE user_id = @user_id AND permiss = @permiss")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE PRIORITY
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/set_morechars","UPDATE infos SET chars = chars + 1 WHERE steam = @steam")
vRP.prepare("vRP/set_premium","UPDATE infos SET premium = @premium, predays = @predays, priority = @priority WHERE steam = @steam")
vRP.prepare("vRP/update_priority","UPDATE infos SET premium = 0, predays = 0, priority = 0 WHERE steam = @steam")
vRP.prepare("vRP/update_premium","UPDATE infos SET predays = predays + @predays WHERE steam = @steam")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE HOMES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/get_homeuser","SELECT * FROM homes WHERE user_id = @user_id AND home = @home")
vRP.prepare("vRP/get_homeuserid","SELECT * FROM homes WHERE user_id = @user_id")
vRP.prepare("vRP/get_homeuserowner","SELECT * FROM homes WHERE user_id = @user_id AND home = @home AND owner = 1")
vRP.prepare("vRP/get_homeuseridowner","SELECT * FROM homes WHERE home = @home AND owner = 1")
vRP.prepare("vRP/get_homepermissions","SELECT * FROM homes WHERE home = @home")
vRP.prepare("vRP/add_permissions","INSERT IGNORE INTO homes(home,user_id) VALUES(@home,@user_id)")
vRP.prepare("vRP/buy_permissions","INSERT IGNORE INTO homes(home,user_id,owner,vault) VALUES(@home,@user_id,1,@vault)")
vRP.prepare("vRP/count_homepermissions","SELECT COUNT(*) as qtd FROM homes WHERE home = @home")
vRP.prepare("vRP/count_homes","SELECT COUNT(*) as qtd FROM homes WHERE user_id = @user_id")
vRP.prepare("vRP/rem_permissions","DELETE FROM homes WHERE home = @home AND user_id = @user_id")
vRP.prepare("vRP/rem_allpermissions","DELETE FROM homes WHERE home = @home")
vRP.prepare("vRP/upd_vaulthomes","UPDATE homes SET vault = vault + @vault WHERE home = @home AND owner = 1")
vRP.prepare("vRP/transfer_homes","UPDATE homes SET user_id = @nuser_id WHERE user_id = @user_id AND home = @home")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE GARAGES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/get_vehicle","SELECT * FROM vehicles WHERE user_id = @user_id")
vRP.prepare("vRP/get_vehicle_plate","SELECT * FROM vehicles WHERE plate = @plate")
vRP.prepare("vRP/get_vehicle_phone","SELECT * FROM vehicles WHERE phone = @phone")
vRP.prepare("vRP/rem_vehicle","DELETE FROM vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vRP/get_vehicles","SELECT * FROM vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vRP/set_update_vehicles","UPDATE vehicles SET engine = @engine, body = @body, fuel = @fuel, doors = @doors, windows = @windows, tyres = @tyres WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vRP/set_arrest","UPDATE vehicles SET arrest = @arrest, time = @time WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vRP/move_vehicle","UPDATE vehicles SET user_id = @nuser_id WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vRP/add_vehicle","INSERT IGNORE INTO vehicles(user_id,vehicle,plate,phone,work) VALUES(@user_id,@vehicle,@plate,@phone,@work)")
vRP.prepare("vRP/con_maxvehs","SELECT COUNT(vehicle) as qtd FROM vehicles WHERE user_id = @user_id AND work = 'false'")
vRP.prepare("vRP/rem_srv_data","DELETE FROM srv_data WHERE dkey = @dkey")
vRP.prepare("vRP/update_garages","UPDATE users SET garage = garage + 1 WHERE id = @id")
vRP.prepare("vRP/update_plate_vehicle","UPDATE vehicles SET plate = @plate WHERE user_id = @user_id AND vehicle = @vehicle")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE INVOICE
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/add_invoice","INSERT INTO invoice(user_id,nuser_id,date,price,text) VALUES(@user_id,@nuser_id,@date,@price,@text)")
vRP.prepare("vRP/get_invoice","SELECT * FROM invoice WHERE user_id = @user_id")
vRP.prepare("vRP/get_myinvoice","SELECT * FROM invoice WHERE nuser_id = @nuser_id")
vRP.prepare("vRP/del_invoice","DELETE FROM invoice WHERE id = @id AND user_id = @user_id")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE SALARY
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/add_salary","INSERT INTO salary(user_id,date,price) VALUES(@user_id,@date,@price)")
vRP.prepare("vRP/get_salary","SELECT * FROM salary WHERE user_id = @user_id")
vRP.prepare("vRP/del_salary","DELETE FROM salary WHERE id = @id AND user_id = @user_id")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE FINES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/add_fines","INSERT INTO fines(user_id,nuser_id,date,price,text) VALUES(@user_id,@nuser_id,@date,@price,@text)")
vRP.prepare("vRP/get_fines","SELECT * FROM fines WHERE user_id = @user_id")
vRP.prepare("vRP/del_fines","DELETE FROM fines WHERE id = @id AND user_id = @user_id")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE WEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/add_weapon","INSERT INTO weapons(user_id,weapon,ammo) VALUES(@user_id,@weapon,@ammo)")
vRP.prepare("vRP/get_weapon","SELECT * FROM weapons WHERE user_id = @user_id")
vRP.prepare("vRP/update_weapon","UPDATE weapons SET ammo = @ammo WHERE user_id = @user_id and weapon = @weapon")
vRP.prepare("vRP/del_weapon","DELETE FROM weapons WHERE user_id = @user_id AND weapon = @weapon")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE BARBERSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/selectSkin","SELECT * FROM barbershop WHERE user_id = @user_id")
vRP.prepare("vRP/insertSkin","INSERT INTO barbershop(user_id) VALUES(@user_id)")
vRP.prepare("vRP/updateSkin","UPDATE barbershop SET fathers = @fathers, kinship = @kinship, eyecolor = @eyecolor, skincolor = @skincolor, acne = @acne, stains = @stains, freckles = @freckles, aging = @aging, hair = @hair, haircolor = @haircolor, haircolor2 = @haircolor2, makeup = @makeup, makeupintensity = @makeupintensity, makeupcolor = @makeupcolor, lipstick = @lipstick, lipstickintensity = @lipstickintensity, lipstickcolor = @lipstickcolor, eyebrow = @eyebrow, eyebrowintensity = @eyebrowintensity, eyebrowcolor = @eyebrowcolor, beard = @beard, beardintentisy = @beardintentisy, beardcolor = @beardcolor, blush = @blush, blushintentisy = @blushintentisy, blushcolor = @blushcolor WHERE user_id = @user_id")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE PRISON
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/set_prison","UPDATE users SET prison = prison + @prison, locate = @locate WHERE id = @user_id")
vRP.prepare("vRP/rem_prison","UPDATE users SET prison = prison - @prison WHERE id = @user_id")
vRP.prepare("vRP/fix_prison","UPDATE users SET prison = 1 WHERE id = @user_id")
vRP.prepare("vRP/resgate_prison","UPDATE users SET prison = 0 WHERE id = @user_id")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE GEMS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/set_gemsitem","UPDATE infos SET gems = gems + 1 WHERE steam = @steam")
vRP.prepare("vRP/set_gems","UPDATE infos SET gems = gems + @gems WHERE steam = @steam")
vRP.prepare("vRP/rem_gems","UPDATE infos SET gems = gems - @gems WHERE steam = @steam")
vRP.prepare("vRP/set_rental_time","UPDATE vehicles SET premiumtime = @premiumtime WHERE user_id = @user_id AND vehicle = @vehicle")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE CHESTS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/getExistChest","SELECT * FROM chests WHERE name = @name")
vRP.prepare("vRP/get_alltable","SELECT * FROM chests")
vRP.prepare("vRP/addChest","INSERT INTO chests (permiss,name,x,y,z,weight) VALUES (@permiss,@name,@x,@y,@z,@weight)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE BENEFACTOR
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/get_ConceStock","SELECT * FROM benefactor")
vRP.prepare("vRP/update_ConceStock","UPDATE benefactor SET estoque = @estoque WHERE vehicle = @vehicle")
vRP.prepare("vRP/insert_ConceStock","INSERT INTO benefactor (estoque,vehicle) VALUES (@estoque,@vehicle)")