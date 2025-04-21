Return-Path: <linux-pwm+bounces-5637-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6CCA9590D
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Apr 2025 00:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1A9E3A4AAA
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 22:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3894021CFEF;
	Mon, 21 Apr 2025 22:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="lgQAR0Fd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D351F5828;
	Mon, 21 Apr 2025 22:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745273439; cv=none; b=r7Ei9qDbtjemnE/joqmUcBTs510RltdIXTe1TJpLsuqL/VSduevaQapCtK40XP8hFrvvImqm0XKaAGiVc26eYMYnx6q6dDEyDZ6/aA5Wzrj73yQz4V/eszISgBRzP/8zhtW8VHe01IFN39X/seM1tbBGPWDq7B+EQFdkXwbFsE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745273439; c=relaxed/simple;
	bh=88NytBEZx1M9q9QrFJivxJbV8CmDOKLcxY8UA3bDaD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHL3MtQpZwkVSpeJjp6Z8aKYNwQQx88nFLKpP5KlFCUtp1m9dI1YogAMFgA0fUKyPFzD9hcjLIob0au1EECBGqgGRgjw/J8yqP2OKmTDTGhJD0jYdQFeBIUWtefpI8hkeATrOGw4nJI7s1fER0Vv+cAC9+wTAHaNrKAh2GJptUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=lgQAR0Fd; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5CBD8606;
	Tue, 22 Apr 2025 00:08:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1745273309;
	bh=88NytBEZx1M9q9QrFJivxJbV8CmDOKLcxY8UA3bDaD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lgQAR0FdpiBjl69XZkOOLNIpTVw2i66GHRpM310ZWR3Ut+CuIcn4kel4muL99G4uL
	 xGYohHWc+JZmj19WS9jX9l9cZnqNX9UO10Gov0nZ+EFutOMENy6y1VVESTENpnGXWZ
	 IRVGXva+KebfAeLtsDgLwA8nvFZ6UDFSAqCy1rzI=
Date: Tue, 22 Apr 2025 01:10:34 +0300
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
Subject: Re: [PATCH v2 16/17] mfd: adp5585: add support for a reset pin
Message-ID: <20250421221034.GX17813@pendragon.ideasonboard.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
 <20250415-dev-adp5589-fw-v2-16-3a799c3ed812@analog.com>
 <20250421094636.GL29968@pendragon.ideasonboard.com>
 <66d72f83fd189b4f9a3bebb250a72a5258ef2218.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66d72f83fd189b4f9a3bebb250a72a5258ef2218.camel@gmail.com>

On Mon, Apr 21, 2025 at 01:42:43PM +0100, Nuno Sá wrote:
> On Mon, 2025-04-21 at 12:46 +0300, Laurent Pinchart wrote:
> > Hi Nuno,
> > 
> > Thank you for the patch.
> > 
> > On Tue, Apr 15, 2025 at 03:49:32PM +0100, Nuno Sá via B4 Relay wrote:
> > > From: Nuno Sá <nuno.sa@analog.com>
> > > 
> > > Make sure to perform an Hardware reset during probe  if the pin is given
> > > in FW.
> > > 
> > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > > ---
> > >  drivers/mfd/adp5585.c | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > > 
> > > diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> > > index
> > > 667cc5bd0745f64eec60837ec3c00057af0cddeb..2af110fb28054c8ad6709a9a42cb21919b
> > > e433e7 100644
> > > --- a/drivers/mfd/adp5585.c
> > > +++ b/drivers/mfd/adp5585.c
> > > @@ -12,6 +12,7 @@
> > >  #include <linux/device.h>
> > >  #include <linux/err.h>
> > >  #include <linux/i2c.h>
> > > +#include <linux/gpio/consumer.h>
> > 
> > Alphabetic order please.
> > 
> > >  #include <linux/mfd/adp5585.h>
> > >  #include <linux/mfd/core.h>
> > >  #include <linux/minmax.h>
> > > @@ -833,6 +834,7 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
> > >  {
> > >  	const struct adp5585_info *info;
> > >  	struct adp5585_dev *adp5585;
> > > +	struct gpio_desc *gpio;
> > >  	unsigned int id;
> > >  	int ret;
> > >  
> > > @@ -854,6 +856,16 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
> > >  	if (ret)
> > >  		return ret;
> > >  
> > > +	gpio = devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_HIGH);
> > > +	if (IS_ERR(gpio))
> > > +		return PTR_ERR(gpio);
> > > +
> > > +	if (gpio) {
> > > +		fsleep(30);
> > > +		gpiod_set_value_cansleep(gpio, 0);
> > > +		fsleep(60);
> > 
> > Where do those values come from ? The only possibly related timing
> > information I found in the datasheet indicate a GPIO debounce delay of
> > 70µs.
> 
> Yeps this were just some reasonable values that work. The datasheet does not
> mention any timing...
> 
> I can add a comment if you like stating there's no defined values in the
> datasheet and these values are "just" some values that work.

If you could explain that in the commit message, it would be nice.

> > > +	}
> > > +
> > >  	adp5585->regmap = devm_regmap_init_i2c(i2c, info->regmap_config);
> > >  	if (IS_ERR(adp5585->regmap))
> > >  		return dev_err_probe(&i2c->dev, PTR_ERR(adp5585->regmap),

-- 
Regards,

Laurent Pinchart

