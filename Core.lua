-- Mounted SFX  by Darken5 --
--		Version 0.0.1	   --
-----------------------------

function MountedSFX_OnLoad()
	MountedSFXOptions = {}
	MountedSFXOptions.Enabled =  {}
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
		print ( |cffff0000 .. "Error: " .. |cff0000ff .. "Slash command for MountedSFX is " .. |cffecda90 .. "/msfx on" .. |cff0000ff .. " or " .. |cffecda90 .. "/msfx off" );
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
	if IsMounted("player") and MountedSFXOptions.Enabled == true then
		currentSpeed, runSpeed, flightSpeed, swimSpeed = GetUnitSpeed("player");
		if UnitAura("player", "Running Wild") ~= nil then
			if currentSpeed == 0 then
				MountedSFX_PlayFile( WorgenHowl );
			end
		elseif UnitAura("player", "Felsaber") ~= nil then
			if currentSpeed == 0 then
				MountedSFX_PlayFile( FelsaberRoar );
			end
		else
			local mountcount = C_MountJournal.GetNumDisplayedMounts()
			local mountName = nil
			i = 1
			repeat 
				local creatureName, spellID, _, active, _, _, _, _, _, _, _, mountID = C_MountJournal.GetMountInfoByID(i)
				i = i + 1
				if type(creatureName) == "string" then
					mountName = string.lower(creatureName)
				end
			until ( active == true ) 
			if string.match(mountName,'strider') then
				MountedSFX_PlayFile( FelsaberRoar );
			end
		end
	end
end

function MountedSFX_PlayFile( file )
	if( FinalFantasylizationOptions.Enabled == true ) and ( FinalFantasylizationOptions.Sound == true ) then
		if( file ~= nil ) then
			PlaySoundFile( S .. file, "Master" )
		end
	end
end