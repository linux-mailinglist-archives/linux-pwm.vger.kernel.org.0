Return-Path: <linux-pwm+bounces-7452-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BEABDA7FA
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Oct 2025 17:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1BCD94F551B
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Oct 2025 15:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C242FF166;
	Tue, 14 Oct 2025 15:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4KQI2kf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6A6221FCB
	for <linux-pwm@vger.kernel.org>; Tue, 14 Oct 2025 15:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760456747; cv=none; b=LQO2/j5itAnpGNKGnHDqvXiAa6W/TvI96+q4v1kxXXsbeJFKDpXSEUckxS3ZFrp7X51c2iVZncNsphuuLXHSakTyqeittZT2iUJAq1oL5RLkM6PiaUHi9NL3SLr06jrr2X9haj95IrIr5mhAhWiOgeUCo9WFJ0TbMdxgrLOsGWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760456747; c=relaxed/simple;
	bh=OPz3JuKsyfEcF7SC28N8BYvQpMOG9+ol+aHvjOGIupM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hPsBd+p/SFvlfzJ4/nj/JoQlna615BqYqMzmuK5pm/Mpzpa6/UL/ghplNen8R6NYj/vqhROxqt1p1DtbCzQH36L5c5Llzn6CPSvxuCObjyNcoQM5OmcfsGCEZJQkYUCeJbtqdNOYlEtmHhxRUbVFsk5QibzBgAtjQCPj6uC/T2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4KQI2kf; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso1142f8f.1
        for <linux-pwm@vger.kernel.org>; Tue, 14 Oct 2025 08:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760456744; x=1761061544; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EuF1h8YvamKDXiEUG/ydx08kAUyXwsN7QyehT348oZQ=;
        b=e4KQI2kfRTFKK2gbKkqkfd2oV/6shil0yLFLNenJOMxMOupKifG9x8qDOYSVEDgs16
         COdLDfVzvXugntASKg1lambfzpmb9GL7KtdHpa7bIinzBFuO1Xb1NwV5gfyYHXS0C+0G
         Bd+h3mqQJRv69JwJcalxQNgRtYlxo06QeiySLvShb2nQ6uSfjGd++oZCiAqWv2c6YH9j
         J6FUP5mfxa1i86WKwUtnQ5wZu/80P1/Ydo+petAAT0WGagwAi/crhGkfYekuZeQdXAK4
         BDzUJkX4kwOkue4iEwuTNvKcKsayp+P4169VprDBVNya2PyMzz6jo5uvG45nVu2ftw7i
         NeNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760456744; x=1761061544;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EuF1h8YvamKDXiEUG/ydx08kAUyXwsN7QyehT348oZQ=;
        b=LoxxWu/ykVDebBSuuJAqQPGlQFsGKvzTGW4kq9NICWPAa5Kyaa6xbaRroDqM8/kNgy
         xH1mW6B8RJnWV/97hafvWD2aCDLQkcp7oxXkPWcKQ56hGpJMGUNGnHdPjDzL28AWd71v
         qSwnlVYHa01GfRrVbsM5nvm63J3eJvWTh9VT0DpPuD/Jn9F1cNrVfIjRIcxQstZLTXJZ
         75dreeAxqP/qvjXn1o7XD1qT5E9zYtGUuy86DLpxJgvjx9na9pJig6eT7Ixvvjyztklb
         0e12su0T8qTZeseZ8gxwhdQ5jbTPqis+CDIN43LdtCo28lpHRa40XZ8dsqB9Ap7V4C+L
         198A==
X-Forwarded-Encrypted: i=1; AJvYcCX1NMODIjBRmtB5V8sxxgLcYvJ+zgYOonB/Dp844ketcTiV7+Q6KrGrjmIYIlgxMYwPo852mPiKyzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9jW8SrWahWdoQkvWIlEVA5d+xw9AgXocA+XuQHfEz6Qhn7n9b
	WHsrm5+pqvf0Mjcqdroxhr9Pj6lyzOh0J2ehoFhAI03eoP8H5/wnBLlH
