Return-Path: <linux-pwm+bounces-5933-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9881AB3E19
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 18:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C0F316C285
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 16:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAC123BCEC;
	Mon, 12 May 2025 16:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcSvvMLH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95F82528FC;
	Mon, 12 May 2025 16:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747068778; cv=none; b=bOmRM3tDIFMFC3nRPuVnak6SF71D+11t6cWu1cqAUGPpzYHqbuiltuHTMq9N6oU7b7LxZ1CDTN0MQJC2/g4BAcW5fQkJWf2AHC2JMIPDfDNw+LNV0I3tow+6JXeF4ur0nfg80+ProFopKi1+A6js6cxmJuOtPRYVEHkXwe8ExBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747068778; c=relaxed/simple;
	bh=VA2k1DyRjqhjpTuXEVQSbyPFByM8zKA5P42D98FPHm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LyKKTo8nGX5//a07CQS9IIO2B3fvZms5WD5oLqwfKUDs08aiz4oYqB5V+8Bildw4D81F7Oq1ZD+gH8kjA43zg5I3YhoEeKCV7MTcEy1EvB0/jwUKFM7DG6Tl/6ew6OqX8ZV5mv2FwyF+alLd9wq0bf5OHvPDcqCKfatlQFsjjLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcSvvMLH; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so34034595e9.0;
        Mon, 12 May 2025 09:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747068775; x=1747673575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bZNWFRrUSg91wrgDi7MuQDR/3MURApHPgoEnszpvjls=;
        b=YcSvvMLHlc7Uaut/WqyXmuTaJmnye7LT1BK6qjl/KxB8HKu292oE52a9cTcaHGIA7R
         aYhOLOorKuB+dRBPWW8OjYwDE3ITpNZfBjYB2XM6Sr71AXv31uqJAeKH9xJQt1W9n4Zu
         xO6MnSrGEdNPr1/ZNJ80xNvVOyYfaSg7J+8GiEcmxWbJM907FH3eReuk8ICeOeQVBamQ
         Q1M67f7h/EtMzp4Rx95cjWIE9eoyYRxtBvBb5EjD46eJPvTFv10xbPiFEsWP9beK5NOO
         Cp3rW2jhES083qkDWWWvsUbN+Ph4yh3grunRiuiS8Gb4Xn4E2scVYENd33cgGoJzt/+8
         SAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747068775; x=1747673575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZNWFRrUSg91wrgDi7MuQDR/3MURApHPgoEnszpvjls=;
        b=T+0A8q+j4kOeebQnqNLUq31cQzNVzvehup5JvPDFgbtDoryceOTNtGpvsamde4VhIr
         YEiNOJ8YygQnXvKuk+463q/KHIacaqv+pX69nnIGCErwHlHQBIa5eJHRRuzrvxn2X7ma
         Gz+h4uod1NUw9gN3iuauS0Krgvrts3NI7oZ33xMLrf4MnbTtv9iQLCV7HA+frdVzP+Tc
         g74cwp84hEog01v0lYEXTCXzqfG0STgRopR9SsrVM6o0/lzN9f8Dv59W23FAob+EnBgU
         TDInG9jxkDapYUcS+jMSyIhDAqQXwn9/1UaAWFAdRZzqjmjiMjmmGjXNHNP5Ru+0zTzz
         hhRg==
X-Forwarded-Encrypted: i=1; AJvYcCVyxTWQG+StKBRqvsm1NW056L1O8BIAlulQDhKoBW6rvPENjFDnKuRoMDI03MM9JfgEa8Uv8SPIaeQV2Rh3@vger.kernel.org, AJvYcCW3fSGhUX3BReo1RalQwu2frXdKUnmPf5KykAySJznBQ76aT/oOsPPJwV2YBHG9ss+iswuChFMRVqYk@vger.kernel.org, AJvYcCWjnngQuV+wGeuU76TjN+TIpiNLiFZIMVeKjfv3EGD4FJe0gCp0yqtGf2rHPVtiznee7Df51oNu2+kX4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqSscuI6eF8R8tD8+fOnBchF2wSmjKn2T6B08JxOLy3Qekdoxn
	K9a1ZjFGnGeO+NaFR+x32wbkWw1d3vZtgWabnVcFxM6E/hdOC7dG
