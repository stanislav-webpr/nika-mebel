<div class="wrapper wrapper-category-home">
    <div class="content-home">
        <h3><?php echo $heading_title; ?></h3>
        <?php foreach ($categories as $category) { ?>
            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 text-center">
                <div class="image">
                    <a href="<?php echo $category['href']; ?>">
                        <img src="<?php echo $category['thumb']; ?>" alt="<?php echo $category['name']; ?>" title="<?php echo $category['name']; ?>" class="img-responsive center-block"/>
                    </a>
                </div>
                <a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
            </div>
        <?php } ?>
    </div>
</div>
