<div class="wrapper wrapper-bestseller-home">
    <div class="content-home">
        <h3><?php echo $heading_title; ?></h3>
        <div class="row bestseller-slick">
            <?php foreach ($products as $product) { ?>
                <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                    <div class="product-thumb transition">
                        <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive"/></a></div>
                        <div class="caption clearfix">
                            <h4><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
                            <!-- <p><?php echo $product['description']; ?></p> -->
                            <!--<?php if ($product['rating']) { ?>
                                 <div class="rating">
                                    <?php for ($i = 1; $i <= 5; $i++) { ?>
                                        <?php if ($product['rating'] < $i) { ?>
                                            <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
                                        <?php } else { ?>
                                            <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
                                        <?php } ?>
                                    <?php } ?>
                                </div>
                            <?php } ?> -->
                            <?php if ($product['price']) { ?>
                                <div class="price">
                                    <?php if (!$product['special']) { ?>
                                        <?php echo $product['price']; ?>
                                    <?php } else { ?>
                                        <span class="price-old"><?php echo $product['price']; ?></span><span class="price-new"><?php echo $product['special']; ?></span> 
                                    <?php } ?>
                                    <?php if ($product['tax']) { ?>
                                        <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
                                    <?php } ?>
                            <?php } ?>
                            <button type="button" onclick="cart.add('<?php echo $product['product_id']; ?>');" class="button-buy"> <span class="hidden-xs"><?php echo $button_cart; ?></span><i class="shopping-cart"></i></button>

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
                    </div>
                </div>
            <?php } ?>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(function () {
        $('.bestseller-slick').slick({
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