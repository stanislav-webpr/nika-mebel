<?php
class ControllerSimpleBlogCategorySetting extends Controller {

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
        $this->language->load('module/simple_blog_category');

        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->model('setting/setting');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

            $this->model_setting_setting->editSetting('simple_blog_category', $this->request->post);

            $this->session->data['success'] = $this->language->get('text_success');

            $this->response->redirect($this->url->link('simple_blog/category_setting', 'token=' . $this->session->data['token'], 'SSL'));
        }

        $data['heading_title'] = $this->language->get('heading_title');

        $data['text_enabled'] = $this->language->get('text_enabled');
        $data['text_disabled'] = $this->language->get('text_disabled');
        $data['text_yes'] = $this->language->get('text_yes');
        $data['text_no'] = $this->language->get('text_no');
        $data['text_edit'] = $this->language->get('text_edit');

        $data['help_search_article'] = $this->language->get('help_search_article');

        $data['entry_search_article'] = $this->language->get('entry_search_article');
        $data['entry_status'] = $this->language->get('entry_status');

        $data['button_save'] = $this->language->get('button_save');

        $data['token'] = $this->session->data['token'];

        if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
        }

        if (isset($this->session->data['success'])) {
            $data['success'] = $this->session->data['success'];

            unset($this->session->data['success']);
        } else {
            $data['success'] = '';
        }

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_home'),
            'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => false
        );

        $data['breadcrumbs'][] = array(
            'text'      => $this->language->get('heading_title'),
            'href'      => $this->url->link('simple_blog/category_setting', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        $data['action'] = $this->url->link('simple_blog/category_setting', 'token=' . $this->session->data['token'], 'SSL');

        $data['simple_blog_category_search_article'] = '';
        $data['simple_blog_category_status'] = '';

        if (isset($this->request->post['simple_blog_category_search_article'])) {
            $data['simple_blog_category_search_article'] = $this->request->post['simple_blog_category_search_article'];
        } elseif ($this->config->get('simple_blog_category_search_article')) {
            $data['simple_blog_category_search_article'] = $this->config->get('simple_blog_category_search_article');
        }

        $this->load->model('design/layout');

        $data['layouts'] = $this->model_design_layout->getLayouts();

        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('simple_blog/category_setting.tpl', $data));
    }

    protected function validate() {
        if (!$this->user->hasPermission('modify', 'module/simple_blog_category')) {
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