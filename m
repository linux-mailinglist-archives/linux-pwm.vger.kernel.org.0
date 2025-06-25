Return-Path: <linux-pwm+bounces-6531-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B72AE845F
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Jun 2025 15:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55AE71BC4BA5
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Jun 2025 13:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A2F262FC2;
	Wed, 25 Jun 2025 13:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWbrss6L"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF18625FA0F;
	Wed, 25 Jun 2025 13:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750857392; cv=none; b=ax7C7pgMh3aCFhXJ/Cp8oxshniRa8SJwCpItu5BuDiEbqdfRdUV3ViFOtP0cAFzd/ZjSJG8qO1lhc3TkdaW7AbL1Dz48M3kxr3X4pV9mCBw0tVMQ4HTvglTwfHGagtFVK5EfG5mUHO57tY1apJJzg32F590LFmkNGNpHQkuM/kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750857392; c=relaxed/simple;
	bh=17ImiBrvIC1hj8JzSb1O1aUHchtP9UQvsq/M13ZSMhI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ds7u8AEVtInbR/T74fYBy6ErVE/g3rZANcY5NPLwA6MJAvSKnRKFQpkKrh95YEEFkRH4Yq1a2zOzq1lTZZdwazTGV59fW3STDiSls+MKzFk4AhVV72UnPNrzUEzdou6AmpOwxWMttOLqIKC3bKsT1Grnex9xngcDDfecbUa6Yvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWbrss6L; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a522224582so838048f8f.3;
        Wed, 25 Jun 2025 06:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750857389; x=1751462189; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kNNms1cqXOggVNTVVI9ToDIchXGpgIDdlrqJ7bT7Z3I=;
        b=AWbrss6LETXrQnLnzWjkb1JQJHUSMV/3xK/ms9eWf65Fs5w8EYBSfnyTnHeYQCNKtx
         TOGR2ZLul2ReI14A8oUp41d9EB2iouwuMJsOuWyP+JUza48dGbtgDYcJdl2THZGDd17w
         zvCu2Faxj4BArBqRpb/1UN+gBqM1Abu5DOc8dlamw9DGqzgzPWb+P+jAfQwPTptbY3tO
         1B04zlyNxdRprZh7Y2Gg8uajR/881IC0EnXg4fVHmlVNgrc1XBYbwPcqDqtLvowuzHDZ
         g6LOyrwaVrgiuVHxfDW7/sfvTGe4Jqq3js1HghuOhPMHdSSaXCjs2Y0xL2KDfQRzVLy6
         XtmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750857389; x=1751462189;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNNms1cqXOggVNTVVI9ToDIchXGpgIDdlrqJ7bT7Z3I=;
        b=LnrVKD4T4lerjEUGh9xpvkJckC0q6KK+t6kPp/Z5xOd+KwZUhI5LViORDpqEKjLs3j
         HqwhDOdaaqaJkaJmGIdeHXZ077jQf4kvUVyJDqfyazShDB9m/FsHGUZ3/tGK59MBRxRO
         21EhVeMlVFJuk51aj+am8AMkzJijWcwPmgNMGjQkezFkqNN6fi5LsBxwIA+NBfLOhM6K
         JQkcRxtBobcAVcMcjug+8sP7iFvNhQBJ3J10UVPLzrzewkRflsq+S+Z3WkM8cBMj5e7B
         7IDofIEHKEU+Oo5EeYiVpipPVtuTSBpWtm1XUQSehgntKfPiB9/OLdyoLXPSYTSppgWi
         kqZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxbNegHE1oYcBh8QbbVNTweOcNXVF9g9rV1Mvudw2Qg+jijhdolJTWbil1gFFcTUg3gFTKqR4jZLbF@vger.kernel.org, AJvYcCW7y5exFeC2YSB+gczW6e6dPaNIiaqoSOCOslJ4G4AplVLK7hHcwRUbEOCn/howcIXAVhaFG8XCECxUEQE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5gp6VQwRdIAWMvZwMpT58GJrNlA4FGv6b3mS3Br//lAa7k07i
	BSVX0nFSU5YZ5Fy5KiFhHDuC6Iyiz/6Yp/mrs6TDRrbFOYfTz+zY7vvn
