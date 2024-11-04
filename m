Return-Path: <linux-pwm+bounces-4028-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7504A9BB56E
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Nov 2024 14:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A50131C2096B
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Nov 2024 13:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7401BB6BA;
	Mon,  4 Nov 2024 13:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1YhGE8Z"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895BB1B6CFB;
	Mon,  4 Nov 2024 13:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730725680; cv=none; b=bdoiC7s7N0wg8iJa5AyKTFSsO/t64jiFKNitjiYgQbNOnytwqR3d05e8g5eeWmdHGv52kC1BLURIikFw/tvOSecQYcH2PHYxZel0lK8U2ab9ToEI9+218GUwzQplVFAk6Il1FxbadulBKTRHMYepWFrn1QDKTtLHN0aIilrMOHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730725680; c=relaxed/simple;
	bh=wm8U+Md/iY4baGztvvI2H56+M1nN/gehfD9KsWVizhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxIcDuFgW6pRyn74ci43CFxG3zLenGo6Adfc9mDRKjG7C0KNuH7Gy+cLKoeLQAzRIo+Soj+ixXJYvlOFDDqwf78WOMqOnuug0kaBnAOObV6DAtzZsr+ssJ3a1uWCqB+qeW1jwws+fRLjM47SZxRU2T4N1Zss0OmBStFDfNM92b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1YhGE8Z; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d4ac91d97so3610058f8f.2;
        Mon, 04 Nov 2024 05:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730725677; x=1731330477; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nNUUQvu0laSrYzFBNdDoqRUGk/pPSUMtABz/eAxZVi8=;
        b=j1YhGE8ZSuptCZuopDOV4zQj3zFB3Evu/2iysYWdCSx+Hiv63/8NUxyDM6qt4WaH3b
         8VajVD/ZZd+p0s9L9qjx3o9NTjIl7oMFDT7+UMnpSKEsCW32OpjOnZ4M0rDmERODoR2O
         yECQ2+AIlp8UAAiVu7tEiJnXlkXSNFA8royD3+zb+fTgeVZeaU5xHSWg0Xopxjg8IkFM
         QvZW2ORBccgoGKv5ICo6jlCsVIS7gB0rKDoVj3RQIg/eqqBKWSgRKVtY+qUeZWUtc611
         ZSxsBgXWfo8cSs7FrgPk21sJjEzqXd/AEUMxuFJH4mreiGHIWLD7b2yFfIjbTO+GffL0
         LEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730725677; x=1731330477;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nNUUQvu0laSrYzFBNdDoqRUGk/pPSUMtABz/eAxZVi8=;
        b=F3bPLeKRTTaXzZcamDAO09ob9zi87rzB0ezVfsA8VlNTYd4vVKfjuZlCHhkFMCsP0D
         Vz/FoTjOusAvDCUu0nIjTG68OwA1ao9bmLfZadQ5YKSYBnLxoWh+YBLhTfZczHi9mv/W
         RvsBH1e3Vmw5ccjWl2x5UhXVzvpl9kEJpynIWQ0gmreZnY/Nzr3WWk2ju6oIOtE4vN4v
         NYFN1CF5eGxbhnz5e+KfhdTi1Xti9Ad+xWRwVRtKGDSO+//IuiV9RkvZxntyQ/WxQnX7
         FCQCjXzf+bYZW4LcfrLMuXhIC1Yujrihda7Xe+9hvMf6i9O9k6PoF/0WIvz8Sr9TloeO
         BOZw==
X-Forwarded-Encrypted: i=1; AJvYcCVFWl6zc9ApL2RS5a6ZPAeKfranQ48B08Gzprh4FhficsjkvUnR+kAMJBlbTcxTj1XXa5L52zj4/g9b@vger.kernel.org, AJvYcCWVhJXZlHsABpmLMlpJwBp1JIE6l+4IXuMUACMnjCOEPjDOg+af3ACOUNhMQU8FbEyuoUQJ1A+rLAVx@vger.kernel.org, AJvYcCXy4m+N2vvcKY09CjM+H5W+yp8kDbVuc1BRKeNSQHfEvYHLpD4M63z4LHkgVmwW4ln06OX9WzeNjrYadZaa@vger.kernel.org
X-Gm-Message-State: AOJu0YwKr/b2yT8aR1jRNr/fbFDAaHEj3d3BTcv9enFKyBBBjJcRzz5Q
	dY5AqpSFV2w2cOzH/zOp1ApQaTD8KNciVUwfNbE8QtDmxLhZDoeu
X-Google-Smtp-Source: AGHT+IFdwmWLS82xVbOPmnCZWoEo+D1jnqxO08X2Um5EHfNEExWpJEjlzzOGkTyG45LA3sX8vmiamQ==
X-Received: by 2002:a5d:64ad:0:b0:374:c658:706e with SMTP id ffacd0b85a97d-381c7ac3c67mr12861036f8f.39.1730725676709;
        Mon, 04 Nov 2024 05:07:56 -0800 (PST)