X-Gm-Gg: ASbGnctvqgs60G5mFQgpsQxH3pGkXQUebcF0/k9qxR6kEyRpH26fiNMVK08Gq/4G04q
	a8DKj4OoXauvSkaBEdRUThm8H+FM17ymrgLsoYyFMpxZ8MBnY1CJDTz5MSqeEHTOPKrpH23IBeV
	xd8F19yHUqfsBdJ/PIbjj+w/dT+mSaJ7Hj0FB+oPriNAnu2aFT8LXnl6T04mLnt9u4GDJSa6Krf
	A2l+Xx3HbmSssuWeaus+wn1mz7k0XaypphGsIcH4c7ieBMKcL0akdnkvFipXqLk7MBFjbkNe1yy
	IfewedzDF7tVa0QyIZ1Fz6/LHLCsSg4VZfWuglyMueXDDqFNCzMcvW4NeSGpIHJrl5Rv7UtLssR
	0P3iON6UkvFZQMiHSFQWqktGl35h72Nagdp7fu6TnjBMxnUMJ7puICe8LZnY2
X-Google-Smtp-Source: AGHT+IGge3yzZz+zKCw2B+VbIVIqsMB8NMcC/S2UhLzXj3IfB0k9KNiL94NqaGNP36Y5hV6zVPOKPA==
X-Received: by 2002:a05:6000:4028:b0:414:c2e8:a739 with SMTP id ffacd0b85a97d-4266e7d64a6mr18739753f8f.31.1760456744191;
        Tue, 14 Oct 2025 08:45:44 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57d3desm24341014f8f.7.2025.10.14.08.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 08:45:43 -0700 (PDT)
Message-ID: <51dab5dee00b95018c8bc6b7ef56b9b722d618f3.camel@gmail.com>
Subject: Re: [PATCH] pwm: Declare waveform stubs for when PWM is not
 reachable
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>, Marcelo
 Schmitt <marcelo.schmitt@analog.com>, linux-pwm@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	jic23@kernel.org, kernel test robot
 <lkp@intel.com>, Trevor Gamblin	 <tgamblin@baylibre.com>, Axel Haslam
 <ahaslam@baylibre.com>, 	dlechner@baylibre.com
Date: Tue, 14 Oct 2025 16:46:16 +0100
In-Reply-To: <aOluoP01oaDzaseV@debian-BULLSEYE-live-builder-AMD64>
References: 
	<1ac0fc529e02744aacfcb9140ed597ff60886f39.1759873890.git.marcelo.schmitt@analog.com>
	 <6v4hny7hxjsdf6zvinhpagtbhluxbd6psq7wpx5ls6zdbnjtym@lnygnkav4ewk>
	 <2e82eaf275b5c8df768c8b842167c3562991e50c.camel@gmail.com>
	 <aOlYDyLzVGbCh5mE@debian-BULLSEYE-live-builder-AMD64>
	 <04eb5b1ccc0268ff7e9b88835203771886c5ee25.camel@gmail.com>
	 <aOluoP01oaDzaseV@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-10 at 17:37 -0300, Marcelo Schmitt wrote:
> ...
> > > >=20
> > > > I did not tested but I also wonder if 'imply SPI_OFFLOAD_TRIGGER_PW=
M' is
> > > > not
> > > > similar to the above.
> > >=20
> > > It works, and I'll update the IIO patch to have
> > > 	select SPI_OFFLOAD
> > > 	imply PWM
> > > 	imply SPI_OFFLOAD_TRIGGER_PWM
> > > in Kconfig. The PWM imply is because I think SPI offload support meet=
s the
> > > "highly desirable feature" criterion mentioned by kbuild doc [1].
> >=20
> > With imply we then need to take care either using stubs (which seems no=
t to
> > be an
> > option) or with preprocessor conditions in your driver. As discussed in=
 the
