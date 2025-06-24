Return-Path: <linux-pwm+bounces-6503-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBB1AE5EF4
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 10:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A83384A1B13
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 08:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F0F257AD1;
	Tue, 24 Jun 2025 08:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FguYRCmM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BC4257AF8;
	Tue, 24 Jun 2025 08:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750753165; cv=none; b=fEckRT5uDdLnFc6ClUbXLvLOw9oRBqANbJ+yh5Qi2kPir40R2IWK90NSw250NlYwI3lfoR95PyfbjfbB25ElYEK7AW98zX4A2elVrtG1Gzbs5cDJZNnq+E/qOspqKr3bkhecEDGII+M4eYQTQ1r+WoUJZvOBshbDPQ7aVz2teWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750753165; c=relaxed/simple;
	bh=lHc4ZAAeqfzHN1X+wVHA/c/Uut3n6yiJSxjoF8fRGM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJ/otmwa5H0j6sgakZgDWq6rHMOHwGVjhFJT/RaRIV/ydoo7WjDVpHc8Zu5qEMs08BdjCNjSoShjy5aNogCUEbYzASqxsWeonTtsCsAWiqgfUEFUahWvuTjqFi7IFoqUx80KXq8rbCsz5Zqnn3LopFs07jVvKp5KVqsltjcYsUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FguYRCmM; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a57ae5cb17so2786605f8f.0;
        Tue, 24 Jun 2025 01:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750753162; x=1751357962; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0HQzhmMwm8dgf3BqJLxWZHwxNCOz9a49V8WdE7r2r9U=;
        b=FguYRCmMN+dN7u+Zmnwmr8jRuHvOI2IINWyxueJMTglU5f1GOYJ0ad3DShailOqtlx
         8V4o0kbkZx/flhJYHjJjf4FX/RpQYkfXd0EGqn7gvZoneikZhqfpvmMoPOJYURq1Tc6S
         OO0a9rEmTc9qUL35tq/SxyiFNrIVomB4YA5njPbEDl03a3LH5XoLEZ7Teg0hgkWD1MGd
         qtCNz8JnISoM/md9xeFtxFKL3djW2xl46H2Fed1J4dm4eRzE2MxWE+IdN8jPvyaAAoqq
         ZyQk+aFhRj8819EiWIL8l1Sff0rGbmDEBarMiiyd/C8XvSK7fgGeoUIahXlFG0qQEigg
         GmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750753162; x=1751357962;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0HQzhmMwm8dgf3BqJLxWZHwxNCOz9a49V8WdE7r2r9U=;
        b=SbkV3zORPSc+5y19JyCCDYWWUwV3m/iliHaT/MihuF7em76pG9d2KUfCXNBo1dqMeO
         ZeQch1maLvGZ78y0DoUEEQZ7qHnIMdIxu6786eeDjkqtAfOpz/QJx1zbty8IkgJSdbpU
         /et2FesaM1HaOhFCZEwTq2BDF+K6k2Aq/5P/nIQDQiSzpxCvO1IC7UXeWU/dUx4yavoa
         sE3p6gF1f3MdbtwvPbixEQq2PY6/Ee75XBBShxRnZm7PJbcKmZ6hdLQm1hM8n1sRdA4j
         YI2anGcuPpfqx0L+s+Z+FjkpSx9wfwtWRNHJ+Tdp5hNJtpghPGtpH+LVB6QFO/C66QIM
         eNvA==
X-Forwarded-Encrypted: i=1; AJvYcCVY/x7lKJisVrN8j4iqDc1S2wl0VSSpPV0CPgAZvZSagwarNuKe7WAnLmmoYaGQ7MeLXRcY0L5SojjA7w==@vger.kernel.org, AJvYcCWfsGbShFM4Y/cQplYnh1eVulxeHqvMsc374llnSA538tZGZf5f0oOA1YqBPhJBWpaL8ut45TAcSsnj@vger.kernel.org, AJvYcCX7fSKNqkzKwp8PScMOf7Ob3kyxWT0uKcAXRSSvUMhl2zpTaaUbqV/DCIk/De7VrMdJnHcnj6L49USDavaA@vger.kernel.org
X-Gm-Message-State: AOJu0YyQBgEgYWefKlU9dLfwRtOrpGsj2PyCWlAGPjYh1Bj3//NdNqi8
	+SFAp5UJpfklJgCyPu06OWCXUw5DMsI6DHCwJ/GPqe9wNKsJOVwCbTNR
