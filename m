Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E90D2CBDC7
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Dec 2020 14:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbgLBNGL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Dec 2020 08:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727956AbgLBNGK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Dec 2020 08:06:10 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C497C0613D4
        for <linux-pwm@vger.kernel.org>; Wed,  2 Dec 2020 05:05:24 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id k14so3881076wrn.1
        for <linux-pwm@vger.kernel.org>; Wed, 02 Dec 2020 05:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YF+WlyCt3rq165R9rPhsAR5qsYk6r1RiPW2tzO/YPhE=;
        b=kxX9wrHZNwlLIJdTxtKvUwuk/et7M4x5wlpSjhdkxmEz1piNL/IeIIXigGIUl9ipjY
         dIdTNlI4IAELmPStajXBBI+Klk6ii/r0HMOro78xmzlzKgcDUptC4TlsCbnICCG1LW4D
         sqnfqrSHnT+1OGJzPA6btCamhetgcJo3iPQvqVq8LVzmPPTMGQLF6VuqcOKjcvYGEL1L
         KiWHTEX6h8AjrKEAv3Z5D3VNdut9VG0waZ9k1XZTtQSZ14qSl0NGIeiTCBj5Mie7kFY3
         8IeGal8nhCIgKtpl50HyJ7RBz+qgk/FWV1+tbFCqgiUa8sVSlrevuMAnmbIkxOKg3Bp5
         b0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YF+WlyCt3rq165R9rPhsAR5qsYk6r1RiPW2tzO/YPhE=;
        b=pBl480Jy0DbHPiiXWnkuzyYwhDO3IEk3dgxvjP4Ja4jKiaGPB0U9dobMKfInl86B+E
         i8VmNV+qIRDllValPiRti8yGw4JBsjd4YCvx1jnnpxuWqaevLU/iuLPZhCJ6US3gaacu
         e4pg2+yzjPkMVTsEldRzVZ6Vh/TH/doEilnKR+5/yi5SKVDBUMaMaqbGAdWNSnUBxmZA
         oEzwvVetZagWZO8rtd0x8zYzdhP02Hxe81hgrOz27a2Zv2YqaY6/Cb32cu8Py9qbdk3k
         ZIn6gy9iF6Dh4Sa9AML5NWY9Dkowhm80PYCAHz1HjbY/Ya5wnsv5XJiHVs10o7XsO+BA
         SqQw==
X-Gm-Message-State: AOAM533p9YwGywjk5G+2YyF+aMB8Rc+d8COAD+WVy0GpfmrDV4KlzcQG
        5xC9v8mrPWTvZRdSnoLjTaz57Q==
X-Google-Smtp-Source: ABdhPJyU7nBUV7L/MOKEYhXF3YQLoNB4SBM8Oj1m3Ptw0bfruV++dLrYVysScV65WUtECftiWqkPEg==
X-Received: by 2002:a5d:548b:: with SMTP id h11mr3417874wrv.306.1606914323134;
        Wed, 02 Dec 2020 05:05:23 -0800 (PST)
Received: from dell ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id v64sm2059455wme.25.2020.12.02.05.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 05:05:22 -0800 (PST)
Date:   Wed, 2 Dec 2020 13:05:20 +0000
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
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 3/7] mfd: Add base driver for Netronix embedded
 controller
Message-ID: <20201202130520.GL4801@dell>
References: <20201122222739.1455132-1-j.neuschaefer@gmx.net>
 <20201122222739.1455132-4-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201122222739.1455132-4-j.neuschaefer@gmx.net>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, 22 Nov 2020, Jonathan Neuschäfer wrote:

