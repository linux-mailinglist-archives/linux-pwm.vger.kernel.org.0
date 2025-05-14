Return-Path: <linux-pwm+bounces-5981-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BE5AB665E
	for <lists+linux-pwm@lfdr.de>; Wed, 14 May 2025 10:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 370C63A30EE
	for <lists+linux-pwm@lfdr.de>; Wed, 14 May 2025 08:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4AE2063F0;
	Wed, 14 May 2025 08:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQ0E9RTM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092F9111BF;
	Wed, 14 May 2025 08:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747212395; cv=none; b=Yj6mDkyVVfgy3bqVf1Fu/0KOmPkBezobJ9+FELViyz5wQp67I/SeBSVddVOrGCZVB0M/KP98TNx7UwOkfAITo7uMnKAvDIEXoKxqqs6yQnxZ0iHwPbu+TYCbhfqnHyOCt0rvXci20AUSyXI4JSOwFc/3nIedeAMa6+/0s1olE84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747212395; c=relaxed/simple;
	bh=+FziuHAd3n+I7YzGXttveC9sX9cxjUEO7hqQ2K7xh6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFKyuPMr9WDnbS6V54q1d+6i8xd+VY6FFwwjrvGP0opxFO1PuYxF01DrKhVQOQoNYLPt3sjsMA1qGcV6TnGzz6tXxjcIteEF4L7JnCcbMW4JPZmYei3MLP+eZWm2ZgbCJ/BAtFxFgNQP8+pbIaKY2PaXfMMFJSIXmmLomeGao6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQ0E9RTM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA81FC4CEEB;
	Wed, 14 May 2025 08:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747212394;
	bh=+FziuHAd3n+I7YzGXttveC9sX9cxjUEO7hqQ2K7xh6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hQ0E9RTMWUqk5d5e/4qiiue+BJfRjNpcInfzsR8YzeX7h+vGqameVZTtOHTvc8piR
	 t+IFQG2n/+RT2UBlPfLsOyUVLIlGsKW2F8D3NeQ8fXeGv/fhZQoMYdipDv8sTR1Kda
	 /4XQQGN5V44SOaQL8EYepNEaKN2Q2KBB/3jaw8F45XTJY/TiKEcrFTZt3zo9cF8IRZ
	 ObU65ZgbDxe2LQjdkhf2C//jG4CClaTnzgBjWT0kQjvtOB6hLgrBQ+EWieBEZBiMFS
	 vfonrKfHk4PUTzF3hjBAks85kJAvgFActy0W/ELO5Qn4AYy69j4glK8KpTOnhTzPWF
	 9DiiahBh25iTw==
Date: Wed, 14 May 2025 09:46:28 +0100
From: Lee Jones <lee@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>,
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-input@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH v3 14/22] mfd: adp5585: support reset and unlock events
Message-ID: <20250514084628.GZ2936510@google.com>
References: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
 <20250512-dev-adp5589-fw-v3-14-092b14b79a88@analog.com>
 <20250513162246.GV2936510@google.com>
 <20250514083541.GG23592@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250514083541.GG23592@pendragon.ideasonboard.com>

On Wed, 14 May 2025, Laurent Pinchart wrote:

