<?php echo $header; ?>
<div class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
      <div class="row">
        <?php if ($column_left && $column_right) { ?>
        <?php $class = 'col-sm-6'; ?>
        <?php } elseif ($column_left || $column_right) { ?>
        <?php $class = 'col-sm-6'; ?>
        <?php } else { ?>
        <?php $class = 'col-sm-7'; ?>
        <?php } ?>
        <div class="<?php echo $class; ?>">
          <?php if ($thumb || $images) { ?>
          <ul class="thumbnails">
            <?php if ($thumb) { ?>
            <li><a class="thumbnail" href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>"><img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a></li>
            <?php } ?>
            <?php if ($images) { ?>
            <?php foreach ($images as $image) { ?>
            <li class="image-additional"><a class="thumbnail" href="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>"> <img src="<?php echo $image['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a></li>
            <?php } ?>
            <?php } ?>
          </ul>
          <?php } ?>

        </div>



        <?php if ($column_left && $column_right) { ?>
        <?php $class = 'col-sm-6'; ?>
        <?php } elseif ($column_left || $column_right) { ?>
        <?php $class = 'col-sm-6'; ?>
        <?php } else { ?>
        <?php $class = 'col-sm-5'; ?>
        <?php } ?>
        <div class="<?php echo $class; ?>">
          <div class="btn-group">
            <button type="button" data-toggle="tooltip" class="btn btn-default" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product_id; ?>');"><i class="fa fa-heart"></i></button>
            <button type="button" data-toggle="tooltip" class="btn btn-default" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product_id; ?>');"><i class="fa fa-exchange"></i></button>
          </div>
          <h1><?php echo $heading_title; ?></h1>
          <ul class="list-unstyled">
<!--            --><?php //if ($manufacturer) { ?>
<!--            <li>--><?php //echo $text_manufacturer; ?><!-- <a href="--><?php //echo $manufacturers; ?><!--">--><?php //echo $manufacturer; ?><!--</a></li>-->
<!--            --><?php //} ?>
            <li><?php echo $text_model; ?> <?php echo $model; ?></li>
