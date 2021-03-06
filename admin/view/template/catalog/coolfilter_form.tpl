<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <button type="submit" form="form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
                <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
            <h1><?php echo $heading_title; ?></h1>
            <ul class="breadcrumb">
                <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
                <?php } ?>
            </ul>
        </div>
    </div>
    <div class="container-fluid">
        <?php if ($error_warning) { ?>
            <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
                <button type="button" class="close" data-dismiss="alert">&times;</button>
            </div>
        <?php } ?>
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $heading_title; ?></h3>
            </div>
            <div class="panel-body">
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
                    <div class="form-group required">
                        <label class="col-sm-2 control-label"><?php echo $entry_name; ?></label>

                        <div class="col-sm-10">
                            <?php foreach ($languages as $language) { ?>
                                <div class="input-group">
                                    <span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>"/></span>
                                    <input type="text" name="category_option_description[<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($name[$language['language_id']]) ? $name[$language['language_id']]['name'] : ''; ?>"
                                           placeholder="<?php echo $entry_name; ?>" class="form-control"/>
                                </div>
                                <?php if (isset($error_name[$language['language_id']])) { ?>
                                    <div class="text-danger"><?php echo $error_name[$language['language_id']]; ?></div>
                                <?php } ?>
                            <?php } ?>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-type"><?php echo $entry_type; ?></label>

                        <div class="col-sm-10">
                            <select name="type" id="input-type">
                                <?php if ($types) { ?>
                                    <?php foreach ($type_groups as $group) { ?>
                                        <optgroup label="<?php echo $$group['text']; ?>">
                                            <?php foreach ($types[$group['value']] as $typeKey => $type) { ?>
                                                <option value="<?php echo $typeKey; ?>" <?php if ($option_types == $typeKey){ ?>selected="selected"<?php } ?>><?php echo $type['value'] ?></option>
                                            <?php } ?>
                                        </optgroup>
                                    <?php } ?>
                                <?php } ?>
                            </select>
                        </div>
                    </div>
                    <div class="form-group" id="style_tr">
                        <label class="col-sm-2 control-label" for="input-style"><?php echo $entry_style; ?></label>

                        <div class="col-sm-10" id="input-style">
                            <select name="style">
                                <?php if ($styles) { ?>
                                    <?php foreach ($styles as $styleKey => $style) { ?>
                                        <?php if ($styleKey == $option_styles) { ?>
                                            <option value="<?php echo $styleKey; ?>" selected="selected"><?php echo $style ?></option>
                                        <?php } else { ?>
                                            <option value="<?php echo $styleKey; ?>"><?php echo $style ?></option>
                                        <?php } ?>
                                    <?php } ?>
                                <?php } ?>
                            </select>
                        </div>

                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-coolfilter-groups"><?php echo $entry_coolfilter_groups; ?></label>

                        <div class="col-sm-10">
                            <div class="scrollbox">
                                <?php $class = 'odd'; ?>
                                <?php foreach ($coolfilter_groups as $coolfilter_group) { ?>
                                    <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                                    <div class="<?php echo $class; ?>">
                                        <?php if (in_array($coolfilter_group['coolfilter_group_id'], $option_coolfilter_group)) { ?>
                                            <input type="checkbox" name="coolfilter_group_id[]" value="<?php echo $coolfilter_group['coolfilter_group_id']; ?>" checked="checked"/>
                                            <?php echo $coolfilter_group['name']; ?>
                                        <?php } else { ?>
                                            <input type="checkbox" name="coolfilter_group_id[]" value="<?php echo $coolfilter_group['coolfilter_group_id']; ?>"/>
                                            <?php echo $coolfilter_group['name']; ?>
                                        <?php } ?>
                                    </div>
                                <?php } ?>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-sort-order"><?php echo $entry_sort_order; ?></label>

                        <div class="col-sm-10">
                            <input type="text" name="sort_order" value="<?php echo $sort_order; ?>" placeholder="<?php echo $entry_sort_order; ?>" id="input-sort-order" class="form-control"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>

                        <div class="col-sm-10">
                            <select name="status" id="input-status" class="form-control">
                                <?php if ($status) { ?>
                                    <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                    <option value="0"><?php echo $text_disabled; ?></option>
                                <?php } else { ?>
                                    <option value="1"><?php echo $text_enabled; ?></option>
                                    <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                <?php } ?>
                            </select>
                        </div>
                    </div>
            </div>
            </form>
        </div>
    </div>
</div>
</div>

<?php echo $footer; ?>

<script>
    function checkPrice() {
        if ($("select[name='type']").val() == 'price') {
            $("#style_tr").hide();
        } else {
            $("#style_tr").show();
        }
    }

    checkPrice();

    $("select[name='type']").change(function () {
        checkPrice();
    });
</script>