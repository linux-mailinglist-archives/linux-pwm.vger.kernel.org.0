Return-Path: <linux-pwm+bounces-2280-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0C48D3328
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 11:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40B701C23E57
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 09:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2253916A361;
	Wed, 29 May 2024 09:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="O3z2qT01"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C2133CFC;
	Wed, 29 May 2024 09:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716975357; cv=none; b=S8N87pzervtCDyTZjzlk3XSt3ZZnvOZNEMSW9KYRJVycANT7mIoCg9O8iqVKLJD/+sRG4xKu3L50wMHSlA+uyiB+Vd2Wt0mQ90azQ8Ds90FowNLjXuVO6dy7cSrqLETBDKbctGiHFIJZ53qB+kBaYq7+O5smEeyvkyd8P3s5+Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716975357; c=relaxed/simple;
	bh=hfsNSVa4Iha07dFb1XFlGFqEe5SlCuyXxb6CXKx53OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzpGMX3WRZhMVJqQ0LXpy57HY/wzPz04Nna82i9oc1HlWk3Puc4iq/a1ydo09JT8nJrYMA6ylSdPGXnLfoWN4OuwvlyF3PMFceuwQfu6To3wff/OHxkpK4IOUQaRqz3tMzGdvDq8fl7VJ1BKwW1Ddpb9WIDATxsD6mh2Kb8gBlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=O3z2qT01; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 016149CA;
	Wed, 29 May 2024 11:35:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1716975350;
	bh=hfsNSVa4Iha07dFb1XFlGFqEe5SlCuyXxb6CXKx53OE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O3z2qT01srHW4mUC/aH8rNQbe9GWy68p5BGB6AcEs5orkZFIpgTZbIvltaqoOoylv
	 V0Ch0Ujm3iOYwR6PQLk3rdCSA8wDC994rL2weam4FcDtGQwwMyFie+BqQloKiAXG+Z
	 CcwoLkRenJQeauMHmfqSRdRxg1NZc79X1fJC2im4=
Date: Wed, 29 May 2024 12:35:41 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Haibo Chen <haibo.chen@nxp.com>
Subject: Re: [PATCH v2 2/4] mfd: adp5585: Add Analog Devices ADP5585 core
 support
Message-ID: <20240529093541.GL1436@pendragon.ideasonboard.com>
References: <20240528190315.3865-1-laurent.pinchart@ideasonboard.com>
 <20240528190315.3865-3-laurent.pinchart@ideasonboard.com>
 <ZlYwJryxeZ2LAKYG@surfacebook.localdomain>
 <20240528201326.GA8500@pendragon.ideasonboard.com>
 <CAHp75VeHA8qH_S=KJjAMv24vGP=hmeN9wSt1_NPsRhBZfEYXXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VeHA8qH_S=KJjAMv24vGP=hmeN9wSt1_NPsRhBZfEYXXw@mail.gmail.com>

Hi Andy,

On Wed, May 29, 2024 at 08:44:26AM +0300, Andy Shevchenko wrote:
> On Tue, May 28, 2024 at 11:13 PM Laurent Pinchart wrote:
> > On Tue, May 28, 2024 at 10:27:34PM +0300, Andy Shevchenko wrote:
> > > Tue, May 28, 2024 at 10:03:12PM +0300, Laurent Pinchart kirjoitti:
> 
> ...
> 
> > > > +   depends on I2C && OF
> > >
> > > Why OF?
> >
> > Because the driver works on OF systems only.
> >
> > > No COMPILE_TEST?
> >
> > The driver won't compile without CONFIG_I2C, so I can use
> >
> >         depends on I2C
> >         depends on OF || COMPILE_TEST
> >
> > Do you think that's better ?
> 
> I think that dropping OF completely is the best.
> OF || COMPILE_TEST would work as well, but I still don't know why we need this.

For the same reason that many drivers depend on specific CONFIG_$ARCH.
They can't run on other platforms, the dependency hides the symbol for
users who can't use the driver. This driver works on OF platforms only.

