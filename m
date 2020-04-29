Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3671BEC01
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Apr 2020 00:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgD2WTA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 29 Apr 2020 18:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726481AbgD2WS7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 29 Apr 2020 18:18:59 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29877C03C1AE;
        Wed, 29 Apr 2020 15:18:59 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id CC72422F54;
        Thu, 30 Apr 2020 00:18:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1588198733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OmNmiJrBqjSomX4a3GYQTKJyBa1w0mCqW3xG6X4r7JU=;
        b=Z/PwLy3ofPJI0xZH8IT5HibD+o80mve3lOqDxmcoLl5fAWYxiphkS3L+FlMZ3hwjqkPVXe
        FWyxmaG79Gwm3M+Y76olNlSWLCYjY+suQcs/NAmXlgNRFpGqjE3p9qgeG7IWOdSSjMV0EB
        tuVu73gv8gmi36GFiF4+cMEP6WC8huQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 30 Apr 2020 00:18:48 +0200
From:   Michael Walle <michael@walle.cc>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 03/16] mfd: mfd-core: match device tree node against
 reg property
In-Reply-To: <20200423174543.17161-4-michael@walle.cc>
References: <20200423174543.17161-1-michael@walle.cc>
 <20200423174543.17161-4-michael@walle.cc>
Message-ID: <67e90dafd67c285158c2c6f67f92edb7@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Spam-Level: *
X-Rspamd-Server: web
X-Spam-Status: No, score=1.40
X-Spam-Score: 1.40
X-Rspamd-Queue-Id: CC72422F54
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[24];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[linux.intel.com,linaro.org,baylibre.com,kernel.org,suse.com,roeck-us.net,gmail.com,pengutronix.de,linux-watchdog.org,nxp.com,linutronix.de,lakedaemon.net,linuxfoundation.org,vger.kernel.org,lists.infradead.org];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Lee,

Am 2020-04-23 19:45, schrieb Michael Walle:
> There might be multiple children with the device tree compatible, for
> example if a MFD has multiple instances of the same function. In this
> case only the first is matched and the other children get a wrong
> of_node reference.
> Add a new option to match also against the unit address of the child
> node. Additonally, a new helper OF_MFD_CELL_REG is added.


Do you think this is feasible? I guess this is the biggest uncertainty
for me at the moment in this patch series.

-michael

> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/mfd/mfd-core.c   | 29 ++++++++++++++++++++---------
>  include/linux/mfd/core.h | 26 ++++++++++++++++++++------
>  2 files changed, 40 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> index e735565969b3..4ecb376338f7 100644
> --- a/drivers/mfd/mfd-core.c
> +++ b/drivers/mfd/mfd-core.c
> @@ -117,6 +117,7 @@ static int mfd_add_device(struct device *parent, 
> int id,
>  	struct device_node *np = NULL;
>  	int ret = -ENOMEM;
>  	int platform_id;
> +	u32 of_reg;
>  	int r;
> 
>  	if (id == PLATFORM_DEVID_AUTO)
> @@ -151,16 +152,26 @@ static int mfd_add_device(struct device *parent, 
> int id,
> 
>  	if (parent->of_node && cell->of_compatible) {
>  		for_each_child_of_node(parent->of_node, np) {
> -			if (of_device_is_compatible(np, cell->of_compatible)) {
> -				if (!of_device_is_available(np)) {
> -					/* Ignore disabled devices error free */
> -					ret = 0;
> -					goto fail_alias;
> -				}
> -				pdev->dev.of_node = np;
> -				pdev->dev.fwnode = &np->fwnode;
> -				break;
> +			if (!of_device_is_compatible(np, cell->of_compatible))
> +				continue;
> +
> +			/* also match the unit address if set */
> +			if (cell->of_reg & MFD_OF_REG_VALID) {
> +				if (of_property_read_u32(np, "reg", &of_reg))
> +					continue;
> +				if ((cell->of_reg & MFD_OF_REG_MASK) != of_reg)
> +					continue;
>  			}
> +
> +			if (!of_device_is_available(np)) {
> +				/* Ignore disabled devices error free */
> +				ret = 0;
> +				goto fail_alias;
> +			}
> +
> +			pdev->dev.of_node = np;
> +			pdev->dev.fwnode = &np->fwnode;
> +			break;
>  		}
>  	}
> 
> diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
> index d01d1299e49d..c2c0ad6b14f3 100644
> --- a/include/linux/mfd/core.h
> +++ b/include/linux/mfd/core.h
> @@ -13,8 +13,11 @@
>  #include <linux/platform_device.h>
> 
>  #define MFD_RES_SIZE(arr) (sizeof(arr) / sizeof(struct resource))
> +#define MFD_OF_REG_VALID	BIT(31)
> +#define MFD_OF_REG_MASK		GENMASK(30, 0)
> 
> -#define MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat, 
> _match)\
> +#define MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat,	\
> +		     _of_reg, _match)					\
>  	{								\
>  		.name = (_name),					\
>  		.resources = (_res),					\
> @@ -22,24 +25,32 @@
>  		.platform_data = (_pdata),				\
>  		.pdata_size = (_pdsize),				\
>  		.of_compatible = (_compat),				\
> +		.of_reg = (_of_reg),					\
>  		.acpi_match = (_match),					\
>  		.id = (_id),						\
>  	}
> 
> +#define OF_MFD_CELL_REG(_name, _res, _pdata, _pdsize, _id, _compat,	\
> +			_of_reg)					\
> +	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat,	\
> +		     ((_of_reg) | MFD_OF_REG_VALID), NULL)		\
> +
>  #define OF_MFD_CELL(_name, _res, _pdata, _pdsize,_id, _compat)		\
> -	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat, NULL)	\
> +	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat,	\
> +		     0, NULL)						\
> 
>  #define ACPI_MFD_CELL(_name, _res, _pdata, _pdsize, _id, _match)	\
> -	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, _match)	\
> +	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, 0,	\
> +		     _match)						\
> 
>  #define MFD_CELL_BASIC(_name, _res, _pdata, _pdsize, _id)		\
> -	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, NULL)	\
> +	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, 0, NULL) \
> 
>  #define MFD_CELL_RES(_name, _res)					\
> -	MFD_CELL_ALL(_name, _res, NULL, 0, 0, NULL, NULL)		\
> +	MFD_CELL_ALL(_name, _res, NULL, 0, 0, NULL, 0, NULL)		\
> 
>  #define MFD_CELL_NAME(_name)						\
> -	MFD_CELL_ALL(_name, NULL, NULL, 0, 0, NULL, NULL)		\
> +	MFD_CELL_ALL(_name, NULL, NULL, 0, 0, NULL, 0, NULL)		\
> 
>  struct irq_domain;
>  struct property_entry;
> @@ -78,6 +89,9 @@ struct mfd_cell {
>  	 */
>  	const char		*of_compatible;
> 
> +	/* matching the reg property if set */
> +	unsigned int		of_reg;
> +
>  	/* Matches ACPI */
>  	const struct mfd_cell_acpi_match	*acpi_match;
