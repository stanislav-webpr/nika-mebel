<?php
class ControllerModuleCoolfilter extends Controller {
	private $error = array(); 
	
	public function index() {
		$this->load->language('module/coolfilter');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('extension/module');
		$this->load->model('catalog/coolfilter');
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			if (!isset($this->request->get['module_id'])) {
				$this->model_extension_module->addModule('coolfilter', $this->request->post);
			} else {
				$this->model_extension_module->editModule($this->request->get['module_id'], $this->request->post);
			}

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}
				
		$data['heading_title'] = $this->language->get('heading_title');


        $data['heading_title'] = $this->language->get('heading_title');

        $data['text_edit'] = $this->language->get('text_edit');
        $data['text_enabled'] = $this->language->get('text_enabled');
        $data['text_disabled'] = $this->language->get('text_disabled');

        $data['entry_name'] = $this->language->get('entry_name');
        $data['entry_status'] = $this->language->get('entry_status');
        $data['entry_coolfilter_group'] = $this->language->get('entry_coolfilter_group');

        $data['button_save'] = $this->language->get('button_save');
        $data['button_cancel'] = $this->language->get('button_cancel');

		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		
		$data['entry_count_enabled'] = $this->language->get('entry_count_enabled');
		$data['entry_coolfilter_group'] = $this->language->get('entry_coolfilter_group');
		
		$data['info_count_enabled'] = $this->language->get('info_count_enabled');

        if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
        }

        if (isset($this->error['name'])) {
            $data['error_name'] = $this->error['name'];
        } else {
            $data['error_name'] = '';
        }
		
  		$data['breadcrumbs'] = array();

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/coolfilter', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);

        if (!isset($this->request->get['module_id'])) {
            $data['action'] = $this->url->link('module/coolfilter', 'token=' . $this->session->data['token'], 'SSL');
        } else {
            $data['action'] = $this->url->link('module/coolfilter', 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], 'SSL');
        }

        $data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

        if (isset($this->request->get['module_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
            $module_info = $this->model_extension_module->getModule($this->request->get['module_id']);
        }

        $data['token'] = $this->session->data['token'];

        if (isset($this->request->post['name'])) {
            $data['name'] = $this->request->post['name'];
        } elseif (!empty($module_info)) {
            $data['name'] = $module_info['name'];
        } else {
            $data['name'] = '';
        }


        if (isset($this->request->post['filter_group'])) {
            $data['filter_group'] = $this->request->post['filter_group'];
        } elseif (!empty($module_info)) {
            $data['filter_group'] = $module_info['filter_group'];
        } else {
            $data['filter_group'] = '';
        }

        if (isset($this->request->post['count_enabled'])) {
            $data['count_enabled'] = $this->request->post['count_enabled'];
        } elseif (!empty($module_info)) {
            $data['count_enabled'] = $module_info['count_enabled'];
        } else {
            $data['count_enabled'] = '';
        }


        if (isset($this->request->post['status'])) {
            $data['status'] = $this->request->post['status'];
        } elseif (!empty($module_info)) {
            $data['status'] = $module_info['status'];
        } else {
            $data['status'] = '';
        }

		$this->load->model('catalog/coolfilter_group');
		$data['coolfilter_groups'] = $this->model_catalog_coolfilter_group->getcoolfilterGroups();

        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/coolfilter.tpl', $data));
	}
	
	public function install() {
		
        $this->load->model('catalog/coolfilter');
		$this->model_catalog_coolfilter->createTables();

        $this->response->redirect(HTTPS_SERVER . 'index.php?route=extension/module&token=' . $this->session->data['token']);
        
	}
	
    public function uninstall() {
        
        $this->load->model('catalog/coolfilter');
		$this->model_catalog_coolfilter->deleteTables();

        $this->response->redirect(HTTPS_SERVER . 'index.php?route=extension/module&token=' . $this->session->data['token']);
    
    }
    
	private function validate() {
        if (!$this->user->hasPermission('modify', 'module/featured')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 64)) {
            $this->error['name'] = $this->language->get('error_name');
        }
				
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
}
?>