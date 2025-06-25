Return-Path: <linux-pwm+bounces-6530-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB3BAE8246
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Jun 2025 14:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEAA23A1FA1
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Jun 2025 12:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC141FF5EC;
	Wed, 25 Jun 2025 12:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvpaHKve"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854AC219E0;
	Wed, 25 Jun 2025 12:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750852873; cv=none; b=gvmM0Gll3A4KKLwj1kQ5y9jovSqg1VPt4UiiiqCjg7PeV4W6H1keQWLyHf8Hgwv4HB4CamKatOvTw0GeMe4zarEs+5CGoP6z8fjXFWhDp3gSsTGgugUbH0mktOYO1hDpRdF8v/nq0/1IfxhBWc/9LlF8spWm+sazGBrYSbPUACQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750852873; c=relaxed/simple;
	bh=CXmSqwBl+ntCnLk7LlQAQLO3lA9jG4t5fgoxlUF/UQg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZI/zey+dfDmPSq4R5TQqzA7zgPDUmhtKeYxCYghlb2So/Z1PoHEl1wgUvWg3gSazMUQDzB0COleYsqQzfPqgkqpmpClPjiL5oeu5RKku/kja7svF4vDznXHwsADbTKL/SVq/wG6yC2QTDSNakULFB2tmBy28628Ekr5lJI2ZSCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvpaHKve; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-450ce671a08so41323375e9.3;
        Wed, 25 Jun 2025 05:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750852870; x=1751457670; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yHefIg2+8X/i5cCCS+NNBXYEiweXVKRtTurM+edGkHs=;
        b=TvpaHKvegtO7W0rHhMZtW449+K/EV1lhH91S6caoSvD3rGiIdBjNQx6PRnKxPmxACB
         9zxWe2dzuAbjlQ2+a3GaTFEm6uZaCeiW7po0G/pXL7YTS6OMxszdcINKgqnPnuaNO4tr
         MpT28ErcPGa2Mpw0RLAcC73fhJwO9pqEHdCM+bG2F012YqI6l7N9DUYWnEoOytmI2wTy
         hDK9U2hlMwr36JaxgGR4WTZrVFQBLy5OsP5JOJaXN7FY4cTFgEPRNUEnN75e5nsSP0/o
         SiyzZvUsqelbIlxs0+ozObWjZ+nat/4jDLVKMBZc0ZYASTYd+dO1zOyqTAF1vSllR/6E
         EXpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750852870; x=1751457670;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yHefIg2+8X/i5cCCS+NNBXYEiweXVKRtTurM+edGkHs=;
        b=fmh2Hi77qcidzEaEEt4D5FYss5vHG8VzRsd8/RrS7ebz657pabhWky8aONHW+F6vMc
         4qWKUp7APrRvsm8p+0xozYZ4G44w8UpI2cMlUMN6JerdGi3WPBxzhcEwZgSG7R9PoB1R
         GmdvZ1/DWBH83mTAHa7bwyB3KeONKlRTWPhwujfCVwrkefXLvMlFropuZolTRw1VyNnF
         bQImO7fgTETmEagktM33EcCeQ+wIl2r1AiZTdMItYXgSv00jZCLw8fDbPdBK0ZZ2Ud7S
         lXyOEzCjQXcWp+9RxJx8ChgA8/v52iMnXhsSHQ5rukyvpStdUa+fc+EJrx8/fF2eEtFW
         MWAg==
X-Forwarded-Encrypted: i=1; AJvYcCVb7KFHlGhqJc7jBVy3386Gh3kVy5NxBi5UvGNBF4kHNQipu3saLNjQKfMxj9EI1OP2xVtdtDMMUTb6@vger.kernel.org, AJvYcCXbkZgWmOqaeGl62X6QwyqOQwXGHBZdupDXEaUhkgTn54+L3mgcsryaChI/0FjXyv1qUmmqGhLdMtctPYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOMQsAjMV4ySDkLtJuhgyalblDSdddzSlgNMyEk6HXD0cwtPBC
	GHu91WrNwQ7/tVNPG9dMR+iVT4oBmPRD3le0cfNTMjc9E2+5DOViNPvZ
