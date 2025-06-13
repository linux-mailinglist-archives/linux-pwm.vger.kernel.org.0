Return-Path: <linux-pwm+bounces-6339-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC56AD8CCD
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Jun 2025 15:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE28C3BAC5A
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Jun 2025 13:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7305A156C6F;
	Fri, 13 Jun 2025 13:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnNIZcbA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E213595A;
	Fri, 13 Jun 2025 13:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749820083; cv=none; b=eLmVIR4ZkkMel0xCATha1ErWdUOBMc74lOhaGfMrv/NMx4AY4p+cimEHffIXX44kfdAn2do6vSEy/dMj0o1LcgRgYZz+Rlz0byVydAJE7RGm7rmK8lDI3cRbu1WcHj315/fhR48Wzoc9Agot5khpwobqG9jKc4WwFtMedmS3gck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749820083; c=relaxed/simple;
	bh=DihGhdCE4zO5qqe2os0aYgPJEWq4j16e0Qs1aql7xj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtTBMoFLjyti7EaBqw5etTjjBoNeJor3aT5BFWPcmnlMiDORw+qpNhyImsB8wOT/Op77O6crmd6+pM3lry2HKHRZu7f96GaxMiUY6AbBU5Ww+C3Obfj6OsoCl2BxPPnHzUzeszB+28+k45I9tn9dsBGe/MGIvsn+vfjPYHHkkJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnNIZcbA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3126C4CEF2;
	Fri, 13 Jun 2025 13:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749820082;
	bh=DihGhdCE4zO5qqe2os0aYgPJEWq4j16e0Qs1aql7xj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FnNIZcbAhoaT8mPciMVlAPTKsSwO6tdKBW1I6PWOSQAX3Z5Y7avHkXrBPpO2SUzJq
	 QnTS47br4O2H9FatyP5aQHQ2yfGRx3xfiStGNZyf3g4f0Pfg0mYxliZxSpxSZ9DyFV
	 tMJtJ37BoVTXOuM80PjiH3FesrZXTtNfwaNbn5vFa0HHluO04Vzp5VLMhjaYr7GMKq
	 yv7ZHqesLUW/N2fqADDP9JLDGFZMDWEnAGSMVD36kMbayEDYzQzIETMEy3v/7hN8L4
	 ZaALA71at6ahDxAHAH2QjhkgdMcXvu9DD5KiZzZ6GssvpFMlWFUiAQvo7YqN5Fq99r
	 qjiyYNznE2Bxg==
Date: Fri, 13 Jun 2025 14:07:57 +0100
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
Subject: Re: [PATCH v4 13/20] mfd: adp5585: support reset and unlock events
Message-ID: <20250613130757.GQ381401@google.com>
References: <20250521-dev-adp5589-fw-v4-0-f2c988d7a7a0@analog.com>
 <20250521-dev-adp5589-fw-v4-13-f2c988d7a7a0@analog.com>
 <20250612145542.GK381401@google.com>
 <1fafdee7c86efdb4aebe3b1c4391f48807aa0aef.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1fafdee7c86efdb4aebe3b1c4391f48807aa0aef.camel@gmail.com>

On Fri, 13 Jun 2025, Nuno Sá wrote:

> On Thu, 2025-06-12 at 15:55 +0100, Lee Jones wrote:
> > On Wed, 21 May 2025, Nuno Sá via B4 Relay wrote:
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
> > >  drivers/mfd/adp5585.c       | 270
> > > +++++++++++++++++++++++++++++++++++++++++++-
> > >  include/linux/mfd/adp5585.h |  39 +++++++
> > >  2 files changed, 308 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> > > index
> > > dcc09c898dd7990b39e21cb2324fa66ae171a802..6737d622a7ed9f280c439399f3709ca816
> > > 2dee01 100644
> > > --- a/drivers/mfd/adp5585.c
> > > +++ b/drivers/mfd/adp5585.c
> > > @@ -170,6 +170,9 @@ static const struct adp5585_regs adp5585_regs = {
> > >  	.int_en = ADP5585_INT_EN,
> > >  	.gen_cfg = ADP5585_GENERAL_CFG,
> > >  	.poll_ptime_cfg = ADP5585_POLL_PTIME_CFG,
> > > +	.reset_cfg = ADP5585_RESET_CFG,
> > > +	.reset1_event_a = ADP5585_RESET1_EVENT_A,
> > > +	.reset2_event_a = ADP5585_RESET2_EVENT_A,
> > >  };
> > >  
> > >  static const struct adp5585_regs adp5589_regs = {
> > > @@ -177,8 +180,50 @@ static const struct adp5585_regs adp5589_regs = {
> > >  	.int_en = ADP5589_INT_EN,
> > >  	.gen_cfg = ADP5589_GENERAL_CFG,
> > >  	.poll_ptime_cfg = ADP5589_POLL_PTIME_CFG,
> > > +	.reset_cfg = ADP5589_RESET_CFG,
> > > +	.reset1_event_a = ADP5589_RESET1_EVENT_A,
> > > +	.reset2_event_a = ADP5589_RESET2_EVENT_A,
> > >  };
> > >  
> > > +static int adp5585_validate_event(const struct adp5585_dev *adp5585,
> > > unsigned int ev)
> > > +{
> > > +	if (adp5585->has_pin6) {
> > > +		if (ev >= ADP5585_ROW5_KEY_EVENT_START && ev <=
> > > ADP5585_ROW5_KEY_EVENT_END)
> > > +			return 0;
> > > +		if (ev >= ADP5585_GPI_EVENT_START && ev <=
> > > ADP5585_GPI_EVENT_END)
> > > +			return 0;
> > > +
> > > +		return dev_err_probe(adp5585->dev, -EINVAL,
> > > +				     "Invalid unlock/reset event(%u) for
> > > this device\n", ev);
> > > +	}
> > > +
> > > +	if (ev >= ADP5585_KEY_EVENT_START && ev <= ADP5585_KEY_EVENT_END)
> > > +		return 0;
> > > +	if (ev >= ADP5585_GPI_EVENT_START && ev <= ADP5585_GPI_EVENT_END) {
> > > +		/* if it's GPI6 */
> > 
> > You have to tell us why this is a problem.
> > 
> > Nit: Comments should start with an upper case char.
> 
> The error message kind of states the problem :). But I'll put it in the comment.

I don't think it does.  Remember, people reading this do not know the
H/W as well as you do.  How is GPI6 even related to R5?

> - Nuno Sá
> > 
> > > +		if (ev == (ADP5585_GPI_EVENT_START + 5))
> > > +			return dev_err_probe(adp5585->dev, -EINVAL,
> > > +					     "Invalid unlock/reset
> > > event(%u). R5 not available\n",
> > > +					     ev);
> > > +		return 0;
> > > +	}

[...]

-- 
Lee Jones [李琼斯]

