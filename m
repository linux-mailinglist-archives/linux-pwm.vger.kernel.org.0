Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDE420C016
	for <lists+linux-pwm@lfdr.de>; Sat, 27 Jun 2020 10:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgF0ISQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 27 Jun 2020 04:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgF0ISQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 27 Jun 2020 04:18:16 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0CBC03E979;
        Sat, 27 Jun 2020 01:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4UusXWVmeZslLL0YrXwQifqLxTB7fqL/8w++bVpT1Ek=; b=CdYOFiAmCvnKTyLHBvYOAYYd2F
        uF2ipBdlMVzJkU/F9iSYsdZ0gtf75hcaUruY15yoJC0DSXLa1aIvjbQ2xUMIKrQB7x3JJ0O3fUqzT
        rRQTziuSZ7Wc5h91mcUSS9Shp8uDaPOQYAzzCCFemo2attCrUfXoqe7vfD0bdh7wO7Mo=;
Received: from p5dcc3098.dip0.t-ipconnect.de ([93.204.48.152] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1jp61s-0007Tj-7u; Sat, 27 Jun 2020 10:17:44 +0200
Date:   Sat, 27 Jun 2020 10:17:38 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
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
        Josua Mayer <josua.mayer@jm0.eu>
Subject: Re: [RFC PATCH 04/10] mfd: Add base driver for Netronix embedded
 controller
Message-ID: <20200627101738.2fe4abc3@aktux>
In-Reply-To: <20200620224222.1312520-3-j.neuschaefer@gmx.net>
References: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
        <20200620224222.1312520-3-j.neuschaefer@gmx.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0 (-)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, 21 Jun 2020 00:42:15 +0200
Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> wrote:

> Third-party hardware documentation is available at
> https://github.com/neuschaefer/linux/wiki/Netronix-MSP430-embedded-contro=
ller
>=20
> The EC supports interrupts, but the driver doesn't make use of them so
> far.
>=20
> Known problems:
> - The reboot handler is installed in such a way that it directly calls
>   into the i2c subsystem to send the reboot command to the EC. This
>   means that the reboot handler may sleep, which is not allowed.
>=20
see
https://patchwork.ozlabs.org/project/linux-i2c/patch/20190415213432.8972-3-=
contact@stefanchrist.eu/

for a fix of such problems.=20

> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---
>  drivers/mfd/Kconfig       |   7 ++
>  drivers/mfd/Makefile      |   1 +
>  drivers/mfd/ntxec.c       | 188 ++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/ntxec.h |  30 ++++++
>  4 files changed, 226 insertions(+)
>  create mode 100644 drivers/mfd/ntxec.c
>  create mode 100644 include/linux/mfd/ntxec.h
>=20
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index a37d7d1713820..78410b928648e 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -978,6 +978,13 @@ config MFD_VIPERBOARD
>  	  You need to select the mfd cell drivers separately.
>  	  The drivers do not support all features the board exposes.
>=20
> +config MFD_NTXEC
> +	bool "Netronix Embedded Controller"
> +	depends on I2C && OF
> +	help
> +	  Say yes here if you want to support the embedded controller of
> +	  certain e-book readers designed by the ODM Netronix.
> +
>  config MFD_RETU
>  	tristate "Nokia Retu and Tahvo multi-function device"
>  	select MFD_CORE
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 9367a92f795a6..19d9391ed6f32 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -218,6 +218,7 @@ obj-$(CONFIG_MFD_INTEL_MSIC)	+=3D intel_msic.o
>  obj-$(CONFIG_MFD_INTEL_PMC_BXT)	+=3D intel_pmc_bxt.o
>  obj-$(CONFIG_MFD_PALMAS)	+=3D palmas.o
>  obj-$(CONFIG_MFD_VIPERBOARD)    +=3D viperboard.o
> +obj-$(CONFIG_MFD_NTXEC)		+=3D ntxec.o
>  obj-$(CONFIG_MFD_RC5T583)	+=3D rc5t583.o rc5t583-irq.o
>  obj-$(CONFIG_MFD_RK808)		+=3D rk808.o
>  obj-$(CONFIG_MFD_RN5T618)	+=3D rn5t618.o
> diff --git a/drivers/mfd/ntxec.c b/drivers/mfd/ntxec.c
> new file mode 100644
> index 0000000000000..82adea34ea746
> --- /dev/null
> +++ b/drivers/mfd/ntxec.c
> @@ -0,0 +1,188 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright 2020 Jonathan Neusch=C3=A4fer
> +//
> +// MFD driver for the usually MSP430-based embedded controller used in c=
ertain
> +// Netronix ebook reader board designs
> +
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
> +#define NTXEC_VERSION		0x00
> +#define NTXEC_POWEROFF		0x50
> +#define NTXEC_POWERKEEP		0x70
> +#define NTXEC_RESET		0x90
> +
> +
> +/* Register access */
> +
> +int ntxec_read16(struct ntxec *ec, u8 addr)
> +{
> +	u8 request[1] =3D { addr };
> +	u8 response[2];
> +	int res;
> +
> +	struct i2c_msg msgs[] =3D {
> +		{
> +			.addr =3D ec->client->addr,
> +			.flags =3D ec->client->flags,
> +			.len =3D sizeof(request),
> +			.buf =3D request
> +		}, {
> +			.addr =3D ec->client->addr,
> +			.flags =3D ec->client->flags | I2C_M_RD,
> +			.len =3D sizeof(response),
> +			.buf =3D response
> +		}
> +	};
> +
> +	res =3D i2c_transfer(ec->client->adapter, msgs, ARRAY_SIZE(msgs));
> +	if (res < 0)
> +		return res;
> +	if (res !=3D ARRAY_SIZE(msgs))
> +		return -EIO;
> +
> +	return get_unaligned_be16(response);
> +}
> +EXPORT_SYMBOL(ntxec_read16);
> +
> +int ntxec_write16(struct ntxec *ec, u8 addr, u16 value)
> +{
> +	u8 request[3] =3D { addr, };
> +	int res;
> +
> +	put_unaligned_be16(value, request + 1);
> +
> +	res =3D i2c_transfer_buffer_flags(ec->client, request, sizeof(request),
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
> +	int res =3D ntxec_read16(ec, addr);
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
> +

do we really need both 16bit and 8bit accessors? If not,
then simply use regmap_i2c_init and set val_bits accordingly.
Maybe just doing the << 8 in the constants?

> +
> +/* Reboot/poweroff handling */
> +
> +static struct ntxec *poweroff_restart_instance;
> +
> +static void ntxec_poweroff(void)
> +{
> +	ntxec_write8(poweroff_restart_instance, NTXEC_POWEROFF, 0x01);
> +	msleep(5000);
> +}
> +
> +static int ntxec_restart(struct notifier_block *nb,
> +		unsigned long action, void *data)
> +{
> +	/* FIXME: The I2C driver sleeps, but restart handlers may not sleep */
> +	ntxec_write8(poweroff_restart_instance, NTXEC_RESET, 0xff);
> +	/* TODO: delay? */
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block ntxec_restart_handler =3D {
> +	.notifier_call =3D ntxec_restart,
> +	.priority =3D 128
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
> +
> +	ec =3D devm_kmalloc(&client->dev, sizeof(*ec), GFP_KERNEL);
> +	if (!ec)
> +		return -ENOMEM;
> +
> +	ec->dev =3D &client->dev;
> +	ec->client =3D client;
> +
> +	/* Determine the firmware version */
> +	res =3D ntxec_read16(ec, NTXEC_VERSION);
> +	if (res < 0) {
> +		dev_dbg(ec->dev, "Failed to read firmware version number\n");
> +		return res;
> +	}
> +	ec->version =3D res;
> +
> +	dev_info(ec->dev,
> +		 "Netronix embedded controller version %04x detected.\n",
> +		 ec->version);
> +
> +	/* For now, we don't support the new register layout. */
> +	if (ntxec_has_new_layout(ec))
> +		return -EOPNOTSUPP;
> +
> +	if (of_device_is_system_power_controller(ec->dev->of_node)) {
> +		/*
> +		 * Set the 'powerkeep' bit. This is necessary on some boards
> +		 * in order to keep the system running.
> +		 */
> +		res =3D ntxec_write8(ec, NTXEC_POWERKEEP, 0x08);
> +		if (res < 0)
> +			return res;
> +
> +		/* Install poweroff handler */
> +		WARN_ON(poweroff_restart_instance);
> +		poweroff_restart_instance =3D ec;
> +		if (pm_power_off !=3D NULL)
> +			/* TODO: Refactor among all poweroff drivers */
> +			dev_err(ec->dev, "pm_power_off already assigned\n");
> +		else
> +			pm_power_off =3D ntxec_poweroff;
> +
common pattern, across drivers, so I think doing something else would
be a separate cleanup issue.

Regards,
Andreas
