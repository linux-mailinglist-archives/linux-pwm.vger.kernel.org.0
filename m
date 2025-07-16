Return-Path: <linux-pwm+bounces-6844-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D07B9B06E7E
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Jul 2025 09:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2BE23A55A1
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Jul 2025 07:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B85C289805;
	Wed, 16 Jul 2025 07:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEcEHM2I"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388F42868B7;
	Wed, 16 Jul 2025 07:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752649583; cv=none; b=gb1eT2lhzH+J8TyI5mlu0HjRJXeS33izCTP8IOSn/y8PSIKArJCkhsUGriQTIrrzgMh7DuNZ+2kUYfjrRBOeedKUUMlhHXD6E1OONKguKPaMri2yFqw+MwOHwcj6vXGQZEzsR9oa7RAbrbiMyFgTyaNY1FGo7885Iyyqi2USFSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752649583; c=relaxed/simple;
	bh=2v8aTWJzavPgsJvmRGcpLNKIpQM1xydyPQ5QDNfpnCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjnBhCRkiGvK0cuO9ymEwzHzRwRj3/KvI4Em06Yyfai2OcUKJHSHh7Fs7I9KLyubX9re/tFFKHn1qaRhl8Dwjig4f87YHaFU9xXzwHLqxEIsBeuVm8BKmNkyUKHvG0k7cunRA9UioIpZ8ZOUBNdZVWbuyVPA4/yZtzJsxwK/Dys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEcEHM2I; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60c4f796446so9254009a12.1;
        Wed, 16 Jul 2025 00:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752649579; x=1753254379; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sy1qfF6J0yZ4M9hDUBcxMOCwE6+RueoLeBAi6Q3h16A=;
        b=CEcEHM2IBlWOi3T/ZlZa7NLd7mRy0xY487TC5uZo5zfCZ46iu/6wE+o6XZB421Nymd
         /30CbN0ipHpBkuTyu1vCreDMwibVQziLFAxOI8LDh9bjDeUwFBOUCy3fq/hgjVeHtr5M
         4ozE4GgKq1fcDX41MVAtU1k4bK6SkLb399nwxxe0hlTrZN36kIGvq8UXG76+ClhunpoG
         Om3UBc6AE1d9vt8opgafixKr1yXvedNn9C15EGt4Cq8liPZSw2embfKSD0E+9HSDjYob
         X7862NYT6YLVAErEfAj5vyL5aR3/B8BeEnMm5TSNp95fHM5PLtZlwjdE5n+JbRA5Sol5
         Q5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752649579; x=1753254379;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sy1qfF6J0yZ4M9hDUBcxMOCwE6+RueoLeBAi6Q3h16A=;
        b=amjlByP2D24kKJBPH+ilL6trKxv2cOHbBdMiNizO2ThGCyhEvTtlYIYreVKm61XCCA
         Vq9o9KWxisU8iX3UMRBMZsm/C8zvzg/fnrRmo7IQ7teL45yLyIKQJXocWCVahEXBHgQw
         fAg3zdg5lg8p24VOdlDhP8EfAgW0lmmiEhH7sDGJ/SkeNh6ocS8VL6v2WUsRglT4PVmk
         pIcCSEmzol/7gL5shk6a06tStLUWKQEIpJSKgcniHuhNNqna4cZeYen+MR8S4SOCh0eQ
         gbVMmX3mHR5UrAewMIMiB3cUtS0t45i+8FhtUGxKhL5FL+lr/hExE3EHMvparkd0/69m
         RtrA==
X-Forwarded-Encrypted: i=1; AJvYcCUDdFVs05doTEN1mIGn2F8AiTPzh1U5pXVgjH0m4rI7pzf0/XX6vtSK8JcuRiTTwwMC2EU/E4w1XyDd@vger.kernel.org, AJvYcCX6VOnFDjTpsBUzdkLEYOZ1nTDISzFORhdcA8zI6UTCXsSPZjNr7aH+eOHD+2P/oponlGUpGAcwi77GYg==@vger.kernel.org, AJvYcCXUfNIDyHUrrHbddBRtA8KhM7Wzzz1eqo91h6e33u1MsOcJMFaRBf+HL16Nfw5VQx92b4kVqfc14v0SsP6b@vger.kernel.org
X-Gm-Message-State: AOJu0YzhJUE8gAfGYvc+lT4bwpFhwwNIbsYXsiEFqMgm21KacltHfYnB
	ZJEFS5EhaelLU1IsmJnhRJj/Ng9+Y2B3bdcysDIj1TEy63tifiz5oHic
