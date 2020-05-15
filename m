Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E07B1D4AEB
	for <lists+linux-pwm@lfdr.de>; Fri, 15 May 2020 12:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgEOK2y (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 15 May 2020 06:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728179AbgEOK2x (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 15 May 2020 06:28:53 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EE2C05BD0B
        for <linux-pwm@vger.kernel.org>; Fri, 15 May 2020 03:28:53 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id i15so2876775wrx.10
        for <linux-pwm@vger.kernel.org>; Fri, 15 May 2020 03:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xpA4uoROidais1iNpnkNzF9vq5C6X235V0wZ35uHdEI=;
        b=CXEYEEqcvkty6QbjHU8IC9+4m00nYkEX+SNv9RcxVR5/SFF+YXke+BvJ6oVoOabQdZ
         zNfD971SDDWzHM8i6tMy7Ide1qyTwoimukooCDQG010KoMF5GvG2qiwCDrJzTOJ/ST1J
         prbm8Ynnzt8vqseddRKMMZbinTDqtdohbq4rUwGgpc6TUwZFSsD+mzok7VbjTnaA+NPE
         7SxmiCj38OP6B2dbzDqJc0ZqywE58/rTxvAnd+HOSQ/e7PuK5vIet7N3V1P5fBuJTFqx
         810hQ3AwpINxJ1EOF2q5K54I50ZckVeqd/fsfxWyzTJVbsxau3rGuKWQxQF/tGuS+Hp3
         egGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xpA4uoROidais1iNpnkNzF9vq5C6X235V0wZ35uHdEI=;
        b=Ggh+5NhDa1hZplv01VTlK4ShyWprC86Anur6qbbj5mJP91AgNWebv6/id2ro7xMwVk
         1ui0mOY0X3Xora+pGwpHGANeb9AeGAInPhghKU06+mMPNIuyCY2UtmvuWCBlXLzTtnet
         QIEJ3g2NTdcELAndUWZGcZAiorz0vkl37flgZgI5DuhgXmwq+qPVdDmVvdU45Nvj6/AA
         Qr4BQXqFMAB6WHwv0m5/emCy0KStQ4Sc7QDnDl/4iUDAYYvlCSLiyIhAghQSTy92R/t7
         w3IUJVX4cOvYXiSIAJn58VseJOtpvjXGpcyt1lhk9ots3gP7w0Dt44scct3naKDq+Bwo
         4Hfg==
X-Gm-Message-State: AOAM533+9gfScgQqxYICXn4pWy/f5VKrywbu0J0+NZQsuCYwk2Wu6sko
        5CduXUId/myBZGeScgwgCgeXug==
X-Google-Smtp-Source: ABdhPJxTv+9YnkgoMuYBGuW3wQDNEiVk0bNzw09WJsjwgIV7JP0J+YUnU47dJL1yqsEb92xCMVOBXw==
X-Received: by 2002:adf:a1d7:: with SMTP id v23mr3514719wrv.155.1589538531500;
        Fri, 15 May 2020 03:28:51 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id j16sm2878629wru.13.2020.05.15.03.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 03:28:50 -0700 (PDT)
Date:   Fri, 15 May 2020 11:28:48 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
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
Message-ID: <20200515102848.GH271301@dell>
References: <20200423174543.17161-1-michael@walle.cc>
 <20200423174543.17161-4-michael@walle.cc>
 <67e90dafd67c285158c2c6f67f92edb7@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67e90dafd67c285158c2c6f67f92edb7@walle.cc>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 30 Apr 2020, Michael Walle wrote:

> Hi Lee,
> 
> Am 2020-04-23 19:45, schrieb Michael Walle:
> > There might be multiple children with the device tree compatible, for
> > example if a MFD has multiple instances of the same function. In this
> > case only the first is matched and the other children get a wrong
> > of_node reference.
> > Add a new option to match also against the unit address of the child
> > node. Additonally, a new helper OF_MFD_CELL_REG is added.
> 
> 
> Do you think this is feasible? I guess this is the biggest uncertainty
> for me at the moment in this patch series.

I think it sounds fine in principle.  So long as it doesn't change the
existing behaviour when of_reg isn't set.

> > Signed-off-by: Michael Walle <michael@walle.cc>
> > ---
> >  drivers/mfd/mfd-core.c   | 29 ++++++++++++++++++++---------
> >  include/linux/mfd/core.h | 26 ++++++++++++++++++++------
> >  2 files changed, 40 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> > index e735565969b3..4ecb376338f7 100644
> > --- a/drivers/mfd/mfd-core.c
> > +++ b/drivers/mfd/mfd-core.c
> > @@ -117,6 +117,7 @@ static int mfd_add_device(struct device *parent, int
> > id,
> >  	struct device_node *np = NULL;
> >  	int ret = -ENOMEM;
> >  	int platform_id;
> > +	u32 of_reg;
> >  	int r;
> > 
> >  	if (id == PLATFORM_DEVID_AUTO)
> > @@ -151,16 +152,26 @@ static int mfd_add_device(struct device *parent,
> > int id,
> > 
> >  	if (parent->of_node && cell->of_compatible) {
> >  		for_each_child_of_node(parent->of_node, np) {
> > -			if (of_device_is_compatible(np, cell->of_compatible)) {
> > -				if (!of_device_is_available(np)) {
> > -					/* Ignore disabled devices error free */
> > -					ret = 0;
> > -					goto fail_alias;
> > -				}
> > -				pdev->dev.of_node = np;
> > -				pdev->dev.fwnode = &np->fwnode;
> > -				break;
> > +			if (!of_device_is_compatible(np, cell->of_compatible))
> > +				continue;
> > +
> > +			/* also match the unit address if set */

Please use correct grammar in comments (leaving off the full-stop).

> > +			if (cell->of_reg & MFD_OF_REG_VALID) {
> > +				if (of_property_read_u32(np, "reg", &of_reg))
> > +					continue;
> > +				if ((cell->of_reg & MFD_OF_REG_MASK) != of_reg)
> > +					continue;
> >  			}
> > +
> > +			if (!of_device_is_available(np)) {
> > +				/* Ignore disabled devices error free */
> > +				ret = 0;
> > +				goto fail_alias;
> > +			}
> > +
> > +			pdev->dev.of_node = np;
> > +			pdev->dev.fwnode = &np->fwnode;
> > +			break;
> >  		}
> >  	}
> > 
> > diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
> > index d01d1299e49d..c2c0ad6b14f3 100644
> > --- a/include/linux/mfd/core.h
> > +++ b/include/linux/mfd/core.h
> > @@ -13,8 +13,11 @@
> >  #include <linux/platform_device.h>
> > 
> >  #define MFD_RES_SIZE(arr) (sizeof(arr) / sizeof(struct resource))
> > +#define MFD_OF_REG_VALID	BIT(31)

What about 64bit platforms?

> > +#define MFD_OF_REG_MASK		GENMASK(30, 0)
> > 
> > -#define MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat,
> > _match)\
> > +#define MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat,	\
> > +		     _of_reg, _match)					\
> >  	{								\
> >  		.name = (_name),					\
> >  		.resources = (_res),					\
> > @@ -22,24 +25,32 @@
> >  		.platform_data = (_pdata),				\
> >  		.pdata_size = (_pdsize),				\
> >  		.of_compatible = (_compat),				\
> > +		.of_reg = (_of_reg),					\
> >  		.acpi_match = (_match),					\
> >  		.id = (_id),						\
> >  	}
> > 
> > +#define OF_MFD_CELL_REG(_name, _res, _pdata, _pdsize, _id, _compat,	\
> > +			_of_reg)					\
> > +	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat,	\
> > +		     ((_of_reg) | MFD_OF_REG_VALID), NULL)		\
> > +
> >  #define OF_MFD_CELL(_name, _res, _pdata, _pdsize,_id, _compat)		\
> > -	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat, NULL)	\
> > +	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat,	\
> > +		     0, NULL)						\
> > 
> >  #define ACPI_MFD_CELL(_name, _res, _pdata, _pdsize, _id, _match)	\
> > -	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, _match)	\
> > +	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, 0,	\
> > +		     _match)						\
> > 
> >  #define MFD_CELL_BASIC(_name, _res, _pdata, _pdsize, _id)		\
> > -	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, NULL)	\
> > +	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, 0, NULL) \
> > 
> >  #define MFD_CELL_RES(_name, _res)					\
> > -	MFD_CELL_ALL(_name, _res, NULL, 0, 0, NULL, NULL)		\
> > +	MFD_CELL_ALL(_name, _res, NULL, 0, 0, NULL, 0, NULL)		\
> > 
> >  #define MFD_CELL_NAME(_name)						\
> > -	MFD_CELL_ALL(_name, NULL, NULL, 0, 0, NULL, NULL)		\
> > +	MFD_CELL_ALL(_name, NULL, NULL, 0, 0, NULL, 0, NULL)		\
> > 
> >  struct irq_domain;
> >  struct property_entry;
> > @@ -78,6 +89,9 @@ struct mfd_cell {
> >  	 */
> >  	const char		*of_compatible;
> > 
> > +	/* matching the reg property if set */

Proper grammar please.

"OF unit address for device matching"

> > +	unsigned int		of_reg;
> > +
> >  	/* Matches ACPI */
> >  	const struct mfd_cell_acpi_match	*acpi_match;

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