<!--            --><?php //if ($reward) { ?>
<!--            <li>--><?php //echo $text_reward; ?><!-- --><?php //echo $reward; ?><!--</li>-->
<!--            --><?php //} ?>
            <li><?php //echo $text_stock; ?><?php echo $stock; ?></li>
          </ul>
          <?php if ($review_status) { ?>
            <div class="rating">
              <p>
                <a href="" onclick="$('a[href=\'#tab-review\']').trigger('click'); return false;"><?php echo $reviews; ?></a>
                <?php for ($i = 1; $i <= 5; $i++) { ?>
                  <?php if ($rating < $i) { ?>
                    <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
                  <?php } else { ?>
                    <span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
                  <?php } ?>
                <?php } ?>
                </p>
              <!-- AddThis Button BEGIN -->
<!--              <div class="addthis_toolbox addthis_default_style"><a class="addthis_button_facebook_like" fb:like:layout="button_count"></a> <a class="addthis_button_tweet"></a> <a class="addthis_button_pinterest_pinit"></a> <a class="addthis_counter addthis_pill_style"></a></div>-->
<!--              <script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-515eeaf54693130e"></script>-->
              <!-- AddThis Button END -->
            </div>
          <?php } ?>

          <div id="product">
          <div class="row">
          <?php if ($attribute_groups) { ?>
            <div class="col-sm-6">
              <table class="table table-bordered">
                <?php foreach ($attribute_groups as $attribute_group) { ?>
                  <thead>
                  <tr>
                    <td colspan="2"><strong><?php echo $attribute_group['name']; ?></strong></td>
                  </tr>
                  </thead>
                  <tbody>
                  <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
                    <tr>
                      <td><?php echo $attribute['name']; ?></td>
                      <td><?php echo $attribute['text']; ?></td>
                    </tr>
                  <?php } ?>
                  </tbody>
                <?php } ?>
              </table>
            </div>
          <?php } ?>

          <?php if ($options) { ?>
            <div class="col-sm-6">
              <?php foreach ($options as $option) { ?>
                <?php if ($option['type'] == 'select') { ?>
                  <div class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                    <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                    <select name="option[<?php echo $option['product_option_id']; ?>]" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control">
                      <option value=""><?php echo $text_select; ?></option>
                      <?php foreach ($option['product_option_value'] as $option_value) { ?>
                          <option src="<?php echo $option_value['option_value_image']; ?>" value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                          <?php if ($option_value['price']) { ?>
                            (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                          <?php } ?>
                        </option>
                      <?php } ?>
                    </select>
                  </div>
                <?php } ?>
                <?php if ($option['type'] == 'radio') { ?>
                  <div class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                    <label class="control-label"><?php echo $option['name']; ?></label>
                    <div id="input-option<?php echo $option['product_option_id']; ?>">
                      <?php foreach ($option['product_option_value'] as $option_value) { ?>
                        <div class="radio">
                          <label>
                              <input class="thumb" src="<?php echo $option_value['option_value_image']; ?>" type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>"/>
                            <?php echo $option_value['name']; ?>
                            <?php if ($option_value['price']) { ?>
                              (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                            <?php } ?>
                          </label>
                        </div>
                      <?php } ?>
                    </div>
                  </div>
                <?php } ?>
                <?php if ($option['type'] == 'checkbox') { ?>
                  <div class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                    <label class="control-label"><?php echo $option['name']; ?></label>

                    <div id="input-option<?php echo $option['product_option_id']; ?>">
                      <?php foreach ($option['product_option_value'] as $option_value) { ?>
                        <div class="checkbox">
                          <label>
                            <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>"/>
                            <?php echo $option_value['name']; ?>
                            <?php if ($option_value['price']) { ?>
                              (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                            <?php } ?>
                          </label>
                        </div>
                      <?php } ?>
                    </div>
                  </div>
                <?php } ?>
                <?php if ($option['type'] == 'image') { ?>
                  <div class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                    <label class="control-label"><?php echo $option['name']; ?></label>
                    <div id="input-option<?php echo $option['product_option_id']; ?>">
                      <?php foreach ($option['product_option_value'] as $option_value) { ?>
                        <div class="radio">
                          <label>
                            <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" class="hidden" onclick="setColor(this);"/>
                            <img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail"/>
                              <?php //echo $option_value['name']; ?>
<!--                            --><?php //if ($option_value['price']) { ?>
<!--                              (--><?php //echo $option_value['price_prefix']; ?><!----><?php //echo $option_value['price']; ?><!--)-->
<!--                            --><?php //} ?>
                          </label>
                        </div>
                      <?php } ?>
                    </div>
                  </div>
                <?php } ?>
                <?php if ($option['type'] == 'text') { ?>
                  <div class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                    <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                    <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>"
                           class="form-control"/>
                  </div>
                <?php } ?>
                <?php if ($option['type'] == 'textarea') { ?>
                  <div class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                    <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                    <textarea name="option[<?php echo $option['product_option_id']; ?>]" rows="5" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>"
                              class="form-control"><?php echo $option['value']; ?></textarea>
                  </div>
                <?php } ?>
                <?php if ($option['type'] == 'file') { ?>
                  <div class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                    <label class="control-label"><?php echo $option['name']; ?></label>
                    <button type="button" id="button-upload<?php echo $option['product_option_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default btn-block"><i class="fa fa-upload"></i> <?php echo $button_upload; ?>
                    </button>
                    <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" id="input-option<?php echo $option['product_option_id']; ?>"/>
                  </div>
                <?php } ?>
                <?php if ($option['type'] == 'date') { ?>
                  <div class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                    <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>

                    <div class="input-group date">
                      <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD" id="input-option<?php echo $option['product_option_id']; ?>"
                             class="form-control"/>
              <span class="input-group-btn">
              <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
              </span></div>
                  </div>
                <?php } ?>
                <?php if ($option['type'] == 'datetime') { ?>
                  <div class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                    <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>

                    <div class="input-group datetime">
                      <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-option<?php echo $option['product_option_id']; ?>"
                             class="form-control"/>
              <span class="input-group-btn">
              <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
              </span></div>
                  </div>
                <?php } ?>
                <?php if ($option['type'] == 'time') { ?>
                  <div class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                    <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>

                    <div class="input-group time">
                      <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control"/>
              <span class="input-group-btn">
              <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
              </span></div>
                  </div>
                <?php } ?>
              <?php } ?>
            </div>
          <?php } ?>
          </div>

          <?php if ($price) { ?>
          <ul class="list-unstyled">
            <?php if (!$special) { ?>
            <li>
              <h2><?php echo $price; ?></h2>
            </li>
            <?php } else { ?>
            <li><span style="text-decoration: line-through;"><?php echo $price; ?></span></li>
            <li>
              <h2><?php echo $special; ?></h2>
            </li>
            <?php } ?>
            <?php if ($tax) { ?>
            <li><?php echo $text_tax; ?> <?php echo $tax; ?></li>
            <?php } ?>
            <?php if ($points) { ?>
            <li><?php echo $text_points; ?> <?php echo $points; ?></li>
            <?php } ?>
            <?php if ($discounts) { ?>
            <li>
              <hr>
            </li>
            <?php foreach ($discounts as $discount) { ?>
            <li><?php echo $discount['quantity']; ?><?php echo $text_discount; ?><?php echo $discount['price']; ?></li>
            <?php } ?>
            <?php } ?>
          </ul>
          <?php } ?>
          <div id="product">
            <?php if ($recurrings) { ?>
            <hr>
            <h3><?php echo $text_payment_recurring ?></h3>
            <div class="form-group required">
              <select name="recurring_id" class="form-control">
                <option value=""><?php echo $text_select; ?></option>
                <?php foreach ($recurrings as $recurring) { ?>
                <option value="<?php echo $recurring['recurring_id'] ?>"><?php echo $recurring['name'] ?></option>
                <?php } ?>
              </select>
              <div class="help-block" id="recurring-description"></div>
            </div>
            <?php } ?>
            <div class="form-group">
              <label class="control-label" for="input-quantity"><?php echo $entry_qty; ?></label>
              <input type="text" name="quantity" value="<?php echo $minimum; ?>" size="2" id="input-quantity" class="form-control" />
              <input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />
              <br />
              <button type="button" id="button-cart" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary btn-lg btn-block"><?php echo $button_cart; ?></button>
            </div>
            <?php if ($minimum > 1) { ?>
            <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $text_minimum; ?></div>
            <?php } ?>
          </div>
        </div>
      </div>
          <?php if($proposition_status) { ?>
          <div class="col-sm-12 proposition-slick">
              <?php foreach ($propositions as $proposition_id => $proposition) { ?>
              <div id="proposition_<?php echo $proposition_id; ?>" class="row">
                  <h2 class="text-center"><?php echo $proposition['name']; ?></h2>

                  <div class="col-lg-3 col-md-3 col-sm-3 col-xs-3" data-product-id="<?php echo $main_product['product_id']; ?>">
                      <div class="product-thumb transition">
                          <?php if ($options) { ?>
                          <a href="javascript: void(null);" onclick="proposition.options('<?php echo $main_product['product_id']; ?>');" class="proposition-show-options"><i class="fa fa-plus-circle"></i>
                          </a>
                          <?php } ?>
                              <div class="image"><img src="<?php echo $main_product['thumb']; ?>" alt="<?php echo $main_product['name']; ?>" title="<?php echo $main_product['name']; ?>" class="img-responsive"/></a></div>
                              <div class="caption">
                                  <h4><?php echo $main_product['name']; ?></h4>

                                  <p><?php echo $main_product['description']; ?></p>
                                  <?php if ($main_product['rating']) { ?>
                                      <div class="rating">
                                          <?php for ($i = 1; $i <= 5; $i++) { ?>
                                              <?php if ($main_product['rating'] < $i) { ?>
                                                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
                                              <?php } else { ?>
                                                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
                                              <?php } ?>
                                          <?php } ?>
                                      </div>
                                  <?php } ?>
                                  <?php if ($main_product['price']) { ?>
                                      <p class="price">
                                          <?php if (!$main_product['special']) { ?>
                                              <?php echo $main_product['price']; ?>
                                          <?php } else { ?>
                                              <?php echo $main_product['special']; ?>
                                          <?php } ?>
                                          <?php if ($main_product['tax']) { ?>
                                              <span class="price-tax"><?php echo $text_tax; ?> <?php echo $main_product['tax']; ?></span>
                                          <?php } ?>
                                      </p>
                                  <?php } ?>
                              </div>
                          </div>
                      </div>
                      <div style="float: left; margin: 10% 20px 0 20px;">
                          <i class="fa fa-plus" style="font-size: 48px;"></i>
                      </div>
                      <?php $count = count($proposition['products']); ?>
                      <?php foreach ($proposition['products'] as $key => $product) { ?>
                          <div class="col-lg-3 col-md-3 col-sm-3 col-xs-3" data-product-id="<?php echo $product['product_id']; ?>">
                              <div class="product-thumb transition">
                                  <?php if ($product['options']) { ?>
                                      <a href="javascript: void(null);" onclick="proposition.options('<?php echo $product['product_id']; ?>');" class="proposition-show-options"><i class="fa fa-plus-circle"></i>
                                      </a>
                                  <?php } ?>
                                  <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive"/></a></div>
                                  <span class="percent"><?php echo $product['percent']; ?></span>

                                  <div class="caption">
                                      <h4><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>

                                      <p><?php echo $product['description']; ?></p>
                                      <?php if ($product['rating']) { ?>
                                          <div class="rating">
                                              <?php for ($i = 1; $i <= 5; $i++) { ?>
                                                  <?php if ($product['rating'] < $i) { ?>
                                                      <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
                                                  <?php } else { ?>
                                                      <span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
                                                  <?php } ?>
                                              <?php } ?>
                                          </div>
                                      <?php } ?>
                                      <?php if ($product['price_included']) { ?>
                                          <p class="price">
                                              <span class="price-new"><?php echo $product['price_included']; ?></span> <span class="price-old"><?php echo $product['price']; ?></span>
                                          </p>
                                      <?php } ?>
                                  </div>
                              </div>
                          </div>
                          <?php if (($key + 1) < $count) { ?>
                              <div style="float: left; margin: 10% 20px 0 20px;">
                                  <i class="fa fa-plus" style="font-size: 48px;"></i>
                              </div>
                          <?php } else { ?>
                              <div style="float: left; margin: 9% 20px 0 20px; ">
                                  <i class="fa fa-equal" style="font-size: 60px;"></i>
                              </div>
                          <?php } ?>
                      <?php } ?>
                      <div class="col-lg-3 col-md-3 col-sm-3 col-xs-3 buy-proposition">
                          <div>
                              <p class="price">
                                  <span class="price-new"><?php echo $proposition['total_new']; ?></span> <span class="price-old"><?php echo $proposition['total_old']; ?></span>
                              </p>

                              <span class="odds"><?php echo $proposition['odds']; ?></span>

                              <div class="button-group">
                                  <button type="button" onclick="proposition.add('<?php echo $proposition_id; ?>');"><span class="hidden-xs hidden-sm hidden-md"><?php echo $button_cart; ?></span> <i class="fa fa-shopping-cart"></i></button>
                              </div>
                          </div>
                          <div class="clearfix"></div>
                      </div>
                  </div>
                  <?php } ?>
              </div>
          <?php } ?>
          <?php if($complects_status) { ?>
            <div class="row col-sm-12" id="complect">
                <h2>Вы покупаете <span id="count">5</span> из 8 товаров комплекта</h2>

                <div class="checkbox">
                    <label>
                        <input type="checkbox" id="select_all" onclick="complect.all();">Выбрать товары из этого комплекта
                    </label>
                    <span class="complect-discount">скидка 5%</span>
                </div>
                <div id="complect_products">
                    <?php foreach ($complect as $product) { ?>
                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12" id="product_<?php echo $product['product_id']; ?>">
                            <div class="product-thumb transition">
                                <img src="<?php echo $product['thumb']; ?>" alt="" class="img-responsive">
                                <h4><?php echo $product['name']; ?></h4>

                                <div class="col-sm-4">
                                    <img src="image/catalog/width.png" alt="">

                                    <div class="size-value"><?php echo $product['width']; ?></div>
                                </div>
                                <div class="col-sm-4">
                                    <img src="image/catalog/height.png" alt="">

                                    <div class="size-value"><?php echo $product['height']; ?></div>
                                </div>
                                <div class="col-sm-4">
                                    <img src="image/catalog/deep.png" alt="">

                                    <div class="size-value"><?php echo $product['length']; ?></div>
                                </div>
                                <div class="col-sm-12">
                                    <div class="price col-sm-6 pull-left"><?php echo $product['price']; ?></div>
                                    <div class="quantity col-sm-6 pull-right">
                                        <i class="fa fa-plus" style="float: left; margin-top: 10px;" onclick="complect.quantity.plus('<?php echo $product['product_id']; ?>')"></i>
                                        <div class="col-sm-8"><input type="text" class="form-control" id="quantity" value="1" /></div>
                                        <i class="fa fa-minus" style="float: left; margin-top: 10px;" onclick="complect.quantity.minus('<?php echo $product['product_id']; ?>')"></i>
                                    </div>
                                </div>
                                <div class="add-complect">
                                    <label for="add_complect">Добавить в комплект</label>
                                    <input type="checkbox" id="add_complect" onclick="complect.add('<?php echo $product['product_id']; ?>')">
                                </div>
                            </div>
                        </div>
                    <?php } ?>
                </div>
            </div>
              <script>
                  $(function() {
                      checkProducts();
                      $('#cart_modal').on('hidden.bs.modal', function (e) {
                          checkProducts();
                      });
                  });

                  var complect = {
                      add: function(id) {
                          if(!$('#complect_products #product_' + id + ' #add_complect').prop("checked")) {
                              $('#complect_products #product_' + id).removeClass('selected');
                              var key = $('#complect_products #product_' + id + ' #quantity').attr('data-product-key');
                              cart.remove(key);
                              foooterBuy();
                          } else {
                              $('#complect_products #product_' + id).addClass('selected');

                              updateCount();

                              var quantity = $('#complect_products #product_' + id + ' #quantity').val();
                              var product_id = <?php echo $product_id; ?>;
                              var complect_product_id = id;
                              $.ajax({
                                  url: 'index.php?route=checkout/complect/add',
                                  type: 'post',
                                  data: {product_id: product_id, complect_product_id: complect_product_id, quantity: quantity},
                                  dataType: 'json',
                                  success: function(json) {
                                      if (json['success']) {
                                          $('#cart-total').html(json['total']);
                                          $('#cart > #cart_modal').load('index.php?route=common/cart/info #cart > #cart_modal > *', function () {$('.footer-buy .total').text($('#cart_modal #total').text()); $('input[name=telephone]').mask("+380 (999) 999-99-99");});
                                          checkProducts();
                                          foooterBuy();
                                      }
                                  }
                              });
                          }
                      },
                      quantity: {
                          plus: function(id) {
                              var input_quantity = $('#complect_products #product_' + id + ' #quantity');
                              var quantity = $(input_quantity).val();
                              ++quantity;
                              $(input_quantity).val(quantity);
                              updateCount();

                              if($(input_quantity).attr('data-product-key')) {
                                  var key = $(input_quantity).attr('data-product-key');
                                  cart.quantity.update(key, quantity);
                                  checkProducts();
                                  foooterBuy();
                              }
                          },
                          minus: function(id) {
                              var input_quantity = $('#complect_products #product_' + id + ' #quantity');
                              var quantity = $(input_quantity).val();
                              if(quantity == 1) {
                                  $(input_quantity).val(quantity);
                              }
                              else {
                                  --quantity;
                                  $(input_quantity).val(quantity);
                                  updateCount();
                              }

                              if($(input_quantity).attr('data-product-key')) {
                                  if($(input_quantity).attr('data-product-key')) {
                                      var key = $(input_quantity).attr('data-product-key');
                                      cart.quantity.update(key, quantity);
                                      checkProducts();
                                      foooterBuy();
                                  }
                              }
                          }
                      },
                      all: function() {
                          var complect = $('#complect_products');
                          $(complect).find('.product-thumb').each(function(index, element) {
                              if(!$(element).find('#add_complect').prop('checked')) {
                                  $(element).find('#add_complect').trigger('click');
                              }
                              if(!$('#complect #select_all').prop('checked')) {
                                  $(element).find('#add_complect').trigger('click');
                              }
                          });
                          updateCount();
                          checkProducts();
                          foooterBuy();
                      }
                  }

                  function updateCount() {
                      var count = $('#complect_products .product-thumb #add_complect:checked').length;
                      $('#complect > h2 span#count').text(count);
                  }

                  function checkProducts() {
                      $.ajax({
                          url: 'index.php?route=checkout/complect/get_added_products',
                          dataType: 'json',
                          success: function(json) {
                              for(var key in json) {
                                  $('#complect_products #product_' + json[key].product_id + ' #quantity').val(json[key].quantity);
                                  $('#complect_products #product_' + json[key].product_id + ' #quantity').attr('data-product-key', json[key].key);
                                  $('#complect_products #product_' + json[key].product_id + ' #add_complect').attr('checked', 'true');
                                  $('#complect_products #product_' + json[key].product_id).addClass('selected');
                              }
                          }
                      });
                  }

              </script>
          <?php } ?>
          <div class="col-sm-12">
              <ul class="nav nav-tabs">
                  <li class="active"><a href="#tab-all" data-toggle="tab"><?php echo $tab_all; ?></a></li>
                  <li><a href="#tab-description" data-toggle="tab"><?php echo $tab_description; ?></a></li>
                  <?php if ($attribute_groups) { ?>
                      <li><a href="#tab-specification" data-toggle="tab"><?php echo $tab_attribute; ?></a></li>
                  <?php } ?>
                  <?php if ($review_status) { ?>
                      <li><a href="#tab-review" data-toggle="tab"><?php echo $tab_review; ?></a></li>
                  <?php } ?>
              </ul>
              <div class="tab-content">
                  <div class="tab-pane active" id="tab-all">

                  </div>
                  <div class="tab-pane" id="tab-description"><?php echo $description; ?></div>
                  <?php if ($attribute_groups) { ?>
                      <div class="tab-pane" id="tab-specification">
                          <table class="table table-bordered">
                              <?php foreach ($attribute_groups as $attribute_group) { ?>
                                  <thead>
                                  <tr>
                                      <td colspan="2"><strong><?php echo $attribute_group['name']; ?></strong></td>
                                  </tr>
                                  </thead>
                                  <tbody>
                                  <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
                                      <tr>
                                          <td><?php echo $attribute['name']; ?></td>
                                          <td><?php echo $attribute['text']; ?></td>
                                      </tr>
                                  <?php } ?>
                                  </tbody>
                              <?php } ?>
                          </table>
                      </div>
                  <?php } ?>
                  <?php if ($review_status) { ?>
                      <div class="tab-pane" id="tab-review">
                          <form class="form-horizontal">
                              <div id="review"></div>
                              <h2><?php echo $text_write; ?></h2>
                              <?php if ($review_guest) { ?>
                                  <div class="form-group required">
                                      <div class="col-sm-12">
                                          <label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
                                          <input type="text" name="name" value="" id="input-name" class="form-control"/>
                                      </div>
                                  </div>
                                  <div class="form-group required">
                                      <div class="col-sm-12">
                                          <label class="control-label" for="input-review"><?php echo $entry_review; ?></label>
                                          <textarea name="text" rows="5" id="input-review" class="form-control"></textarea>

                                          <div class="help-block"><?php echo $text_note; ?></div>
                                      </div>
                                  </div>
                                  <div class="form-group required">
                                      <div class="col-sm-12">
                                          <label class="control-label"><?php echo $entry_rating; ?></label>
                                          &nbsp;&nbsp;&nbsp; <?php echo $entry_bad; ?>&nbsp;
                                          <input type="radio" name="rating" value="1"/>
                                          &nbsp;
                                          <input type="radio" name="rating" value="2"/>
                                          &nbsp;
                                          <input type="radio" name="rating" value="3"/>
                                          &nbsp;
                                          <input type="radio" name="rating" value="4"/>
                                          &nbsp;
                                          <input type="radio" name="rating" value="5"/>
                                          &nbsp;<?php echo $entry_good; ?></div>
                                  </div>
                                  <div class="form-group required">
                                      <div class="col-sm-12">
                                          <label class="control-label" for="input-captcha"><?php echo $entry_captcha; ?></label>
                                          <input type="text" name="captcha" value="" id="input-captcha" class="form-control"/>
                                      </div>
                                  </div>
                                  <div class="form-group">
                                      <div class="col-sm-12"><img src="index.php?route=tool/captcha" alt="" id="captcha"/></div>
                                  </div>
                                  <div class="buttons">
                                      <div class="pull-right">
                                          <button type="button" id="button-review" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary"><?php echo $button_continue; ?></button>
                                      </div>
                                  </div>
                              <?php } else { ?>
                                  <?php echo $text_login; ?>
                              <?php } ?>
                          </form>
                      </div>
                  <?php } ?>
              </div>
          </div>
      <?php if ($products) { ?>
      <h3><?php echo $text_related; ?></h3>
      <div class="row related-slick">
        <?php $i = 0; ?>
        <?php foreach ($products as $product) { ?>
        <?php if ($column_left && $column_right) { ?>
        <?php $class = 'col-lg-6 col-md-6 col-sm-12 col-xs-12'; ?>
        <?php } elseif ($column_left || $column_right) { ?>
        <?php $class = 'col-lg-4 col-md-4 col-sm-6 col-xs-12'; ?>
        <?php } else { ?>
        <?php $class = 'col-lg-3 col-md-3 col-sm-6 col-xs-12'; ?>
        <?php } ?>
        <div class="<?php echo $class; ?>">
          <div class="product-thumb transition">
            <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" /></a></div>
            <div class="caption">
              <h4><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
              <p><?php echo $product['description']; ?></p>
              <?php if ($product['rating']) { ?>
              <div class="rating">
                <?php for ($i = 1; $i <= 5; $i++) { ?>
                <?php if ($product['rating'] < $i) { ?>
                <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
                <?php } else { ?>
                <span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
                <?php } ?>
                <?php } ?>
              </div>
              <?php } ?>
              <?php if ($product['price']) { ?>
              <p class="price">
                <?php if (!$product['special']) { ?>
                <?php echo $product['price']; ?>
                <?php } else { ?>
                <span class="price-new"><?php echo $product['special']; ?></span> <span class="price-old"><?php echo $product['price']; ?></span>
                <?php } ?>
                <?php if ($product['tax']) { ?>
                <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
                <?php } ?>
              </p>
              <?php } ?>
            </div>
            <div class="button-group">
              <button type="button" onclick="cart.add('<?php echo $product['product_id']; ?>');"><span class="hidden-xs hidden-sm hidden-md"><?php echo $button_cart; ?></span> <i class="fa fa-shopping-cart"></i></button>
              <button type="button" data-toggle="tooltip" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-heart"></i></button>
              <button type="button" data-toggle="tooltip" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-exchange"></i></button>
            </div>
              <div class="dropdown-caption">
                  <?php if ($product['options']) { ?>
                      <div class="options clearfix">
                          <div class="option-select col-sm-6 pull-right">
                              <div class="name-select">Размеры</div>
                              <?php foreach ($product['options'] as $option) { ?>
                                  <?php if ($option['type'] == 'select') { ?>
                                      <div class="col-sm-4">
                                          <div class="name"><?php echo $option['name']; ?></div>
                                          <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                              <img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="pull-left"/>
                                              <div class="value"><?php echo $option_value['name']; ?>

                                                  <?php if ($option_value['price']) { ?>
                                                      <span>(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)</span>
                                                  <?php } ?>
                                              </div>
                                          <?php } ?>
                                      </div>
                                  <?php } ?>
                              <?php } ?>
                          </div>

                          <?php foreach ($product['options'] as $option) { ?>

                              <?php if ($option['type'] == 'image') { ?>
                                  <div class="option-image col-sm-6">
                                      <div class="name"><?php echo $option['name']; ?></div>
                                      <div class="wrapper-value clearfix">
                                          <?php foreach ($option['product_option_value'] as $option_value) { ?>

                                              <div class="value clearfix">
                                                  <img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>"/>
                                              </div>
                                          <?php } ?>
                                      </div>
                                  </div>
                              <?php } ?>
                          <?php } ?>
                      </div>
                  <?php } ?>

                  <button type="button" data-toggle="tooltip" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product['product_id']; ?>');" class="button-wishlist"><i></i><span>В список желаний</span></button>
                  <button type="button" data-toggle="tooltip" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product['product_id']; ?>');" class="button-compare"><i></i><span>Сравнить</span></button>

              </div> <!-- end dropdown-caption-->
          </div>
        </div>
        <?php if (($column_left && $column_right) && ($i % 2 == 0)) { ?>
        <div class="clearfix visible-md visible-sm"></div>
        <?php } elseif (($column_left || $column_right) && ($i % 3 == 0)) { ?>
        <div class="clearfix visible-md"></div>
        <?php } elseif ($i % 4 == 0) { ?>
        <div class="clearfix visible-md"></div>
        <?php } ?>
        <?php $i++; ?>
        <?php } ?>
      </div>
      <?php } ?>
      <?php if ($tags) { ?>
      <p><?php echo $text_tags; ?>
        <?php for ($i = 0; $i < count($tags); $i++) { ?>
        <?php if ($i < (count($tags) - 1)) { ?>
        <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>,
        <?php } else { ?>
        <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>
        <?php } ?>
        <?php } ?>
      </p>
      <?php } ?>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<script type="text/javascript"><!--
$('select[name=\'recurring_id\'], input[name="quantity"]').change(function(){
	$.ajax({
		url: 'index.php?route=product/product/getRecurringDescription',
		type: 'post',
		data: $('input[name=\'product_id\'], input[name=\'quantity\'], select[name=\'recurring_id\']'),
		dataType: 'json',
		beforeSend: function() {
			$('#recurring-description').html('');
		},
		success: function(json) {
			$('.alert, .text-danger').remove();

			if (json['success']) {
				$('#recurring-description').html(json['success']);
			}
		}
	});
});
//--></script>
<script type="text/javascript"><!--
$('#button-cart').on('click', function() {
	$.ajax({
		url: 'index.php?route=checkout/cart/add',
		type: 'post',
		data: $('#product input[type=\'text\'], #product input[type=\'hidden\'], #product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select, #product textarea'),
		dataType: 'json',
		beforeSend: function() {
			$('#button-cart').button('loading');
		},
		complete: function() {
			$('#button-cart').button('reset');
		},
		success: function(json) {
			$('.alert, .text-danger').remove();
			$('.form-group').removeClass('has-error');

			if (json['error']) {
				if (json['error']['option']) {
					for (i in json['error']['option']) {
						var element = $('#input-option' + i.replace('_', '-'));

						if (element.parent().hasClass('input-group')) {
							element.parent().after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
						} else {
							element.after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
						}
					}
				}

				if (json['error']['recurring']) {
					$('select[name=\'recurring_id\']').after('<div class="text-danger">' + json['error']['recurring'] + '</div>');
				}

				// Highlight any found errors
				$('.text-danger').parent().addClass('has-error');
			}

			if (json['success']) {
				$('#cart-total').html(json['total']);
                $('#cart > #cart_modal').load('index.php?route=common/cart/info #cart > #cart_modal > *', function () {$('.footer-buy .total').text($('#cart_modal #total').text()); $('input[name=telephone]').mask("+380 (999) 999-99-99");});
                $('#cart > #cart_modal').modal('show');
			}
		}
	});
});
//--></script>
<script type="text/javascript"><!--
$('.date').datetimepicker({
	pickTime: false
});

$('.datetime').datetimepicker({
	pickDate: true,
	pickTime: true
});

$('.time').datetimepicker({
	pickDate: false
});

$('button[id^=\'button-upload\']').on('click', function() {
	var node = this;

	$('#form-upload').remove();

	$('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');

	$('#form-upload input[name=\'file\']').trigger('click');

	timer = setInterval(function() {
		if ($('#form-upload input[name=\'file\']').val() != '') {
			clearInterval(timer);

			$.ajax({
				url: 'index.php?route=tool/upload',
				type: 'post',
				dataType: 'json',
				data: new FormData($('#form-upload')[0]),
				cache: false,
				contentType: false,
				processData: false,
				beforeSend: function() {
					$(node).button('loading');
				},
				complete: function() {
					$(node).button('reset');
				},
				success: function(json) {
					$('.text-danger').remove();

					if (json['error']) {
						$(node).parent().find('input').after('<div class="text-danger">' + json['error'] + '</div>');
					}

					if (json['success']) {
						alert(json['success']);

						$(node).parent().find('input').attr('value', json['code']);
					}
				},
				error: function(xhr, ajaxOptions, thrownError) {
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
			});
		}
	}, 500);
});
//--></script>
<script type="text/javascript"><!--
$('#review').delegate('.pagination a', 'click', function(e) {
  e.preventDefault();

    $('#review').fadeOut('slow');

    $('#review').load(this.href);

    $('#review').fadeIn('slow');
});

$('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>',
    function() {
        reviewReply();
    }
);

$('#button-review').on('click', function() {
    var parent = "";
    var parent_val = $('#tab-review input[name=\'parent\']').val();
    if(parent_val.length > 0) {
        parent += '&parent_id=' + parent_val;
    }

	$.ajax({
		url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
		type: 'post',
		dataType: 'json',
		data: 'name=' + encodeURIComponent($('#tab-review input[name=\'name\']').val()) + '&text=' + encodeURIComponent($('#tab-review textarea[name=\'text\']').val()) + '&rating=' + encodeURIComponent($('#tab-review input[name=\'rating\']:checked').val() ? $('#tab-review input[name=\'rating\']:checked').val() : '') + '&captcha=' + encodeURIComponent($('#tab-review input[name=\'captcha\']').val()) + parent,
		beforeSend: function() {
			$('#button-review').button('loading');
		},
		complete: function() {
			$('#button-review').button('reset');
			$('#captcha').attr('src', 'index.php?route=tool/captcha#'+new Date().getTime());
			$('input[name=\'captcha\']').val('');
		},
		success: function(json) {
			$('.alert-success, .alert-danger').remove();

			if (json['error']) {
				$('#tab-review #review').after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
			}

			if (json['success']) {
				$('#tab-review #review').after('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');

				$('#tab-review input[name=\'name\']').val('');
				$('#tab-review textarea[name=\'text\']').val('');
				$('#tab-review input[name=\'rating\']:checked').prop('checked', false);
				$('#tab-review input[name=\'captcha\']').val('');
			}
		}
	});
});

$(document).ready(function() {
	$('.thumbnails').magnificPopup({
		type:'image',
		delegate: 'a',
		gallery: {
			enabled:true
		}
	});
});
//--></script>


    <script>
        $(function() {
            $(window).scroll(function() {
                foooterBuy();
            });

            $('#cart_modal').on('hidden.bs.modal', function (e) {
                foooterBuy();
            });
        });

        function foooterBuy() {
            var total = $('#cart_modal #total');
            if($(total).text() !== "") {
                $('.footer-buy .total').text(total.text());
                scroll_t = $(this).scrollTop();
                if (scroll_t > 100) {
                    $('.footer-buy').removeClass('hidden');
                } else {
                    $('.footer-buy').addClass('hidden');
                }
            }
            else {
                $('.footer-buy').addClass('hidden');
            }
        }
    </script>

    <script>
        $(function() {
            var description = $('#tab-description').html();

            var specification = "";
            if($('#tab-specification').length > 0) {
                var specification = $('#tab-specification').html();
            }

            var right_column = "";
            var left_column = "";

            if(specification !== "" ){
                left_column = '<div class="col-sm-7"><div id="all-description"><h4><?php echo $tab_description; ?></h4><div>' + description + '</div></div><div class="all-review"><h4><?php echo $tab_review; ?></h4><div></div></div></div>';
                right_column = '<div class="col-sm-5"><h4><?php echo $tab_attribute; ?></h4><div>' + specification + '</div></div>';
            }
            else {
                left_column = '<div class="col-sm-12"><div id="all-description"><h4><?php echo $tab_description; ?></h4><div>' + description + '</div></div><div class="all-review"><h4><?php echo $tab_review; ?></h4><div></div></div></div>';
            }

            $('#tab-all').html(left_column + right_column);

            $('.all-review div').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>',
                function() {
                    reviewReply();
                }
            );
        });
    </script>

    <script>
        function reviewReply () {
            $('.review-reply').on('click', function() {
                var parent_id = $(this).attr('data-parent-id');

                var scroll_el = $('#tab-review h2');
                $(scroll_el).after('<input type="hidden" name="parent" value="' + parent_id + '" />');

                $('a[href=\'#tab-review\']').trigger('click');

                if ($(scroll_el).length != 0) {
                    $('html, body').animate({ scrollTop: $(scroll_el).offset().top }, 500);
                }
            });
        }
    </script>

    <div class="footer-buy hidden">
        <span class="total"></span>
        <button class="btn btn-default footer-button-buy" type="button" data-target="#cart_modal" data-toggle="modal"><?php echo $button_cart; ?></button>
    </div>



    <script src="catalog/view/javascript/selectordie.js" type="text/javascript"></script>
    <script>
        $(function() {
            $('#product select.form-control').selectOrDie();
        });
    </script>


    <script type="text/javascript">
        $(function () {
            $('.related-slick').slick({
                accessibility: true,
                arrows: true,
                draggable: true,
                infinite: true,
                pauseOnHover: true,
                pauseOnDotsHover: true,
                slidesToShow: 4,
                slidesToScroll: 1,
                responsive: [
                    {
                        breakpoint: 1024,
                        settings: {
                            slidesToShow: 3
                        }
                    },
                    {
                        breakpoint: 600,
                        settings: {
                            slidesToShow: 2
                        }
                    },
                    {
                        breakpoint: 480,
                        settings: {
                            slidesToShow: 1
                        }
                    },
                ]
            });
        });
    </script>


    <?php if ($options) { ?>
        <div class="modal proposition-options" id="proposition_product_options_<?php echo $main_product['product_id']; ?>" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title"><?php echo $text_option; ?></h4>
                    </div>
                    <div class="modal-body">
                        <?php foreach ($options as $option) { ?>
                            <?php if ($option['type'] == 'select') { ?>
                                <div class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                                    <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                                    <select name="option[<?php echo $option['product_option_id']; ?>]" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control">
                                        <option value=""><?php echo $text_select; ?></option>
                                        <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                            <option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                                                <?php if ($option_value['price']) { ?>
                                                    (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                                <?php } ?>
                                            </option>
                                        <?php } ?>
                                    </select>
                                </div>
                            <?php } ?>
                            <?php if ($option['type'] == 'radio') { ?>
                                <div class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                                    <label class="control-label"><?php echo $option['name']; ?></label>

                                    <div id="input-option<?php echo $option['product_option_id']; ?>">
                                        <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>"/>
                                                    <?php echo $option_value['name']; ?>
                                                    <?php if ($option_value['price']) { ?>
                                                        (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                                    <?php } ?>
                                                </label>
                                            </div>
                                        <?php } ?>
                                    </div>
                                </div>
                            <?php } ?>
                            <?php if ($option['type'] == 'checkbox') { ?>
                                <div class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                                    <label class="control-label"><?php echo $option['name']; ?></label>

                                    <div id="input-option<?php echo $option['product_option_id']; ?>">
                                        <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>"/>
                                                    <?php echo $option_value['name']; ?>
                                                    <?php if ($option_value['price']) { ?>
                                                        (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                                    <?php } ?>
                                                </label>
                                            </div>
                                        <?php } ?>
                                    </div>
                                </div>
                            <?php } ?>
                            <?php if ($option['type'] == 'image') { ?>
                                <div class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                                    <label class="control-label"><?php echo $option['name']; ?></label>

                                    <div id="input-option<?php echo $option['product_option_id']; ?>">
                                        <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>"/>
                                                    <img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>"
                                                         class="img-thumbnail"/> <?php echo $option_value['name']; ?>
                                                    <?php if ($option_value['price']) { ?>
                                                        (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                                    <?php } ?>
                                                </label>
                                            </div>
                                        <?php } ?>
                                    </div>
                                </div>
                            <?php } ?>
                            <?php if ($option['type'] == 'text') { ?>
                                <div class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                                    <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                                    <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" placeholder="<?php echo $option['name']; ?>"
                                           id="input-option<?php echo $option['product_option_id']; ?>" class="form-control"/>
                                </div>
                            <?php } ?>
                            <?php if ($option['type'] == 'textarea') { ?>
                                <div class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                                    <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                                    <textarea name="option[<?php echo $option['product_option_id']; ?>]" rows="5" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>"
                                              class="form-control"><?php echo $option['value']; ?></textarea>
                                </div>
                            <?php } ?>
                            <?php if ($option['type'] == 'file') { ?>
                                <div class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                                    <label class="control-label"><?php echo $option['name']; ?></label>
                                    <button type="button" id="button-upload<?php echo $option['product_option_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default btn-block"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
                                    <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" id="input-option<?php echo $option['product_option_id']; ?>"/>
                                </div>
                            <?php } ?>
                            <?php if ($option['type'] == 'date') { ?>
                                <div class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                                    <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>

                                    <div class="input-group date">
                                        <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control"/>
                                        <span class="input-group-btn">
                                            <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                                        </span>
                                    </div>
                                </div>
                            <?php } ?>
                            <?php if ($option['type'] == 'datetime') { ?>
                                <div class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                                    <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>

                                    <div class="input-group datetime">
                                        <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control"/>
                                        <span class="input-group-btn">
                                            <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                                        </span>
                                    </div>
                                </div>
                            <?php } ?>
                            <?php if ($option['type'] == 'time') { ?>
                                <div class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                                    <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>

                                    <div class="input-group time">
                                        <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control"/>
                                        <span class="input-group-btn">
                                            <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                                        </span>
                                    </div>
                                </div>
                            <?php } ?>
                        <?php } ?>
                    </div>
                </div>
            </div>
        </div>
    <?php } ?>

    <?php
    foreach ($propositions as $proposition_id => $proposition) {
        foreach ($proposition['products'] as $product) {
            if ($product['options']) {
                ?>
                <div class="modal proposition-options" id="proposition_product_options_<?php echo $product['product_id']; ?>" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title"><?php echo $text_option; ?></h4>
                            </div>
                            <div class="modal-body">
                                <?php foreach ($product['options'] as $option) { ?>
                                    <?php if ($option['type'] == 'select') { ?>
                                        <div class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                                            <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                                            <select name="option[<?php echo $option['product_option_id']; ?>]" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control">
                                                <option value=""><?php echo $text_select; ?></option>
                                                <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                                    <option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                                                        <?php if ($option_value['price']) { ?>
                                                            (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                                        <?php } ?>
                                                    </option>
                                                <?php } ?>
                                            </select>
                                        </div>
                                    <?php } ?>
                                    <?php if ($option['type'] == 'radio') { ?>
                                        <div class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                                            <label class="control-label"><?php echo $option['name']; ?></label>

                                            <div id="input-option<?php echo $option['product_option_id']; ?>">
                                                <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                                    <div class="radio">
                                                        <label>
                                                            <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>"/>
                                                            <?php echo $option_value['name']; ?>
                                                            <?php if ($option_value['price']) { ?>
                                                                (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                                            <?php } ?>
                                                        </label>
                                                    </div>
                                                <?php } ?>
                                            </div>
                                        </div>
                                    <?php } ?>
                                    <?php if ($option['type'] == 'checkbox') { ?>
                                        <div class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                                            <label class="control-label"><?php echo $option['name']; ?></label>

                                            <div id="input-option<?php echo $option['product_option_id']; ?>">
                                                <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                                    <div class="checkbox">
                                                        <label>
                                                            <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>"/>
                                                            <?php echo $option_value['name']; ?>
                                                            <?php if ($option_value['price']) { ?>
                                                                (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                                            <?php } ?>
                                                        </label>
                                                    </div>
                                                <?php } ?>
                                            </div>
                                        </div>
                                    <?php } ?>
                                    <?php if ($option['type'] == 'image') { ?>
                                        <div class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                                            <label class="control-label"><?php echo $option['name']; ?></label>

                                            <div id="input-option<?php echo $option['product_option_id']; ?>">
                                                <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                                    <div class="radio">
                                                        <label>
                                                            <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>"/>
                                                            <img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail"/> <?php echo $option_value['name']; ?>
                                                            <?php if ($option_value['price']) { ?>
                                                                (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                                            <?php } ?>
                                                        </label>
                                                    </div>
                                                <?php } ?>
                                            </div>
                                        </div>
                                    <?php } ?>
                                    <?php if ($option['type'] == 'text') { ?>
                                        <div class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                                            <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                                            <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control"/>
                                        </div>
                                    <?php } ?>
                                    <?php if ($option['type'] == 'textarea') { ?>
                                        <div class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                                            <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                                            <textarea name="option[<?php echo $option['product_option_id']; ?>]" rows="5" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control"><?php echo $option['value']; ?></textarea>
                                        </div>
                                    <?php } ?>
                                    <?php if ($option['type'] == 'file') { ?>
                                        <div class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                                            <label class="control-label"><?php echo $option['name']; ?></label>
                                            <button type="button" id="button-upload<?php echo $option['product_option_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default btn-block"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
                                            <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" id="input-option<?php echo $option['product_option_id']; ?>"/>
                                        </div>
                                    <?php } ?>
                                    <?php if ($option['type'] == 'date') { ?>
                                        <div class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                                            <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>

                                            <div class="input-group date">
                                                <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control"/>
                                                <span class="input-group-btn">
                                                    <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                                                </span>
                                            </div>
                                        </div>
                                    <?php } ?>
                                    <?php if ($option['type'] == 'datetime') { ?>
                                        <div class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                                            <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>

                                            <div class="input-group datetime">
                                                <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control"/>
                                                <span class="input-group-btn">
                                                    <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                                                </span>
                                            </div>
                                        </div>
                                    <?php } ?>
                                    <?php if ($option['type'] == 'time') { ?>
                                        <div class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                                            <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>

                                            <div class="input-group time">
                                                <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control"/>
                                                <span class="input-group-btn">
                                                    <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                                                </span>
                                            </div>
                                        </div>
                                    <?php } ?>
                                <?php } ?>
                            </div>
                        </div>
                    </div>
                </div>
            <?php
            }
        }
    }
    ?>


    <script type="text/javascript">
        $(function () {
            $('.proposition-slick').slick({
                accessibility: true,
                arrows: true,
                draggable: true,
                infinite: true,
                pauseOnHover: true,
                pauseOnDotsHover: true,
                slidesToShow: 1,
                slidesToScroll: 1,
                adaptiveHeight: true
            });
        });

        var proposition = {
            options: function(id) {
                $('#proposition_product_options_' + id).modal('show');
            },
            add: function(proposition_id) {
                var products = {};
                $('#proposition_' + proposition_id + ' [data-product-id]').each(function(index, element) {
                    products[index] = {};
                    var product_id = $(element).attr('data-product-id');
                    var options = $('#proposition_product_options_' + product_id + ' input[type=\'text\'], #proposition_product_options_' + product_id + ' input[type=\'hidden\'], #proposition_product_options_' + product_id + ' input[type=\'radio\']:checked, #proposition_product_options_' + product_id + ' input[type=\'checkbox\']:checked, #proposition_product_options_' + product_id + ' select, #proposition_product_options_' + product_id + ' textarea').serialize();
                    console.log(options);
                    products[index]['product_id'] = product_id;
                    products[index]['options'] = options;
                    products[index]['proposition_id'] = proposition_id;
                });

                $.ajax({
                    url: 'index.php?route=checkout/proposition/add',
                    type: 'post',
                    data: products,
                    dataType: 'json',
                    success: function(json) {
                        $('.proposition-options .form-group').removeClass('has-error');
                        $('.alert').remove();

                        if(json['error']) {
                            if (json['error']['option']) {
                                $('.proposition-slick').before('<div class="clearfix"></div><div class="alert alert-danger" role="alert"><button type="button" class="close pull-right" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button><?php echo $error_proposition_options; ?></div>');
                                for (var product_id in json['error']['option']) {
                                    var product_name = $('#proposition_' + proposition_id + ' [data-product-id=' + product_id + '] h4').text();
                                    var errors = "";
                                    for (i in json['error']['option'][product_id]) {
                                        var element = $('#proposition_product_options_' + product_id + ' #input-option' + i.replace('_', '-'));

                                        if (element.parent().hasClass('input-group')) {
                                            element.parent().after('<div class="text-danger">' + json['error']['option'][product_id][i] + '</div>');
                                        } else {
                                            element.after('<div class="text-danger">' + json['error']['option'][product_id][i] + '</div>');
                                        }
                                        errors += json['error']['option'][product_id][i] + "<br />";
                                    }
                                    $('.proposition-slick').before('<div class="clearfix"></div><div class="alert alert-danger" role="alert"><button type="button" class="close pull-right" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button><strong>' + product_name + '</strong><br />' + errors + '</div>');

                                    // Highlight any found errors
                                    $('.text-danger').parent().addClass('has-error');
                                }
                                $('.proposition-slick').before('<div class="clearfix"></div><div class="alert alert-info" role="alert"><button type="button" class="close pull-right" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button><?php echo $text_proposition_option; ?></div>');
                            }
                        }

                        if (json['success']) {
                            $('#cart-total').html(json['total']);
                            $('#cart > #cart_modal').load('index.php?route=common/cart/info #cart > #cart_modal > *', function () {$('.footer-buy .total').text($('#cart_modal #total').text()); $('input[name=telephone]').mask("+380 (999) 999-99-99");});
                            $('#cart > #cart_modal').modal('show');
                        }
                    }
                });
            }
        };
    </script>
<?php echo $footer; ?>