> On Tue, May 13, 2025 at 05:22:46PM +0100, Lee Jones wrote:
> > On Mon, 12 May 2025, Nuno Sá via B4 Relay wrote:
> > 
> > > From: Nuno Sá <nuno.sa@analog.com>
> > > 
> > > The ADP558x family of devices can be programmed to respond to some
> > > especial events, In case of the unlock events, one can lock the keypad
> > > and use KEYS or GPIs events to unlock it. For the reset events, one can
> > > again use a combinations of GPIs/KEYs in order to generate an event that
> > > will trigger the device to generate an output reset pulse.
> > > 
> > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > > ---
> > >  drivers/mfd/adp5585.c       | 279 ++++++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/mfd/adp5585.h |  41 +++++++
> > >  2 files changed, 320 insertions(+)
> > > 
> > > diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> > > index 5851ad30e7323bbb891878167d0786bc60ef5d90..b1227a390fe2f932ba8060b0d722f53f45ec3b4b 100644
> > > --- a/drivers/mfd/adp5585.c
> > > +++ b/drivers/mfd/adp5585.c
> > > @@ -157,6 +157,9 @@ static const struct adp5585_regs adp5585_regs = {
> > >  	.int_en = ADP5585_INT_EN,
> > >  	.gen_cfg = ADP5585_GENERAL_CFG,
> > >  	.poll_ptime_cfg = ADP5585_POLL_PTIME_CFG,
> > > +	.reset_cfg = ADP5585_RESET_CFG,
> > > +	.reset1_event_a = ADP5585_RESET1_EVENT_A,
> > > +	.reset2_event_a = ADP5585_RESET2_EVENT_A,
> > >  };
> > >  
> > >  static const struct adp5585_regs adp5589_regs = {
> > > @@ -164,8 +167,52 @@ static const struct adp5585_regs adp5589_regs = {
> > >  	.int_en = ADP5589_INT_EN,
> > >  	.gen_cfg = ADP5589_GENERAL_CFG,
> > >  	.poll_ptime_cfg = ADP5589_POLL_PTIME_CFG,
> > > +	.reset_cfg = ADP5589_RESET_CFG,
> > > +	.reset1_event_a = ADP5589_RESET1_EVENT_A,
> > > +	.reset2_event_a = ADP5589_RESET2_EVENT_A,
> > >  };
> > >  
> > > +static int adp5585_validate_event(const struct adp5585_dev *adp5585,
> > > +				  unsigned int ev, bool has_pin5)
> > 
> > has_pin5 (which doesn't actually mean much to me) is passed around a lot
> > and is only used in one place, as far as I can see.  You also have 'dev'
> > available here, so why not drop it everywhere and call
> > 
> >    if (!device_property_present(dev, "gpio-reserved-ranges"))
> > 
> > ... here instead?
> 
> The information can be stored in struct adp5585_dev. I wouldn't call
> device_property_present() here, as that's costly.

Does this function get called a lot?

Storing in the device data is also good.

> > > +{
> > > +	if (has_pin5) {
> > > +		if (ev >= ADP5585_ROW5_KEY_EVENT_START && ev <= ADP5585_ROW5_KEY_EVENT_END)
> > > +			return 0;
> > > +		if (ev >= ADP5585_GPI_EVENT_START && ev <= ADP5585_GPI_EVENT_END)
> > > +			return 0;
> > > +
> > > +		return dev_err_probe(adp5585->dev, -EINVAL,
> > > +				     "Invalid unlock/reset event(%u) for this device\n", ev);
> > > +	}
> > > +
> > > +	if (ev >= ADP5585_KEY_EVENT_START && ev <= ADP5585_KEY_EVENT_END)
> > > +		return 0;
> > > +	if (ev >= ADP5585_GPI_EVENT_START && ev <= ADP5585_GPI_EVENT_END) {
> > > +		/* if it's GPI5 */
> > > +		if (ev == (ADP5585_GPI_EVENT_START + 5))
> > > +			return dev_err_probe(adp5585->dev, -EINVAL,
> > > +					     "Invalid unlock/reset event(%u). R5 not available\n",
> > > +					     ev);
> > > +		return 0;
> > > +	}
> > > +
> > > +	return dev_err_probe(adp5585->dev, -EINVAL,
> > > +			     "Invalid unlock/reset event(%u) for this device\n", ev);
> > > +}
> > > +
> > > +static int adp5589_validate_event(const struct adp5585_dev *adp5585,
> > > +				  unsigned int ev, bool has_pin5)
> > > +{
> > > +	if (ev >= ADP5589_KEY_EVENT_START && ev <= ADP5589_KEY_EVENT_END)
> > > +		return 0;
> > > +	if (ev >= ADP5589_GPI_EVENT_START && ev <= ADP5589_GPI_EVENT_END)
> > > +		return 0;
> > > +
> > > +	return dev_err_probe(adp5585->dev, -EINVAL,
> > > +			     "Invalid unlock/reset event(%u) for this device\n",
> > > +			     ev);
> > > +}
> > > +
> > >  static int adp5585_fill_chip_configs(struct adp5585_dev *adp5585,
> > >  				     struct i2c_client *i2c,
> > >  				     struct regmap_config *regmap_config)
> > > @@ -180,10 +227,13 @@ static int adp5585_fill_chip_configs(struct adp5585_dev *adp5585,
> > >  	case ADP5585_MAN_ID_VALUE:
> > >  		*regmap_config = adp5585_regmap_config_template;
> > >  		info->regs = &adp5585_regs;
> > > +		info->validate_event = adp5585_validate_event;
> > 
> > I'd take an extra if() / switch() over a driver-level pointer to a function.
> 
> Funny how we have different tastes for this kind of things, I find the
> function pointer more readable :-)

Contributors have tried to do "interesting" things with function
pointers in MFD in the past.  To the point were I now have a general
aversion to them.  I think they're great for things like subsystem-level
Ops, but beyond that, things _can_ get messy, fast.

-- 
Lee Jones [李琼斯]

