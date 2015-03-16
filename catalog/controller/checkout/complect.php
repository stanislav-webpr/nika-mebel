<?php

class ControllerCheckoutComplect extends Controller
{
    public function add()
    {
        $this->load->language('checkout/cart');

        if (isset($this->request->post['product_id'])) {
            $product_id = (int)$this->request->post['product_id'];
        } else {
            $product_id = 0;
        }

        if (isset($this->request->post['complect_product_id'])) {
            $complect_product_id = (int)$this->request->post['complect_product_id'];
        } else {
            $complect_product_id = 0;
        }

        $this->load->model('catalog/product');

        $product_info = $this->model_catalog_product->getComplectProduct($product_id, $complect_product_id);

        if ($product_info) {
            if (isset($this->request->post['quantity'])) {
                $quantity = (int)$this->request->post['quantity'];
            } else {
                $quantity = 1;
            }

            $option = array();

            $recurring_id = 0;

            $optional_data = array();
            $optional_data['complect_product_id'] = $complect_product_id;

            $this->cart->add($product_id, $quantity, $option, $recurring_id, $optional_data);

            $json['success'] = sprintf($this->language->get('text_success'), $this->url->link('product/product', 'product_id=' . $this->request->post['product_id']), $product_info['name'], $this->url->link('checkout/cart'));

            unset($this->session->data['shipping_method']);
            unset($this->session->data['shipping_methods']);
            unset($this->session->data['payment_method']);
            unset($this->session->data['payment_methods']);

            // Totals
            $this->load->model('extension/extension');

            $total_data = array();
            $total = 0;
            $taxes = $this->cart->getTaxes();

            // Display prices
            if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                $sort_order = array();

                $results = $this->model_extension_extension->getExtensions('total');

                foreach ($results as $key => $value) {
                    $sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
                }

                array_multisort($sort_order, SORT_ASC, $results);

                foreach ($results as $result) {
                    if ($this->config->get($result['code'] . '_status')) {
                        $this->load->model('total/' . $result['code']);

                        $this->{'model_total_' . $result['code']}->getTotal($total_data, $total, $taxes);
                    }
                }

                $sort_order = array();

                foreach ($total_data as $key => $value) {
                    $sort_order[$key] = $value['sort_order'];
                }

                array_multisort($sort_order, SORT_ASC, $total_data);
            }

            $json['total'] = sprintf($this->language->get('text_items'), $this->currency->format($total));
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    public function get_added_products() {
        $result = array();
        foreach ($this->cart->getProducts() as $product) {
            if(isset($product['complect_product_id'])) {
                $result[] = array(
                    'key' => $product['key'],
                    'product_id' => $product['complect_product_id'],
                    'quantity' => $product['quantity'],
                );
            }
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($result));
    }

//
//    public function remove() {
//        $this->load->language('checkout/cart');
//
//        $json = array();
//
//        // Remove
//        if (isset($this->request->post['key'])) {
//            $this->cart->remove($this->request->post['key']);
//
//            unset($this->session->data['vouchers'][$this->request->post['key']]);
//
//            $this->session->data['success'] = $this->language->get('text_remove');
//
//            unset($this->session->data['shipping_method']);
//            unset($this->session->data['shipping_methods']);
//            unset($this->session->data['payment_method']);
//            unset($this->session->data['payment_methods']);
//            unset($this->session->data['reward']);
//
//            // Totals
//            $this->load->model('extension/extension');
//
//            $total_data = array();
//            $total = 0;
//            $taxes = $this->cart->getTaxes();
//
//            // Display prices
//            if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
//                $sort_order = array();
//
//                $results = $this->model_extension_extension->getExtensions('total');
//
//                foreach ($results as $key => $value) {
//                    $sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
//                }
//
//                array_multisort($sort_order, SORT_ASC, $results);
//
//                foreach ($results as $result) {
//                    if ($this->config->get($result['code'] . '_status')) {
//                        $this->load->model('total/' . $result['code']);
//
//                        $this->{'model_total_' . $result['code']}->getTotal($total_data, $total, $taxes);
//                    }
//                }
//
//                $sort_order = array();
//
//                foreach ($total_data as $key => $value) {
//                    $sort_order[$key] = $value['sort_order'];
//                }
//
//                array_multisort($sort_order, SORT_ASC, $total_data);
//            }
//
//            $json['total'] = sprintf($this->language->get('text_items'), $this->currency->format($total));
//        }
//
//        $this->response->addHeader('Content-Type: application/json');
//        $this->response->setOutput(json_encode($json));
//    }
}