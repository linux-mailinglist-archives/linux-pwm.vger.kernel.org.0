Return-Path: <linux-pwm+bounces-5634-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BAAA958D9
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Apr 2025 00:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABCF31896BD5
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 22:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528A8221FA1;
	Mon, 21 Apr 2025 22:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="a8BO/IX5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7633221F0A;
	Mon, 21 Apr 2025 22:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745273018; cv=none; b=ESPd8xWdZQ5ODy1Ofgjt4E4N7TJIF13S6TmeNh3iVpAdkTy1EWQovBjt4oDtxRPMPkxRLIIg+0iJCBwsUFwcCHiMz7YLz0FCv6eFaI0pseZ2rr+h7FS8NWk7Qx0BuqeakV9hjfOwixyVhkp28R7MwQWJHef6e9MaYkP+dkobQC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745273018; c=relaxed/simple;
	bh=L4Vm17wQXJt18C/sghPsQAjFU4r6TeOLbu1yYf7tbM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aibYZGcBo4VYtKo29jU91CwNonLiggMk1sFEWnmxWxrmyH1j08iiGOBMDQZX5oNIfZjfkDpwcg23P7FKFwz7SPbIbb81UhU6VtMktZXvTZVE5yLHaKbjtpkKqhttVFZSFlWBINPfMW7Q1L1Mw3nn8OrVWE9cIAbOqArqaNkvRBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=a8BO/IX5; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id BBB10F01;
	Tue, 22 Apr 2025 00:01:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1745272887;
	bh=L4Vm17wQXJt18C/sghPsQAjFU4r6TeOLbu1yYf7tbM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a8BO/IX52LNbxPTSI8RPpLv5mqe8JTQvgdkJE/68qzmONPMzE3XLo2f2aLcNddFhs
	 TIkb7OvPuB/wBhVg65fCTnrbZfunWW3rzBsciPMHY1HV6VzyCJg7jfj23gr5Zvr3ic
	 UhiAttG0hGeDYco1X6yNOI1cAIHyF2W/EsxSH2Kw=
Date: Tue, 22 Apr 2025 01:03:32 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: nuno.sa@analog.com, linux-gpio@vger.kernel.org,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-input@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH v2 02/17] mfd: adp5585: enable oscilator during probe
Message-ID: <20250421220332.GU17813@pendragon.ideasonboard.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
 <20250415-dev-adp5589-fw-v2-2-3a799c3ed812@analog.com>
 <20250421085758.GB29968@pendragon.ideasonboard.com>
 <aadec5eae6645e3e9c2f8f09dcf842510515122f.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aadec5eae6645e3e9c2f8f09dcf842510515122f.camel@gmail.com>

Hi Nuno,

On Mon, Apr 21, 2025 at 01:14:28PM +0100, Nuno Sá wrote:
> On Mon, 2025-04-21 at 11:57 +0300, Laurent Pinchart wrote:
> > On Tue, Apr 15, 2025 at 03:49:18PM +0100, Nuno Sá via B4 Relay wrote:
> > > From: Nuno Sá <nuno.sa@analog.com>
> > > 
> > > Make sure to enable the oscillator in the top device. This will allow to
> > > not control this in the child PWM device as that would not work with
> > > future support for keyboard matrix where the oscillator needs to be
> > > always enabled (and so cannot be disabled by disabling PWM).
> > 
> > Setting this bit unconditionally increases power consumption. It should
> > only be set when needed.
> 
> Well, not sure if the effort for that pays off... The only usecase were it would
> make sense to do that would be for PWM. For the other devices (and assuming I'm
> right with the GPI case) we need this always set.

For the keypad, can't the device be kept powered off if the input device
exposed to userspace is not open ? And for GPIOs, OSC_EN isn't needed
when all requested GPIOs are configured as outputs, as far as I can
tell.

I'm fine addressing this issue on top of this series.

> > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > > ---
> > >  drivers/mfd/adp5585.c | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > > 
> > > diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> > > index
> > > 160e0b38106a6d78f7d4b7c866cb603d96ea673e..f17b5f2474cac6a403556694066f438288
> > > 264a49 100644
> > > --- a/drivers/mfd/adp5585.c
> > > +++ b/drivers/mfd/adp5585.c
> > > @@ -110,6 +110,13 @@ static const struct regmap_config adp5585_regmap_configs[] = {
> > >  	},
> > >  };
> > >  
> > > +static void adp5585_osc_disable(void *data)
> > > +{
> > > +	const struct adp5585_dev *adp5585 = data;
> > > +
> > > +	regmap_write(adp5585->regmap, ADP5585_GENERAL_CFG, 0);
> > > +}
> > > +
> > >  static int adp5585_i2c_probe(struct i2c_client *i2c)
> > >  {
> > >  	const struct regmap_config *regmap_config;
> > > @@ -138,6 +145,15 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
> > >  		return dev_err_probe(&i2c->dev, -ENODEV,
> > >  				     "Invalid device ID 0x%02x\n", id);
> > >  
> > > +	ret = regmap_set_bits(adp5585->regmap, ADP5585_GENERAL_CFG,
> > > +			      ADP5585_OSC_EN);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = devm_add_action_or_reset(&i2c->dev, adp5585_osc_disable, adp5585);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > >  	ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO,
> > >  				   adp5585_devs, ARRAY_SIZE(adp5585_devs),
> > >  				   NULL, 0, NULL);

-- 
Regards,

Laurent Pinchart

