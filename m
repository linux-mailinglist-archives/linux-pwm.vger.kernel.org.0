Return-Path: <linux-pwm+bounces-6317-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 688D1AD738A
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Jun 2025 16:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 926A97B175D
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Jun 2025 14:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F3724DCFA;
	Thu, 12 Jun 2025 14:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lo5ghAy9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916F52F4317;
	Thu, 12 Jun 2025 14:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749737861; cv=none; b=UMuX0SrBHk3XkRuP02qr1FwARgcfBN//d+t1TrFxz0LM4nFYBKykwl7JcsSJMxcQma4tnjT1wmQTc/C3Y/asOHc7pj07x7yfWfDzyl/96z377Ijn+79BLfN4WfjhjjhPOaRYTix53xQVtBN8RnVQQNoaFyXjsxYXkFNOLKVNNnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749737861; c=relaxed/simple;
	bh=aXWAap/3SzO2kNQAqVr8dWDMLe0sawEzrRF3iN9Sodk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LaLLaEB0KrJUAfOxJDuYdB5g81xYfzZQ88tTLWG4Rv4qjsFjgj/B+cUgy3jh1fiu6qEZnNIpDsmtPqprlU65hOG5acUy6IPyMt3Vb9fWReiz3icosERQsyTfrxAB10RjkjZzT82bfklZrvf19G7/DQpu2Lbv45A7Xie9zaJp/tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lo5ghAy9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A96C4CEEA;
	Thu, 12 Jun 2025 14:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749737861;
	bh=aXWAap/3SzO2kNQAqVr8dWDMLe0sawEzrRF3iN9Sodk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lo5ghAy94vUuJkE72Scr3DZ1jADIzOX0MLZ7X/viCPJqH9gfYfWVPQYMfxWodbW0y
	 Trq/daO7+7XOLaw2ckGTW1eFQTEZCmSjNpO7s3sdmohqbRDlk6eowTgcrWXQ0bgh+X
	 2GZ9cQq6SYaoGGF/KFRI6jZrN8+ZtIyoxEo1tm/8OTos3ZoyRIjYBj8a20WhL/X5WG
	 gIo6pYmbcH5UVRY2Jr8Va6kO3ASM2aLe9kgzzL4v5ohDhX5UgTvKwpayfgqVkrmoXZ
	 NNqnNC8091AAXzYE+9FEQTK7f8IIfo3BEPf0xtizVQNTE8T82XTR4yi0oXmiNXiovz
	 4CiLFWsKIMaHw==
Date: Thu, 12 Jun 2025 15:17:35 +0100
From: Lee Jones <lee@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: nuno.sa@analog.com, linux-gpio@vger.kernel.org,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-input@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH v4 02/20] mfd: adp5585: only add devices given in FW
Message-ID: <20250612141735.GG381401@google.com>
References: <20250521-dev-adp5589-fw-v4-0-f2c988d7a7a0@analog.com>
 <20250521-dev-adp5589-fw-v4-2-f2c988d7a7a0@analog.com>
 <20250523145144.GF1378991@google.com>
 <196e5106d37121b394d0d70d34abeb33940c1de1.camel@gmail.com>
 <20250523151929.GJ1378991@google.com>
 <e8991f6ffbec759a6c8b21baa5adfe2dc7b3aa8c.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8991f6ffbec759a6c8b21baa5adfe2dc7b3aa8c.camel@gmail.com>

On Fri, 23 May 2025, Nuno Sá wrote:

