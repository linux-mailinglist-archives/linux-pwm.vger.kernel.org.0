Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F55D2613F1
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Sep 2020 17:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730863AbgIHP4Y (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Sep 2020 11:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730943AbgIHPyo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Sep 2020 11:54:44 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49406C061239
        for <linux-pwm@vger.kernel.org>; Tue,  8 Sep 2020 06:29:39 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l9so17187838wme.3
        for <linux-pwm@vger.kernel.org>; Tue, 08 Sep 2020 06:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GJ8f45V/YQ+Eng4fxZFpuD78DaTJ/jouOJPgvPqWatM=;
        b=f0ukX8fwPzIqcAj9jAjsHyPPhe4xG58+3ZKxfhlG9kjhYN5vVOOSEWSeeGc0rcC+bb
         s0k5bpWJACmfUERh+ptbvJAbSZoMxC/pzxVM7tWH10OeavQ3p93BRNV+J/0pzKu4jVcL
         Qu99W9zF6DDZIVCMOTOQ03CCW6Xy9ioATE4SzAx+sEUSKRouw4Ytsup8RrzjQgSGw5Vh
         j73PawIRIfN1Q08LH9ZLGu6ODpqWqGUVNxoVMxO9UJ5j6w0wncEDmNfAJnZcJYpC8Zwm
         FMCrdZwmt+RA5+bk0/lopZLWMrYcea575WC1KQ9XvtHILF1DTXAOnhWiHu6PSC845fm2
         5JEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GJ8f45V/YQ+Eng4fxZFpuD78DaTJ/jouOJPgvPqWatM=;
        b=gOh+GVjbKGvVJaDfd7rp/XwTEi2Y24s+jQe+ACMHw9CuuTr9R34942JZUsNly2i/90
         KvFgT/XTBnUBQgBAos4ENCeQ354NR3qaWg+FsfdBYDOWgubGQgya/LRhO9l33N4BqrGM
         wY8Im7mHUGo2n54lHW/Ai1Wj8LYa8bBGabKB+N1JjNUM4NKEQOSwHh474BhlLUjwWD+b
         5avZsyNMgsfa9cVfoYB4XEGLiyle762UeN4OslHk1INUk2u55Cty5JmBE0XQ7APk/6VN
         D3UpH0hV0ZOKRtkYSKseq5beIuubrWC6cn3hfGyMK5ishB3F6MuH6ImMFvvdyK5/vSid
         fKlQ==
X-Gm-Message-State: AOAM533ozdTWJQBU32UhNqI3u/Wvqklz4hW1hnzVH7UycOIhIKPFMwou
        G/hXtUiWorIMTCO6Rw5Ea3umkUTCHHGb6w==
X-Google-Smtp-Source: ABdhPJypEa53OzaHDX/+LCTq6rRzpTOD+oW/vOD+O8phED5GyB/dsYhfp3BKrZbR5mOjmBP6f20jsg==
X-Received: by 2002:a1c:4d12:: with SMTP id o18mr4787212wmh.177.1599571777534;
        Tue, 08 Sep 2020 06:29:37 -0700 (PDT)
Received: from dell ([91.110.221.179])
        by smtp.gmail.com with ESMTPSA id t16sm34490237wrm.57.2020.09.08.06.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 06:29:36 -0700 (PDT)
Date:   Tue, 8 Sep 2020 14:29:34 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Andreas Kemnade <andreas@kemnade.info>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>
Subject: Re: [PATCH v2 03/10] mfd: Add base driver for Netronix embedded
 controller
Message-ID: <20200908132934.GT4400@dell>
References: <20200905133230.1014581-1-j.neuschaefer@gmx.net>
 <20200905133230.1014581-4-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200905133230.1014581-4-j.neuschaefer@gmx.net>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, 05 Sep 2020, Jonathan Neuschäfer wrote:

> The Netronix embedded controller is a microcontroller found in some
> e-book readers designed by the ODM Netronix, Inc. It contains RTC,
> battery monitoring, system power management, and PWM functionality.
> 
> This driver implements register access and version detection.
> 
> Third-party hardware documentation is available at:
> 
>   https://github.com/neuschaefer/linux/wiki/Netronix-MSP430-embedded-controller
> 
> The EC supports interrupts, but the driver doesn't make use of them so
> far.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
> 
> v2:
> - Add a description of the device to the patch text
> - Unify spelling as 'Netronix embedded controller'.
>   'Netronix' is the proper name of the manufacturer, but 'embedded controller'
>   is just a label that I have assigned to the device.
> - Switch to regmap, avoid regmap use in poweroff and reboot handlers.
>   Inspired by cf84dc0bb40f4 ("mfd: rn5t618: Make restart handler atomic safe")
> - Use a list of known-working firmware versions instead of checking for a
>   known-incompatible version
> - Prefix registers with NTXEC_REG_
> - Define register values as constants
> - Various style cleanups as suggested by Lee Jones
> - Don't align = signs in struct initializers [Uwe Kleine-König]
> - Don't use dev_dbg for an error message
> - Explain sleep in poweroff handler
> - Remove (struct ntxec).client
> - Switch to .probe_new in i2c driver
> - Add .remove callback
> - Make CONFIG_MFD_NTXEC a tristate option
> ---
>  drivers/mfd/Kconfig       |   7 ++
>  drivers/mfd/Makefile      |   1 +
>  drivers/mfd/ntxec.c       | 217 ++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/ntxec.h |  24 +++++
>  4 files changed, 249 insertions(+)
>  create mode 100644 drivers/mfd/ntxec.c
>  create mode 100644 include/linux/mfd/ntxec.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 33df0837ab415..bab999081f32d 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -978,6 +978,13 @@ config MFD_VIPERBOARD
>  	  You need to select the mfd cell drivers separately.
>  	  The drivers do not support all features the board exposes.
> 
> +config MFD_NTXEC
> +	tristate "Netronix embedded controller"

Nit: "Embedded Controller (EC)"

> +	depends on I2C && OF

	depends on (I2C && OF) || COMPILE_TEST

> +	help
> +	  Say yes here if you want to support the embedded controller found in
> +	  certain e-book readers designed by the ODM Netronix.
> +
>  config MFD_RETU
>  	tristate "Nokia Retu and Tahvo multi-function device"
>  	select MFD_CORE
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index a60e5f835283e..236a8acd917a0 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -217,6 +217,7 @@ obj-$(CONFIG_MFD_INTEL_MSIC)	+= intel_msic.o
>  obj-$(CONFIG_MFD_INTEL_PMC_BXT)	+= intel_pmc_bxt.o
>  obj-$(CONFIG_MFD_PALMAS)	+= palmas.o
>  obj-$(CONFIG_MFD_VIPERBOARD)    += viperboard.o
> +obj-$(CONFIG_MFD_NTXEC)		+= ntxec.o
>  obj-$(CONFIG_MFD_RC5T583)	+= rc5t583.o rc5t583-irq.o
>  obj-$(CONFIG_MFD_RK808)		+= rk808.o
>  obj-$(CONFIG_MFD_RN5T618)	+= rn5t618.o
> diff --git a/drivers/mfd/ntxec.c b/drivers/mfd/ntxec.c
> new file mode 100644
> index 0000000000000..49cc4fa35b9fe
> --- /dev/null
> +++ b/drivers/mfd/ntxec.c
> @@ -0,0 +1,217 @@
> +// SPDX-License-Identifier: GPL-2.0-only

Why 2 only?

> +/*
> + * The Netronix embedded controller is a microcontroller found in some
> + * e-book readers designed by the ODM Netronix, Inc. It contains RTC,
> + * battery monitoring, system power management, and PWM functionality.
> + *
> + * This driver implements register access, version detection, and system
> + * power-off/reset.
> + *
> + * Copyright 2020 Jonathan Neuschäfer

Email?

> + */
> +
> +#include <asm/unaligned.h>
> +#include <linux/delay.h>
> +#include <linux/errno.h>
> +#include <linux/i2c.h>
> +#include <linux/mfd/ntxec.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/pm.h>
> +#include <linux/reboot.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>
> +
> +#define NTXEC_REG_VERSION	0x00
> +#define NTXEC_REG_POWEROFF	0x50
> +#define NTXEC_REG_POWERKEEP	0x70
> +#define NTXEC_REG_RESET		0x90
> +
> +#define NTXEC_POWEROFF_VALUE	0x0100
> +#define NTXEC_POWERKEEP_VALUE	0x0800
> +#define NTXEC_RESET_VALUE	0xff00
> +
> +static struct i2c_client *poweroff_restart_client;
> +
> +static void ntxec_poweroff(void)
> +{
> +	int res;
> +

Remove this line please.

> +	u8 buf[] = {
> +		NTXEC_REG_POWEROFF,
> +		(NTXEC_POWEROFF_VALUE >> 8) & 0xff,
> +		NTXEC_POWEROFF_VALUE & 0xff,
> +	};
> +

And this one.

> +	struct i2c_msg msgs[] = {
> +		{
> +			.addr = poweroff_restart_client->addr,
> +			.flags = 0,
> +			.len = sizeof(buf),
> +			.buf = buf
> +		}
> +	};
> +
> +	res = i2c_transfer(poweroff_restart_client->adapter, msgs, ARRAY_SIZE(msgs));
> +

And this one.

> +	if (res < 0)
> +		dev_alert(&poweroff_restart_client->dev, "Failed to power off (err = %d)\n", res);

This looks way over 80 chars.

Did you run checkpatch.pl?

> +	/*
> +	 * The time from the register write until the host CPU is powered off
> +	 * has been observed to be about 2.5 to 3 seconds. Sleep long enough to
> +	 * safely avoid returning from the poweroff handler.
> +	 */
> +	msleep(5000);
> +}
> +
> +static int ntxec_restart(struct notifier_block *nb,
> +			 unsigned long action, void *data)
> +{
> +	int res;
> +
> +	/*
> +	 * NOTE: The lower half of the reset value is not sent, because sending
> +	 * it causes an error
> +	 */
> +	u8 buf[] = {
> +		NTXEC_REG_RESET,
> +		(NTXEC_RESET_VALUE >> 8) & 0xff,
> +	};
> +
> +	struct i2c_msg msgs[] = {
> +		{
> +			.addr = poweroff_restart_client->addr,
> +			.flags = 0,
> +			.len = sizeof(buf),
> +			.buf = buf
> +		}
> +	};
> +
> +	res = i2c_transfer(poweroff_restart_client->adapter, msgs, ARRAY_SIZE(msgs));
> +
> +	if (res < 0)
> +		dev_alert(&poweroff_restart_client->dev, "Failed to restart (err = %d)\n", res);
> +
> +	return NOTIFY_DONE;
> +}

All as above for this function.

> +static struct notifier_block ntxec_restart_handler = {
> +	.notifier_call = ntxec_restart,
> +	.priority = 128
> +};
> +
> +static const struct regmap_config regmap_config = {
> +	.name = "ntxec",
> +	.reg_bits = 8,
> +	.val_bits = 16,
> +	.cache_type = REGCACHE_NONE,
> +	.val_format_endian = REGMAP_ENDIAN_BIG,
> +};
> +
> +static const struct ntxec_info ntxec_known_versions[] = {
> +	{ 0xd726 }, /* found in Kobo Aura */
> +};
> +
> +static const struct ntxec_info *ntxec_lookup_info(u16 version)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(ntxec_known_versions); i++) {
> +		const struct ntxec_info *info = &ntxec_known_versions[i];
> +
> +		if (info->version == version)
> +			return info;
> +	}
> +
> +	return NULL;
> +}

