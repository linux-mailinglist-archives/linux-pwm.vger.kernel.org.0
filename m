Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0601E136F
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2020 19:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391044AbgEYRge (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 May 2020 13:36:34 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:60753 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388230AbgEYRge (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 May 2020 13:36:34 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id DDEC922F2E;
        Mon, 25 May 2020 19:36:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1590428188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tccD7vzIYEWi1bFmktWHDapg7/kSp29lv3VkLLvN1aI=;
        b=f6dMxTFgq0dv3WcoUWQY3lGpKEI1zRaAo5vQ4eXD9W5/1IcgsbkQs2IprvSdGhntzf7+3s
        VjDUBiP0Ohl+I7F/gjvbCkc+SOXy34S18pA/Vg+5sV+GUZVZ6tYqTNQJ4NOoGbVDgMncOV
        VXE73fAV7Jnjk0n8FxO++uqxK4wM9EM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 25 May 2020 19:36:27 +0200
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
In-Reply-To: <20200515102848.GH271301@dell>
References: <20200423174543.17161-1-michael@walle.cc>
 <20200423174543.17161-4-michael@walle.cc>
 <67e90dafd67c285158c2c6f67f92edb7@walle.cc> <20200515102848.GH271301@dell>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <159e68b4ce53630ef906b2fcbca925bd@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Am 2020-05-15 12:28, schrieb Lee Jones:
> On Thu, 30 Apr 2020, Michael Walle wrote:
> 
>> Hi Lee,
>> 
>> Am 2020-04-23 19:45, schrieb Michael Walle:
>> > There might be multiple children with the device tree compatible, for
>> > example if a MFD has multiple instances of the same function. In this
>> > case only the first is matched and the other children get a wrong
>> > of_node reference.
>> > Add a new option to match also against the unit address of the child
>> > node. Additonally, a new helper OF_MFD_CELL_REG is added.
>> 
>> 
>> Do you think this is feasible? I guess this is the biggest uncertainty
>> for me at the moment in this patch series.
> 
> I think it sounds fine in principle.  So long as it doesn't change the
> existing behaviour when of_reg isn't set.
> 
>> > Signed-off-by: Michael Walle <michael@walle.cc>
>> > ---
>> >  drivers/mfd/mfd-core.c   | 29 ++++++++++++++++++++---------
>> >  include/linux/mfd/core.h | 26 ++++++++++++++++++++------
>> >  2 files changed, 40 insertions(+), 15 deletions(-)
>> >
>> > diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
>> > index e735565969b3..4ecb376338f7 100644
>> > --- a/drivers/mfd/mfd-core.c
>> > +++ b/drivers/mfd/mfd-core.c
>> > @@ -117,6 +117,7 @@ static int mfd_add_device(struct device *parent, int
>> > id,
>> >  	struct device_node *np = NULL;
>> >  	int ret = -ENOMEM;
>> >  	int platform_id;
>> > +	u32 of_reg;
>> >  	int r;
>> >
>> >  	if (id == PLATFORM_DEVID_AUTO)
>> > @@ -151,16 +152,26 @@ static int mfd_add_device(struct device *parent,
>> > int id,
>> >
>> >  	if (parent->of_node && cell->of_compatible) {
>> >  		for_each_child_of_node(parent->of_node, np) {
>> > -			if (of_device_is_compatible(np, cell->of_compatible)) {
>> > -				if (!of_device_is_available(np)) {
>> > -					/* Ignore disabled devices error free */
>> > -					ret = 0;
>> > -					goto fail_alias;
>> > -				}
>> > -				pdev->dev.of_node = np;
>> > -				pdev->dev.fwnode = &np->fwnode;
>> > -				break;
>> > +			if (!of_device_is_compatible(np, cell->of_compatible))
>> > +				continue;
>> > +
>> > +			/* also match the unit address if set */
> 
> Please use correct grammar in comments (leaving off the full-stop).
> 
>> > +			if (cell->of_reg & MFD_OF_REG_VALID) {
>> > +				if (of_property_read_u32(np, "reg", &of_reg))
>> > +					continue;
>> > +				if ((cell->of_reg & MFD_OF_REG_MASK) != of_reg)
>> > +					continue;
>> >  			}
>> > +
>> > +			if (!of_device_is_available(np)) {
>> > +				/* Ignore disabled devices error free */
>> > +				ret = 0;
>> > +				goto fail_alias;
>> > +			}
>> > +
>> > +			pdev->dev.of_node = np;
>> > +			pdev->dev.fwnode = &np->fwnode;
>> > +			break;
>> >  		}
>> >  	}
>> >
>> > diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
>> > index d01d1299e49d..c2c0ad6b14f3 100644
>> > --- a/include/linux/mfd/core.h
>> > +++ b/include/linux/mfd/core.h
>> > @@ -13,8 +13,11 @@
>> >  #include <linux/platform_device.h>
>> >
>> >  #define MFD_RES_SIZE(arr) (sizeof(arr) / sizeof(struct resource))
>> > +#define MFD_OF_REG_VALID	BIT(31)
> 
> What about 64bit platforms?

The idea was to have this as a logical number. I.e. for now you may only
have one subdevice per unique compatible string. In fact, if you have a
look at the ab8500.c, there are multiple "stericsson,ab8500-pwm"
subdevices. But there is only one DT node for all three of it. I guess
this works as long as you don't use phandles to reference the pwm node
in the device tree. Or you don't want to use device tree properties
per subdevice (for example the "timeout-sec" of a watchdog device).

So to circumvent this, I thought of having the unit-address (and thus
the "reg" property) to differentiate between multiple subdevices. Now
there is one special case for me: this board management controller
might be upgradable and it might change internally. Thus I came up
with that logical numbering of subdevices. Rob doesn't seem to be a
fan of that, though. Therefore, having bit 31 as a valid indicator
leaves you with 2^31 logical devices, which should be enough ;)

Rob proposed to have the internal offset as the unit-address. But
in that case I can also use devm_of_platform_populate() and don't
need the OF_MFD_CELL_REG; I'd just parse the reg offset in each
individual subdevice driver. But like I said, I wanted to keep the
internal offsets out of the device tree.

-michael

> 
>> > +#define MFD_OF_REG_MASK		GENMASK(30, 0)
>> >
>> > -#define MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat,
>> > _match)\
>> > +#define MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat,	\
>> > +		     _of_reg, _match)					\
>> >  	{								\
>> >  		.name = (_name),					\
>> >  		.resources = (_res),					\
>> > @@ -22,24 +25,32 @@
>> >  		.platform_data = (_pdata),				\
>> >  		.pdata_size = (_pdsize),				\
>> >  		.of_compatible = (_compat),				\
>> > +		.of_reg = (_of_reg),					\
>> >  		.acpi_match = (_match),					\
>> >  		.id = (_id),						\
>> >  	}
>> >
>> > +#define OF_MFD_CELL_REG(_name, _res, _pdata, _pdsize, _id, _compat,	\
>> > +			_of_reg)					\
>> > +	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat,	\
>> > +		     ((_of_reg) | MFD_OF_REG_VALID), NULL)		\
>> > +
>> >  #define OF_MFD_CELL(_name, _res, _pdata, _pdsize,_id, _compat)		\
>> > -	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat, NULL)	\
>> > +	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat,	\
>> > +		     0, NULL)						\
>> >
>> >  #define ACPI_MFD_CELL(_name, _res, _pdata, _pdsize, _id, _match)	\
>> > -	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, _match)	\
>> > +	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, 0,	\
>> > +		     _match)						\
>> >
>> >  #define MFD_CELL_BASIC(_name, _res, _pdata, _pdsize, _id)		\
>> > -	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, NULL)	\
>> > +	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, 0, NULL) \
>> >
>> >  #define MFD_CELL_RES(_name, _res)					\
>> > -	MFD_CELL_ALL(_name, _res, NULL, 0, 0, NULL, NULL)		\
>> > +	MFD_CELL_ALL(_name, _res, NULL, 0, 0, NULL, 0, NULL)		\
>> >
>> >  #define MFD_CELL_NAME(_name)						\
>> > -	MFD_CELL_ALL(_name, NULL, NULL, 0, 0, NULL, NULL)		\
>> > +	MFD_CELL_ALL(_name, NULL, NULL, 0, 0, NULL, 0, NULL)		\
>> >
>> >  struct irq_domain;
>> >  struct property_entry;
>> > @@ -78,6 +89,9 @@ struct mfd_cell {
>> >  	 */
>> >  	const char		*of_compatible;
>> >
>> > +	/* matching the reg property if set */
> 
> Proper grammar please.
> 
> "OF unit address for device matching"
> 
>> > +	unsigned int		of_reg;
>> > +
>> >  	/* Matches ACPI */
>> >  	const struct mfd_cell_acpi_match	*acpi_match;
