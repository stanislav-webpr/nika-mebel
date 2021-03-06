<?php

class ControllerCheckoutProposition extends Controller
{
    public function add()
    {
        $this->load->language('checkout/cart');
        $this->load->model('catalog/product');

        $json = array();

        if (!empty($this->request->post)) {
            foreach ($this->request->post as $product) {
                if($product['options']) {
                    $options_GET = $product['options'];
                    $options_GET = html_entity_decode($options_GET);
                    $options_GET = urldecode($options_GET);

                    parse_str($options_GET, $options);
                    $option = $options['option'];
                } else {
                    $option = array();
                }

                $product_info = $this->model_catalog_product->getProduct($product['product_id']);

                if ($product_info) {
                    $product_options = $this->model_catalog_product->getProductOptions($product['product_id']);

                    foreach ($product_options as $product_option) {
                        if ($product_option['required'] && empty($option[$product_option['product_option_id']])) {
                            $json['error']['option'][$product['product_id']][$product_option['product_option_id']] = sprintf($this->language->get('error_required'), $product_option['name']);
                        }
                    }
                }
            }

            if (!$json) {
                foreach ($this->request->post as $product) {
                    $product_info = $this->model_catalog_product->getProduct($product['product_id']);

                    if ($product_info) {
                        if($product['options']) {
                            $options_GET = $product['options'];
                            $options_GET = html_entity_decode($options_GET);
                            $options_GET = urldecode($options_GET);

                            parse_str($options_GET, $options);
                            $option = $options['option'];
                        } else {
                            $option = array();
                        }

                        $recurring_id = 0;
                        $recurrings = $this->model_catalog_product->getProfiles($product_info['product_id']);

                        if ($recurrings) {
                            $recurring_ids = array();

                            foreach ($recurrings as $recurring) {
                                $recurring_ids[] = $recurring['recurring_id'];
                            }

                            if (!in_array($recurring_id, $recurring_ids)) {
                                $json['error']['recurring'] = $this->language->get('error_recurring_required');
                            }
                        }

                        $optional_data = array();
                        $optional_data['proposition'] = $product['proposition_id'];

                        $this->cart->add($product['product_id'], 1, $option, $recurring_id, $optional_data);

                        $json['success'] = sprintf($this->language->get('text_success'), $this->url->link('product/product', 'product_id=' . $product['product_id']), $product_info['name'], $this->url->link('checkout/cart'));

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
                }
            }
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }
}