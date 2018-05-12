-- Mounted SFX  by Darken5 --
--		Version 0.1.1	   --
-----------------------------
MountedSFX_Enable = MountedSFX_Enable or true
MountedSFX_Debug = MountedSFX_Debug or false

function MountedSFX_OnLoad()
	hooksecurefunc("JumpOrAscendStart"	, MountedSFX_JumpOrAscendStart);

	-- Slash Commands
	SLASH_MountedSFXCMD1 = "/msfx"
	SlashCmdList["MountedSFXCMD"] = MountedSFX_Command
	
	-- Addon loaded message
	print("|cff50c0ffMountedSFX |cffffa500"..GetAddOnMetadata("MountedSFX", "Version").."|cff50c0ff loaded.")
end

-- Processes a MountedSFX slash command.
function MountedSFX_Command(Command)
	local Lower = strlower(Command)
	if Lower == "" or Lower == nil then
		print ( "|cffff0000Error: |cff50c0ffSlash command for MountedSFX is |cffecda90/msfx on|cff50c0ff or |cffecda90/msfx off" );
	elseif Lower == "on" then
		MountedSFX_Enable = true
	elseif Lower == "off" then
		MountedSFX_Enable = false
	elseif Lower == "debug" then
		if MountedSFX_Debug == true then
			MountedSFX_Debug = false
			print ( "|cff50c0ffMounted SFX Debug |cffecda90OFF" )
		elseif MountedSFX_Debug == false then
			MountedSFX_Debug = true
			print ( "|cff50c0ffMounted SFX Debug |cffecda90ON" )
		end
	end
end
--'==========================================================================================
--'	MountedSFX Event: Howl's, Growl's, Roar's and Chocobo Kweh!! 
--'==========================================================================================	
function MountedSFX_JumpOrAscendStart()
	if IsMounted("player") and MountedSFX_Enable == true then
		currentSpeed, _, _, _ = GetUnitSpeed("player");
		if UnitAura("player", "Running Wild") ~= nil then
			if currentSpeed == 0 then
				MountedSFX_PlayFile( WorgenHowl );
			end
		else
			i = 1
			repeat 
				creatureName, spellID, _, active, _, _, _, _, _, _, _, mID = C_MountJournal.GetMountInfoByID(i)
				i = i + 1
			until ( active == true )
		-- Debug 
		if MountedSFX_Debug == true then
			print ( "|cff50c0ff" .. creatureName .. ": SpellID = " .. spellID .. ", mountID = " .. mID )
		end
		-- End Debug
			local MType = MountedID[spellID]
			if MType == "horse" then
				MountedSFX_PlayFile( Horse1 );
			elseif MType == "felsaber" then
				if currentSpeed == 0 then
					MountedSFX_PlayFile( FelsaberRoar );
				end
			elseif MType == "hawkstrider" then
				if currentSpeed == 0 then
					MountedSFX_PlayFile( KwehS );
				else
					MountedSFX_PlayFile( KwehM );
				end
			elseif MType == "mechanostrider" then
				MountedSFX_PlayFile( Cuckoo );
			elseif MType == "motorcycle" then
				MountedSFX_PlayFile( MotorcycleRev1 );
			elseif MountedID[spellID] == nil then
				return
			end
		end
	end
end

function MountedSFX_PlayFile( file )
	if( file ~= nil ) then
		PlaySoundFile( S .. file, "Master" )
	end
end