Received: from debian ([2a00:79c0:639:7c00:224:9bff:fe22:6dd6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d473bsm13262539f8f.35.2024.11.04.05.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 05:07:56 -0800 (PST)
Date: Mon, 4 Nov 2024 14:07:53 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] pwm: add support for NXPs high-side switch
 MC33XS2410
Message-ID: <20241104130753.GA14681@debian>
References: <20240927125745.38367-1-dima.fedrau@gmail.com>
 <20240927125745.38367-3-dima.fedrau@gmail.com>
 <oppdnsda4tqjcpsb26j5ew62t4bkkmtxuu7e2fpinnazubk5ky@tmz76o5xdrlj>
 <20241023125221.GA197308@debian>
 <eyom32milbbqp6floun4r5bpozuewbe5kk2htvhp5cmcytj2oy@bpcrd2aiwk6m>
 <20241103190709.GA466098@debian>
 <atkj7wnhl4n6frl5swjwrto6r6dhofjtnqisqrn5z6w3cmfl3h@dgqgdxovrqb4>
 <20241103205215.GA509903@debian>
 <dy5abepkqhkmbgirwjkblbmw6vwb56vaqgazluyt675qflzioz@glp4djy6fhuo>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dy5abepkqhkmbgirwjkblbmw6vwb56vaqgazluyt675qflzioz@glp4djy6fhuo>

Am Mon, Nov 04, 2024 at 09:52:51AM +0100 schrieb Uwe Kleine-König:
> On Sun, Nov 03, 2024 at 09:52:15PM +0100, Dimitri Fedrau wrote:
> > Hello Uwe,
> > 
> > Am Sun, Nov 03, 2024 at 09:19:36PM +0100 schrieb Uwe Kleine-König:
> > > Hello Dimitri,
> > > 
> > > On Sun, Nov 03, 2024 at 08:07:09PM +0100, Dimitri Fedrau wrote:
> > > > Am Thu, Oct 24, 2024 at 11:19:16PM +0200 schrieb Uwe Kleine-König:
> > > > > What breaks if you drop the check for state->enabled?
> > > > >  
> > > > The device is unable to generate a 0% duty cycle, to support this you
> > > > proposed in an earlier review to disable the output. Without checking if
> > > > the output is disabled, the mc33xs2410_pwm_get_state function returns the
> > > > wrong duty cycle for a previously setted 0% duty cycle. A "0" value in the
> > > > MC33XS2410_PWM_DC register means that the relative duty cylce is 1/256. As
> > > > a result there are complaints if PWM_DEBUG is enabled.
> > > 
> > > I fail to follow. If .enabled=true + .duty_cycle=0 is requested you
> > > disable. That's fine. However it shouldn't be necessary to use
> > > state->enabled in .get_state(). I didn't look at the actual code, but if
> > > you provide a sequence of writes to /sys that trigger a PWM_DEBUG
> > > output, I'll take another look.
> > > 
> > Apply 0% duty cycle: .enabled=false + .duty_cycle=0
> > Below some writes triggering PWM_DEBUG output:
> > 
> > # echo 488282 > /sys/class/pwm/pwmchip3/pwm0/period
> > # echo 244140 > /sys/class/pwm/pwmchip3/pwm0/duty_cycle
> > # echo 0 > /sys/class/pwm/pwmchip3/pwm0/duty_cycle
> > [   91.813513] mc33xs2410-pwm spi0.0: .apply is supposed to round down duty_cycle (requested: 0/488282, applied: 1908/488282)
> 
> I don't understand that. We're talking about 
> 
> diff --git a/drivers/pwm/pwm-mc33xs2410.c b/drivers/pwm/pwm-mc33xs2410.c
> index f9a334a5e69b..14f5f7312d0a 100644
> --- a/drivers/pwm/pwm-mc33xs2410.c
> +++ b/drivers/pwm/pwm-mc33xs2410.c
> @@ -244,15 +244,6 @@ static int mc33xs2410_pwm_get_relative_duty_cycle(u64 period, u64 duty_cycle)
>  	return duty_cycle - 1;
>  }
>  
> -static void mc33xs2410_pwm_set_relative_duty_cycle(struct pwm_state *state,
> -						   u16 duty_cycle)
> -{
> -	if (!state->enabled)
> -		state->duty_cycle = 0;
> -	else
> -		state->duty_cycle = DIV_ROUND_UP_ULL((duty_cycle + 1) * state->period, 256);
> -}
> -
>  static int mc33xs2410_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  				const struct pwm_state *state)
>  {
> @@ -325,7 +316,7 @@ static int mc33xs2410_pwm_get_state(struct pwm_chip *chip,
>  	state->polarity = (val[2] & MC33XS2410_PWM_CTRL1_POL_INV(pwm->hwpwm)) ?
>  			  PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
>  	state->enabled = !!(val[3] & MC33XS2410_PWM_CTRL3_EN(pwm->hwpwm));
> -	mc33xs2410_pwm_set_relative_duty_cycle(state, val[1]);
> +	state->duty_cycle = DIV_ROUND_UP_ULL((duty_cycle + 1) * state->period, 256);
>  	return 0;
>  }
>  
> on top of your patch, right?
>
Yes.

> `echo 0 > /sys/class/pwm/pwmchip3/pwm0/duty_cycle` should result in
> MC33XS2410_PWM_CTRL3 having MC33XS2410_PWM_CTRL3_EN(pwm->hwpwm) cleared.
> When mc33xs2410_pwm_get_state() is called then it returns state->enabled
> = false and in that case the above mentioned warning doesn't trigger.
>
Yes, as you explained. But the warning is shown.

> Where is the misunderstanding?
>

if (state->enabled && state->duty_cycle < s2.duty_cycle)
	dev_warn(pwmchip_parent(chip),
		".apply is supposed to round down duty_cycle (requested: %llu/%llu, applied: %llu/%llu)\n",
		state->duty_cycle, state->period,
		s2.duty_cycle, s2.period);

state has previously applied settings and is parameter of pwm_apply_debug,
in that case s2=s1, and s1 is returned by get_state:

state->enabled=true
state->duty_cycle=0
s2.enabled=false
s2.duty_cycle=1908

Due to the code the warning should be raised. If it shouldn't the check
should be different, something like if (state->enabled && s2.enabled &&
...)

Best regards,
Dimitri