Wait, what?  This is over-engineered.

Just have a look-up table (switch) of supported devices.

> +static int ntxec_probe(struct i2c_client *client)
> +{
> +	struct ntxec *ec;
> +	unsigned int version;
> +	int res;
> +
> +	ec = devm_kmalloc(&client->dev, sizeof(*ec), GFP_KERNEL);
> +	if (!ec)
> +		return -ENOMEM;
> +
> +	ec->dev = &client->dev;
> +
> +	ec->regmap = devm_regmap_init_i2c(client, &regmap_config);
> +	if (IS_ERR(ec->regmap)) {
> +		dev_err(ec->dev, "Failed to set up regmap for device\n");
> +		return res;
> +	}
> +
> +	/* Determine the firmware version */
> +	res = regmap_read(ec->regmap, NTXEC_REG_VERSION, &version);
> +	if (res < 0) {
> +		dev_err(ec->dev, "Failed to read firmware version number\n");
> +		return res;
> +	}
> +	dev_info(ec->dev,
> +		 "Netronix embedded controller version %04x detected.\n",
> +		 version);
> +
> +	/* Bail out if we encounter an unknown firmware version */
> +	ec->info = ntxec_lookup_info(version);
> +	if (!ec->info)
> +		return -EOPNOTSUPP;

#define EOPNOTSUPP      95      /* Operation not supported on transport endpoint */

I think you want:

#define ENODEV          19      /* No such device */

> +	if (of_device_is_system_power_controller(ec->dev->of_node)) {
> +		/*
> +		 * Set the 'powerkeep' bit. This is necessary on some boards
> +		 * in order to keep the system running.
> +		 */
> +		res = regmap_write(ec->regmap, NTXEC_REG_POWERKEEP,
> +				   NTXEC_POWERKEEP_VALUE);
> +		if (res < 0)
> +			return res;
> +
> +		/* Install poweroff handler */

Don't think this comment is required.

> +		WARN_ON(poweroff_restart_client);
> +		poweroff_restart_client = client;
> +		if (pm_power_off)
> +			dev_err(ec->dev, "pm_power_off already assigned\n");
> +		else
> +			pm_power_off = ntxec_poweroff;
> +
> +		/* Install board reset handler */

Nor this.

> +		res = register_restart_handler(&ntxec_restart_handler);
> +		if (res)
> +			dev_err(ec->dev,
> +				"Failed to register restart handler: %d\n", res);
> +	}
> +
> +	i2c_set_clientdata(client, ec);
> +
> +	return devm_of_platform_populate(ec->dev);
> +}
> +
> +static int ntxec_remove(struct i2c_client *i2c)

