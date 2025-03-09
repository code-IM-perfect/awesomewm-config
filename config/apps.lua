local _M = {
	editor   = os.getenv('EDITOR') or 'nano',
	terminal = os.getenv("TERMINAL") or "kitty",
}

_M.editor_cmd = _M.terminal .. ' -e ' .. _M.editor
_M.manual_cmd = _M.terminal .. ' -e man awesome'

return _M