> On Fri, 2025-05-23 at 16:19 +0100, Lee Jones wrote:
> > On Fri, 23 May 2025, Nuno Sá wrote:
> > 
> > > On Fri, 2025-05-23 at 15:51 +0100, Lee Jones wrote:
> > > > On Wed, 21 May 2025, Nuno Sá via B4 Relay wrote:
> > > > 
> > > > > From: Nuno Sá <nuno.sa@analog.com>
> > > > > 
> > > > > Not all devices (features) of the adp5585 device are mandatory to be
> > > > > used in all platforms. Hence, check what's given in FW and dynamically
> > > > > create the mfd_cell array to be given to devm_mfd_add_devices().
> > > > > 
> > > > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > > > > ---
> > > > >  drivers/mfd/adp5585.c | 48 +++++++++++++++++++++++++++++++++++++++-----
> > > > > ----
> > > > >  1 file changed, 39 insertions(+), 9 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> > > > > index
> > > > > 160e0b38106a6d78f7d4b7c866cb603d96ea673e..806867c56d6fb4ef1f461af26a424a
> > > > > 3a05
> > > > > f46575 100644
> > > > > --- a/drivers/mfd/adp5585.c
> > > > > +++ b/drivers/mfd/adp5585.c
> > > > > @@ -17,7 +17,13 @@
> > > > >  #include <linux/regmap.h>
> > > > >  #include <linux/types.h>
> > > > >  
> > > > > -static const struct mfd_cell adp5585_devs[] = {
> > > > > +enum {
> > > > > +	ADP5585_DEV_GPIO,
> > > > > +	ADP5585_DEV_PWM,
> > > > > +	ADP5585_DEV_MAX
> > > > > +};
> > > > > +
> > > > > +static const struct mfd_cell adp5585_devs[ADP5585_DEV_MAX] = {
> > > > >  	{ .name = "adp5585-gpio", },
> > > > >  	{ .name = "adp5585-pwm", },
> > > > >  };
> > > > > @@ -110,6 +116,37 @@ static const struct regmap_config
> > > > > adp5585_regmap_configs[] = {
> > > > >  	},
> > > > >  };
> > > > >  
> > > > > +static void adp5585_remove_devices(void *dev)
> > > > > +{
> > > > > +	mfd_remove_devices(dev);
> > > > > +}
> > > > > +
> > > > > +static int adp5585_add_devices(struct device *dev)
> > > > > +{
> > > > > +	int ret;
> > > > > +
> > > > > +	if (device_property_present(dev, "#pwm-cells")) {
> > > > > +		ret = mfd_add_devices(dev, PLATFORM_DEVID_AUTO,
> > > > > +				      &adp5585_devs[ADP5585_DEV_PWM],
> > > > > 1,
> > > > > NULL, 0, NULL);
> > > > > +		if (ret)
> > > > > +			return dev_err_probe(dev, ret, "Failed to add
> > > > > pwm
> > > > > device\n");
> > > > 
> > > > PWM is an acronym, it should be capitalised.
> > > > 
> > > > > +	}
> > > > > +
> > > > > +	if (device_property_present(dev, "#gpio-cells")) {
> > > > > +		ret = mfd_add_devices(dev, PLATFORM_DEVID_AUTO,
> > > > > +				      &adp5585_devs[ADP5585_DEV_GPIO],
> > > > > 1,
> > > > > NULL, 0, NULL);
> > > > > +		if (ret) {
> > > > > +			ret = dev_err_probe(dev, ret, "Failed to add
> > > > > gpio
> > > > > device\n");
> > > > 
> > > > Same with GPIO.
> > > > 
> > > > > +			goto out_error;
> > > > > +		}
> > > > > +	}
> > > > > +
> > > > > +	return devm_add_action_or_reset(dev, adp5585_remove_devices,
> > > > > dev);
> > > > 
> > > > We have 2 of these now.
> > > > 
> > > > Why do we need lots of unbinding functions?
> > > > 
> > > > What's wrong .remove() or devm_*()?
> > > 
> > > I do mention in the cover why I did not used devm_mfd_add_devices(). We
> > > would be
> > > adding an action per device and mfd_remove_devices() removes all of them in
> > > one
> > > call. Not that is an issue (I believe subsequent calls with be kind of no-
> > > ops)
> > > but this way felt more correct.
> > 
> > I haven't seen another device add a .remove() equivalent per device.
> > 
> > Why do you need it?  What's the use-case where this would become critical?
> 
> No sure I'm following you. I don't need a .remove() per device (or it is not
> critical to have one). I just went with this because devm_mfd_add_devices()
> would be adding more devres_add() than what we need given that
> mfd_remove_devices() removes all child devices at once. So, logically, the above
> makes sense to me. Now, I'm ok if you say, don't bother with this and just use 
> devm_mfd_add_devices() on every device we want to add.

If there is no specific reason for using it this way, I would simply
stick with the usual semantics and devm_* it.

-- 
Lee Jones [李琼斯]