X-Gm-Gg: ASbGncvSY0X0WvEqj1U/gnzSyiOUEwFyG+NiXJuvQtn6Jd2CCGJ0rVtxXRt2EqwZO0M
	BKpWiIAJgqlQdTTce8vR/bIHGYnlzW9AnutdXH+y+HOKSOMO/xxjONWRRG+V/nQIJcs846pdJkD
	PjfeKDlLQHyUwBK3QArugokZDwlf87LfclwkPdjk9mQhn+7QlxKH0aRtOaI9xVVayFegjsLe8AV
	mWQqIarFk87SFQdGxuHllLlYVWSv0vMHkS6UwFSuX4Hzqcmh7+vusine4At6KX0YvT1P2l6mRW0
	QI6TUTfkZH5qVQnuccH2M9f0jgtbOslN0W6dh1c+ObOg447z3GKSmBKy2uHsQ3R+UbxPpuPWlkl
	IAYt+UlJ23UF6UeYiDaqXQ4o0sVsuNybRr6RqXDlE
X-Google-Smtp-Source: AGHT+IGq7oFEenjuXbxDNQjcsj9gWmgJnvZG8GpNaxkXhGYLzXzBwzP/VpQHzk2fr7XLaslvSUvxKA==
X-Received: by 2002:a05:6402:40c3:b0:608:2e97:4399 with SMTP id 4fb4d7f45d1cf-61281e9bc83mr1868801a12.4.1752649579148;
        Wed, 16 Jul 2025 00:06:19 -0700 (PDT)
Received: from legfed1 (lis01.vpn.liebherr.com. [193.27.220.234])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c97335e2sm8473152a12.41.2025.07.16.00.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 00:06:18 -0700 (PDT)
Date: Wed, 16 Jul 2025 09:06:16 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: dimitri.fedrau@liebherr.com, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v4 1/2] pwm: mc33xs2410: add hwmon support
Message-ID: <20250716070616.GA5639@legfed1>
References: <20250708-mc33xs2410-hwmon-v4-0-95b9e3ea5f5c@liebherr.com>
 <20250708-mc33xs2410-hwmon-v4-1-95b9e3ea5f5c@liebherr.com>
 <fxzkuflnasxp73fyf262wk5yx7yfnb5druegdujhzll3wjn6r5@n4xg6gs6segi>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fxzkuflnasxp73fyf262wk5yx7yfnb5druegdujhzll3wjn6r5@n4xg6gs6segi>

Hi Uwe,

Am Wed, Jul 16, 2025 at 08:39:14AM +0200 schrieb Uwe Kleine-König:
> Hello Dimitri,
> 
> On Tue, Jul 08, 2025 at 06:13:03PM +0200, Dimitri Fedrau via B4 Relay wrote:
> > diff --git a/drivers/pwm/pwm-mc33xs2410.c b/drivers/pwm/pwm-mc33xs2410.c
> > index a1ac3445ccdb4709d92e0075d424a8abc1416eee..e70ed90bfdac77f5c777f0ba66d670331a515d12 100644
> > --- a/drivers/pwm/pwm-mc33xs2410.c
> > +++ b/drivers/pwm/pwm-mc33xs2410.c
> > @@ -18,10 +18,12 @@
> >   *   rather something in between.
> >   */
> >  
> > +#include <linux/auxiliary_bus.h>
> >  #include <linux/bitfield.h>
> >  #include <linux/delay.h>
> >  #include <linux/err.h>
> >  #include <linux/math64.h>
> > +#include <linux/mc33xs2410.h>
> >  #include <linux/minmax.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > @@ -120,12 +122,19 @@ static int mc33xs2410_read_reg(struct spi_device *spi, u8 reg, u16 *val, u8 flag
> >  	return mc33xs2410_read_regs(spi, &reg, flag, val, 1);
> >  }
> >  
> > -static int mc33xs2410_read_reg_ctrl(struct spi_device *spi, u8 reg, u16 *val)
> > +int mc33xs2410_read_reg_ctrl(struct spi_device *spi, u8 reg, u16 *val)
> >  {
> >  	return mc33xs2410_read_reg(spi, reg, val, MC33XS2410_FRAME_IN_DATA_RD);
> >  }
> > +EXPORT_SYMBOL_NS_GPL(mc33xs2410_read_reg_ctrl, "PWM_MC33XS2410");
> 
> To reduce repetition (a bit) you can consider to define
> DEFAULT_SYMBOL_NAMESPACE.
> 
Will add it in V5.

