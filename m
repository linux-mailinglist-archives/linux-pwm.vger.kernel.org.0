Return-Path: <linux-pwm+bounces-5429-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDA6A82D6D
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 19:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D52A67B0FA8
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 17:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7645926FDB5;
	Wed,  9 Apr 2025 17:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4wKTQrn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91C81CB332;
	Wed,  9 Apr 2025 17:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744219006; cv=none; b=AiywyeYCEaGORGRuDV/aH65MxryVrR7UpKgqKFPNEHLM+ZzdJ7wP6BWwrfDN7w7Yr9YjyqNBeZMGfB7Aa34tbeirreLjQOrGYZCD7EXPncLVABvGz+9G1UVZvYwml2w0uZ8hgWhLob24ejdjaW+krOQwTtdsWXoSK8+tbG/UnhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744219006; c=relaxed/simple;
	bh=hAy1MJepwnZxQmMK/uOX+EgaJ07ZfV47gUfy+9bYyfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgWQXjdJ/k8rxWmX04Y1HC+uktEhEvg6fdD5B/HEgF1wV3XFJj78xlK7bkRCjaEMPM03gt7DMPxshguLlvedgcGj57Rp9xQyNmVcs6w1NCBaqy9T4ENsfsR+eYNEINQ0emPGD7v0Gf+Ur88lCblqv2bvag7wi71rOcrTgAKiKPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4wKTQrn; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7369ce5d323so5759256b3a.1;
        Wed, 09 Apr 2025 10:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744219004; x=1744823804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5JqUMAh6AmNecX7O3aET6mXLWZl7+p4uOdSNHYwRAMQ=;
        b=M4wKTQrnkYwE67DfmzedDAjYZxq4aSK4LT4pxBpFJ4ySyZCq/x+5BY46yMmoZD3kfR
         yRSSiNGXMMtmOdGK+pAQ9fXsYPWyI5hTISETQszZ8w2onz+8pUSroh/UHfmTxmWBuIT9
         5hmC11k6yohqhm/3vpq9HjccMpOf+seozx0PyZ8i0or+9Zw+wvoa8FhiLMg3qobRnIwR
         besgMmMcL06hukjaL7Nt215N/4EfEfiVvTEwRrJfSZXvw5GLgF3037JMwj8ywLOlugCx
         y24lE4y0sQeZjUVsrS7b0jY2kVlWF8Mcjkr3puGGPuSXZBjzzvtb8Cl3lwHNDrIBTRJN
         GFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744219004; x=1744823804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JqUMAh6AmNecX7O3aET6mXLWZl7+p4uOdSNHYwRAMQ=;
        b=EAvOPKsgWDDEPaRiLcWVLsunw/RycKJGJnLa03D1UyETWhQiLMRa95E8YfC/KV1Hu3
         LojSvAju+olBecOnEnS7a4zs1FsTd1Ay8IpR9kwMJDFVx5mWtvieBPfW5/DY8fDJ56B5
         LssS1jYbGrDFUC/OGLSuBV4ZqYKc535uF4D47DDF0Eo/UmY7wICYlSq0AmKm55S/Zjfp
         2bCbSY5Brwm0FhLMK7xMT3oTvDCUKTB/tD7JIc74+i3sQ6JaEmz35ac5RrmUrHrL0IaQ
         xf62v4MXfeETAyQ2ACIrJ+16xu+la2SSU9a7MZowFWIjz8TizFaHUHWT3sjEpQZesJtA
         SecQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbgRm7Fh+xW2pp0KCJrQ9C44WdJ0FF42EDCJs6JbfA5zWzOAEyA3Lb9ceEwEFCby4aoEftIcl1uRcy9VYA@vger.kernel.org, AJvYcCW0KagUnd+oJD7RmuwixjM46daQ0AISmH4FFW9J8F3t/MBh4CKno8/GgnbvmbZNfdgTtkSqmRWkrrku@vger.kernel.org, AJvYcCW1E8W82yAxIDb2V1Q3EduhA71k+H3enAOAUPoN4Aw8GvpyyARRVALLVJz+r9E4mg6IJxeBJrjS7D0V2io=@vger.kernel.org, AJvYcCWURy7kDgyL8NQ93Nj7d3gnMry4BwItY9xcphnMDnF92I5SVkz216yoHs0n8IGXY8hyVaTQP264XZf0@vger.kernel.org, AJvYcCXmvGtoBauBrYDdrkyf1Pm9ml2/tPdw9uIQrweZfS71U1njXgBuJ4c2MmoHlza7W8geRuc9xkZg06bw+A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm3TpzWFYnvWTi7+Islp/9hdDdiA5sCOMlI3xcXiZTGZlEiSpY
	G4j0t18WizV5KwRQ1Omt+qf6JKJ19NFurK45D1vfkolctym9YN0s
