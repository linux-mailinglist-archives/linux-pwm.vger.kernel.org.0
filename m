Return-Path: <linux-pwm+bounces-6481-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32831AE4581
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Jun 2025 15:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0FC2189C481
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Jun 2025 13:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6E2253340;
	Mon, 23 Jun 2025 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYPMaItt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3300252910;
	Mon, 23 Jun 2025 13:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750686764; cv=none; b=itlpuJAcTgrgAl17iGegaIrPImGeQEd89fcJbXyz1seQxyZK+sbwGRui0nytmXKisx7BHO+cPCy//dF+j32R9VmN+A25LAMBKWc5bLlkWVAEaZS7sdrZ0M7XGsdiFsYWhUr8ov+xAfAIVdta58IqiK2hWQJN7VVif3alT0tohpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750686764; c=relaxed/simple;
	bh=xxGXKK9KWN+8H/j3IIN45HKzkBJezEeZISLUmQmBQ78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5zihIOoTwHb8Jzt95zgw3oxRMU0FIJXtr5C4ldSQiEATSEsEf/lEbPP+CjkJ1DIVj1LMH0z+UW5qwkDYn7R5fUHCFvWDjchPc3Y4hlU3o7f80/wUHz18g0FeTlTYO2IERZbexztewUe89YIcll+gLduhH2XiqfjT2lMMfceN9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYPMaItt; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-742c3d06de3so4958547b3a.0;
        Mon, 23 Jun 2025 06:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750686762; x=1751291562; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MEAOl2fmYBawK262JHhZ1StQPL81DZb0ZoMlQf2lKOs=;
        b=BYPMaIttm1iLynuJQTeT+cMP3VDyYGzUZ99qp03bGc0IFpN78s2/781o9xUFg2U7lA
         Ekyw8csZ1ZojcI1emaXXG5HrrEwkpXMEdPfZEoqJLuWC/M8qXLL6iUvvIx2SSJ5CEV5o
         rynI0vuZEEX2X90BlAm3FCsolupQk4cqh2HtR2sgN5BUezCr6XqO1LhDxdo4iUgUeXCW
         wsiHGAg/+teK2Zwgay5i8xgPcHdWBH4tyyB+XImPjkmQBXzC5ubR9u6ccBypXtvBL/gM
         62k9rzAtTloUH0Srfp7kJ6d/uQ1sh6eK4RPi7ltXJTJqG8Frrhuu4kNG8x/ngPU7FEIx
         XVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750686762; x=1751291562;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MEAOl2fmYBawK262JHhZ1StQPL81DZb0ZoMlQf2lKOs=;
        b=rw6il6F4lTaPX+NLawY5nG0pR7W0kQIoVY39CfylznGinLNpkTbtkqAVGQEP3qr1Ln
         FlTzhDJcFoNX1dVvykPHsPLvjjMHz37KkantyGnqY1RCVXT5yV8xNOda/MzOyWfhACuR
         JSxpfRlo+nuA37JpF4nuBJ/o/MKT57MrFe0DAQW9l5QB0LqBU8BcvUa2IlwqYfzztcdX
         W15pJBUJsq8i9r9CrpnaEihv4gTXimFK9AkThYzXGiSH2TxU3QHtuqS/GR+2lWp7T6OZ
         mHUFCZBYvGSPK6DkaDQPsOfwd5B/mVrvlvpIjxLIACPAhOWV7qd/AnfuQo3bw5WTF/wd
         sHjA==
X-Forwarded-Encrypted: i=1; AJvYcCUjhT+jSsfP7F0wfHHZUJHWDcZIHrSA6ySmxDjRP2dqkTtINFjtQfvx8bqzavyZpwnbh08SiTADWtyKWg==@vger.kernel.org, AJvYcCV7cGs6GqIhy/72YbC7XI9XEVhguYOtRdstV8GErLXEF2/14ACfvJRENpz7WuO7XKhCA3J/V1Z2xbH2@vger.kernel.org, AJvYcCXFzUlpKre468k+9mZzXnxW/I5XthFaKvGuiFXyImIktqoBHlnWywrR0iMCweqnKcS8zfAP2QE6AgNftjFr@vger.kernel.org
X-Gm-Message-State: AOJu0YycepLElmX+Qh4h3gNtPdmHQ9eZRu/lyVIqCqeA0D6OWA4wvC31
	T9fwFcUAT59PYxdmcTSyLlMLJUKfOmmeVC+8fp7Nb3YHsBC8RrLHDFES
