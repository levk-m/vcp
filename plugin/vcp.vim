if exists('g:loaded_vcp') || exists('g:loaded_cp_templates')
  finish
endif
let g:loaded_vcp = 1

command! -bar -nargs=0 Vcp call vcp#open()
command! -bar -nargs=0 CpTemplate call vcp#open()

if !get(g:, 'vcp_no_mappings', get(g:, 'cp_templates_no_mappings', 0))
  nnoremap <silent> <C-t> :<C-u>Vcp<CR>
endif