Why do you call it 'client' in .probe, but 'i2c' in .remove?

> +{
> +	if (i2c == poweroff_restart_client) {
> +		poweroff_restart_client = NULL;
> +		pm_power_off = NULL;
> +		unregister_restart_handler(&ntxec_restart_handler);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id of_ntxec_match_table[] = {
> +	{ .compatible = "netronix,ntxec", },
> +	{}
> +};
> +
> +static struct i2c_driver ntxec_driver = {
> +	.driver = {
> +		.name = "ntxec",
> +		.of_match_table = of_ntxec_match_table,
> +	},
> +	.probe_new = ntxec_probe,
> +	.remove = ntxec_remove,
> +};
> +module_i2c_driver(ntxec_driver);
> diff --git a/include/linux/mfd/ntxec.h b/include/linux/mfd/ntxec.h
> new file mode 100644
> index 0000000000000..65e389af79da6
> --- /dev/null
> +++ b/include/linux/mfd/ntxec.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright 2020 Jonathan Neuschäfer
> + *
> + * Register access and version information for the Netronix embedded
> + * controller.
> + */
> +
> +#ifndef NTXEC_H
> +#define NTXEC_H
> +
> +#include <linux/types.h>
> +
> +struct ntxec_info {
> +	u16 version;
> +};
> +
> +struct ntxec {
> +	struct device *dev;
> +	struct regmap *regmap;

> +	const struct ntxec_info *info;

What is this used for?

> +};
> +
> +#endif

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