X-Gm-Gg: ASbGncuAXjK/PwIiwFr6OP2cTcF+8E9zPfcqGLN1e3i/lAqP4Z72UotNGgYXLdOiSZu
	F5dykkg1kSGsc7xsaRUa4pMaxOZmZDdgWUUyl7oZ+NPT2m5A/pipyYddMUa+VQH4Fum681vcruC
	KNSSCeoVuLqyep9p18ex2WXFPvLkGncU09PMg2wYCJzRgmSMaPcEHRJWlLVUewAajgTPpMsxGkG
	jo2FdCpJbZvsHNJELqNagq0JsSQFx1Ddd8MRUUsPb4QeJY3rLIY29yNl3p/ezyuxREv9qEaLgbJ
	CCXCcJUuEdbTUerZf/RpGF/kyV25YdnuvWPlmkw3pGHGpTBGSveEPZT+PX+U
X-Google-Smtp-Source: AGHT+IHM8PUchadujkUTWUPCwyBPckulRdVw9/8xANJ2K7NJhCiUFZ9kIVn/HWC58YcEhFgH9pggxA==
X-Received: by 2002:a05:6000:144e:b0:3a3:6b07:20a1 with SMTP id ffacd0b85a97d-3a6d12deb86mr13227259f8f.40.1750753162353;
        Tue, 24 Jun 2025 01:19:22 -0700 (PDT)
Received: from legfed1 ([2a00:79c0:6bf:b400:22ea:3d6a:5919:85f8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e805d21fsm1275485f8f.23.2025.06.24.01.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 01:19:22 -0700 (PDT)
Date: Tue, 24 Jun 2025 10:19:20 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: dimitri.fedrau@liebherr.com, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3] pwm: mc33xs2410: add support for temperature sensors
Message-ID: <20250624081920.GA10327@legfed1>
References: <20250619-mc33xs2410-hwmon-v3-1-301731e49f8f@liebherr.com>
 <cviovwci5fgtyina7p7zqjns7cwveivy3vetqhhagwmrlc2gm2@jrqgorif7xff>
 <20250624070442.GA3383@legfed1>
 <u4aigv7nhsqygisyrhcohq25tvktsukjexng6zddib6kvj6hwl@vaa2pset4qbi>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <u4aigv7nhsqygisyrhcohq25tvktsukjexng6zddib6kvj6hwl@vaa2pset4qbi>

Am Tue, Jun 24, 2025 at 09:29:25AM +0200 schrieb Uwe Kleine-König:
> On Tue, Jun 24, 2025 at 09:04:42AM +0200, Dimitri Fedrau wrote:
> > Hi Uwe,
> > 
> > Am Mon, Jun 23, 2025 at 11:07:24AM +0200 schrieb Uwe Kleine-König:
> > > hello Dimitri,
> > > 
> > > On Thu, Jun 19, 2025 at 07:32:42PM +0200, Dimitri Fedrau via B4 Relay wrote:
> > > > @@ -29,6 +30,8 @@
> > > >  
> > > >  #include <linux/spi/spi.h>
> > > >  
> > > > +/* ctrl registers */
> > > > +
> > > >  #define MC33XS2410_GLB_CTRL			0x00
> > > >  #define MC33XS2410_GLB_CTRL_MODE		GENMASK(7, 6)
> > > >  #define MC33XS2410_GLB_CTRL_MODE_NORMAL		FIELD_PREP(MC33XS2410_GLB_CTRL_MODE, 1)
> > > > @@ -51,6 +54,21 @@
> > > >  
> > > >  #define MC33XS2410_WDT				0x14
> > > >  
> > > > +#define MC33XS2410_TEMP_WT			0x29
> > > > +#define MC33XS2410_TEMP_WT_MASK			GENMASK(7, 0)
> > > > +
> > > > +/* diag registers */
> > > > +
> > > > +/* chan in { 1 ... 4 } */
> > > > +#define MC33XS2410_OUT_STA(chan)		(0x02 + (chan) - 1)
> > > > +#define MC33XS2410_OUT_STA_OTW			BIT(8)
> > > > +
> > > > +#define MC33XS2410_TS_TEMP_DIE			0x26
> > > > +#define MC33XS2410_TS_TEMP_MASK			GENMASK(9, 0)
> > > 
> > > Keep the registers in address order please
> >
> > Aren't they ? There are "ctrl" and "diag" registers and I didn't mix up
> > adresses. There is a comment for each of them when defines start.
> 
> +#define MC33XS2410_TEMP_WT                     0x29
> ...
> +#define MC33XS2410_TS_TEMP_DIE                 0x26
>

MC33XS2410_TEMP_WT is a "ctrl" register and MC33XS2410_TS_TEMP_DIE is a
"diag" register. Both register sets start with adress 0. "ctrl" and
"diag" defines are separated because I didn't want to mix them up.

[...]

Best regards,
Dimitri Fedrau


