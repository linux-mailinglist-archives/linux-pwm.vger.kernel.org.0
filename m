Return-Path: <linux-pwm+bounces-5581-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BADA94222
	for <lists+linux-pwm@lfdr.de>; Sat, 19 Apr 2025 09:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC00E443135
	for <lists+linux-pwm@lfdr.de>; Sat, 19 Apr 2025 07:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E461991CB;
	Sat, 19 Apr 2025 07:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFwuv4XI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5D013C695;
	Sat, 19 Apr 2025 07:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745048172; cv=none; b=o2jFmEFJYcbrWVxNChqhifYltlNgNtDndllQW5afYCxc7/M9uxldF6fbzdsgCLdDblNMNXcUWBF1j/Ft9pgCocXB6eAQbEUJoxGLq42NsLQyHb9P64x7xrwzlN9v5jKu4NlQQhQEM0UtL28nU3Q0NZz5Exh+SqwdtQB4s3Wp7G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745048172; c=relaxed/simple;
	bh=YBK6y7m3vZOAQqF+Bkk1DHbXXrlb3AtVna7xej1bwYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVsrYI8xcfrQrLF+zADCz1WwJzBu199/gwrrfUrCDEIUG1F0qF1soq9hlFrkgAdvEqf59IPeSV0+h2nR6MQTCLLDy2No7nwWQERfBQjiOhGESoPHgHpYQuH6bBC9RRp5D7P7mgDOsDRsXgTUyVo8fhzPy2eQhHjgrS2GNTaSBR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFwuv4XI; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2254e0b4b79so37066255ad.2;
        Sat, 19 Apr 2025 00:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745048170; x=1745652970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VbNMv8EcDVNc7S53ITN7O5grQN0Xg+vZe4s9ox5YAkY=;
        b=NFwuv4XI87LQ6/dNV0mPUwQ5yWK3EEddZbIjmm3JHIWwzlR1SAFFzLrXYpg95Hlapf
         h09gW3LHZnwHka6y/0wOhP78z2h462cxSoz1g54DfBDRIyzLuSsGLha6mF9QfRcctZUO
         NCpdipNPk+dc13LhCGkjlIRZXuNSvylifpplYssrcBacHLpf5Q2fJOrmTMJBFO3IrkSi
         xNpZiga08iyccOTUeCMxpR8w8Ndcp8OL7ZoWYuVfRg/KEPT54v+mu7vJWajRPzpwJuKp
         owlVXWsrBP9RliCI6MiO7mCWI3OTUkpvevMFh7s7LxKg3j+cCNC2oIYsIOeNCzMSLcGE
         qROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745048170; x=1745652970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbNMv8EcDVNc7S53ITN7O5grQN0Xg+vZe4s9ox5YAkY=;
        b=alULv3Mk9FY2G8i29t1svcstbb+bpMxtbvFwX31tujrl41GhnH04UW8cg1pe00efTm
         sH7sYpKkBguMuhQI2i2KVmSB+9DF7790/Rrri0+cpkPMW6Abs3tD2WrUgVuUufmKvOYj
         EkMngvLJ26sfE8ZKwiR0Ybfe769b4rv1PzdcjQw+RR7BOEoL4pKfOIl0NUQS9l+9yCgl
         1vQB+E/X0EYdAQw1DMlQVVwTJBOxpkgiS3w++ThICKtlCUPkSI9paYpbF3AvcfUc7gbi
         pLcftDNWZaHypICEycjxvqVm51p05yS783fcE8+OVlU1eRqBdnpWTzzNlLVBH63DBvcD
         vQtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQVWSwlrZ+ryn1+mpzdc5USVYKnp98BRKg6IVaJAHb6tfWOShxTWKPXO2jC/JtDTvocJW8kjJrQeh4@vger.kernel.org, AJvYcCWlMdrA90NK9edXKqCqJJquh9SGbFpUl8+UAXXracnvwkfIQANizFciMY7HAUAd4UMF4SWM0r6clK0F@vger.kernel.org, AJvYcCWxgF0b3NzegfzcfVES8FnoycwDJ+NK+tIeTEitmioYlR1HMcX0w4b4N7Jq7XqQZVdjNdRebQYyMb8FAhzY@vger.kernel.org
