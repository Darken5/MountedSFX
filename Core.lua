-- Mounted SFX  by Darken5 --
--		Version 0.1.0	   --
-----------------------------

function MountedSFX_OnLoad()
	hooksecurefunc("JumpOrAscendStart"	, MountedSFX_JumpOrAscendStart);

	-- Slash Commands
	SLASH_MountedSFXCMD1 = "/msfx"
	SlashCmdList["MountedSFXCMD"] = MountedSFX_Command
	
	-- Addon loaded message
	print("|cFF50C0FFMountedSFX |cFFFFA500"..GetAddOnMetadata("MountedSFX", "Version").."|cFF50C0FF loaded.")
end

-- Processes a MountedSFX slash command.
function MountedSFX_Command(Command)
	local Lower = strlower(Command)
	if Lower == "" or Lower == nil then
		print ( "|cffff0000Error: |cff0000ffSlash command for MountedSFX is |cffecda90/msfx on|cff0000ff or |cffecda90/msfx off" );
	elseif Lower == "on" then
		MountedSFX_Enable = true
	elseif Lower == "off" then
		MountedSFX_Enable = false
	end
end
--'==========================================================================================
--'	MountedSFX Event: Howl's, Growl's, Roar's and Chocobo Kweh!! 
--'==========================================================================================	
function MountedSFX_JumpOrAscendStart()
	if IsMounted("player") then
		currentSpeed, _, _, _ = GetUnitSpeed("player");
		if UnitAura("player", "Running Wild") ~= nil then
			if currentSpeed == 0 then
				MountedSFX_PlayFile( WorgenHowl );
			end
		elseif UnitAura("player", "Felsaber") ~= nil then
			if currentSpeed == 0 then
				MountedSFX_PlayFile( FelsaberRoar );
			end
		else
			i = 1
			repeat 
				creatureName, spellID, _, active, _, _, _, _, _, _, _, mID = C_MountJournal.GetMountInfoByID(i)
				i = i + 1
			until ( active == true )
		-- Debug 
			print ( creatureName .. ": SpellID - " .. spellID .. ", mountID - " .. mID )
		-- End Debug
			local MType = MountedID[spellID]
			if MType == "horse" then
				MountedSFX_PlayFile( Horse1 );
			elseif MType == "hawkstrider" then
				if currentSpeed == 0 then
					MountedSFX_PlayFile( KwehS );
				else
					MountedSFX_PlayFile( KwehM );
				end
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