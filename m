Return-Path: <linux-pwm+bounces-8153-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMEqM2konGl1AAQAu9opvQ
	(envelope-from <linux-pwm+bounces-8153-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Feb 2026 11:14:01 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B501174A4E
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Feb 2026 11:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8BCFB3067A91
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Feb 2026 10:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CF735B62C;
	Mon, 23 Feb 2026 10:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaZ5atst"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469743596E1
	for <linux-pwm@vger.kernel.org>; Mon, 23 Feb 2026 10:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771841380; cv=none; b=TVOjSi7joppvjbqVvBN1voaXnNau4y16YuGJnHWgPlQoZIEybUDJgj+3Ne1agFOKR0RBPCMR92r2LhS5wvIZflOCwI94FDoQXWfubEev3OEILBH+CNuO+kQW0LPINXoXH43yQ8dSbUVrcj869gs4s+LFoGuLpFwWwDS4TibUBoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771841380; c=relaxed/simple;
	bh=Ky3jcIBbGAp358Kb7hZKDppR/DA4Xry1FogPtt3x2sE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FMYnk9OESCm1BzmGj9lXjZCueR9z9M74hJ6lPecwS50gfZfUjmyD1fo49RyRNE2+2bTrJARnYWKUQ/kh0hNIYptVFlLAZNj1jlM54k65nqWGWC4BTHshHOH+QYizKk2WTWf3alN+12gqGt9tf9fUxY7a0xoEBEtcVcxJBz/YO00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YaZ5atst; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4806f3fc50bso46764695e9.0
        for <linux-pwm@vger.kernel.org>; Mon, 23 Feb 2026 02:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771841378; x=1772446178; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y3U0wiZ1PaLP9HKufniCA3p+26o0xtDqndh6mBEwyx0=;
        b=YaZ5atstiuyyX/KZ4RGNr8CAywUBCCig5Wo62ckOMjU3Ar02DldYn69p7x3kgXyS0S
         gWClepkcbbcupsiVSlusldMOEVWNxCTcN6V7W7LvwAmasazxHXvic6YyJJf6ATOSOzur
         bh0SWGvIh7B+pKF+1P3iKhXN0GiCgsOfbpgkLKWi4C8P1XO1X0G0IXlIB71KZk8RiDq0
         IhuGbODNEdkycFjdKIHlKTmNnebWIBRc7Syt9Mw2ntlYUmsi3F4Q7a9ODtnf4M2YiULq
         IHde9fhM018Mc3nNuiz+UgvI7DMmj22TrusJmUPSppNC+uqz62pqIWuW6Gr120WqPufw
         tLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771841378; x=1772446178;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3U0wiZ1PaLP9HKufniCA3p+26o0xtDqndh6mBEwyx0=;
        b=cNljj0xoB/msZb9DJ2oACZkHCVSE2Y7DlfpoSrPnrJJHTteVPX/oOG2ZdWGUSGWND2
         UJQolHqZtYb7TWuNqYV+M5TyvEMceEmlshqsI+dC0ij+eebkohrS9Llo5C3bwEBQuMVn
         UDAUpZ4E45vgSI/tyktqH/KpuQs33TTXHtjhoiJXQNXDQlQPHL4afukw4lkPuB+cjzuW
         kD/+J6Yui1cOiWXkSEXP9bLmzO8jKdnR8jJMyOQ6mluPL5QrkYGO9IjN5ymQzQ7748PT
         zBWOjD5RAATFwkNbbhe9Ms4+EicBEk4Fsd47A7FGty0hxHtPuHG+sYTDTlqqLeFjQPlP
         xjDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqTtxFoMVoq7htJtf9wIT0EQ+3FU7ZnBNI9ymPEo7Eu78P3HOPnw/94PTCfxJUKAJ8KCbC431bT80=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0jzq1vIW/JFgFJgMj2zKj5ei8Z6daLvriybxVPpCtVQ+aD4yy
	RFOQhMc8QNn0q7zl7aT64CKTPjaM6FaoUrG1ct+pi4JTiYUSPrFViC6n
X-Gm-Gg: AZuq6aJi8ASyZmrqoc579GeHcKY8/h5bLYBiXPN6xEts+6A+hT/pozR9V3/PwjnElmS
	pQt4FuFPswEvjKHCYcRgS0c8wuGNMZW5d0MhXydY9NJREjwuO0Uk4o1xuQ4oA8CTGQ94Ah0PaIO
	qvwFXDsgygaOiOxBHSq5bwmdiRSsstNwa7Yr/LOSGh5Mz+XQRaFPN5u8ldUFmYUynR39Kv1i0ZO
	p1N+5jg44R/AMqwvWTdmMU/khXCjwrfblxmpks3COccnC3F7tPllFh5aGnk91/ipEp8mPVTuAZs
	zF/kCdimNUvj6SphPtbB03JlTdQXoHjoUDMMS+IL82DuSrUPecpm59glYAzal9lbST8O/XyTifu
	1IzWDfZe1Bv9SBHUmvuxGHVk+M9ZLr5yH1/yLrj4KT7Rws94OURO/5YoFTjNnxDFBE788QfMEBI
	I7hAGDaoQ9fYpHXpgI5jVXaZfZPaU1BWZwwqLaJFiiyQ==
X-Received: by 2002:a05:600c:34d3:b0:47a:975b:e3e6 with SMTP id 5b1f17b1804b1-483a962e175mr136244295e9.18.1771841377468;
        Mon, 23 Feb 2026 02:09:37 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31bc068sm245815725e9.4.2026.02.23.02.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 02:09:37 -0800 (PST)
Message-ID: <d1a1f8af14fd515409805f1071c051fb51206b1d.camel@gmail.com>
Subject: Re: [PATCH 2/3] iio: dac: ad5706r: Add support for AD5706R DAC
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron	 <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=	
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring	
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <ukleinek@kernel.org>, 	linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
Date: Mon, 23 Feb 2026 10:10:20 +0000
In-Reply-To: <aZiSVSvCOS4MvcGt@smile.fi.intel.com>
References: <20260220-dev_ad5706r-v1-0-7253bbd74889@analog.com>
	 <20260220-dev_ad5706r-v1-2-7253bbd74889@analog.com>
	 <4fd329ed6416fd2f8e2a72adfa5a77f73107948b.camel@gmail.com>
	 <aZg-vtenBU2rKKX_@smile.fi.intel.com>
	 <a6a2fc3ebb45fa4d7b379d552196d56eb13fa8d3.camel@gmail.com>
	 <aZiSVSvCOS4MvcGt@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8153-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nonamenuno@gmail.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7B501174A4E
X-Rspamd-Action: no action

On Fri, 2026-02-20 at 18:56 +0200, Andy Shevchenko wrote:
> On Fri, Feb 20, 2026 at 03:02:37PM +0000, Nuno S=C3=A1 wrote:
> > On Fri, 2026-02-20 at 13:00 +0200, Andy Shevchenko wrote:
> > > On Fri, Feb 20, 2026 at 10:48:59AM +0000, Nuno S=C3=A1 wrote:
> > > > On Fri, 2026-02-20 at 16:02 +0800, Alexis Czezar Torreno wrote:
>=20
> ...
>=20
> > > > > +static void ad5706r_debugs_init(struct iio_dev *indio_dev)
> > > > > +{
> > > > > +	struct dentry *d =3D iio_get_debugfs_dentry(indio_dev);
> > > >=20
> > > > It should have:
> > > >=20
> > > > if (!IS_ENABLED(CONFIG_DEBUGFS))
> > > > 	return
> > >=20
> > > But why? The debugfs is a stub when disabled, nobody should do that
> > > in the cases when the main purpose is not the debugfs code.
> >=20
> > Because the compiler can then optimize away all of the above code...
>=20
> How is it different to the code elimination part that is inside in each o=
f
> the below calls?

Clearly none :). For some reason I thought it would matter. Maybe I was mis=
taken by
some old code that had #ifdef guards on the debug code.

Any ways, I might send some patches cleaning some places where I added the =
above so
people do not copy it around.

- Nuno S=C3=A1
>=20