X-Gm-Gg: ASbGncu3Zy4RHsz3Jo8oaQ8v809e9JNncYAVJivwxIHN6wQ8fptT0nQiQA5pNGzQVOI
	M3QvO49YGxhIm/DGerAoMcgEeGlr0EbeIs8yE4uE63hjFMzoShcIPPNffNATRCu6e/2UhqcT5/Q
	nES0odXR/wROLn1g2uW85RsVhhR/vH/MKlfJj//cPZ5Tzuj2CORW3ZBM9mPGPXS4kK8UM3+gIIo
	KurbNRivWhqho5mKMdFwuNp8+hTvC5FpuBwVPawVeNRnzMCINQwH/ZiwO1/zhRDRk7TN/OQoVD8
	QDg1Uuw1YeLFVIaZu5haMO8/iSXaBRL3LxxL1ohqGQ==
X-Google-Smtp-Source: AGHT+IHwkaJMo3yG/X2kIQQLKeqOt+a7WIEY87CCGVmBrcmN2ocarEBiD+9SHNAOXX+Wk5f33TSTmA==
X-Received: by 2002:a05:6a21:168d:b0:1f5:86ce:126a with SMTP id adf61e73a8af0-201592e127fmr6116939637.40.1744219003913;
        Wed, 09 Apr 2025 10:16:43 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:cff4:8871:54bb:4c97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a0cf38dasm1312066a12.23.2025.04.09.10.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 10:16:43 -0700 (PDT)
Date: Wed, 9 Apr 2025 10:16:40 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Mark Brown <broonie@kernel.org>, 
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kamel Bouhara <kamel.bouhara@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Michael Walle <mwalle@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-pwm@vger.kernel.org, =?utf-8?Q?Gr=C3=A9gory?= Clement <gregory.clement@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 05/12] regmap: irq: Remove unreachable goto
Message-ID: <asjb2gjqpohtq2cyn3pll6nabbymd2o3jg723eloog6znwruo3@47wewlrtom5h>
References: <20250409-mdb-max7360-support-v6-0-7a2535876e39@bootlin.com>
 <20250409-mdb-max7360-support-v6-5-7a2535876e39@bootlin.com>
 <1b280408-888e-48e1-8e6b-de4e7a913e74@sirena.org.uk>
 <Z_aUeKm0k1zReS_D@smile.fi.intel.com>
 <7126e672-a829-489e-a0c0-8d6d64a8b2f4@sirena.org.uk>
 <Z_aZmJxPwIBgcwhG@smile.fi.intel.com>
 <28982424-d425-47c3-b910-58c787e13510@sirena.org.uk>
 <Z_akNogB_TkXcS37@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_akNogB_TkXcS37@smile.fi.intel.com>

On Wed, Apr 09, 2025 at 07:45:42PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 09, 2025 at 05:32:55PM +0100, Mark Brown wrote:
> > On Wed, Apr 09, 2025 at 07:00:24PM +0300, Andy Shevchenko wrote:
> > > On Wed, Apr 09, 2025 at 04:46:04PM +0100, Mark Brown wrote:
> > 
> > > > unreachable() just annotates things, AFAICT it doesn't actually
> > > > guarantee to do anything in particular if the annotation turns out to be
> > > > incorrect.
> > 
> > > I;m not sure I follow. unreachable is a wrapper on top of
> > > __builtin_unreachable() which is intrinsic of the compiler.
> > 
> > > https://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html#index-_005f_005fbuiltin_005funreachable
> > 
> > That just says that the program is undefined if we get to the
> > __builtin_undefined() and documents some behaviour around warnings.  One
> > example of undefined behaviour would be doing nothing.
> 
> Theoretically yes, practically return after a BUG() makes no sense. Note,
> that compiler effectively removes 'goto exit;' here (that's also mentioned
> in the documentation independently on the control flow behaviour), so
> I don't know what you expect from it.

So unreachable() sometimes lears to weird behavior from compiler, for
example as mentioned here where we ended up removing it to prevent
miscompilations:

https://lore.kernel.org/all/20241010222451.GA3571761@thelio-3990X/

Thanks.

-- 
Dmitry