> > -static int mc33xs2410_modify_reg(struct spi_device *spi, u8 reg, u8 mask, u8 val)
> > +int mc33xs2410_read_reg_diag(struct spi_device *spi, u8 reg, u16 *val)
> > +{
> > +	return mc33xs2410_read_reg(spi, reg, val, 0);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(mc33xs2410_read_reg_diag, "PWM_MC33XS2410");
> > +
> > +int mc33xs2410_modify_reg(struct spi_device *spi, u8 reg, u8 mask, u8 val)
> >  {
> >  	u16 tmp;
> >  	int ret;
> > @@ -139,6 +148,7 @@ static int mc33xs2410_modify_reg(struct spi_device *spi, u8 reg, u8 mask, u8 val
> >  
> >  	return mc33xs2410_write_reg(spi, reg, tmp);
> >  }
> > +EXPORT_SYMBOL_NS_GPL(mc33xs2410_modify_reg, "PWM_MC33XS2410");
> >  
> >  static u8 mc33xs2410_pwm_get_freq(u64 period)
> >  {
> > @@ -297,6 +307,52 @@ static const struct pwm_ops mc33xs2410_pwm_ops = {
> >  	.get_state = mc33xs2410_pwm_get_state,
> >  };
> >  
> > +static void mc33xs2410_adev_release(struct device *dev)
> > +{
> > +	struct auxiliary_device *adev = to_auxiliary_dev(dev);
> > +
> > +	kfree(adev);
> > +}
> > +
> > +static void mc33xs2410_unregister_adev(void *_adev)
> > +{
> > +	struct auxiliary_device *adev = _adev;
> > +
> > +	auxiliary_device_delete(adev);
> > +	auxiliary_device_uninit(adev);
> > +}
> 
> This is a copy of auxiliary_device_destroy(). But see below.
>
Yes, you are right.

> > +static int mc33xs2410_hwmon_register(struct device *dev)
> > +{
> > +	struct auxiliary_device *adev;
> > +	int ret;
> > +
> > +	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
> > +	if (!adev)
> > +		return -ENOMEM;
> > +
> > +	adev->name = "hwmon";
> > +	adev->dev.parent = dev;
> > +	adev->dev.release = mc33xs2410_adev_release;
> > +	adev->id = 0;
> > +
> > +	ret = auxiliary_device_init(adev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = auxiliary_device_add(adev);
> > +	if (ret) {
> > +		auxiliary_device_uninit(adev);
> > +		return ret;
> > +	}
> > +
> > +	ret = devm_add_action_or_reset(dev, mc33xs2410_unregister_adev, adev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> 
> This function is equivalent to devm_auxiliary_device_create(dev, "hwmon", NULL);
>
Thanks for finding this, will implement it in V5.

> > +
> >  static int mc33xs2410_reset(struct device *dev)
> >  {
> >  	struct gpio_desc *reset_gpio;
> > @@ -361,6 +417,10 @@ static int mc33xs2410_probe(struct spi_device *spi)
> >  	if (ret < 0)
> >  		return dev_err_probe(dev, ret, "Failed to add pwm chip\n");
> >  
> > +	ret = mc33xs2410_hwmon_register(dev);
> > +	if (ret < 0)
> > +		return dev_err_probe(dev, ret, "Failed to register hwmon device\n");
> > +
> >  	return 0;
> >  }
> >  
> > diff --git a/include/linux/mc33xs2410.h b/include/linux/mc33xs2410.h
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..15a0b0b595fe00a369cee45f2d30b2d912b612bb
> > --- /dev/null
> > +++ b/include/linux/mc33xs2410.h
> > @@ -0,0 +1,14 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2024 Liebherr-Electronics and Drives GmbH
> > + */
> > +#ifndef _MC33XS2410_H
> > +#define _MC33XS2410_H
> > +
> > +#include <linux/spi/spi.h>
> > +
> > +int mc33xs2410_read_reg_ctrl(struct spi_device *spi, u8 reg, u16 *val);
> > +int mc33xs2410_read_reg_diag(struct spi_device *spi, u8 reg, u16 *val);
> > +int mc33xs2410_modify_reg(struct spi_device *spi, u8 reg, u8 mask, u8 val);
> > +
> > +#endif /* _MC33XS2410_H */
> 
> I consider it elegant to have the
> 
> 	MODULE_IMPORT_NS("PWM_MC33XS2410")
> 
> in the header. This is nice because the namespacing is completely
> transparant to consumers and all they need it the right #include as if
> there was no namespacing at all.
> 
Yes, will implement it as you suggested.

Thanks for your input.

Best regards,
Dimitri Fedrau