> ...
> 
> > > + array_size.h
> > > + device.h // e.g., devm_kzalloc()
> > >
> > > > +#include <linux/module.h>
> > > > +#include <linux/moduleparam.h>
> > > > +#include <linux/init.h>
> > > > +#include <linux/slab.h>
> >
> > I'll drop those 3 headers, there's not needed anymore.
> >
> > > > +#include <linux/i2c.h>
> > >
> > > > +#include <linux/of.h>
> > > > +#include <linux/of_device.h>
> > >
> > > You don't need them, instead of proxying...
> >
> > of.h for of_device_get_match_data() and of_match_ptr(). I'll drop the
> > former, but I need the latter, so I'll keep of.h
> 
> Why do you need of_match_ptr()? What for?

That's actually not needed, I'll drop it.

> > of_device.h for historical reasons probably, I'll drop it.
> >
> > > > +#include <linux/mfd/core.h>
> > > > +#include <linux/mfd/adp5585.h>
> > >
> > > m is earlier than 'o', but with above drop no more issue :-)
> > >
> > > ...just include mod_devicetable.h.
> > >
> > > > +#include <linux/regmap.h>
> > >
> > > + types.h // e.g., u8
> 
> I assume that all marked with + in my previous reply you agree on?

If I don't reply to a particular comment it means I agree with it and
will address it, yes.

> ...
> 
> > > > +#define            ADP5585_MAN_ID(v)               (((v) & 0xf0) >> 4)
> > >
> > > GENMASK()
> >
> > This is not a mask. Or do you mean
> >
> >         (((v) & GENMASK(7, 4)) >> 4)
> >
> > ?
> 
> Yes.
> 
> > I think that's overkill.
> 
> Why? You have a mask, use it for less error prone code.

I'll change this to

diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
index fa4092a5c97f..924758b8a3cd 100644
--- a/drivers/mfd/adp5585.c
+++ b/drivers/mfd/adp5585.c
@@ -125,7 +125,7 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
 		return dev_err_probe(&i2c->dev, ret,
 				     "Failed to read device ID\n");
 
-	if (ADP5585_MAN_ID(id) != ADP5585_MAN_ID_VALUE)
+	if (id & ADP5585_MAN_ID_MASK != ADP5585_MAN_ID_VALUE)
 		return dev_err_probe(&i2c->dev, -ENODEV,
 				     "Invalid device ID 0x%02x\n", id);
 
diff --git a/include/linux/mfd/adp5585.h b/include/linux/mfd/adp5585.h
index f06a574afedf..f5776ee844dc 100644
--- a/include/linux/mfd/adp5585.h
+++ b/include/linux/mfd/adp5585.h
@@ -12,8 +12,8 @@
 #include <linux/bits.h>
 
 #define ADP5585_ID			0x00
-#define		ADP5585_MAN_ID(v)		(((v) & 0xf0) >> 4)
-#define		ADP5585_MAN_ID_VALUE		0x02
+#define		ADP5585_MAN_ID_VALUE		0x20
+#define		ADP5585_MAN_ID_MASK		GENMASK(7, 4)
 #define ADP5585_INT_STATUS		0x01
 #define ADP5585_STATUS			0x02
 #define ADP5585_FIFO_1			0x03

> ...
> 
> > > > +#define            ADP5585_Rx_PULL_CFG_MASK        (3)
> > >
> > > GENMASK()
> >
> > Not here, as this value is meant to be passed to ADP5585_Rx_PULL_CFG().
> 
> Why is it marked as a mask? Rename it to _ALL or alike.

It's a mask, but used as

	ADP5585_Rx_PULL_CFG(ADP5585_Rx_PULL_CFG_MASK)

We're reaching a level of bike-shedding that even I find impressive :-)
As with a few other of your review comments that I think are related to
personal taste more than anything else, I'll defer to the subsystem
maintainer and follow their preference on this one.

> ...
> 
> > > > +#define            ADP5585_C4_EXTEND_CFG_MASK      (1U << 6)
> > >
> > > > +#define            ADP5585_R4_EXTEND_CFG_MASK      (1U << 5)
> > >
> > > > +#define            ADP5585_R3_EXTEND_CFG_MASK      (3U << 2)
> > >
> > > > +#define            ADP5585_R0_EXTEND_CFG_MASK      (1U << 0)
> > >
> > > > +#define            ADP5585_OSC_FREQ_MASK           (3U << 5)
> > >
> > > BIT() / GENMASK()
> >
> > I'll use GENMASK for the masks.
> 
> For a single bit the BIT() is okay, and TBH I don't remember if
> GENMASK() supports h == l cases.

I've tested it and it works.

-- 
Regards,

Laurent Pinchart

