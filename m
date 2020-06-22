Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C161203529
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jun 2020 12:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgFVKzv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Jun 2020 06:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727863AbgFVKzt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Jun 2020 06:55:49 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055A5C061797
        for <linux-pwm@vger.kernel.org>; Mon, 22 Jun 2020 03:55:48 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g18so7121319wrm.2
        for <linux-pwm@vger.kernel.org>; Mon, 22 Jun 2020 03:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KoWfZGUWw5C18ooOV0MLNeymXgRwlrvLzPcWKgUELZ8=;
        b=MqPCIqVfeX6FnZR0P6Nv/pkU/Oo/r0qpdBVkZ41DKtClDNp2XknFMQblxt6Kl4dOLf
         500zLlXFEy7KVKZbNIyzTbGNL1FbqwZeuw5h2neOFh9FU+hFKFVoHMrebkUMRS7NSCnf
         /Iep0kf+yLJ7awueDHIC9Qd1hkolYp1hIpg/iyOAbK6Lnd92wZ8sy/rYW9+wYz0i0jg+
         Wa75paKy6HV6VvhOnYDFIPxB1IFJxktZmHTgch1QVs/FZl/5aZ5koo9CYDQCiTC6+Aor
         9cqRS/n4IqkLdeBVrK9GjEPtlvYUM/t7ygvmJ3LdUMEZ34Bo/eI4jG4LQQpddCqALScL
         NtPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KoWfZGUWw5C18ooOV0MLNeymXgRwlrvLzPcWKgUELZ8=;
        b=A/xNNYPxD3TxoYSpJqGxZhrx5s8GTwhzbOdaHkcIIvP6wWJyPyv+ZnFe6qJomBu31H
         FlfTpKa+yNWwx/X/RGH5VaEmzI8iFAsvEr4ImvjKnAMdwMTZcmrt+WLJo4Qp8JtKYos9
         6eP9XVpsbmlOwj2v5fQ15vdWggP8JSVxXpO4b0ZkEnMDUeyzOUOSc5GsrXuICqpR0EQX
         ww0DeVphrATQcDiX68IS6uQ/d32IeoAV3mVD845rqLfOR2OZgA13/Z8y3ZY2tMgXhbJD
         9UxY0E2mlvgKyF34o8QT/JOMsBFtST8WAgREhXfFIoUT01PnectmZOY1b/LadevdfdKT
         M7yg==
X-Gm-Message-State: AOAM530aWdofbJmoj/mt7Qf9lFlLjtkPsWGWrLkWj3m7C2XAQljhNCAB
        xUgl5I6cLDhiIdrD/m84IEAwPA==
X-Google-Smtp-Source: ABdhPJwUK4AwBpQhsM0+AFV5S7K5kK/5FkSGHnjSyKX7rVYVRGIgnKd20aMohuBX+6UliHE+X1ez0A==
X-Received: by 2002:adf:9286:: with SMTP id 6mr18654037wrn.361.1592823347358;
        Mon, 22 Jun 2020 03:55:47 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id c20sm10890766wrb.65.2020.06.22.03.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 03:55:46 -0700 (PDT)
Date:   Mon, 22 Jun 2020 11:55:44 +0100
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
        Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [RFC PATCH 04/10] mfd: Add base driver for Netronix embedded
 controller
Message-ID: <20200622105544.GU954398@dell>
References: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
 <20200620224222.1312520-3-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200620224222.1312520-3-j.neuschaefer@gmx.net>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, 21 Jun 2020, Jonathan Neuschäfer wrote:

Description of the device here please.

> Third-party hardware documentation is available at

'\n'

> https://github.com/neuschaefer/linux/wiki/Netronix-MSP430-embedded-controller

Indent this with a couple of spaces.

> The EC supports interrupts, but the driver doesn't make use of them so
> far.
> 
> Known problems:
> - The reboot handler is installed in such a way that it directly calls
>   into the i2c subsystem to send the reboot command to the EC. This
>   means that the reboot handler may sleep, which is not allowed.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  drivers/mfd/Kconfig       |   7 ++
>  drivers/mfd/Makefile      |   1 +
>  drivers/mfd/ntxec.c       | 188 ++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/ntxec.h |  30 ++++++
>  4 files changed, 226 insertions(+)
>  create mode 100644 drivers/mfd/ntxec.c
>  create mode 100644 include/linux/mfd/ntxec.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index a37d7d1713820..78410b928648e 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -978,6 +978,13 @@ config MFD_VIPERBOARD
>  	  You need to select the mfd cell drivers separately.
>  	  The drivers do not support all features the board exposes.
> 
> +config MFD_NTXEC
> +	bool "Netronix Embedded Controller"
> +	depends on I2C && OF
> +	help
> +	  Say yes here if you want to support the embedded controller of
> +	  certain e-book readers designed by the ODM Netronix.

