Return-Path: <linux-pwm+bounces-5968-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B99AB5957
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 18:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7C9E16B2D6
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 16:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27992BE0F4;
	Tue, 13 May 2025 16:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVRwQHpR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DF814A8B;
	Tue, 13 May 2025 16:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747152438; cv=none; b=Afp5Kmfwc9wcciTNNa6bUBVUQ2i4BiPxYHILR/A6LuEGWKyLZ7jwCJTgq5bq1t2DBgizTHZp0AcR0aXSJWKCieqM08LxSFj464xyE0FgXlXJsL7hcK57A58oMbnQVffI5dTYuWu2WnEo1QzSmoa9OuXnBLOyzh1anVwV9C4d3HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747152438; c=relaxed/simple;
	bh=F4oBU6YZM4f4oH4pP4Oqk4uFeV2QfLN5JGR0/4PM6iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtL2yaYN3UVYs6/mjPEIEIvkf+12CrLeltDLkXLYooHSlwbeUS3iHY6bbESgdxO/ewidI4MKalo84/cV5nSrVNRq1X/EdkVhQBOQ184Ou/y+wYiU1t/7/xm5Mh5NNC0tSAaGrS77606s4NgFDiM0yunc4ZChrzhSZsA43/YuYEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVRwQHpR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34568C4CEE4;
	Tue, 13 May 2025 16:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747152438;
	bh=F4oBU6YZM4f4oH4pP4Oqk4uFeV2QfLN5JGR0/4PM6iw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gVRwQHpRbxeOMKv6EXZ0T17kHIoXoPhLBwSvH61VdDaVJbxDYk5LRnBvm7cTBC5cs
	 NvLX488tozEjRLJaxtN5sWl9BjyVOwNCX3ZpTG7hThmqff4rqDy/GNqCg9CHzJSjFa
	 nBa+qQOK7O67myz7t4w3lOkIumbbz8EvDy7UThIQKggof955yX1cNNgfvix3CdWnrF
	 AF38sufSaruAzO1yHivhhNyqs8FQK+P6gmdkh5y6fxpovy//fN8AgZ9CQXTPdkOQA5
	 dx5p1ytZMEEGEJ0f0zAePLEEduEYhaKESanMeMpoPjmrwRu2829GNZYva0jGssGXAy
	 EHf50Q2b6tPyg==
Date: Tue, 13 May 2025 17:07:12 +0100
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
Subject: Re: [PATCH v3 03/22] mfd: adp5585: enable oscilator during probe
Message-ID: <20250513160712.GT2936510@google.com>
References: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
 <20250512-dev-adp5589-fw-v3-3-092b14b79a88@analog.com>
 <20250513142618.GL2936510@google.com>
 <12d73022533c250ecd5af696fbcb90dbad8fc88d.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12d73022533c250ecd5af696fbcb90dbad8fc88d.camel@gmail.com>

On Tue, 13 May 2025, Nuno Sá wrote:
> On Tue, 2025-05-13 at 15:26 +0100, Lee Jones wrote:
> > On Mon, 12 May 2025, Nuno Sá via B4 Relay wrote:
> > 
> > > From: Nuno Sá <nuno.sa@analog.com>
> > > 
> > > Make sure to enable the oscillator in the top device. This will allow to
> > > not control this in the child PWM device as that would not work with
> > > future support for keyboard matrix where the oscillator needs to be
> > > always enabled (and so cannot be disabled by disabling PWM).
> > > 
> > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > > ---
> > >  drivers/mfd/adp5585.c | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > > 
> > > diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> > > index
> > > 02f9e8c1c6a1d8b9516c060e0024d69886e9fb7a..d693b1ead05128e02f671ca465f9c72cab
> > > 3b3395 100644
> > > --- a/drivers/mfd/adp5585.c
> > > +++ b/drivers/mfd/adp5585.c
> > > @@ -143,6 +143,13 @@ static int adp5585_parse_fw(struct device *dev, struct
> > > adp5585_dev *adp5585,
> > >  	return rc;
> > >  }
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
> > > @@ -176,6 +183,15 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
> > >  	if (n_devs < 0)
> > >  		return n_devs;
> > >  
> > > +	ret = regmap_set_bits(adp5585->regmap, ADP5585_GENERAL_CFG,
> > > +			      ADP5585_OSC_EN);
> > 
> > Nit: Consider unwrapping to 100-chars to avoid these simple line breaks.
> > 
> > Other than that, looks okay.
> 
> This topic is always hard as some other maintainers perfect the rule "keep the
> 80 char and only go 100 if readability is hurt). Personally, I do prefer 100 so
> happy to do it here.

Yes, it like many things are subsystem / maintainer preference.

It's not the 1990's anymore - we have 4k monitors - they'll come around.

-- 
Lee Jones [李琼斯]