X-Gm-Gg: ASbGncuk5TcubK6nPbPvm4NLf0M04EThs8AaaBFg4wdZQ4iFKYe90o1QWIEc67rEqmi
	r4RsA3aLdLXJ1hDcZHTa/x9Q4v+EJg1p6PoOOC/JoeSqxp93zYo+KcDfTPhrwGgdO9hzRnYJWoq
	Q9LfFlCqk62/jCWbAMQqEd5BxKI9qxRZoXP95D9xp3Mz9j5tMCTXUQqBiq9CuCrAnJp7mZ8Oir7
	zoLM8WX7+Y9mYiHOlo31LunflqVkWEGymewBo7BWuRXC8VwAYYCxJVK3PE3eHQx3hYjpbaEdF2Z
	vPqLJMBc4O8+lT/OHN5bDpmRWvBgUWoBaeWvYtdY1RmipdytPjxPeV1MAgn1rIkNfBrmpkgZpfT
	AgXop6nryRP923Wc0bQ==
X-Google-Smtp-Source: AGHT+IFTWlrNcKJ5mnN361DuQVQviW6Cwd7jiDuBvnqI/hGGoBQlP2Vju7DwNXUSJ9DFLMJsKmUovA==
X-Received: by 2002:a05:6000:3c7:b0:3a4:e609:dc63 with SMTP id ffacd0b85a97d-3a6ed631bafmr1718435f8f.20.1750852869462;
        Wed, 25 Jun 2025 05:01:09 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e805eeffsm4437090f8f.34.2025.06.25.05.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 05:01:08 -0700 (PDT)
Message-ID: <685be504.050a0220.1095cd.0c7f@mx.google.com>
X-Google-Original-Message-ID: <aFvlAjNbUwuB7Cy8@Ansuel-XPS.>
Date: Wed, 25 Jun 2025 14:01:06 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH v16 2/2] pwm: airoha: Add support for EN7581 SoC
References: <20250625000059.20040-1-ansuelsmth@gmail.com>
 <20250625000059.20040-2-ansuelsmth@gmail.com>
 <dehsalp2za4i6jgod6ej6gqhestljo7qost66jzmql52n2zecp@imtgipg24lv5>
 <685ba7d9.df0a0220.e1b22.e6c2@mx.google.com>
 <aFvbDdVdoroASlM6@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aFvbDdVdoroASlM6@smile.fi.intel.com>

On Wed, Jun 25, 2025 at 02:18:37PM +0300, Andy Shevchenko wrote:
> On Wed, Jun 25, 2025 at 09:40:07AM +0200, Christian Marangi wrote:
> > On Wed, Jun 25, 2025 at 09:24:33AM +0200, Uwe Kleine-König wrote:
> > > On Wed, Jun 25, 2025 at 02:00:39AM +0200, Christian Marangi wrote:
> 
> ...
> 
> > > > +	/*
> > > > +	 * Period goes at 4ns step, normalize it to check if we can
> > > > +	 * share a generator.
> > > > +	 */
> > > > +	period_ns = rounddown_u64(period_ns, AIROHA_PWM_PERIOD_TICK_NS);
> > > 
> > > I don't understand why you need that. If you clamp to
> > > AIROHA_PWM_PERIOD_MAX_NS first, you don't need the (expensive) 64-bit
> > > operation. If you compare using ticks instead of ns you don't even need
> > > to round down, but just do the division that you end up doing anyhow.
> > 
> > Correct me if I'm wrong but 
> > 
> > #define NSEC_PER_SEC	1000000000L
> > #define AIROHA_PWM_PERIOD_MAX_NS       (1 * NSEC_PER_SEC)
> > 
> > doesn't fit u32 so an u64 is needed.
> 
> I'm not sure what was the exact question, but u32 can hold up to 4*10^9,
> this is just 1*10^9.
> 

Ok feeling stupid... was treating 1000000000 as 0x1000000000 :D

-- 
	Ansuel

