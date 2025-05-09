Return-Path: <linux-pwm+bounces-5881-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB21AB1D83
	for <lists+linux-pwm@lfdr.de>; Fri,  9 May 2025 21:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 016543B3289
	for <lists+linux-pwm@lfdr.de>; Fri,  9 May 2025 19:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DFF25D1E2;
	Fri,  9 May 2025 19:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwhZxac+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446D7242D92;
	Fri,  9 May 2025 19:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746820296; cv=none; b=srkwd8stPhIvP52Lkw8mYHoknL5xTxD57IOY9VZYIOQkNYehkJuePp+hy7hWlsGzLJaggucH7co42xBVAUFJzyrEukUb1bEdTmnsRpOzikotb5wjp2qbKgPUlOfVmcKT7+cnjssEQVeI57KmYP8HKnQ07+qMFLOXIpGiLl+jCxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746820296; c=relaxed/simple;
	bh=xaosuZ21PuBKJnCQj6CapwEz/mgEpSecCiagHZRIwh0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7nxiZnvWwP7UtZFrRy1/uNGUfjeP32zNS48hMFsp4aCQIkGFL9Nob0LxVCmfInsvS5MWqlIj51vrcxjcEfb2twizzR+IR8MYb7Ksh09nG4ZudJRAk4KVz8FAfhszOucxYFjHPKPIS0U8t6Dqa/sPtqbW1BrbMRBGAJyQfuDI8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwhZxac+; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a1fa0d8884so605649f8f.3;
        Fri, 09 May 2025 12:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746820292; x=1747425092; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JyFLabtIx9ghrAi5UT5OteHI+j56zONY5iKuInVBjsM=;
        b=UwhZxac+O/7oPY2EOqTwfLJE3nhcNPG2lqU9tecVrRD0Sb07opQAKnHY3RyN5PIzmT
         X3p8irsDQE8TvBocBgqIKZvmpakA8I+x2Wg4+zjtcgb1qICkeq8v2ytq2eHBdSE8RmhD
         oA5qm/wyobTFG0IhoPGAxiYmclWYSndIuwqmIHW4T6VGxWa43XRirafoKILI5jUWy4pX
         aVcuq1CH4/DybNa8JhtHW5er9b6hlU+LkBpy5J+TPbnx9K9sCuba0fNnvPKZaxNGeOJf
         qKfkjNmETKrbJtrEuziRswkVqkpz/FMBHS3ByPI7exsL6/LVHBb1ox3jhaswSAwcMpz2
         U3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746820292; x=1747425092;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JyFLabtIx9ghrAi5UT5OteHI+j56zONY5iKuInVBjsM=;
        b=ZB39Wg1Nxnut0mQzhpo89N2FkXKwNVWPOEDT7dQVActnNEGISxYQ4n2gS2kl6YzvdR
         2p6bUwkNbZXN6JHlmfRdaP/kjJB9glxPtJHIYORDkOE5S/Jwwo3rsuBZ7dUOssWJvvMt
         wUEtsyrmFZnfpOUEa9QImccCfscdCZ8i+NVy+JobdBbLeSd4jPYEbxVnSPXL4lOHjIk9
         p+aWIgEkDZnunnYdCO4JWnN3di21d9pzqF4w4+uld8K+HmMSf/xf7lo47PQT8TgN0jvO
         LQkbwVQ3kRpEn4TYA2/HPP967nK1bgrpRpJBPbu07A2gYyMSxbdOC2bFrKEkiGONSiVa
         08/g==
X-Forwarded-Encrypted: i=1; AJvYcCWR5pAsZ1yRIOhEzLMlOzW0elhGSVI5GR4YThlOiQTmZYmL+5HaG2MTfwtD5YSbJY62M3fw+1WVuks=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYgYFdWQ8j6loyCLwH6/ayw1opbWapNxMgwdYTKHRNlpaRgCZR
	a914V6nYEdHfpYic2raFf/pcEuND9onR1TKBp8rhuBQE7dkEW5Ji
X-Gm-Gg: ASbGncsPmjEXP7R7O5+o+g+N1K4CLdCxiR9koe2ZreuAfMxnq8plW1yTxpS3t0vkK4I
	eFJeQjN+TuFccmGis/9DBBjqKEcf5rOh3L2aTcAiTZ/0YEC3N42jthO6FrBJdGAm/SigxUhgUSK
	ZMLst6aj0X8gJ5j8iCJy3TGO7+0E6KITIskLyd+d5ANSmykRZ7Tctl4nwPR1LFGuusDznVDvxhj
	KmyeCrklbHiIRPv6kPnNM4416eL5+m/5hmsLnr0SPzdN0gJfbo4j2L+FvGkmv4P+3bvngFjRmVR
	jvSCP57o58RINy/3ccc2QCz1plw2S57DpxXuFH3lSmhxIo+HeJJnHNBNNoVqJVqOw57kmtmwZIl
	3nJ2MXzI=