s/of certain/found in certain/.

>  config MFD_RETU
>  	tristate "Nokia Retu and Tahvo multi-function device"
>  	select MFD_CORE
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 9367a92f795a6..19d9391ed6f32 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -218,6 +218,7 @@ obj-$(CONFIG_MFD_INTEL_MSIC)	+= intel_msic.o
>  obj-$(CONFIG_MFD_INTEL_PMC_BXT)	+= intel_pmc_bxt.o
>  obj-$(CONFIG_MFD_PALMAS)	+= palmas.o
>  obj-$(CONFIG_MFD_VIPERBOARD)    += viperboard.o
> +obj-$(CONFIG_MFD_NTXEC)		+= ntxec.o
>  obj-$(CONFIG_MFD_RC5T583)	+= rc5t583.o rc5t583-irq.o
>  obj-$(CONFIG_MFD_RK808)		+= rk808.o
>  obj-$(CONFIG_MFD_RN5T618)	+= rn5t618.o
> diff --git a/drivers/mfd/ntxec.c b/drivers/mfd/ntxec.c
> new file mode 100644
> index 0000000000000..82adea34ea746
> --- /dev/null
> +++ b/drivers/mfd/ntxec.c
> @@ -0,0 +1,188 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright 2020 Jonathan Neuschäfer
> +//
> +// MFD driver for the usually MSP430-based embedded controller used in certain
> +// Netronix ebook reader board designs

Only the SPDX line should contain C++ style comments.

Description at the top, copyright after.

An "MFD driver" isn't really a thing.  Please describe the device.

> +#include <asm/unaligned.h>
> +#include <linux/delay.h>
> +#include <linux/errno.h>
> +#include <linux/i2c.h>
> +#include <linux/mfd/ntxec.h>
> +#include <linux/of_platform.h>
> +#include <linux/pm.h>
> +#include <linux/reboot.h>
> +#include <linux/types.h>
> +
> +

No need for double line spacing.

> +#define NTXEC_VERSION		0x00
> +#define NTXEC_POWEROFF		0x50
> +#define NTXEC_POWERKEEP		0x70
> +#define NTXEC_RESET		0x90

Are these registers?  Might be worth pre/post-fixing with _REG.

