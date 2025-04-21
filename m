Return-Path: <linux-pwm+bounces-5636-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3D2A9590B
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Apr 2025 00:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29C777A74E7
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 22:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B3621B9FC;
	Mon, 21 Apr 2025 22:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="hOocRdpg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249A121B9D1;
	Mon, 21 Apr 2025 22:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745273403; cv=none; b=F4OQtmffRMO/1FM7b65lLW8GBkLufFszGYeMTWYtM15z1BSwDg5dFI959+Lza0VxLR6CJBHrMiR/xafPyphlXpH5KDgiLjOYFMaGLYrcr5pZg3IiVSr5FeUmfbcBnEH90j/cCFMpNM8XJd4ziSk8PNcBSEmcpqd1nZ/hSbVcwVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745273403; c=relaxed/simple;
	bh=tv850H2+wRsyeWXPBxpH1hOF4r62lf8rnXMr78D3GwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tRlk/NF2pSpsJS+ftTp2cFXObKdHip5lzddUqRAS0OqMp9KczTf6M+z0PMmYf9ZouD6jS2MU6HcsBgaa6X8AIu5wBQLhZSbkanAEwMrkrqNiROB/5ZgpRQ0Y7CtHTm7j2ZkEzbIhwASEiERnHCFytG9WRaaeva6fHKoV4utMQ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=hOocRdpg; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5D605606;
	Tue, 22 Apr 2025 00:07:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1745273273;
	bh=tv850H2+wRsyeWXPBxpH1hOF4r62lf8rnXMr78D3GwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hOocRdpgdklk0XsZg51z195aWxWxkvH0D2I6gvC/xHzXnj1ONFLPFu4yAf6GDsdkw
	 vws+P2bRCIsH1qqTXjTzHZsshYAcZ6fwZMj0vUKLEzZCz0Sx2mEK2KNC2/ZwyIkzDA
	 es0nG0g7j/w/nBHBbzgZ7Q4zR+W00xgne1vfzH0Q=
Date: Tue, 22 Apr 2025 01:09:58 +0300
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
Subject: Re: [PATCH v2 14/17] mfd: adp5585: support getting vdd regulator
Message-ID: <20250421220958.GW17813@pendragon.ideasonboard.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
 <20250415-dev-adp5589-fw-v2-14-3a799c3ed812@analog.com>
 <20250421094801.GM29968@pendragon.ideasonboard.com>
 <dd63c35315c2e8252b1451fd44423c0c79e5be45.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd63c35315c2e8252b1451fd44423c0c79e5be45.camel@gmail.com>

Hi Nuno,

On Mon, Apr 21, 2025 at 01:38:47PM +0100, Nuno Sá wrote:
> On Mon, 2025-04-21 at 12:48 +0300, Laurent Pinchart wrote:
> > On Tue, Apr 15, 2025 at 03:49:30PM +0100, Nuno Sá via B4 Relay wrote:
> > > From: Nuno Sá <nuno.sa@analog.com>
> > > 
> > > Make sure we get and enable the VDD supply (if available).
> > 
> > Can the regulator be enabled only when needed ?
> > 
> 
> Hmm, I guess we could do that for the case where only the PWM device is
> "enabled". That said, I don't think the extra complexity for that really pays
> off...

Or when no GPIO is requested, or when the input device for the keypad is
not open ? Then can be handled with power optimization for OSC_EN on top
of this series.

> > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > > ---
> > >  drivers/mfd/adp5585.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> > > index
> > > c1d51d50dca6c9367d4a1b98a4f8bbec12dbf90b..667cc5bd0745f64eec60837ec3c00057af
> > > 0cddeb 100644
> > > --- a/drivers/mfd/adp5585.c
> > > +++ b/drivers/mfd/adp5585.c
> > > @@ -18,6 +18,7 @@
> > >  #include <linux/mod_devicetable.h>
> > >  #include <linux/module.h>
> > >  #include <linux/regmap.h>
> > > +#include <linux/regulator/consumer.h>
> > >  #include <linux/types.h>
> > >  
> > >  static const struct mfd_cell adp5585_devs[] = {
> > > @@ -849,6 +850,10 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
> > >  	adp5585->dev = &i2c->dev;
> > >  	adp5585->irq = i2c->irq;
> > >  
> > > +	ret = devm_regulator_get_enable(&i2c->dev, "vdd");
> > > +	if (ret)
> > > +		return ret;
> > > +
> > >  	adp5585->regmap = devm_regmap_init_i2c(i2c, info->regmap_config);
> > >  	if (IS_ERR(adp5585->regmap))
> > >  		return dev_err_probe(&i2c->dev, PTR_ERR(adp5585->regmap),

-- 
Regards,

Laurent Pinchart

