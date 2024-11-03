Return-Path: <linux-pwm+bounces-4019-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 283F99BA80C
	for <lists+linux-pwm@lfdr.de>; Sun,  3 Nov 2024 21:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2F452817AF
	for <lists+linux-pwm@lfdr.de>; Sun,  3 Nov 2024 20:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F67818BBBD;
	Sun,  3 Nov 2024 20:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L19Xm/T3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606F083CD3;
	Sun,  3 Nov 2024 20:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730667143; cv=none; b=rnDsB0vTxIKRPZq0Z7qA++L+7PasdBgez+s/87t44xyTPh/Itoiv5o4AdNQ6tQFTOZcJ3lr6Op0pRJ3L/dWEPgyWROBNYzrdHNTXp1ztiBlF5e49LJxfZ9neNhRy/7Y25EjRDnN3Xzbj7RgmZhVArN/Fmd/Z/SVwSghUTBckfGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730667143; c=relaxed/simple;
	bh=CLSbQ6BNFBif9u+81PM50aXLEE10VwBvWHMzGBM7NBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJZCdbKjQrI9B8XQPdOJvbJ/kTpm8IX8btGHGDxVOCVbheVWpdW66cl7r/Bn7a0Mib3mHBEAQrTatXSH6M2g9QJ2fMMjos873gcTMIrQ92YhBGIwATgMNhTxEXlAqz/BK6++/1hVJvn76Twv2lkWG4FYSE8d4WqH9q0Tcp8iLO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L19Xm/T3; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4314f38d274so44333945e9.1;
        Sun, 03 Nov 2024 12:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730667140; x=1731271940; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iH1YN/Y7vMbe+Q32uUgavVIhZywzTnAITsZxQEjUsQQ=;
        b=L19Xm/T3lO1GNwdO1d7e5uZBkPnjsHs/Po1+NoHOy69Er2CMn7czeHt4JdjLaUYu9z
         bCDKlzq8ffmhiQJGPJFfrbLAlHmaGF7T5MTqUNZopkIilVfzKhYUDGyzAv6BACXRyBki
         m8B/mtPuaGx1nkVQN31By7KycHCeAkI2tETA4svfKU34PwFXJKXv4JIJCDNwJTCKeedd
         +PDYpc5rX4oGz7yzqVLkUsNj+XXKC/zY+7ipIdBxEaW+LZwQEE8PZB06jJbTo0ceNVmQ
         YuD481y29a0TLy0i2+TvizWHjH92OZsnMCXI34XVlt3mc3trBVunPkhO5bBRpaoVlTtE
         APug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730667140; x=1731271940;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iH1YN/Y7vMbe+Q32uUgavVIhZywzTnAITsZxQEjUsQQ=;
        b=G/E+tzXqxQTFntCt5VHB1CA8RlhpRJ8we8SBX0fK87IdcUWqnZQ82ENSnS1mG4HsW5
         WkiJ2f8uvS7eZ7vgeYfQKGj546+mRpTFh85vlNeAtmBvF7ecnGba09qOWetumr3rm4wJ
         XkGVSythmN3VUTlYE1shOHQmBgwS72BBKJXgtFy72PKdV6tS+whjD8LXE3Bp4NQsFSMz
         2MNrrU+J8gEh2VHDXS+0fAo/aNOxCd1P6aXWPflsPxHuSOEx1JUY0mQpaT339WiPAzF9
         mHJaIrKfU5fYE2DVRAmx7yL/wD8jEjrUG9h5b4e4yzWYW219l2f6BjOg7TpVYzB1M/k/
         Fhew==