X-Google-Smtp-Source: AGHT+IFHom5bubo9P7WTq4F4VXM9tWOJPD++d8wYa4UV4EU/pHTfCkR+YCMiAY5GezB87WTnJkoERA==
X-Received: by 2002:a5d:5391:0:b0:3a1:f937:6e70 with SMTP id ffacd0b85a97d-3a1f9376edcmr2407816f8f.30.1746820292261;
        Fri, 09 May 2025 12:51:32 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f3369sm4240114f8f.57.2025.05.09.12.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 12:51:31 -0700 (PDT)
Message-ID: <681e5cc3.df0a0220.2f84eb.c5cf@mx.google.com>
X-Google-Original-Message-ID: <aB5cwe-QNLZwqeYS@Ansuel-XPS.>
Date: Fri, 9 May 2025 21:51:29 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH v12] pwm: airoha: Add support for EN7581 SoC
References: <20250407173559.29600-1-ansuelsmth@gmail.com>
 <q46vqvt4ebepk47as3vhx24fqfnv2ollatjzjw5hbxtcbaklff@exkozghztvlv>
 <681dfd1e.170a0220.1d9a3f.15ad@mx.google.com>
 <pbutokheq6zm4gzjzvhhmxvnse3uudb5obpuyd55z7emlm3pju@7l7hocoktu37>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pbutokheq6zm4gzjzvhhmxvnse3uudb5obpuyd55z7emlm3pju@7l7hocoktu37>

On Fri, May 09, 2025 at 09:43:55PM +0200, Uwe Kleine-König wrote:
> Hello Christian,
> 
> On Fri, May 09, 2025 at 03:03:23PM +0200, Christian Marangi wrote:
> > thanks a lot for the review. I was just starting reviewing some patch on
> > patchwork so I could remove some work from you but you were faster...
> 
> You're still invited to comment ...
> 

Ok will check!

> > On Fri, May 09, 2025 at 12:39:37PM +0200, Uwe Kleine-König wrote:
> > > On Mon, Apr 07, 2025 at 07:35:53PM +0200, Christian Marangi wrote:
> > > > +static void airoha_pwm_get_ticks_from_ns(u64 period_ns, u32 *period_tick,
> > > > +					 u64 duty_ns, u32 *duty_tick)
> > > > +{
> > > > +	u64 tmp_duty_tick;
> > > > +
> > > > +	*period_tick = div_u64(period_ns, AIROHA_PWM_PERIOD_TICK_NS);
> > > > +
> > > > +	tmp_duty_tick = mul_u64_u64_div_u64(duty_ns, AIROHA_PWM_DUTY_FULL,
> > > > +					    period_ns);
> > > 
> > > So period can be set to multiples of 4 ms. If you request
> > > 
> > > 	.period_ns = 11999 ns
> > > 	.duty_ns = 4016 ns
> > > 
> > > the hardware should configure 
> > > 
> > > 	.period = 8000 ns
> > > 	.duty_cycle = 4015.6862745098038 ns (i.e. 128/255 * period)
> > > 
> > > corresponding to period_tick = 2 and duty_tick = 128.
> > > 
> > > However you calculate duty_tick = 85.
> > > 
> > > I would expect that with having PWM_DEBUG enabled you get a warning when
> > > you do:
> > > 
> > > 	pwmset -P 8000 -D 4016
> > > 	pwmset -P 11999 -D 4016
> > > 
> > 
> > I addressed all the other comments but this is the only thing that I'm
> > confused about.
> > 
> > Where 85 comes from?
> 
> 4016 * 255 / 11999 -> 85. The problem I suspected is that duty_tick is
> calculated using the requested period value instead of the real one.
> 
> > I tested your command and I can correctly observe the values getting
> > set to the expected tick.
> 
> I didn't recheck in detail and now I'm unsure if that really happens
> because period_ns might be already round to a multiple of 4 ms?
>  

Yes it it. And that was actually a problem I notice in v11 that was
causing idempotent problem.

It's done in .apply with 

period_ns = rounddown(state->period, AIROHA_PWM_PERIOD_TICK_NS);

We normalize the value to 4ns step. Sooo with 11999, in
airoha_pwm_config the actual value used is 8000.

> > And I don't have the idempotent warning from PWM debug.
> > 
> > With period = 8000 and duty to 4016, period tick is set to 0x2 and duty
> > is set to 0x80 (128)
> > 
> > When PWM debug repply the configuration and read the state, it gets
> > period 0x8000 and duty 4015,687.
> > 
> > And those are the expected values. Am I missing something here?
> 
> If you don't get the warning, you most probably only miss that I
> misjudged the code :-)

I both tested with your combo values and with a loop and pwm-leds from 0
to 255 and no warning.

I will send v13, finger crossed everything is good!

> 
> Best regards
> Uwe



-- 
	Ansuel