> +/* Register access */
> +
> +int ntxec_read16(struct ntxec *ec, u8 addr)
> +{
> +	u8 request[1] = { addr };
> +	u8 response[2];
> +	int res;
> +
> +	struct i2c_msg msgs[] = {
> +		{
> +			.addr = ec->client->addr,
> +			.flags = ec->client->flags,
> +			.len = sizeof(request),
> +			.buf = request
> +		}, {
> +			.addr = ec->client->addr,
> +			.flags = ec->client->flags | I2C_M_RD,
> +			.len = sizeof(response),
> +			.buf = response
> +		}
> +	};
> +
> +	res = i2c_transfer(ec->client->adapter, msgs, ARRAY_SIZE(msgs));
> +	if (res < 0)
> +		return res;
> +	if (res != ARRAY_SIZE(msgs))
> +		return -EIO;
> +
> +	return get_unaligned_be16(response);
> +}
> +EXPORT_SYMBOL(ntxec_read16);
> +
> +int ntxec_write16(struct ntxec *ec, u8 addr, u16 value)
> +{
> +	u8 request[3] = { addr, };
> +	int res;
> +
> +	put_unaligned_be16(value, request + 1);
> +
> +	res = i2c_transfer_buffer_flags(ec->client, request, sizeof(request),
> +					ec->client->flags);
> +	if (res < 0)
> +		return res;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(ntxec_write16);
> +
> +int ntxec_read8(struct ntxec *ec, u8 addr)
> +{
> +	int res = ntxec_read16(ec, addr);
> +
> +	if (res < 0)
> +		return res;
> +
> +	return (res >> 8) & 0xff;
> +}
> +EXPORT_SYMBOL(ntxec_read8);
> +
> +int ntxec_write8(struct ntxec *ec, u8 addr, u8 value)
> +{
> +	return ntxec_write16(ec, addr, value << 8);
> +}
> +EXPORT_SYMBOL(ntxec_write8);

Why are you hand-rolling your own accessors?

> +
> +
> +/* Reboot/poweroff handling */

These comments seem to be stating the obvious.

Please remove them.

> +static struct ntxec *poweroff_restart_instance;
> +
> +static void ntxec_poweroff(void)
> +{
> +	ntxec_write8(poweroff_restart_instance, NTXEC_POWEROFF, 0x01);

All magic numbers should be defined?

> +	msleep(5000);

Why 5000?

> +}
> +
> +static int ntxec_restart(struct notifier_block *nb,
> +		unsigned long action, void *data)
> +{
> +	/* FIXME: The I2C driver sleeps, but restart handlers may not sleep */

Then this is not allowed.

You need to fix this *before* submitting upstream.

> +	ntxec_write8(poweroff_restart_instance, NTXEC_RESET, 0xff);
> +	/* TODO: delay? */

TODO *before* submitting upstream.  This is not a development branch.

> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block ntxec_restart_handler = {
> +	.notifier_call = ntxec_restart,
> +	.priority = 128
> +};
> +
> +
> +/* Driver setup */
> +
> +static int ntxec_probe(struct i2c_client *client,
> +			    const struct i2c_device_id *ids)
> +{
> +	struct ntxec *ec;
> +	int res;

What does 'res' mean?

> +	ec = devm_kmalloc(&client->dev, sizeof(*ec), GFP_KERNEL);
> +	if (!ec)
> +		return -ENOMEM;
> +
> +	ec->dev = &client->dev;
> +	ec->client = client;

You don't need both (if any).

> +	/* Determine the firmware version */
> +	res = ntxec_read16(ec, NTXEC_VERSION);
> +	if (res < 0) {
> +		dev_dbg(ec->dev, "Failed to read firmware version number\n");

Why dbg?

> +		return res;
> +	}
> +	ec->version = res;
> +
> +	dev_info(ec->dev,
> +		 "Netronix embedded controller version %04x detected.\n",
> +		 ec->version);
> +
> +	/* For now, we don't support the new register layout. */
> +	if (ntxec_has_new_layout(ec))
> +		return -EOPNOTSUPP;

What is the new layout?

Why don't you support it?

> +	if (of_device_is_system_power_controller(ec->dev->of_node)) {
> +		/*
> +		 * Set the 'powerkeep' bit. This is necessary on some boards
> +		 * in order to keep the system running.
> +		 */
> +		res = ntxec_write8(ec, NTXEC_POWERKEEP, 0x08);
> +		if (res < 0)
> +			return res;
> +
> +		/* Install poweroff handler */
> +		WARN_ON(poweroff_restart_instance);

Why WARN?

> +		poweroff_restart_instance = ec;
> +		if (pm_power_off != NULL)

if (pm_power_off)

> +			/* TODO: Refactor among all poweroff drivers */

Nope.

> +			dev_err(ec->dev, "pm_power_off already assigned\n");

Error, but execution carries on anyway?

> +		else
> +			pm_power_off = ntxec_poweroff;
> +
> +		/* Install board reset handler */
> +		res = register_restart_handler(&ntxec_restart_handler);
> +		if (res < 0)

Is >0 valid?

> +			dev_err(ec->dev,
> +				"Failed to register restart handler: %d\n", res);
> +	}
> +
> +	i2c_set_clientdata(client, ec);

Where do you use this?

> +	return devm_of_platform_populate(ec->dev);
> +}
> +
> +static const struct of_device_id of_ntxec_match_table[] = {
> +	{ .compatible = "netronix,ntxec", },
> +	{}
> +};

Use .probe_new() and drop this.

> +static struct i2c_driver ntxec_driver = {
> +	.driver	= {
> +		.name	= "ntxec",
> +		.of_match_table = of_ntxec_match_table,
> +	},
> +	.probe		= ntxec_probe,

Nothing to .remove()?

> +};
> +builtin_i2c_driver(ntxec_driver);

Only built-in?

> diff --git a/include/linux/mfd/ntxec.h b/include/linux/mfd/ntxec.h
> new file mode 100644
> index 0000000000000..9f9d6f2141751
> --- /dev/null
> +++ b/include/linux/mfd/ntxec.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright 2020 Jonathan Neuschäfer
> + *
> + * MFD access functions for the Netronix embedded controller.

No such thing as an MFD.

"Embedded Controller"

> + */
> +
> +#ifndef NTXEC_H
> +#define NTXEC_H
> +
> +#include <linux/types.h>
> +
> +struct ntxec {
> +	struct device *dev;
> +	struct i2c_client *client;
> +	u16 version;
> +	/* TODO: Add a mutex to protect actions consisting of multiple accesses? */

No TODOs.  Please fix before upstreaming.

> +};
> +
> +static inline bool ntxec_has_new_layout(struct ntxec *ec)
> +{
> +	return ec->version == 0xe916;

Why don't you just check for the devices you *do* support?

> +}
> +
> +int ntxec_read16(struct ntxec *ec, u8 addr);
> +int ntxec_write16(struct ntxec *ec, u8 addr, u16 value);
> +int ntxec_read8(struct ntxec *ec, u8 addr);
> +int ntxec_write8(struct ntxec *ec, u8 addr, u8 value);
> +
> +#endif

#endif /* NTXEC_H */

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