X-Gm-Message-State: AOJu0YxPdSdgBVmAjCRWbMzH4qqmxDUF4J88heMCvvGU8dBq6F+pc4n5
	5bjJUm2KlMCfIxpjGdmeKW0QLHZ6KIgl9MWvhhIBfWq4vb157pWW
X-Gm-Gg: ASbGncug7n2X0iweRXbgBD8l0MBrMiLvfL867bBtILiUAuEnVDr4fx27t0Xk2HikjLc
	guIcA4Sr8dAs1p8z0CDfKeH+lm21qkc4m6TYBCYZihXGoSythm3iwvdYuSKfy6gkbxd8aZdOwQQ
	IJ0Ze7IaoZGBuwwLGuXpb461NqGFfFnUWMUZiC5nTSxnGKYx5qKMLMW9rlZKoV9UxM9pKS5DbO5
	wtgeLrZh9CzISYjIcFccXmyGtQzUppwwHyovYqcswkEWb8Yzs/MMI7V+aCMNNbHrnx8DTTmnpTi
	fpG/FVwJ+3LOf9aXSqwIn68EJrm3CBUNcpq8H8/o/A==
X-Google-Smtp-Source: AGHT+IE8gk3khKs6q2QV88hzoLFK8V9guTrvMWRFQ6JyDLTYcHlv4zmRal3/vUFMXM/1CNJJOpJ0+w==
X-Received: by 2002:a17:902:e549:b0:224:376:7a21 with SMTP id d9443c01a7336-22c536076f3mr77627655ad.42.1745048169844;
        Sat, 19 Apr 2025 00:36:09 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22c50ed0f7asm27997115ad.169.2025.04.19.00.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 00:36:09 -0700 (PDT)
Date: Sat, 19 Apr 2025 15:36:05 +0800
From: Longbin Li <looong.bin@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Inochi Amaoto <inochiama@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 3/3] pwm: sophgo: add driver for SG2044
Message-ID: <pat3f5nc57uo6p7vwmlrky6ezxhtn3qldmx3falmc4hv5beyyj@r2jfmuxtx5pi>
References: <20250418022948.22853-1-looong.bin@gmail.com>
 <20250418022948.22853-4-looong.bin@gmail.com>
 <MA0P287MB2262E14F6F9758646320F7CBFEBE2@MA0P287MB2262.INDP287.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MA0P287MB2262E14F6F9758646320F7CBFEBE2@MA0P287MB2262.INDP287.PROD.OUTLOOK.COM>

On Sat, Apr 19, 2025 at 09:24:23AM +0800, Chen Wang wrote:
> 
> On 2025/4/18 10:29, Longbin Li wrote:
> > Add PWM controller for SG2044 on base of SG2042.
> > 
> > Signed-off-by: Longbin Li <looong.bin@gmail.com>
> > ---
> >   drivers/pwm/pwm-sophgo-sg2042.c | 89 ++++++++++++++++++++++++++++++++-
> >   1 file changed, 87 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-sophgo-sg2042.c b/drivers/pwm/pwm-sophgo-sg2042.c
> > index 23a83843ba53..26147ec596c9 100644
> > --- a/drivers/pwm/pwm-sophgo-sg2042.c
> > +++ b/drivers/pwm/pwm-sophgo-sg2042.c
> > @@ -13,6 +13,9 @@
> >    *   the running period.
> >    * - When PERIOD and HLPERIOD is set to 0, the PWM wave output will
> >    *   be stopped and the output is pulled to high.
> > + * - SG2044 support polarity while SG2042 does not. When PWMSTART is
> > + *   false, POLARITY being NORMAL will make output being low,
> > + *   POLARITY being INVERSED will make output being high.
> >    * See the datasheet [1] for more details.
> >    * [1]:https://github.com/sophgo/sophgo-doc/tree/main/SG2042/TRM
> >    */
> > @@ -26,6 +29,10 @@
> >   #include <linux/pwm.h>
> >   #include <linux/reset.h>
> > 
> > +#define SG2044_REG_POLARITY		0x40
> > +#define SG2044_REG_PWMSTART		0x44
> > +#define SG2044_REG_PWM_OE		0xD0
> 
> SG2044_REG_xxx, the prefix looks inconsistent with
> SG2042_PWM_HLPERIOD/SG2042_PWM_PERIOD. Can it be unified?
> 
> The others look fine.
> 
> Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
> 
> [......]
> 
> 

I will rename it to unify, thanks.

Best regards,
Longbin Li

