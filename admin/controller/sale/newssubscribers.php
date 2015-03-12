<?php

class ControllerSaleNewssubscribers extends Controller
{
    private $error = array();

    public function index()
    {
        $this->load->language('sale/newssubscribers');

        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->model('sale/newssubscribers');

        $this->getList();
    }

    public function insert()
    {
        $this->load->language('sale/newssubscribers');

        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->model('sale/newssubscribers');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
            $this->model_sale_newssubscribers->addEmail($this->request->post);

            $this->session->data['success'] = $this->language->get('text_success');

            $url = '';

            if (isset($this->request->get['page'])) {
                $url .= '&page=' . $this->request->get['page'];
            }

            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }

            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }

            $this->response->redirect($this->url->link('sale/newssubscribers', 'token=' . $this->session->data['token'] . $url, 'SSL'));
        }

        $this->getForm();
    }

    public function update()
    {
        $this->load->language('sale/newssubscribers');

        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->model('sale/newssubscribers');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
            $this->model_sale_newssubscribers->editEmail($this->request->get['id'], $this->request->post);

            $this->session->data['success'] = $this->language->get('text_success');

            $url = '';

            if (isset($this->request->get['page'])) {
                $url .= '&page=' . $this->request->get['page'];
            }

            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }

            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }

            $this->response->redirect($this->url->link('sale/newssubscribers', 'token=' . $this->session->data['token'] . $url, 'SSL'));
        }

        $this->getForm();
    }

    public function export()
    {
        $this->load->model('sale/newssubscribers');

        $contents = "Name \t Email \n";

        $results = $this->model_sale_newssubscribers->exportEmails();

        $filename = "Newsletter_subscribers_" . date("Y-m-d") . ".xls";
        if ($results) {
            foreach ($results as $results) {
                $contents .= implode("\t", $results) . "\n";
            }
        } else {
            $contents = $this->language->get('text_no_results');
        }
        header('Content-type: application/ms-excel');
        header('Content-Disposition: attachment; filename=' . $filename);
        echo $contents;

    }

    public function delete()
    {
        $this->load->language('sale/newssubscribers');

        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->model('sale/newssubscribers');

        if (isset($this->request->post['selected'])) {
            foreach ($this->request->post['selected'] as $id) {
                $this->model_sale_newssubscribers->deleteEmail($id);
            }

            $this->session->data['success'] = $this->language->get('text_success');

            $url = '';

            if (isset($this->request->get['page'])) {
                $url .= '&page=' . $this->request->get['page'];
            }

            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }

            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }

            $this->response->redirect($this->url->link('sale/newssubscribers', 'token=' . $this->session->data['token'] . $url, 'SSL'));
        }

        $this->getList();
    }

    private function getList()
    {
        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'href' => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
            'text' => $this->language->get('text_home'),
            'separator' => FALSE
        );

        $data['breadcrumbs'][] = array(
            'href' => $this->url->link('sale/newssubscribers', 'token=' . $this->session->data['token'], 'SSL'),
            'text' => $this->language->get('heading_title'),
            'separator' => ' :: '
        );


        $data['insert'] = $this->url->link('sale/newssubscribers/insert', 'token=' . $this->session->data['token'], 'SSL');
        $data['delete'] = $this->url->link('sale/newssubscribers/delete', 'token=' . $this->session->data['token'], 'SSL');
        $data['export'] = $this->url->link('sale/newssubscribers/export', 'token=' . $this->session->data['token'], 'SSL');


        $data['text_export'] = $this->language->get('text_export');

        if (isset($this->request->get['page'])) {
            $page = $this->request->get['page'];
        } else {
            $page = 1;
        }

        $data['emails'] = array();


        $email_total = $this->model_sale_newssubscribers->getTotalEmails();

        $results = $this->model_sale_newssubscribers->getEmails(($page - 1) * 20, 20);

        foreach ($results as $result) {
            $action = array();

            $action[] = array(
                'text' => $this->language->get('text_edit'),
                'href' => $this->url->link('sale/newssubscribers/update', 'token=' . $this->session->data['token'] . '&id=' . $result['id'], 'SSL')
            );

            $data['emails'][] = array(
                'id' => $result['id'],
                'name' => $result['name'],
                'email' => $result['email'],
                'action' => $action
            );
        }

        $data['heading_title'] = $this->language->get('heading_title');

        $data['text_no_results'] = $this->language->get('text_no_results');
        $data['text_edit'] = $this->language->get('heading_title');
        $data['text_confirm'] = $this->language->get('text_confirm');

        $data['column_name'] = $this->language->get('column_name');
        $data['column_email'] = $this->language->get('column_email');

        $data['column_action'] = $this->language->get('column_action');

        $data['button_insert'] = $this->language->get('button_insert');
        $data['button_delete'] = $this->language->get('button_delete');
        $data['button_edit'] = $this->language->get('button_edit');

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

        $url = "";


        $pagination = new Pagination();
        $pagination->total = $email_total;
        $pagination->page = $page;
        $pagination->limit = $this->config->get('config_admin_limit');
        $pagination->text = $this->language->get('text_pagination');
        $pagination->url = $this->url->link('sale/newssubscribers/', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');

        $data['pagination'] = $pagination->render();

        $data['sort_name'] = $this->url->link('sale/newssubscribers/', 'token=' . $this->session->data['token']);

        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('sale/newsletter_subscriberslist.tpl', $data));
    }

    private function getForm()
    {
        $data['heading_title'] = $this->language->get('heading_title');

        $data['text_edit'] = $this->language->get('heading_title');

        $data['entry_name'] = $this->language->get('entry_name');
        $data['entry_email'] = $this->language->get('entry_email');

        $data['button_save'] = $this->language->get('button_save');
        $data['button_cancel'] = $this->language->get('button_cancel');

        if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
        }

        if (isset($this->error['error_name'])) {
            $data['error_name'] = $this->error['error_name'];
        } else {
            $data['error_name'] = '';
        }

        if (isset($this->error['error_email'])) {
            $data['error_email'] = $this->error['error_email'];
        } else {
            $data['error_email'] = '';
        }


        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'href' => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
            'text' => $this->language->get('text_home')
        );

        $data['breadcrumbs'][] = array(
            'href' => $this->url->link('sale/newssubscribers', 'token=' . $this->session->data['token'], 'SSL'),
            'text' => $this->language->get('heading_title')
        );

        if (!isset($this->request->get['id'])) {
            $data['action'] = $this->url->link('sale/newssubscribers/insert', 'token=' . $this->session->data['token'], 'SSL');
        } else {
            $data['action'] = $this->url->link('sale/newssubscribers/update', 'token=' . $this->session->data['token'] . '&id=' . $this->request->get['id'], 'SSL');
        }

        $data['token'] = $this->session->data['token'];

        $data['cancel'] = $this->url->link('sale/newssubscribers', 'token=' . $this->session->data['token'], 'SSL');

        if (isset($this->request->get['id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
            $email_info = $this->model_sale_newssubscribers->getEmail($this->request->get['id']);
        }

        if (isset($this->request->post['name'])) {
            $data['name'] = $this->request->post['name'];
        } elseif (isset($email_info)) {
            $data['name'] = $email_info['name'];
        } else {
            $data['name'] = '';
        }

        if (isset($this->request->post['email'])) {
            $data['email'] = $this->request->post['email'];
        } elseif (isset($email_info)) {
            $data['email'] = $email_info['email'];
        } else {
            $data['email'] = '';
        }

        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('sale/newsletter_subscriber_form.tpl', $data));
    }

    private function validateForm()
    {
        $this->load->model('sale/newssubscribers');

        if (!$this->user->hasPermission('modify', 'sale/newssubscribers')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        if ($this->request->post['name'] == "") {
            $this->error['error_name'] = $this->language->get('error_name');
        }

        if (!filter_var($this->request->post['email'], FILTER_VALIDATE_EMAIL)) {
            $this->error['error_email'] = $this->language->get('error_email');
        }

        if (isset($this->request->get['id']) and $this->request->get['id'] != "") {
            if ($this->model_sale_newssubscribers->checkmail($this->request->post['email'], $this->request->get['id']))
                $this->error['error_email'] = $this->language->get('error_email_exist');

        } else {
            if ($this->model_sale_newssubscribers->checkmail($this->request->post['email']))
                $this->error['error_email'] = $this->language->get('error_email_exist');

        }

        if (!$this->error) {
            return TRUE;
        } else {
            return FALSE;
        }
    }

}

?>