X-Gm-Gg: ASbGncstHA7AtebGfNJoGHGip+qlV8QXKrEEy8FTqchN/TfRUUdd77Uqpd++3Niulf8
	/PYYrqVIQogrx45odPmRY24TXvKq6u3DP6uEpcmxAc5bsFWTBxmUTqxgdtOVHLY3vFhNf17k77U
	9cAq8MDFz5Jeq/Gtl6Wv4BJpS/fMJTjdEHsuixYGCG0es7nlsiXG5DksAtTVjpB69FsPhmenkEZ
	GtVf0SXDbrUPRrg+Zf1ZM9J7uh0i5YRIhhBMbLM4nwI22X12rEpiGkDY/ksFgiA4ETJRlPnCXgY
	tOARG6kSnBncxNMelHcQJdMmZ6PtzQx+j4HLiq1KnKCHNIoCtA==
X-Google-Smtp-Source: AGHT+IFgWc2wCu7S/9RbJZkXPhP5XtjOV9ZJ33dg5BwNo4gnN8tIOEohMbw4lQklsVP/+z33huQ1EA==
X-Received: by 2002:a05:600c:528a:b0:43d:abd:ad0e with SMTP id 5b1f17b1804b1-442d6d6b6ecmr121896135e9.18.1747068774592;
        Mon, 12 May 2025 09:52:54 -0700 (PDT)
Received: from legfed1 ([2a00:79c0:632:2600:22ea:3d6a:5919:85f8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd32f194sm176749815e9.10.2025.05.12.09.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 09:52:54 -0700 (PDT)
Date: Mon, 12 May 2025 18:52:52 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: dimitri.fedrau@liebherr.com,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Jean Delvare <jdelvare@suse.com>, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] pwm: mc33xs2410: add support for temperature sensors
Message-ID: <20250512165252.GA11091@legfed1>
References: <20250512-mc33xs2410-hwmon-v1-1-addba77c78f9@liebherr.com>
 <1bd48694-9760-4e6b-9138-4651d42ff032@roeck-us.net>
 <20250512133114.GA6440@legfed1>
 <a7a71408-c01d-4e0c-bd44-73ffbd79f716@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7a71408-c01d-4e0c-bd44-73ffbd79f716@roeck-us.net>

Am Mon, May 12, 2025 at 06:53:21AM -0700 schrieb Guenter Roeck:
> On 5/12/25 06:31, Dimitri Fedrau wrote:
> > Hi Guenter,
> > 
> > Am Mon, May 12, 2025 at 06:04:33AM -0700 schrieb Guenter Roeck:
> > > On 5/12/25 04:26, Dimitri Fedrau via B4 Relay wrote:
> > > > From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> > > > 
> > > > The MC33XS2410 provides temperature sensors for the central die temperature
> > > > and the four outputs. Additionally a common temperature warning threshold
> > > > can be configured for the outputs. Add hwmon support for the sensors.
> > > > 
> > > > Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> > > > ---
> > > 
> > > > +
> > > > +static int mc33xs2410_hwmon_read_out_status(struct spi_device *spi,
> > > > +					    int channel, u16 *val)
> > > > +{
> > > > +	int ret;
> > > > +
> > > > +	ret = mc33xs2410_read_reg_diag(spi, MC33XS2410_OUT_STA(channel), val);
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +
> > > > +	/* Bits latches high */
> > > > +	return mc33xs2410_read_reg_diag(spi, MC33XS2410_OUT_STA(channel), val);
> > > 
> > > Is that double read of the same register needed ? If so, you'll probably
> > > need a lock to prevent it from being executed from multiple threads at the
> > > same time.
> > > 
> > > The comment "Bit latches high" doesn't really mean anything to me and doesn't
> > > explain why the register needs to be read twice.
> > > 
> > > 
> > 
> > All bits of the output status registers are latched high. In case there
> > was overtemperature detected, the bit stays set until read once and cleared
> > afterwards. So I need a second read to get the "realtime" status.
> > Otherwise I might end up returning an false positive overtemperature
> > warning. I don't think a lock is really necessary, since I'm only
> > interested in the "realtime" status but not if there was a warning in
> > the past. What do you think ?
> > 
> 
> Hardware monitoring is _expected_ to report the last latched status and clear
> it afterwards, to ensure that historic alarms are reported at least once.
> This isn't about "false positive", it is about "report at least once if
> possible".
>
Didn't know that, thanks for the explanation.

> Given that, the second read is unnecessary from hwmon ABI perspective. If you
> don't want to do that, you should explicitly document that latched (historic)
> over-temperature alarms are not reported.
> 
I would stick to hwmon ABI, just didn't know better.

Best regards,
Dimitri Fedrau

