<?php
	class ControllerModuleSimpleBlog extends Controller {
	   
       private $error = array();
       
       public function index() {
            $url = $this->request->get['route'];
            if($this->checkDatabase()) {
                
                $this->language->load('simple_blog/install');
                
                $this->document->setTitle($this->language->get('error_database'));
                
                $data['install_database'] = $this->url->link('simple_blog/install/installDatabase', 'token=' . $this->session->data['token'] . '&url=' . $url, 'SSL');
                
                $data['text_install_message'] = $this->language->get('text_install_message');
                
                $data['text_upgread'] = $this->language->get('text_upgread');
                
                $data['error_database'] = $this->language->get('error_database');
                
                $data['breadcrumbs'] = array();

    	   		$data['breadcrumbs'][] = array(
    	       		'text'      => $this->language->get('text_home'),
    				'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
    	      		'separator' => false
    	   		);
                
                $data['header'] = $this->load->controller('common/header');
      		    $data['column_left'] = $this->load->controller('common/column_left');
                $data['footer'] = $this->load->controller('common/footer');
        
                $this->response->setOutput($this->load->view('simple_blog/notification.tpl', $data));
                
            } else {
                $this->getData();
            }	
		}
		
        public function checkDatabase() {
            $database_not_found = $this->load->controller('simple_blog/install/validateTable');
            
            if(!$database_not_found) {
                return true;
            } 
            
            return false;
        }
       
		public function getData() {
			$this->language->load('module/simple_blog');

			$this->document->setTitle($this->language->get('heading_title'));

            $this->load->model('extension/module');
			
			if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

                if (!isset($this->request->get['module_id'])) {
                    $this->model_extension_module->addModule('simple_blog', $this->request->post);
                } else {
                    $this->model_extension_module->editModule($this->request->get['module_id'], $this->request->post);
                }
	
				$this->session->data['success'] = $this->language->get('text_success');
	
				$this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
			}
			
			$data['heading_title'] = $this->language->get('heading_title');

			$data['text_enabled'] = $this->language->get('text_enabled');
			$data['text_disabled'] = $this->language->get('text_disabled');
			$data['text_yes'] = $this->language->get('text_yes');
			$data['text_no'] = $this->language->get('text_no');;
			$data['text_latest_article'] = $this->language->get('text_latest_article');
			$data['text_popular_article'] = $this->language->get('text_popular_article');
			$data['text_article_related'] = $this->language->get('text_article_related');
            $data['text_edit'] = $this->language->get('text_edit');
            $data['text_category_label'] = $this->language->get('text_category_label');

			$data['entry_name'] = $this->language->get('entry_name');;
			$data['entry_status'] = $this->language->get('entry_status');;
			$data['entry_article_limit'] = $this->language->get('entry_article_limit');
			$data['entry_category'] = $this->language->get('entry_category');

			$data['button_save'] = $this->language->get('button_save');
			$data['button_cancel'] = $this->language->get('button_cancle');
            
			$data['token'] = $this->session->data['token'];
			
			if (isset($this->error['warning'])) {
				$data['error_warning'] = $this->error['warning'];
			} else {
				$data['error_warning'] = '';
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
				'href'      => $this->url->link('module/simple_blog', 'token=' . $this->session->data['token'], 'SSL'),
				'separator' => ' :: '
			);
			
			$data['action'] = $this->url->link('module/simple_blog', 'token=' . $this->session->data['token'], 'SSL');

			$data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSl');

            $this->load->model('simple_blog/category');
			$data['categories'] = $this->model_simple_blog_category->getCategories(0);

            if (isset($this->request->get['module_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
                $module_info = $this->model_extension_module->getModule($this->request->get['module_id']);
            }

            if (isset($this->request->post['name'])) {
                $data['name'] = $this->request->post['name'];
            } elseif (!empty($module_info)) {
                $data['name'] = $module_info['name'];
            } else {
                $data['name'] = '';
            }

            if (isset($this->request->post['article_limit'])) {
                $data['article_limit'] = $this->request->post['article_limit'];
            } elseif (!empty($module_info)) {
                $data['article_limit'] = $module_info['article_limit'];
            } else {
                $data['article_limit'] = '';
            }

            if (isset($this->request->post['category_id'])) {
                $data['category_id'] = $this->request->post['category_id'];
            } elseif (!empty($module_info)) {
                $data['category_id'] = $module_info['category_id'];
            } else {
                $data['category_id'] = '';
            }

            if (isset($this->request->post['status'])) {
                $data['status'] = $this->request->post['status'];
            } elseif (!empty($module_info)) {
                $data['status'] = $module_info['status'];
            } else {
                $data['status'] = '';
            }

			$this->load->model('design/layout');

			$data['layouts'] = $this->model_design_layout->getLayouts();			
			
            $data['header'] = $this->load->controller('common/header');
  		    $data['column_left'] = $this->load->controller('common/column_left');
            $data['footer'] = $this->load->controller('common/footer');
    
            $this->response->setOutput($this->load->view('module/simple_blog.tpl', $data));	
		}

		protected function validate() {
            if (!$this->user->hasPermission('modify', 'module/simple_blog')) {
    			$this->error['warning'] = $this->language->get('error_permission');
    		}
            
			if (!$this->error) {
				return true;
			} else {
				return false;
			}	
		}
	}
?>