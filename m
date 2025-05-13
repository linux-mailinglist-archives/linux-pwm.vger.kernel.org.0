Return-Path: <linux-pwm+bounces-5955-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF4BAB587D
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 17:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 749BA4C0854
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 15:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1362BE11F;
	Tue, 13 May 2025 15:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Fhtj/8UV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11334E552;
	Tue, 13 May 2025 15:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747149601; cv=none; b=kM/RwWb956mlRnxknc/KxsFOUAdp/Z3Ceby3SRejyyxWESv70nZ2dCEVKvdvh9AWseJgUWLNdAns4bt59gTzV431aLCt0vUp+/B01ue0EUxRnwdIGgsFRKKPtko0ARVhmFiHXxtFXqm1SllmwIr9W00TgjAMrGfK3jidDdn9rDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747149601; c=relaxed/simple;
	bh=f1aHhmyioVFKbkY8CdahzJyEqA4BsgJMIKLn/n1wOpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyCxRM1NK53Us2/abO2cXHzamQw3Z0w0Hp2QpfcV/qGuro+tRWthoLUvPuhVSNV+CYxPwHZ6Zf0uoN/VJ1AmQgb6qQOE9AbkvpQfekw7W9MgAfieBmSSrlp54Qi4N3ZsFJVKDvf5U0bYM+gx8h8wLt345kspky3YIIM285UK0W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Fhtj/8UV; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (unknown [146.0.27.149])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id EB1E04C9;
	Tue, 13 May 2025 17:19:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1747149581;
	bh=f1aHhmyioVFKbkY8CdahzJyEqA4BsgJMIKLn/n1wOpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fhtj/8UVLWgqJatoAnist/8/F0/lPFu2pyBdk/cFtwYBZGu/RmYIyXLBYZfGJStA4
	 ZBVLlqZzwBV6zLEjHcf7Av3d2eLVDR+VUFzU2LcJgYMOyR8OimRVgp4WIt+A5+eFMs
	 AEiOZlQHXTX3ehIipnFLIJv14xiO4ibBicS59HZs=
Date: Tue, 13 May 2025 17:19:48 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Lee Jones <lee@kernel.org>, nuno.sa@analog.com,
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-input@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH v3 02/22] mfd: adp5585: only add devices given in FW
Message-ID: <20250513151948.GA23592@pendragon.ideasonboard.com>
References: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
 <20250512-dev-adp5589-fw-v3-2-092b14b79a88@analog.com>
 <20250513143450.GM2936510@google.com>
 <8863db9b433d4911abba4480bb6ac59f799ed5c5.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8863db9b433d4911abba4480bb6ac59f799ed5c5.camel@gmail.com>

