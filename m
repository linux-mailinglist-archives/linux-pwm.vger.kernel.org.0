Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05B7EE0F25
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2019 02:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732991AbfJWAW7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 22 Oct 2019 20:22:59 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37628 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729635AbfJWAW7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 22 Oct 2019 20:22:59 -0400
Received: by mail-pg1-f193.google.com with SMTP id p1so11002614pgi.4;
        Tue, 22 Oct 2019 17:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AJ99jQGb+gyxGLeVmGq3R/518oIhDBRezT3bHcS5bwc=;
        b=fpUMTiEaWeM95fnjPEalkDMXoldKdjnmmXGIoFsUkD2b+f6bpEo/B1VQI16oXvJDJL
         wZ6TP0cHcRJ6w2wFS8H0ddYUd1gpXFFJFnfthhc7BQCFcRE53H8wLxnSmhmH7d3P2Q6Z
         99ly6qLRfPKa10UWshwEHh7vOFZksGXVIBKKio56ZvVGlWzOC3YXQ/deqNeE/1TXdtiO
         q/n3CDEqZ+EI4fB5eKSE+O1xSNl4vKd82ail9R/RzxkGrUwHPS7T/aBuA7ue42GOgcKo
         SGqhkAFyyevR8ZMQ9/2TaGysDRGwG2S9DlKMJB022mMRE0sw2ss+m0vdApPbNogU5Yem
         E0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AJ99jQGb+gyxGLeVmGq3R/518oIhDBRezT3bHcS5bwc=;
        b=GM+QzG0XPRGUeShrIG3eQWcMI4qeYdbstg1DN90BUhx/W9T12raTSLEp9kA/7ax5KJ
         ee1RDGCqrgMIr0s4PNXd2vad/ZkQor50A5xWllRGaV2dkN9Fx93LSAORBgr9CsUs/ZSu
         J67CnEp02yfZcDMOJn1zvL4D9ZpI3d09e0G/2o37yQPPXlEqLhYFU5QU0Mbi6RbBcOum
         ++ZVG0SUdS43yQRRbx70UvN0kVFd62/fzixrSP6bd/rCC+QkEcyq3H26Nx1w7pLrlKOy
         srnpGXsM4d2Sp7hulYDKU6ve40hNoGlaQga2ULledLE7YqOf2E973869j8+N5n3wMJ8S
         E+hA==
X-Gm-Message-State: APjAAAVIjkzaIk9UQfPLMdllOkEKIqlBWrj+qi1yY4bMAKCrztXBp+J1
        ltb4ayN8hWAfCPCA2t8VoS4=
X-Google-Smtp-Source: APXvYqxN7grf4GC+/5Pmox4LrLszid2IfEG29K381JJ+640VYQ2OwNFy66LgfjlwdyxZv+LTH4E89w==
X-Received: by 2002:a63:6f02:: with SMTP id k2mr6908984pgc.163.1571790177722;
        Tue, 22 Oct 2019 17:22:57 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id r185sm21645894pfr.68.2019.10.22.17.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 17:22:56 -0700 (PDT)
Date:   Tue, 22 Oct 2019 17:22:54 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     lee.jones@linaro.org, jdelvare@suse.com, linux@roeck-us.net,
        thierry.reding@gmail.com, jic23@kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-hwmon@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Subject: Re: [PATCH 3/8] input: keyboard: Add support for Azoteq
 IQS620A/621/622/624/625
Message-ID: <20191023002254.GW35946@dtor-ws>
References: <1571631083-4962-1-git-send-email-jeff@labundy.com>
 <1571631083-4962-4-git-send-email-jeff@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571631083-4962-4-git-send-email-jeff@labundy.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Jeff,

