Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4C23141325
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2020 22:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgAQVdf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 17 Jan 2020 16:33:35 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40822 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQVde (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 17 Jan 2020 16:33:34 -0500
Received: by mail-pl1-f195.google.com with SMTP id s21so10359767plr.7;
        Fri, 17 Jan 2020 13:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wdp6cLJwlGdaiNgVZ7Oq+Sray4WTuyHCCJRXgdtyBAc=;
        b=GoPFcDUCxQafzsGDZGpN0UaUZxqmsRvqy9i3YmdfLB961xfWifkd6LXSzLEG8zr1or
         Gp8uDzjg+1sivte+xusXPCR2peQWTEV6MWAOCSNALFrZgCvZAiQYCjlSFDDrb4c5tPup
         XaMvVGAFR8SG7YspVUByfvC3NpM0dPXCAJrySwBGYySjm/gRiALLY8aS65U68XzGf776
         Sml/BlVEEdoDo1DmOU2iv92Hz6X0lIl9FRPPdnncOAXn3/HkUWtQBSdHcTaJZbNoKFmi
         EkQMugyjul3ZOeUBoLndXcYLr2/COC4K/6yjQ69C+2gGgolzDu/NBJ1/6UNENXtvCEDz
         7x/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wdp6cLJwlGdaiNgVZ7Oq+Sray4WTuyHCCJRXgdtyBAc=;
        b=t3PthZ6gfO0E1LO+b1ChilkWM0JVK6ht2K/xL+W8gJn7llADq0dg8bZzkZIZlW+xl7
         atXkZHZ67mZKVdoL2P+yU78LzTacT9PKpi6LParxVeKRbCZL1bnpFn6B6X/plnD1Whx4
         sxDkfpiSbzB5nCRYG+dta6A89WBlE/MhJIit4gZDhFc6wkIjWP6+h3p5c+v90QwTJap6
         DHrC3N2YC5kcFV+oMrh5xuXsE2RPOx2Ko03Ck8/nQ8S5wqWZX7lbxtoCCNH08iAxmQu+
         67qsekinRYtU7ZzsJjaaxaibQ+c0OAia6A3ZsVcTBfSrHSthtncM/WfSsmYngJeoOH/u
         1tLw==
X-Gm-Message-State: APjAAAUs9LKm6XUpLrjFXLTxR9ZVLDd9CAHqIKZdw3LW0c/5Pr2I0Yac
        YiZGpkMmt2wL/LHlCNUov0U=
X-Google-Smtp-Source: APXvYqyGEg2C78QqJ9gcxuqqLXXe62GWDIUUzySWaO4mU2ow0kPF8/uwMwqim2J74vrsUuWPDSwoyQ==
X-Received: by 2002:a17:902:7613:: with SMTP id k19mr1360737pll.7.1579296813676;
        Fri, 17 Jan 2020 13:33:33 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id y203sm31409362pfb.65.2020.01.17.13.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:33:32 -0800 (PST)
Date:   Fri, 17 Jan 2020 13:33:30 -0800
From:   "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: [PATCH v4 3/7] input: keyboard: Add support for Azoteq
 IQS620A/621/622/624/625
Message-ID: <20200117213330.GF47797@dtor-ws>
References: <1579228475-6681-1-git-send-email-jeff@labundy.com>
 <1579228475-6681-4-git-send-email-jeff@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579228475-6681-4-git-send-email-jeff@labundy.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Jeff,

On Fri, Jan 17, 2020 at 02:35:46AM +0000, Jeff LaBundy wrote:
> This patch adds key and switch support for the Azoteq IQS620A,
> IQS621, IQS622, IQS624 and IQS625 multi-function sensors.
> 
> Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> ---
> Changes in v4:
>   - None
> 
> Changes in v3:
>   - None
> 
> Changes in v2:
>   - Merged 'Copyright' and 'Author' lines into one in introductory comments
>   - Replaced 'error' with 'ret' throughout
>   - Updated iqs62x_keys_parse_prop to use unified device property interface
>   - Clarified the comment in iqs62x_keys_notifier to state that wheel up or
>     down events elicit an emulated release cycle
>   - Eliminated tabbed alignment of platform_driver struct members
> 
>  drivers/input/keyboard/Kconfig       |  10 ++
>  drivers/input/keyboard/Makefile      |   1 +
>  drivers/input/keyboard/iqs62x-keys.c | 340 +++++++++++++++++++++++++++++++++++
>  3 files changed, 351 insertions(+)
>  create mode 100644 drivers/input/keyboard/iqs62x-keys.c
> 
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index 4706ff0..28de965 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -663,6 +663,16 @@ config KEYBOARD_IPAQ_MICRO
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ipaq-micro-keys.
> 
> +config KEYBOARD_IQS62X
> +	tristate "Azoteq IQS620A/621/622/624/625 keys and switches"
> +	depends on MFD_IQS62X
> +	help
> +	  Say Y here to enable key and switch support for the Azoteq IQS620A,
> +	  IQS621, IQS622, IQS624 and IQS625 multi-function sensors.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called iqs62x-keys.
> +
>  config KEYBOARD_OMAP
>  	tristate "TI OMAP keypad support"
>  	depends on ARCH_OMAP1
> diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
> index f5b1752..1d689fd 100644
> --- a/drivers/input/keyboard/Makefile
> +++ b/drivers/input/keyboard/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_KEYBOARD_TCA8418)		+= tca8418_keypad.o
>  obj-$(CONFIG_KEYBOARD_HIL)		+= hil_kbd.o
>  obj-$(CONFIG_KEYBOARD_HIL_OLD)		+= hilkbd.o
>  obj-$(CONFIG_KEYBOARD_IPAQ_MICRO)	+= ipaq-micro-keys.o
> +obj-$(CONFIG_KEYBOARD_IQS62X)		+= iqs62x-keys.o
>  obj-$(CONFIG_KEYBOARD_IMX)		+= imx_keypad.o
>  obj-$(CONFIG_KEYBOARD_IMX_SC_KEY)	+= imx_sc_key.o
>  obj-$(CONFIG_KEYBOARD_HP6XX)		+= jornada680_kbd.o
> diff --git a/drivers/input/keyboard/iqs62x-keys.c b/drivers/input/keyboard/iqs62x-keys.c
> new file mode 100644
> index 0000000..b477334
> --- /dev/null
> +++ b/drivers/input/keyboard/iqs62x-keys.c
> @@ -0,0 +1,340 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Azoteq IQS620A/621/622/624/625 Keys and Switches
> + *
> + * Copyright (C) 2019 Jeff LaBundy <jeff@labundy.com>
> + */
> +
> +#include <linux/device.h>
> +#include <linux/input.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/iqs62x.h>
> +#include <linux/module.h>
> +#include <linux/notifier.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +enum {
> +	IQS62X_SW_HALL_N,
> +	IQS62X_SW_HALL_S,
> +};
> +
> +static const char * const iqs62x_switch_names[] = {
> +	[IQS62X_SW_HALL_N] = "hall-switch-north",
> +	[IQS62X_SW_HALL_S] = "hall-switch-south",
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
> +	struct fwnode_handle *child;
> +	unsigned int val;
> +	int ret, i;
> +
> +	ret = device_property_read_u32_array(&pdev->dev, "linux,keycodes",
> +					     NULL, 0);

You can use device_property_count_u32().

> +	if (ret > IQS62X_NUM_KEYS) {
> +		dev_err(&pdev->dev, "Too many keycodes present\n");
> +		return -EINVAL;
> +	} else if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to count keycodes: %d\n", ret);
> +		return ret;
> +	}
> +	iqs62x_keys->keycodemax = ret;
> +
> +	ret = device_property_read_u32_array(&pdev->dev, "linux,keycodes",
> +					     iqs62x_keys->keycode,
> +					     iqs62x_keys->keycodemax);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to read keycodes: %d\n", ret);
> +		return ret;
> +	}