X-Forwarded-Encrypted: i=1; AJvYcCUGGyFMa0cmsQ9HfTzyCEDpMzD3sYylfZdThr7Z7h1MMnrNd6eISXujNErU+R6IwZR6GXIbQtYjKS9j@vger.kernel.org, AJvYcCUcOYbIuPuqOqMCpr0xKqwxWK5j87aDd1VcksF+JqboN3gjdl0sZx9VF32qnelOlz4w4tDq/k9onLVf4h6A@vger.kernel.org, AJvYcCXCNEG/TlOuOOfqHOk6QM14n+OllCR1W2Fzf+iHZ3XUnRZyXWfNonw2Vq6MYYPUfCXIuvw0FnC3tqS0@vger.kernel.org
X-Gm-Message-State: AOJu0YwWtlFXFpmb9Sw+FcSM8fjIhKN7e+RHveyUppwf1K1qD63xEJxe
	o9lpU4yPmPDneuz082wy1EPl0Zj3E8nWKY5K4GtULzQvbuahZo1J
X-Google-Smtp-Source: AGHT+IHl+PAHqugAup4MaxG3BV4VMU1IvR9qU9iP/6wI2w0BLxULjq+3BZK6K1pAxY4A6or2C63+lA==
X-Received: by 2002:a05:600c:4689:b0:431:52a3:d9d5 with SMTP id 5b1f17b1804b1-432831cb9demr122399465e9.0.1730667139375;
        Sun, 03 Nov 2024 12:52:19 -0800 (PST)
Received: from debian ([2a00:79c0:63e:e900:224:9bff:fe22:6dd6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd947bf4sm166879175e9.27.2024.11.03.12.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 12:52:17 -0800 (PST)
Date: Sun, 3 Nov 2024 21:52:15 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] pwm: add support for NXPs high-side switch
 MC33XS2410
Message-ID: <20241103205215.GA509903@debian>
References: <20240927125745.38367-1-dima.fedrau@gmail.com>
 <20240927125745.38367-3-dima.fedrau@gmail.com>
 <oppdnsda4tqjcpsb26j5ew62t4bkkmtxuu7e2fpinnazubk5ky@tmz76o5xdrlj>
 <20241023125221.GA197308@debian>
 <eyom32milbbqp6floun4r5bpozuewbe5kk2htvhp5cmcytj2oy@bpcrd2aiwk6m>
 <20241103190709.GA466098@debian>
 <atkj7wnhl4n6frl5swjwrto6r6dhofjtnqisqrn5z6w3cmfl3h@dgqgdxovrqb4>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <atkj7wnhl4n6frl5swjwrto6r6dhofjtnqisqrn5z6w3cmfl3h@dgqgdxovrqb4>

Hello Uwe,

Am Sun, Nov 03, 2024 at 09:19:36PM +0100 schrieb Uwe Kleine-König:
> Hello Dimitri,
> 
> On Sun, Nov 03, 2024 at 08:07:09PM +0100, Dimitri Fedrau wrote:
> > Am Thu, Oct 24, 2024 at 11:19:16PM +0200 schrieb Uwe Kleine-König:
> > > What breaks if you drop the check for state->enabled?
> > >  
> > The device is unable to generate a 0% duty cycle, to support this you
> > proposed in an earlier review to disable the output. Without checking if
> > the output is disabled, the mc33xs2410_pwm_get_state function returns the
> > wrong duty cycle for a previously setted 0% duty cycle. A "0" value in the
> > MC33XS2410_PWM_DC register means that the relative duty cylce is 1/256. As
> > a result there are complaints if PWM_DEBUG is enabled.
> 
> I fail to follow. If .enabled=true + .duty_cycle=0 is requested you
> disable. That's fine. However it shouldn't be necessary to use
> state->enabled in .get_state(). I didn't look at the actual code, but if
> you provide a sequence of writes to /sys that trigger a PWM_DEBUG
> output, I'll take another look.
> 
Apply 0% duty cycle: .enabled=false + .duty_cycle=0
Below some writes triggering PWM_DEBUG output:

# echo 488282 > /sys/class/pwm/pwmchip3/pwm0/period
# echo 244140 > /sys/class/pwm/pwmchip3/pwm0/duty_cycle
# echo 0 > /sys/class/pwm/pwmchip3/pwm0/duty_cycle
[   91.813513] mc33xs2410-pwm spi0.0: .apply is supposed to round down duty_cycle (requested: 0/488282, applied: 1908/488282)

Best regards,
Dimitri