> > other
> > thread I would just select SPI_OFFLOAD. Basically I would:
> >=20
> > 	select SPI_OFFLOAD
> > 	select SPI_OFFLOAD_TRIGGER_PWM
> > 	depends on PWM
>=20
> Yeah, depending on PWM is what I was trying to avoid because the ADC can =
be
> used
> without PWM. Doing the above is the easiest solution - depend on everythi=
ng,
> select everything. Though, I guess I'm technically not keeping backwards
> compatibility if I add a new dependency to the driver.
>=20
> IIO_BUFFER_DMA and IIO_BUFFER_DMAENGINE are part of IIO subsystem so okay=
 to
> select them? Otherwise, yeah, they should be optional too (would either i=
mply
> them or select if SPI_OFFLOAD).
>=20
> I'm currently leaning towards
> =C2=A0	imply PWM
> =C2=A0	imply SPI_OFFLOAD_TRIGGER_PWM //(SPI_OFFLOAD_TRIGGER_PWM depends o=
n
> SPI_OFFLOAD)
> but not really sure.
>=20
> It's sort of a feature bundle we want to enable to provide SPI offloading=
.
>=20
> if SPI_OFFLOAD && PWM
> 	select SPI_OFFLOAD_TRIGGER_PWM
> 	select IIO_BUFFER_DMA
> 	select IIO_BUFFER_DMAENGINE
>=20
> we can have
> 	imply IIO_BUFFER_DMA
> 	imply IIO_BUFFER_DMAENGINE
> =C2=A0	imply PWM
> =C2=A0	imply SPI_OFFLOAD_TRIGGER_PWM
>=20
> but we could then have IIO_BUFFER_DMA=3Dy and PWM=3Dn and still be unable=
 to SPI
> offload?
>=20
> Maybe
> 	imply IIO_BUFFER_DMA if (SPI_OFFLOAD && PWM)
> 	imply IIO_BUFFER_DMAENGINE if (SPI_OFFLOAD && PWM)
> =C2=A0	imply PWM
> =C2=A0	imply SPI_OFFLOAD_TRIGGER_PWM if (SPI_OFFLOAD && PWM)
> ?
>=20

With imply I don't think you need those if (...). However, the key point is=
 that
with it, I believe you'll need the stubs (so you need some convincing) beca=
use
those configs can be disabled which means your driver should not compile. W=
hile
I feel sympathetic with that "depend on optional code", the above does not =
look
pretty :). For the IIO_BUFFER* stuff I would likely not care about it and f=
or
PWM and SPI_OFFLOAD either depend on we need the stubs.

But if you really feel strong about this, one possible solution would be to=
 try
and factor out all of the spi_offload related code into an extra source fil=
e
like ad4030-offload.c (that would have it's own kconfig knob) and that woul=
d
need to depend on PWM and then you would also be "free" to have the ad4030-=
*
stubs in your header file so that it does not fail to compile in case PWM=
=3Dn.

- Nuno S=C3=A1

> Forgot to add David to CC list on previous reply so doing it now.
>=20
> >=20
> > - Nuno S=C3=A1
> > =09
> > >=20
> > > [1]:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/Documentation/kbuild/kconfig-language.rst?h=3Dv6.17#n197
> > >=20
> > > One alternative to this patch is to have `#if IS_REACHABLE(CONFIG_PWM=
)` in
> > > the
> > > ADC driver as David suggested in the other thread. I'll probably do t=
hat
> > > and
> > > drop the changes to PWM.
> > >=20
> > > I first thought of using `#ifdef CONFIG_PWM`, but couldn't convince m=
yself
> > > about
> > > that from the relatively small number of ifdef use-cases in IIO.
> > >=20
> > > Thanks,
> > > Marcelo
> > >=20
> > > >=20
> > > > - Nuno S=C3=A1
> > > >=20
> > > > > Best regards
> > > > > Uwe

