Return-Path: <linux-pwm+bounces-6327-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4BFAD7622
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Jun 2025 17:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEF283B5907
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Jun 2025 15:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B1729DB7E;
	Thu, 12 Jun 2025 15:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hxhzogt2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC91329DB68;
	Thu, 12 Jun 2025 15:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749741637; cv=none; b=ExTRwlcR7m4xUNcmAFWl1gmnovJCxrbq26F6myKU0wYb9XPggREXMqrEZ5qlzbrV7Myx49X8pRvZhYTaBU/hjU9gj8M8b4yGTaf3Am/6ZXfH9g9IrmHoCs8jxWum4GJ3q7IlPQVjI9UKm2paJyFGMu1bXIcpG7ptvKQj4xHtz1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749741637; c=relaxed/simple;
	bh=Dw+5SN04E/qbU62qNOsbR5TmNjRSAAmGNq1xSE5F7yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rr5dR8fW+Ku3bK2stHNaZJSrvDkkB8vTxq2e1lzKjsQu7uH13Fp/rEjU+dNNuOcUyOaBep22ES/7NA/oV1cpS/T4r9ggLSJYnd69KVP6l6/YjIIWgh9tG6zsZyAHbvSuyT/5YxkdSTBfRfYOo+lqMbnxWRo6foDPi+/o2ngr0IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hxhzogt2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA9EC4CEEA;
	Thu, 12 Jun 2025 15:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749741634;
	bh=Dw+5SN04E/qbU62qNOsbR5TmNjRSAAmGNq1xSE5F7yQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hxhzogt2FI//5nXAAX2AKe3dNMqKxSC31GT2aDwGQvHAJQ+FAMGtxcOTh46U1/HlT
	 9MujscHMq67EXUAsISCmudzgzlqAR2pMwhpLBH/1R/7pCzoIq0o7swwG+7YC0oGN5e
	 +FSwB2ss+cT+yaw71LdAHYrxTJ8wGLbBlXrMbUUd+MGH3COkjGXPkRYTP/f9TrNgcx
	 9AUNJnyE7ye+qKmqCv89Yyn8DbIm0ZGMyHaAT/w5TswX0NErgAKC7A2GOd0/PiAxjp
	 rljncSksprYfxZoE93bDgms2NtXE/ui2RaXHy75zvouAKDv05imNZdogBjEIjojJxW
	 Rwcs/eZFfxkJQ==
Date: Thu, 12 Jun 2025 16:20:29 +0100
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
Subject: Re: [PATCH v4 03/20] mfd: adp5585: enable oscilator during probe
Message-ID: <20250612152029.GO381401@google.com>
References: <20250521-dev-adp5589-fw-v4-0-f2c988d7a7a0@analog.com>
 <20250521-dev-adp5589-fw-v4-3-f2c988d7a7a0@analog.com>
 <20250612142001.GH381401@google.com>
 <4736b759609a9939b3a99a5c87df0fd5518a6af0.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4736b759609a9939b3a99a5c87df0fd5518a6af0.camel@gmail.com>

On Thu, 12 Jun 2025, Nuno Sá wrote:

> On Thu, 2025-06-12 at 15:20 +0100, Lee Jones wrote:
> > On Wed, 21 May 2025, Nuno Sá via B4 Relay wrote:
> > 
> > > From: Nuno Sá <nuno.sa@analog.com>
> > > 
> > > Make sure to enable the oscillator in the top device. This will allow to
> > > not control this in the child PWM device as that would not work with
> > > future support for keyboard matrix where the oscillator needs to be
> > > always enabled (and so cannot be disabled by disabling PWM).
> > > 
> > > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > > ---
> > >  drivers/mfd/adp5585.c     | 23 +++++++++++++++++++++++
> > >  drivers/pwm/pwm-adp5585.c |  5 -----
> > >  2 files changed, 23 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> > > index
> > > 806867c56d6fb4ef1f461af26a424a3a05f46575..f3b74f7d6040413d066eb6dbaecfa3d5e6
> > > ee06bd 100644
> > > --- a/drivers/mfd/adp5585.c
> > > +++ b/drivers/mfd/adp5585.c
> > > @@ -147,6 +147,13 @@ static int adp5585_add_devices(struct device *dev)
> > >  	return ret;
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
> > > @@ -175,6 +182,22 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
> > >  		return dev_err_probe(&i2c->dev, -ENODEV,
> > >  				     "Invalid device ID 0x%02x\n", id);
> > >  
> > > +	/*
> > > +	 * Enable the internal oscillator, as it's shared between multiple
> > > +	 * functions.
> > > +	 *
> > > +	 * As a future improvement, power consumption could possibly be
> > > +	 * decreased in some use cases by enabling and disabling the
> > > oscillator
> > > +	 * dynamically based on the needs of the child drivers.
> > 
> > This is normal.  What's stopping us from doing this from the offset?
> 
> This is always needed when we have the input device registered. From my testing,
> we also need it for GPIOs configured as input. So basically the only reason this
> is not being done now is that it would not be trivial or really straightforward
> and honestly the series is already big enough :)

Agreed!

> Laurent also agreed with this not being mandatory now so hopefully it's also
> fine with you.

If there is no explicit plan to do this in the future, you may as well
remove the comment.  TODOs have a tendency to rot after code is
accepted.

-- 
Lee Jones [李琼斯]