On Sun, Oct 20, 2019 at 11:11:18PM -0500, Jeff LaBundy wrote:
> This patch adds touch key support for six-channel members of the
> Azoteq ProxFusion family of sensor devices.
> 
> Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> ---
>  drivers/input/keyboard/Kconfig       |  10 ++
>  drivers/input/keyboard/Makefile      |   1 +
>  drivers/input/keyboard/iqs62x-keys.c | 340 +++++++++++++++++++++++++++++++++++
>  3 files changed, 351 insertions(+)
>  create mode 100644 drivers/input/keyboard/iqs62x-keys.c
> 
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index 8911bc2..ab10aff 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -657,6 +657,16 @@ config KEYBOARD_IPAQ_MICRO
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ipaq-micro-keys.
>  
> +config KEYBOARD_IQS62X
> +	tristate "Azoteq IQS620A/621/622/624/625 touch keys"
> +	depends on MFD_IQS62X
> +	help
> +	  Say Y here to enable touch-key support for six-channel members of
> +	  the Azoteq ProxFusion family of sensor devices.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called iqs62x-keys.
> +
>  config KEYBOARD_OMAP
>  	tristate "TI OMAP keypad support"
>  	depends on ARCH_OMAP1
> diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
> index 9510325..ee85b7f 100644
> --- a/drivers/input/keyboard/Makefile
> +++ b/drivers/input/keyboard/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_KEYBOARD_TCA8418)		+= tca8418_keypad.o
>  obj-$(CONFIG_KEYBOARD_HIL)		+= hil_kbd.o
>  obj-$(CONFIG_KEYBOARD_HIL_OLD)		+= hilkbd.o
>  obj-$(CONFIG_KEYBOARD_IPAQ_MICRO)	+= ipaq-micro-keys.o
> +obj-$(CONFIG_KEYBOARD_IQS62X)		+= iqs62x-keys.o
>  obj-$(CONFIG_KEYBOARD_IMX)		+= imx_keypad.o
>  obj-$(CONFIG_KEYBOARD_HP6XX)		+= jornada680_kbd.o
>  obj-$(CONFIG_KEYBOARD_HP7XX)		+= jornada720_kbd.o
> diff --git a/drivers/input/keyboard/iqs62x-keys.c b/drivers/input/keyboard/iqs62x-keys.c
> new file mode 100644
> index 0000000..9d929f1
> --- /dev/null
> +++ b/drivers/input/keyboard/iqs62x-keys.c
> @@ -0,0 +1,340 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Azoteq IQS620A/621/622/624/625 Touch Keys
> + *
> + * Copyright (C) 2019
> + * Author: Jeff LaBundy <jeff@labundy.com>
> + */
> +
> +#include <linux/device.h>
> +#include <linux/input.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/iqs62x.h>
> +#include <linux/module.h>
> +#include <linux/notifier.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +enum {
> +	IQS62X_SW_HALL_N,
> +	IQS62X_SW_HALL_S,
> +};
> +
> +static const char * const iqs62x_switch_names[] = {
> +	[IQS62X_SW_HALL_N] = "hall_switch_north",
> +	[IQS62X_SW_HALL_S] = "hall_switch_south",
> +};
> +
> +struct iqs62x_switch_desc {
> +	enum iqs62x_event_flag flag;
> +	unsigned int code;
> +	bool enabled;
> +};
> +
> +struct iqs62x_keys_private {
> +	struct iqs62x_core *iqs62x;
> +	struct input_dev *input;
> +	struct notifier_block notifier;
> +	struct iqs62x_switch_desc switches[ARRAY_SIZE(iqs62x_switch_names)];
> +	unsigned int keycode[IQS62X_NUM_KEYS];
> +	unsigned int keycodemax;
> +	u8 interval;
> +};
> +
> +static int iqs62x_keys_parse_prop(struct platform_device *pdev,
> +				  struct iqs62x_keys_private *iqs62x_keys)
> +{
> +	struct device_node *keys_node = pdev->dev.of_node;
> +	struct device_node *hall_node;
> +	unsigned int val;
> +	int ret, i;
> +
> +	if (!keys_node)
> +		return 0;
> +
> +	ret = of_property_read_variable_u32_array(keys_node, "linux,keycodes",
> +						  iqs62x_keys->keycode, 0,
> +						  IQS62X_NUM_KEYS);

I do not think this has to be OF-specific, so please use
device_property_*() API.

> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to read keycodes: %d\n", ret);
> +		return ret;
> +	}
> +	iqs62x_keys->keycodemax = ret;
> +
> +	for (i = 0; i < ARRAY_SIZE(iqs62x_keys->switches); i++) {
> +		hall_node = of_get_child_by_name(keys_node,
> +						 iqs62x_switch_names[i]);
> +		if (!hall_node)
> +			continue;
> +
> +		ret = of_property_read_u32(hall_node, "linux,code", &val);
> +		if (ret < 0) {
> +			dev_err(&pdev->dev, "Failed to read switch code: %d\n",
> +				ret);
> +			of_node_put(hall_node);
> +			return ret;
> +		}
> +
> +		if (of_property_read_bool(hall_node, "azoteq,use-prox"))
> +			iqs62x_keys->switches[i].flag = (i == IQS62X_SW_HALL_N ?
> +							 IQS62X_EVENT_HALL_N_P :
> +							 IQS62X_EVENT_HALL_S_P);
> +		else
> +			iqs62x_keys->switches[i].flag = (i == IQS62X_SW_HALL_N ?
> +							 IQS62X_EVENT_HALL_N_T :
> +							 IQS62X_EVENT_HALL_S_T);
> +
> +		iqs62x_keys->switches[i].code = val;
> +		iqs62x_keys->switches[i].enabled = true;
> +
> +		of_node_put(hall_node);
> +	}
> +
> +	return 0;
> +}
> +
> +static int iqs62x_keys_init(struct iqs62x_keys_private *iqs62x_keys)
> +{
> +	struct iqs62x_core *iqs62x = iqs62x_keys->iqs62x;
> +	enum iqs62x_event_flag flag;
> +	unsigned int event_mask_reg;
> +	unsigned int event_mask = 0;
> +	unsigned int val;
> +	int error, i;
> +
> +	switch (iqs62x->dev_desc->prod_num) {
> +	case IQS620_PROD_NUM:
> +	case IQS621_PROD_NUM:
> +	case IQS622_PROD_NUM:
> +		event_mask_reg = IQS620_GLBL_EVENT_MASK;
> +
> +		/*
> +		 * Discreet button, hysteresis and SAR UI flags represent keys
> +		 * and are unmasked if mapped to a valid keycode.
> +		 */
> +		for (i = 0; i < iqs62x_keys->keycodemax; i++) {
> +			if (iqs62x_keys->keycode[i] == KEY_RESERVED)
> +				continue;
> +
> +			if (iqs62x_events[i].reg == IQS62X_EVENT_PROX)
> +				event_mask |= iqs62x->dev_desc->prox_mask;
> +			else if (iqs62x_events[i].reg == IQS62X_EVENT_HYST)
> +				event_mask |= (iqs62x->dev_desc->hyst_mask |
> +					       iqs62x->dev_desc->sar_mask);
> +		}
> +
> +		error = regmap_read(iqs62x->map, iqs62x->dev_desc->hall_flags,
> +				    &val);
> +		if (error)
> +			return error;
> +
> +		/*
> +		 * Hall UI flags represent switches and are unmasked if their
> +		 * corresponding child nodes are present.
> +		 */
> +		for (i = 0; i < ARRAY_SIZE(iqs62x_keys->switches); i++) {
> +			if (!(iqs62x_keys->switches[i].enabled))
> +				continue;
> +
> +			flag = iqs62x_keys->switches[i].flag;
> +
> +			if (iqs62x_events[flag].reg != IQS62X_EVENT_HALL)
> +				continue;
> +
> +			event_mask |= iqs62x->dev_desc->hall_mask;
> +
> +			input_report_switch(iqs62x_keys->input,
> +					    iqs62x_keys->switches[i].code,
> +					    (val & iqs62x_events[flag].mask) ==
> +					    iqs62x_events[flag].val);
> +		}
> +
> +		input_sync(iqs62x_keys->input);
> +		break;
> +
> +	case IQS624_PROD_NUM:
> +		event_mask_reg = IQS624_HALL_UI;
> +
> +		/*
> +		 * Interval change events represent keys and are unmasked if
> +		 * either wheel movement flag is mapped to a valid keycode.
> +		 */
> +		if (iqs62x_keys->keycode[IQS62X_EVENT_WHEEL_UP] != KEY_RESERVED)
> +			event_mask |= IQS624_HALL_UI_INT_EVENT;
> +
> +		if (iqs62x_keys->keycode[IQS62X_EVENT_WHEEL_DN] != KEY_RESERVED)
> +			event_mask |= IQS624_HALL_UI_INT_EVENT;
> +
> +		error = regmap_read(iqs62x->map, iqs62x->dev_desc->interval,
> +				    &val);
> +		if (error)
> +			return error;
> +
> +		iqs62x_keys->interval = val;
> +		break;
> +
> +	default:
> +		return 0;
> +	}
> +
> +	return regmap_update_bits(iqs62x->map, event_mask_reg, event_mask, 0);
> +}
> +
> +static int iqs62x_keys_notifier(struct notifier_block *notifier,
> +				unsigned long event_flags, void *context)
> +{
> +	struct iqs62x_event_data *event_data = context;
> +	struct iqs62x_keys_private *iqs62x_keys;
> +	int error, i;
> +
> +	iqs62x_keys = container_of(notifier, struct iqs62x_keys_private,
> +				   notifier);
> +
> +	if (event_flags & BIT(IQS62X_EVENT_SYS_RESET)) {
> +		error = iqs62x_keys_init(iqs62x_keys);
> +		if (error) {
> +			dev_err(iqs62x_keys->input->dev.parent,
> +				"Failed to re-initialize device: %d\n", error);
> +			return NOTIFY_BAD;
> +		}
> +
> +		return NOTIFY_OK;
> +	}
> +
> +	for (i = 0; i < iqs62x_keys->keycodemax; i++) {
> +		if (iqs62x_events[i].reg == IQS62X_EVENT_WHEEL &&
> +		    event_data->interval == iqs62x_keys->interval)
> +			continue;
> +
> +		input_report_key(iqs62x_keys->input, iqs62x_keys->keycode[i],
> +				 event_flags & BIT(i));
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(iqs62x_keys->switches); i++)
> +		if (iqs62x_keys->switches[i].enabled)
> +			input_report_switch(iqs62x_keys->input,
> +					    iqs62x_keys->switches[i].code,
> +					    event_flags &
> +					    BIT(iqs62x_keys->switches[i].flag));
> +
> +	input_sync(iqs62x_keys->input);
> +
> +	if (event_data->interval == iqs62x_keys->interval)
> +		return NOTIFY_OK;
> +
> +	/*
> +	 * Each frame contains at most one wheel event (up or down), in which
> +	 * case a full keystroke is emulated.
> +	 */
> +	if (event_flags & BIT(IQS62X_EVENT_WHEEL_UP)) {
> +		input_report_key(iqs62x_keys->input,
> +				 iqs62x_keys->keycode[IQS62X_EVENT_WHEEL_UP],
> +				 0);
> +		input_sync(iqs62x_keys->input);
> +	} else if (event_flags & BIT(IQS62X_EVENT_WHEEL_DN)) {
> +		input_report_key(iqs62x_keys->input,
> +				 iqs62x_keys->keycode[IQS62X_EVENT_WHEEL_DN],
> +				 0);

Not '1'?

> +		input_sync(iqs62x_keys->input);
> +	}
> +
> +	iqs62x_keys->interval = event_data->interval;
> +
> +	return NOTIFY_OK;
> +}
> +
> +static int iqs62x_keys_probe(struct platform_device *pdev)
> +{
> +	struct iqs62x_core *iqs62x = dev_get_drvdata(pdev->dev.parent);
> +	struct iqs62x_keys_private *iqs62x_keys;
> +	struct input_dev *input;
> +	int error, i;
> +
> +	iqs62x_keys = devm_kzalloc(&pdev->dev, sizeof(*iqs62x_keys),
> +				   GFP_KERNEL);
> +	if (!iqs62x_keys)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, iqs62x_keys);
> +
> +	error = iqs62x_keys_parse_prop(pdev, iqs62x_keys);
> +	if (error)
> +		return error;
> +
> +	input = devm_input_allocate_device(&pdev->dev);
> +	if (!input)
> +		return -ENOMEM;
> +
> +	input->keycodemax = iqs62x_keys->keycodemax;
> +	input->keycode = iqs62x_keys->keycode;
> +	input->keycodesize = sizeof(*iqs62x_keys->keycode);
> +
> +	input->name = iqs62x->dev_desc->dev_name;
> +	input->id.bustype = BUS_I2C;
> +
> +	__set_bit(EV_KEY, input->evbit);
> +
> +	for (i = 0; i < iqs62x_keys->keycodemax; i++)
> +		__set_bit(iqs62x_keys->keycode[i], input->keybit);
> +
> +	__clear_bit(KEY_RESERVED, input->keybit);
> +
> +	for (i = 0; i < ARRAY_SIZE(iqs62x_keys->switches); i++)
> +		if (iqs62x_keys->switches[i].enabled) {
> +			__set_bit(EV_SW, input->evbit);
> +			__set_bit(iqs62x_keys->switches[i].code, input->swbit);
> +		}
> +
> +	iqs62x_keys->iqs62x = iqs62x;
> +	iqs62x_keys->input = input;
> +
> +	error = iqs62x_keys_init(iqs62x_keys);
> +	if (error) {
> +		dev_err(&pdev->dev, "Failed to initialize device: %d\n", error);
> +		return error;
> +	}
> +
> +	error = input_register_device(iqs62x_keys->input);
> +	if (error) {
> +		dev_err(&pdev->dev, "Failed to register device: %d\n", error);
> +		return error;
> +	}
> +
> +	iqs62x_keys->notifier.notifier_call = iqs62x_keys_notifier;
> +	error = blocking_notifier_chain_register(&iqs62x_keys->iqs62x->nh,
> +						 &iqs62x_keys->notifier);
> +	if (error)
> +		dev_err(&pdev->dev, "Failed to register notifier: %d\n", error);
> +
> +	return error;
> +}
> +
> +static int iqs62x_keys_remove(struct platform_device *pdev)
> +{
> +	struct iqs62x_keys_private *iqs62x_keys = platform_get_drvdata(pdev);
> +	int error;
> +
> +	error = blocking_notifier_chain_unregister(&iqs62x_keys->iqs62x->nh,
> +						   &iqs62x_keys->notifier);
> +	if (error)
> +		dev_err(&pdev->dev,
> +			"Failed to unregister notifier: %d\n", error);
> +
> +	return error;
> +}
> +
> +static struct platform_driver iqs62x_keys_platform_driver = {
> +	.driver = {
> +		.name	= IQS62X_DRV_NAME_KEYS,
> +	},
> +	.probe		= iqs62x_keys_probe,
> +	.remove		= iqs62x_keys_remove,
> +};
> +module_platform_driver(iqs62x_keys_platform_driver);
> +
> +MODULE_AUTHOR("Jeff LaBundy <jeff@labundy.com>");
> +MODULE_DESCRIPTION("Azoteq IQS620A/621/622/624/625 Touch Keys");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:" IQS62X_DRV_NAME_KEYS);
> -- 
> 2.7.4
> 

Thanks.

-- 
Dmitry