> The Netronix embedded controller is a microcontroller found in some
> e-book readers designed by the original design manufacturer Netronix,
> Inc. It contains RTC, battery monitoring, system power management, and
> PWM functionality.
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
> v4:
> - include asm/unaligned.h after linux/*
> - Use put_unaligned_be16 instead of open-coded big-endian packing
> - Clarify that 0x90=0xff00 causes an error in downstream kernel too
> - Add commas after non-sentinel positions
> - ntxec.h: declare structs device and regmap
> - Replace WARN_ON usage and add comments to explain errors
> - Replace dev_alert with dev_warn when the result isn't handled
> - Change subdevice registration error message to dev_err
> - Declare ntxec_reg8 as returning __be16
> - Restructure version detection code
> - Spell out ODM
> 
> v3:
> - https://lore.kernel.org/lkml/20200924192455.2484005-4-j.neuschaefer@gmx.net/
> - Add (EC) to CONFIG_MFD_NTXEC prompt
> - Relicense as GPLv2 or later
> - Add email address to copyright line
> - remove empty lines in ntxec_poweroff and ntxec_restart functions
> - Split long lines
> - Remove 'Install ... handler' comments
> - Make naming of struct i2c_client parameter consistent
> - Remove struct ntxec_info
> - Rework 'depends on' lines in Kconfig, hard-depend on I2C, select REGMAP_I2C and
>   MFD_CORE
> - Register subdevices via mfd_cells
> - Move 8-bit register conversion to ntxec.h
> 
> v2:
> - https://lore.kernel.org/lkml/20200905133230.1014581-4-j.neuschaefer@gmx.net/
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
>  drivers/mfd/Kconfig       |  11 ++
>  drivers/mfd/Makefile      |   1 +
>  drivers/mfd/ntxec.c       | 216 ++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/ntxec.h |  34 ++++++
>  4 files changed, 262 insertions(+)
>  create mode 100644 drivers/mfd/ntxec.c
>  create mode 100644 include/linux/mfd/ntxec.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 8b99a13669bfc..d96751f884dc6 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -990,6 +990,17 @@ config MFD_VIPERBOARD
>  	  You need to select the mfd cell drivers separately.
>  	  The drivers do not support all features the board exposes.
> 
> +config MFD_NTXEC
> +	tristate "Netronix embedded controller (EC)"
> +	depends on OF || COMPILE_TEST
> +	depends on I2C
> +	select REGMAP_I2C
> +	select MFD_CORE
> +	help
> +	  Say yes here if you want to support the embedded controller found in
> +	  certain e-book readers designed by the original design manufacturer
> +	  Netronix.
> +
>  config MFD_RETU
>  	tristate "Nokia Retu and Tahvo multi-function device"
>  	select MFD_CORE
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 1780019d24748..815c99b84019e 100644
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
> index 0000000000000..c1510711d7363
> --- /dev/null
> +++ b/drivers/mfd/ntxec.c
> @@ -0,0 +1,216 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * The Netronix embedded controller is a microcontroller found in some
> + * e-book readers designed by the original design manufacturer Netronix, Inc.
> + * It contains RTC, battery monitoring, system power management, and PWM
> + * functionality.
> + *
> + * This driver implements register access, version detection, and system
> + * power-off/reset.
> + *
> + * Copyright 2020 Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/errno.h>
> +#include <linux/i2c.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/ntxec.h>
> +#include <linux/module.h>
> +#include <linux/pm.h>
> +#include <linux/reboot.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>
> +#include <asm/unaligned.h>
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
> +	u8 buf[3] = { NTXEC_REG_POWEROFF };
> +	struct i2c_msg msgs[] = {
> +		{
> +			.addr = poweroff_restart_client->addr,
> +			.flags = 0,
> +			.len = sizeof(buf),
> +			.buf = buf,
> +		},
> +	};
> +
> +	put_unaligned_be16(NTXEC_POWEROFF_VALUE, buf + 1);
> +
> +	res = i2c_transfer(poweroff_restart_client->adapter, msgs, ARRAY_SIZE(msgs));
> +	if (res < 0)
> +		dev_warn(&poweroff_restart_client->dev,
> +			 "Failed to power off (err = %d)\n", res);
> +
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
> +	u8 buf[3] = { NTXEC_REG_RESET };
> +	/*
> +	 * NOTE: The lower half of the reset value is not sent, because sending
> +	 * it causes an I2C error. (The reset handler in the downstream driver
> +	 * does send the full two-byte value, but doesn't check the result).
> +	 */
> +	struct i2c_msg msgs[] = {
> +		{
> +			.addr = poweroff_restart_client->addr,
> +			.flags = 0,
> +			.len = sizeof(buf) - 1,
> +			.buf = buf,
> +		},
> +	};
> +
> +	put_unaligned_be16(NTXEC_RESET_VALUE, buf + 1);
> +
> +	res = i2c_transfer(poweroff_restart_client->adapter, msgs, ARRAY_SIZE(msgs));
> +	if (res < 0)
> +		dev_warn(&poweroff_restart_client->dev,
> +			 "Failed to restart (err = %d)\n", res);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block ntxec_restart_handler = {
> +	.notifier_call = ntxec_restart,
> +	.priority = 128,
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
> +static const struct mfd_cell ntxec_subdevices[] = {
> +	{ .name = "ntxec-rtc" },
> +	{ .name = "ntxec-pwm" },
> +};
> +
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
> +
> +	/* Bail out if we encounter an unknown firmware version */
> +	switch (version) {
> +	case 0xd726: /* found in Kobo Aura */

No magic numbers.

Please submit a subsequent patch to define this.

> +		break;
> +	default:
> +		dev_err(ec->dev,
> +			"Netronix embedded controller version %04x is not supported.\n",
> +			version);
> +		return -ENODEV;
> +	}


Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