X-Gm-Gg: ASbGncun4ZVlRDHFmVRPBk0Z5h3kWioGmATZxcyPZnnE2IyBsSgaZ61KnbQzhPlZH93
	Gww/qmU0/Ujr0cPX2jIDVeR1SgVC4lv4m4W/rD+G6vJamprtFJ2fHDc4ZXWRVwg0ywxHVHfydK1
	h6S/rNYcgynf41RIeb3BEVRKWeF4ZO9DmnMg/jIUYf2vmWiEY7QRk0wv4kybi65XtpOw9YNuIqR
	740fjGe8r8NnQMHCDmNNX/spnoPWyixLIxsPBgFCcK/L9GWJXp0kfS/pWcO+rXRA/JtFL1tR/w+
	hruvDqc++jvJVolOiMzKBDqEDe48lfSqWHyw9CIeys/zHfbThdxW8lBfncm2KUm+hvXW73v/KkA
	=
X-Google-Smtp-Source: AGHT+IFsk6OnUqdJRXFu+cICkcXlqNrRTHzhHp4e9QiInYluD76HZZipl2DugnuD6dOulq6Wol09jg==
X-Received: by 2002:a05:6a00:a0f:b0:746:24c9:c92e with SMTP id d2e1a72fcca58-7490d6a290dmr19614165b3a.8.1750686762080;
        Mon, 23 Jun 2025 06:52:42 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a64cdabsm8524162b3a.129.2025.06.23.06.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 06:52:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 23 Jun 2025 06:52:40 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: dimitri.fedrau@liebherr.com, Jean Delvare <jdelvare@suse.com>,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH v3] pwm: mc33xs2410: add support for temperature sensors
Message-ID: <d8cad439-0106-4079-9164-64b11d1681c6@roeck-us.net>
References: <20250619-mc33xs2410-hwmon-v3-1-301731e49f8f@liebherr.com>
 <cviovwci5fgtyina7p7zqjns7cwveivy3vetqhhagwmrlc2gm2@jrqgorif7xff>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cviovwci5fgtyina7p7zqjns7cwveivy3vetqhhagwmrlc2gm2@jrqgorif7xff>

On Mon, Jun 23, 2025 at 11:07:24AM +0200, Uwe Kleine-König wrote:
> hello Dimitri,
> 
> On Thu, Jun 19, 2025 at 07:32:42PM +0200, Dimitri Fedrau via B4 Relay wrote:
> > @@ -29,6 +30,8 @@
> >  
> >  #include <linux/spi/spi.h>
> >  
> > +/* ctrl registers */
> > +
> >  #define MC33XS2410_GLB_CTRL			0x00
> >  #define MC33XS2410_GLB_CTRL_MODE		GENMASK(7, 6)
> >  #define MC33XS2410_GLB_CTRL_MODE_NORMAL		FIELD_PREP(MC33XS2410_GLB_CTRL_MODE, 1)
> > @@ -51,6 +54,21 @@
> >  
> >  #define MC33XS2410_WDT				0x14
> >  
> > +#define MC33XS2410_TEMP_WT			0x29
> > +#define MC33XS2410_TEMP_WT_MASK			GENMASK(7, 0)
> > +
> > +/* diag registers */
> > +
> > +/* chan in { 1 ... 4 } */
> > +#define MC33XS2410_OUT_STA(chan)		(0x02 + (chan) - 1)
> > +#define MC33XS2410_OUT_STA_OTW			BIT(8)
> > +
> > +#define MC33XS2410_TS_TEMP_DIE			0x26
> > +#define MC33XS2410_TS_TEMP_MASK			GENMASK(9, 0)
> 
> Keep the registers in address order please
> 
> > +/* chan in { 1 ... 4 } */
> > +#define MC33XS2410_TS_TEMP(chan)		(0x2f + (chan) - 1)
> 
> I wonder if it would be cleaner if this was abstracted using mfd. Then
> the hwmon driver could live in drivers/hwmon
> 

For some reason the recent tendency is to move code out of hwmon, not into
it. Maybe my review feedback is too strong or something. Either case,
consider using auxiliary devices if you really want to move the code. That
seems to be a better fit, and it would be more lightweight since it doesn't
require an interconnect driver.

Guenter