X-Gm-Gg: ASbGncs5P4JJ9AiewVf7HkqghLtB4fPDrsf2Z3878ExlV0QY5XJjzrudX/sfYdTOSTp
	Jthbo0pLpjkxrZSTeXAh5cRPwXLZLphCNgGdwuu3UIY/KaqUN0eGijDwSoxr6ZbaRsIVgme7y2x
	9SvRe26D9fRYJf++aSzqstkQsRK0wAf9uTjRFsaZlS4BGBhTiwvSD7WJWaNNWYcs1DaYQ19PA1v
	mDz1ZBVWvqtuCvlQw4rHq6Lbn5xZJlap6+zwloYXdAexoZl58QVZNTVCDDKYn5C6l/P+Z0Lxhy/
	YqRQBW5oIXFNmHnAMvn1bnHiEsyF6eD4VsZdNuvy//ZvFr9hCsqUQZj2pj5eiX9HCXPtgcHjulp
	ecM7D3G2G89jghGEZJQ==
X-Google-Smtp-Source: AGHT+IHb3Q0fgemYtR23g+jZRPWflFpdrZhbF17TvO7pkjsqXfR8YQ4Ku28UgCKOYBTi2n6UQD4jJQ==
X-Received: by 2002:a5d:5f4d:0:b0:3a4:f7ae:77e8 with SMTP id ffacd0b85a97d-3a6ed620053mr2616782f8f.15.1750857388773;
        Wed, 25 Jun 2025 06:16:28 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45382376ff7sm20503605e9.35.2025.06.25.06.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 06:16:28 -0700 (PDT)
Message-ID: <685bf6ac.050a0220.357231.66b2@mx.google.com>
X-Google-Original-Message-ID: <aFv2qTBCCSwmj1y3@Ansuel-XPS.>
Date: Wed, 25 Jun 2025 15:16:25 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v16 1/2] math64.h: provide rounddown_u64 variant for
 rounddown macro
References: <20250625000059.20040-1-ansuelsmth@gmail.com>
 <aFvf4c6Jp-cgBssA@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFvf4c6Jp-cgBssA@smile.fi.intel.com>

On Wed, Jun 25, 2025 at 02:39:13PM +0300, Andy Shevchenko wrote:
> On Wed, Jun 25, 2025 at 02:00:38AM +0200, Christian Marangi wrote:
> > There is currently a problem with the usage of rounddown() macro with
> > u64 dividends. This causes compilation error on specific arch where
> > 64-bit division is done on 32-bit system.
> > 
> > To be more specific GCC try to optimize the function and replace it
> > with __umoddi3() but this is actually not compiled in the kernel.
> > 
> > Example:
> > pwm-airoha.c:(.text+0x8f8): undefined reference to `__umoddi3'
> > 
> > To better handle this, introduce a variant of rounddown() macro,
> > rounddown_u64() that can be used exactly for this scenario.
> > 
> > The new rounddown_u64() in math64.h uses do_div() to do the heavy work
> > of handling internally all the magic for the 64-bit division on 32-bit
> > (and indirectly fix the compilation error).
> 
> ...
> 
> > static inline u64 roundup_u64(u64 x, u32 y)
> >  {
> >  	return DIV_U64_ROUND_UP(x, y) * y;
> >  }
> 
> ...
> 
> > +static inline u64 rounddown_u64(u64 x, u32 y)
> > +{
> > +	u64 tmp = x;
> > +	return x - do_div(tmp, y);
> > +}
> 
> Can it be implemented as above?
> 
> 	return DIV_U64_ROUND_DOWN(x, y) * y;
> 
> (yes, it seems we are missing the DIV_U64_ROUND_DOWN() implementation).
> 

Guess it would be

#define DIV_U64_ROUND_DOWN(ll, d)		\
	({ u32 _tmp = (d); div_u64((ll), _tmp); })


But isn't that just directly div_u64?? (maybe the dividend is enforced
u32 with the cast)

and in math.h I can also notice

#define DIV_ROUND_DOWN_ULL(ll, d) \
	({ unsigned long long _tmp = (ll); do_div(_tmp, d); _tmp; })

tons of macro that do the same thing ahhahah

Really seems I'm opening a can of worm.

Also also division + subtraction isn't less CPU intensive than division
+ multiplication?

I know the compiler does magic on these internally but still...

-- 
	Ansuel