I wonder why you can't simply use

	error = device_property_read_u32_array(&pdev->dev, "linux,keycodes",
						iqs62x_keys->keycode,
						IQS62X_NUM_KEYS);

Are you concerned with someone trying to set up keys that are not
actually exposed later via EVOCSKEYCODES and that is why you are
limiting keycodemax?

> +
> +	for (i = 0; i < ARRAY_SIZE(iqs62x_keys->switches); i++) {
> +		child = device_get_named_child_node(&pdev->dev,
> +						    iqs62x_switch_names[i]);
> +		if (!child)
> +			continue;
> +
> +		ret = fwnode_property_read_u32(child, "linux,code", &val);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Failed to read switch code: %d\n",
> +				ret);
> +			return ret;
> +		}
> +		iqs62x_keys->switches[i].code = val;
> +		iqs62x_keys->switches[i].enabled = true;
> +
> +		if (fwnode_property_present(child, "azoteq,use-prox"))
> +			iqs62x_keys->switches[i].flag = (i == IQS62X_SW_HALL_N ?
> +							 IQS62X_EVENT_HALL_N_P :
> +							 IQS62X_EVENT_HALL_S_P);
> +		else
> +			iqs62x_keys->switches[i].flag = (i == IQS62X_SW_HALL_N ?
> +							 IQS62X_EVENT_HALL_N_T :
> +							 IQS62X_EVENT_HALL_S_T);
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
> +	int ret, i;
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
> +		ret = regmap_read(iqs62x->map, iqs62x->dev_desc->hall_flags,
> +				  &val);
> +		if (ret)
> +			return ret;
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
> +		ret = regmap_read(iqs62x->map, iqs62x->dev_desc->interval,
> +				  &val);
> +		if (ret)
> +			return ret;
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
> +	int ret, i;
> +
> +	iqs62x_keys = container_of(notifier, struct iqs62x_keys_private,
> +				   notifier);
> +
> +	if (event_flags & BIT(IQS62X_EVENT_SYS_RESET)) {
> +		ret = iqs62x_keys_init(iqs62x_keys);
> +		if (ret) {
> +			dev_err(iqs62x_keys->input->dev.parent,
> +				"Failed to re-initialize device: %d\n", ret);
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
> +	 * case a complementary release cycle is emulated.
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
> +	int ret, i;
> +
> +	iqs62x_keys = devm_kzalloc(&pdev->dev, sizeof(*iqs62x_keys),
> +				   GFP_KERNEL);
> +	if (!iqs62x_keys)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, iqs62x_keys);
> +
> +	ret = iqs62x_keys_parse_prop(pdev, iqs62x_keys);
> +	if (ret)
> +		return ret;
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

input_set_capability(input, EV_SW, iqs62x_keys->switches[i].code)

> +		}
> +
> +	iqs62x_keys->iqs62x = iqs62x;
> +	iqs62x_keys->input = input;
> +
> +	ret = iqs62x_keys_init(iqs62x_keys);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to initialize device: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = input_register_device(iqs62x_keys->input);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to register device: %d\n", ret);
> +		return ret;
> +	}
> +
> +	iqs62x_keys->notifier.notifier_call = iqs62x_keys_notifier;
> +	ret = blocking_notifier_chain_register(&iqs62x_keys->iqs62x->nh,
> +					       &iqs62x_keys->notifier);
> +	if (ret)
> +		dev_err(&pdev->dev, "Failed to register notifier: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int iqs62x_keys_remove(struct platform_device *pdev)
> +{
> +	struct iqs62x_keys_private *iqs62x_keys = platform_get_drvdata(pdev);
> +	int ret;
> +
> +	ret = blocking_notifier_chain_unregister(&iqs62x_keys->iqs62x->nh,
> +						 &iqs62x_keys->notifier);
> +	if (ret)
> +		dev_err(&pdev->dev, "Failed to unregister notifier: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static struct platform_driver iqs62x_keys_platform_driver = {
> +	.driver = {
> +		.name = IQS62X_DRV_NAME_KEYS,
> +	},
> +	.probe = iqs62x_keys_probe,
> +	.remove = iqs62x_keys_remove,
> +};
> +module_platform_driver(iqs62x_keys_platform_driver);
> +
> +MODULE_AUTHOR("Jeff LaBundy <jeff@labundy.com>");
> +MODULE_DESCRIPTION("Azoteq IQS620A/621/622/624/625 Keys and Switches");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:" IQS62X_DRV_NAME_KEYS);

Otherwise

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

I suppose it will be merged through MFD?

Thanks.

-- 
Dmitry