On Tue, May 13, 2025 at 04:02:11PM +0100, Nuno Sá wrote:
> On Tue, 2025-05-13 at 15:34 +0100, Lee Jones wrote:
> > On Mon, 12 May 2025, Nuno Sá via B4 Relay wrote:
> > 
> > > From: Nuno Sá <nuno.sa@analog.com>
> > > 
> > > Not all devices (features) of the adp5585 device are mandatory to be
> > > used in all platforms. Hence, check what's given in FW and dynamically
> > > create the mfd_cell array to be given to devm_mfd_add_devices().
> > > 
> > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > > ---
> > >  drivers/mfd/adp5585.c | 45 +++++++++++++++++++++++++++++++++++++++++----
> > >  1 file changed, 41 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> > > index
> > > 160e0b38106a6d78f7d4b7c866cb603d96ea673e..02f9e8c1c6a1d8b9516c060e0024d69886
> > > e9fb7a 100644
> > > --- a/drivers/mfd/adp5585.c
> > > +++ b/drivers/mfd/adp5585.c
> > > @@ -17,7 +17,13 @@
> > >  #include <linux/regmap.h>
> > >  #include <linux/types.h>
> > >  
> > > -static const struct mfd_cell adp5585_devs[] = {
> > > +enum {
> > > +	ADP5585_DEV_GPIO,
> > > +	ADP5585_DEV_PWM,
> > > +	ADP5585_DEV_MAX
> > > +};
> > > +
> > > +static const struct mfd_cell adp5585_devs[ADP5585_DEV_MAX] = {
> > >  	{ .name = "adp5585-gpio", },
> > >  	{ .name = "adp5585-pwm", },
> > >  };
> > > @@ -110,12 +116,40 @@ static const struct regmap_config
> > > adp5585_regmap_configs[] = {
> > >  	},
> > >  };
> > >  
> > > +static int adp5585_parse_fw(struct device *dev, struct adp5585_dev
> > > *adp5585,
> > > +			    struct mfd_cell **devs)
> > > +{
> > > +	unsigned int has_pwm = 0, has_gpio = 0, rc = 0;
> > > +
> > > +	if (device_property_present(dev, "#pwm-cells"))
> > > +		has_pwm = 1;
> > 
> > This is a little sloppy.  Instead of using throwaway local variables, do
> > what you're going to do in the if statement.
> 
> Then I would need to realloc my device cells... But as I realized below, this is
> indeed not needed.
> 
> > > +	if (device_property_present(dev, "#gpio-cells"))
> > > +		has_gpio = 1;
> > > +
> > > +	if (!has_pwm && !has_gpio)
> > > +		return -ENODEV;
> > 
> > Are we really dictating which child devices to register based on random
> > DT properties?  Why not register them anyway and have them fail if the

The properties are not random.

> > information they need is not available?  Missing / incorrect properties
> > usually get a -EINVAL.
> 
> Well, this was something Laurent asked for... In the previous version I was
> registering all the devices unconditionally.

Registering them all means we'll get error messages in the kernel log
when the corresponding drivers will probe, while nothing is actually
wrong. That's fairly confusing for the user.

In an ideal situation we would have child nodes in DT and only register
child devices for existing child nodes. Unfortunately the DT bindings
were not designed that way, so we have to live with the current
situation.

> > > +	*devs = devm_kcalloc(dev, has_pwm + has_gpio, sizeof(struct mfd_cell),
> > > +			     GFP_KERNEL);
> > > +	if (!*devs)
> > > +		return -ENOMEM;
> > > +
> > > +	if (has_pwm)
> > > +		(*devs)[rc++] = adp5585_devs[ADP5585_DEV_PWM];
> > > +	if (has_gpio)
> > > +		(*devs)[rc++] = adp5585_devs[ADP5585_DEV_GPIO];
> > 
> > Passing around pointers to pointers for allocation (and later, pointer
> > to functions) is not the way we wish to operate.  See how all of the
> > other MFD drivers handle selective sub-drivers.
> 
> Any pointer from the top of your head (example driver)? Honestly, I do not see
> this being that bad. Pretty much is a dynamic array of struct mfd_cel but
> anyways, no strong feelings

I don't find it that bad either. I don't think you should use
devm_kcalloc() though, as the memory should be freed as soon as it's not
needed anymore.

> But... I was actually being very stupid. First I did looked at an API to only

Occasionally overseeing a possible solution isn't being stupid. Or at
least I hope it isn't, otherwise I would be very stupid too.

> add one mfd device and failed to realize that I can use devm_mfd_add_devices()
> with n_devs = 1
> 
> Nevermind, will refactor in v4
> 
> > > +	return rc;
> > > +}
> > > +
> > >  static int adp5585_i2c_probe(struct i2c_client *i2c)
> > >  {
> > >  	const struct regmap_config *regmap_config;
> > >  	struct adp5585_dev *adp5585;
> > > +	struct mfd_cell *devs;
> > >  	unsigned int id;
> > > -	int ret;
> > > +	int ret, n_devs;
> > >  
> > >  	adp5585 = devm_kzalloc(&i2c->dev, sizeof(*adp5585), GFP_KERNEL);
> > >  	if (!adp5585)
> > > @@ -138,9 +172,12 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
> > >  		return dev_err_probe(&i2c->dev, -ENODEV,
> > >  				     "Invalid device ID 0x%02x\n", id);
> > >  
> > > +	n_devs = adp5585_parse_fw(&i2c->dev, adp5585, &devs);
> > > +	if (n_devs < 0)
> > > +		return n_devs;
> > > +
> > >  	ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO,
> > > -				   adp5585_devs, ARRAY_SIZE(adp5585_devs),
> > > -				   NULL, 0, NULL);
> > > +				   devs, n_devs, NULL, 0, NULL);
> > >  	if (ret)
> > >  		return dev_err_probe(&i2c->dev, ret,
> > >  				     "Failed to add child devices\n");
> > > 

-- 
Regards,

Laurent Pinchart

