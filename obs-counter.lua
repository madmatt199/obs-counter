--[[
@file obs-counter.lua
@date 3/26/2018
@author GlazedHam
@version 0.1
--]]
obs = obslua
glzl = require("glzl/glzl")

glzl.glzSetLogLevel(GLZ_LOG_LEVELS["INFO"])
glzl.glzDebug("Source intialization successful.")

m_counter_value = 0
m_text_source_name = nil
m_inc_hotkey_id = obs.OBS_INVALID_HOTKEY_ID
m_dec_hotkey_id = obs.OBS_INVALID_HOTKEY_ID

--[[
This is my atrocious solution for OBS not documenting what their key up/down events are called.
--]]
m_inc_setting = 1
m_dec_setting = 1

--[[
Reset counter callback.
--]]
function reset_counter_button_clicked()
  m_counter_value = 0
  
  glzl.glzDebug("The Text Source (" .. m_text_source_name .. ")");
  
  if m_text_source_name ~= nil then
    glzl.glzDebug("Resetting the counter value.")
    
    local source = obs.obs_get_source_by_name(m_text_source_name)
		if source ~= nil then
			local settings = obs.obs_data_create()
			obs.obs_data_set_string(settings, "text", m_counter_value)
			obs.obs_source_update(source, settings)
			obs.obs_data_release(settings)
			obs.obs_source_release(source)
		end
  else
    glzl.glzWarn("You have to set the Text Source before resetting the counter.")
  end
end

--[[
Sets the properties on the script menu. This is what shows up when you click on the script in the Scripts menu.
--]]
function script_properties()
  local props = obs.obs_properties_create()
  
  local p = obs.obs_properties_add_list(props, "text_target", "Text Source", obs.OBS_COMBO_TYPE_EDITABLE, obs.OBS_COMBO_FORMAT_STRING)
	local sources = obs.obs_enum_sources()
	if sources ~= nil then
		for _, source in ipairs(sources) do
			source_id = obs.obs_source_get_id(source)
			if source_id == "text_gdiplus" or source_id == "text_ft2_source" then
				local name = obs.obs_source_get_name(source)
				obs.obs_property_list_add_string(p, name, name)
			end
		end
	end
	obs.source_list_release(sources)
  
  obs.obs_properties_add_button(props, "reset_counter_button", "Reset Counter", reset_counter_button_clicked)
  
  glzl.glzDebug("Script properties created.");
  
  return props
end

--[[
Sets the description in the scripts menu.
--]]
function script_description()
	return "Connects a text source to be used as a counter that can be incremented via user configurable hotkeys."
end

--[[
Called on saving the script.
--]]
function script_save(settings)
  local inc_hotkey_save_array = obs.obs_hotkey_save(m_inc_hotkey_id)
	obs.obs_data_set_array(settings, "increment_hotkey", inc_hotkey_save_array)
	obs.obs_data_array_release(inc_hotkey_save_array)
  
  local dec_hotkey_save_array = obs.obs_hotkey_save(m_dec_hotkey_id)
	obs.obs_data_set_array(settings, "decrement_hotkey", dec_hotkey_save_array)
	obs.obs_data_array_release(dec_hotkey_save_array)
end

--[[
Called on script update. Currently used to bind the text box to a variable.
--]]
function script_update(settings)
	m_text_source_name = obs.obs_data_get_string(settings, "text_target")
  
  glzl.glzDebug("The Text Source was set to (" .. m_text_source_name .. ")");
end

--[[
Increment the text box value.
--]]
function increment_value()
  if m_inc_setting % 2 == 0 then
    m_inc_setting = m_inc_setting + 1
    return
  end
  
  m_counter_value = m_counter_value + 1
  m_inc_setting = m_inc_setting + 1
  
  -- Update the text box.
  local source = obs.obs_get_source_by_name(m_text_source_name)
		if source ~= nil then
			local settings = obs.obs_data_create()
			obs.obs_data_set_string(settings, "text", m_counter_value)
			obs.obs_source_update(source, settings)
			obs.obs_data_release(settings)
			obs.obs_source_release(source)
		end
end

--[[
Decrement the text box value.
--]]
function decrement_value()
  if m_dec_setting % 2 == 0 then
    m_dec_setting = m_dec_setting + 1
    return
  end
  
  m_counter_value = m_counter_value - 1
  m_dec_setting = m_dec_setting + 1
  
  if m_counter_value < 0 then
    m_counter_value = 0
  end
  
  -- Update the text box.
  local source = obs.obs_get_source_by_name(m_text_source_name)
		if source ~= nil then
			local settings = obs.obs_data_create()
			obs.obs_data_set_string(settings, "text", m_counter_value)
			obs.obs_source_update(source, settings)
			obs.obs_data_release(settings)
			obs.obs_source_release(source)
		end
end

--[[
Called on loading the script.
--]]
function script_load(settings)
  m_inc_setting = 1
  m_dec_setting = 1
  
  m_inc_hotkey_id = obs.obs_hotkey_register_frontend("increment_counter", "Increment Counter", increment_value)
	local inc_hotkey_save_array = obs.obs_data_get_array(settings, "increment_hotkey")
	obs.obs_hotkey_load(m_inc_hotkey_id, inc_hotkey_save_array)
	obs.obs_data_array_release(inc_hotkey_save_array)
  
  m_dec_hotkey_id = obs.obs_hotkey_register_frontend("decrement_counter", "Decrement Counter", decrement_value)
	local dec_hotkey_save_array = obs.obs_data_get_array(settings, "decrement_hotkey")
	obs.obs_hotkey_load(m_dec_hotkey_id, dec_hotkey_save_array)
	obs.obs_data_array_release(dec_hotkey_save_array)
end