Return-Path: <linux-pwm+bounces-7442-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FACBCE6CB
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Oct 2025 21:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9F559355ACA
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Oct 2025 19:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8842FD1C2;
	Fri, 10 Oct 2025 19:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuGvX3hB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC8C207A20
	for <linux-pwm@vger.kernel.org>; Fri, 10 Oct 2025 19:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760125817; cv=none; b=ioakJF2Uhrbz3PDH6z1dmDzycWCb2xSQCF3EbjF+llr+6ZQb+dCVmDU7JNmBgmPPtZ+R7uCbf6CqUn+HHdwnqIF0agKaOIzoqd6TPjzaZ2UDQU+ZDoG0XCq7a6jAsgGMLeBDzehNaR/BZlvOETtlySCKbWZXiOp7Y3uNdIKkidY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760125817; c=relaxed/simple;
	bh=dDRddy0hTLMC1Q2l5YTbUr56IthAb5s29SZb7ZL5aM0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O6MQfSm3NqK0fkwa2xCThmELocrynI3Qf1qcZU/EsjVVNqBaxT6kqIBeGz6XKhxsJFDoSrIYmNhdLgt6e4xKS4ou3FSD7IPepaTe2/IZnX2ujWSdTjIz7YEXeVoZbnC+7tw/VHz4pjyRHsEtkInM/nwvbXVxkzkEl1hteHEitXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GuGvX3hB; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e37d6c21eso14170795e9.0
        for <linux-pwm@vger.kernel.org>; Fri, 10 Oct 2025 12:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760125814; x=1760730614; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uD99ohMxZEnhdEHdGOxQcLw8qff06m3mKbdtK3D4uSo=;
        b=GuGvX3hBgVoyzdhPr2XT97bsIEema04S0xegECtujmTfdOyR6Hv2ySTEJn06bOHYio
         u+Z8gpMGCS7pQvLpR9kn5bBCfH5hqhsUsrs1OfCBMnmvu9Y/7iyE3RzCwVyuESQOgr9K
         hkrXXvs+M0PAPqgcCrDuy6MP1c89jZ1ZSMboNS2W579bwo5Y5nDs7GqFZVRAYyqnZMCU
         AMYOtWxAGyJ0JyVDwWRGLc34mUmxm1D86IjQ2dfl895U0Z8qJuaBJkNrzM66Ok8Xz8y2
         zhdNBp7ejtZcZHD+gTluo7qZR4Cmjer6YjrTyp8nWQOW/N4Jat/XBwFdF+FsUp2p2tDD
         0M0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760125814; x=1760730614;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uD99ohMxZEnhdEHdGOxQcLw8qff06m3mKbdtK3D4uSo=;
        b=CO6hecS/+aZgtsrr7mEct9vPFXCyzRFW6rNuLatCuaw+4jtR1Ju4xKPnVMTmu3QES/
         nG01FlF0Y7JzUCjetCqEadOQNMcC6GWH5vJvpURPZH7s36k/mQx++OGJ7Wh+yJsaZsvk
         R3fiAqr/H9kzGgdNFZb8ndyEiD6rwSH+TUz6zXgDX0n/QudPpyRd0+ZVb8PEdnyG36YD
         ysZIcYh8ZvOODp33vV4QA8x4fZOix5YnmQUMkEQL4FHv3O9R5AHT4EVN3t1cPcv5X4ub
         wrv7jWmXMfr7GgU6yPwfuHrOq7ukugYDhJEOjGhMGU3gKMiGD9CBt7N1qmCBgBBzqo7e
         UKHA==
X-Forwarded-Encrypted: i=1; AJvYcCU/CqhW/YLcjyTeG0LbPHCTlAjCYWU4d+isDl+PH6QSrggeWeos/0RI4CtEMH43ZEy4jF2/VUAOV/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQVk2Ibd3a3Qgr7Lvolf8gZKhEnBwTM1jAxnajRrY1nSAkk1Ti
	3vR6+t5SQLrn2kgCwb7tTVsxT1VjPj0se98vKXzROqFO+gP7k9dOATec
X-Gm-Gg: ASbGncsw8HuPXegWguWsp7KEU9wSnvpskt/ZTlgnxWvB5b3HGEJcxfBUVj8ed43DCMO
	j1dzfDWVpFM+gA3NdPnnbu/i08EvyAMN8CRO50uPJ9Cn3irfadwmjsyCPc9FqifXs6WmTcGIaES
	lWtHMUNKO5t1hORK8jn+PCZsbi2mQFZyYSOZxzdeuwI22afUW46dtqw/0k0SG7MF6Xw6sY6QASn
	13Y4naCxp2et2pxoSm3+ylfxkBKkvKcwRrLDM2cj6ru0BgOXpheAwQfgBjwu7iwzwczb0Ne4fDr
	gB47oNXxzI6xl/zNTvmiBCy9H2eBxVWkckcI/4u75AP41d10m0+2bBigD6Of7pf0cDbedTrTYBY
	N71sgUqQ2JD54AkvzqI1GAO9G3HjdtJAZnMOkA1VDoFEjJzt+sMk8dNnHnMV3g8iQDZ8wlUAf30
	8OYxdcVfJ3M9caqpsdh2jINRnK
X-Google-Smtp-Source: AGHT+IF0OZCVxzB0OYjh+2qV/roiwzWcqHXK7nUan4FNVuMCPACvaleacFPbxehK0aOb0eyJdTbIEg==
X-Received: by 2002:a05:6000:2681:b0:425:7153:80af with SMTP id ffacd0b85a97d-4266e8dab65mr7995317f8f.49.1760125813796;
        Fri, 10 Oct 2025 12:50:13 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:94c4:fb0e:28f:2a8d? ([2001:818:ea56:d000:94c4:fb0e:28f:2a8d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5d015esm5665065f8f.33.2025.10.10.12.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 12:50:13 -0700 (PDT)
Message-ID: <04eb5b1ccc0268ff7e9b88835203771886c5ee25.camel@gmail.com>
Subject: Re: [PATCH] pwm: Declare waveform stubs for when PWM is not
 reachable
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>, Marcelo
 Schmitt <marcelo.schmitt@analog.com>, linux-pwm@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	jic23@kernel.org, kernel test robot
 <lkp@intel.com>, Trevor Gamblin	 <tgamblin@baylibre.com>, Axel Haslam
 <ahaslam@baylibre.com>
Date: Fri, 10 Oct 2025 19:51:09 +0100
In-Reply-To: <aOlYDyLzVGbCh5mE@debian-BULLSEYE-live-builder-AMD64>
References: 
	<1ac0fc529e02744aacfcb9140ed597ff60886f39.1759873890.git.marcelo.schmitt@analog.com>
	 <6v4hny7hxjsdf6zvinhpagtbhluxbd6psq7wpx5ls6zdbnjtym@lnygnkav4ewk>
	 <2e82eaf275b5c8df768c8b842167c3562991e50c.camel@gmail.com>
	 <aOlYDyLzVGbCh5mE@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-10 at 16:01 -0300, Marcelo Schmitt wrote:
> On 10/10, Nuno S=C3=A1 wrote:
> > On Thu, 2025-10-09 at 18:53 +0200, Uwe Kleine-K=C3=B6nig wrote:
> ...
> > > >=20
> > > > Fixes: 6c5126c6406d ("pwm: Provide new consumer API functions for
> > > > waveforms")
> > >=20
> > > At the time 6c5126c6406d was applied, there was no user of the API th=
at
> > > doesn't depend on CONFIG_PWM, so I object adding this Fixes line.
>=20
> Fair. Looks like the stubs are not the preferred solution so probably goi=
ng to
> drop this patch.=20
>=20
> > >=20
> ...
> > >=20
> > > 	WARNING: unmet direct dependencies detected for
> > > SPI_OFFLOAD_TRIGGER_PWM
> > > 	=C2=A0 Depends on [n]: SPI [=3Dy] && SPI_OFFLOAD [=3Dy] && PWM [=3Dn=
]
> > > 	=C2=A0 Selected by [y]:
> > > 	=C2=A0 - AD4030 [=3Dy] && IIO [=3Dy] && SPI [=3Dy] && GPIOLIB [=3Dy]
> > >=20
> > > This is the thing that needs fixing, i.e. don't select a symbol with
> > > dependencies that the selecting symbol doesn't assert to be fulfilled=
.
> > >=20
> >=20
> > Agreed. Seems to be one of those cases where we select a symbol that de=
pends on
> > something.
> >=20
> > However, this driver can indeed work without spi offload and hence PWM =
and
> > SPI_OFFLOAD (AFAIR) are optional so I wonder what's the right approach.=
 Looking
> > at the new series I already see:
> >=20
> > select SPI_OFFLOAD_TRIGGER_PWM if (SPI_OFFLOAD && PWM)
> >=20
> > Which makes more sense but I guess we still need the stubs with the abo=
ve. But=20
> > I would also expect stubs to be needed for spi/offload/consumer.h. Mayb=
e I'm
> > missing something though...
>=20
> I have successfully tested it with imply SPI_OFFLOAD_TRIGGER_PWM in Kconf=
ig and
> MODULE_IMPORT_NS("SPI_OFFLOAD") in the ADC driver.
> Both the PWM offload trigger and ADC driver were built as modules.
> I'm not sure the import ns is needed, but ended up breaking the remote te=
st
> setup so will only be able to tell it next week.
>=20
> >=20
> > I did not tested but I also wonder if 'imply SPI_OFFLOAD_TRIGGER_PWM' i=
s not
> > similar to the above.
>=20
> It works, and I'll update the IIO patch to have
> 	select SPI_OFFLOAD
> 	imply PWM
> 	imply SPI_OFFLOAD_TRIGGER_PWM
> in Kconfig. The PWM imply is because I think SPI offload support meets th=
e=20
> "highly desirable feature" criterion mentioned by kbuild doc [1].

With imply we then need to take care either using stubs (which seems not to=
 be an
option) or with preprocessor conditions in your driver. As discussed in the=
 other
thread I would just select SPI_OFFLOAD. Basically I would:

	select SPI_OFFLOAD
	select SPI_OFFLOAD_TRIGGER_PWM
	depends on PWM

- Nuno S=C3=A1
=09
>=20
> [1]:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/kbuild/kconfig-language.rst?h=3Dv6.17#n197
>=20
> One alternative to this patch is to have `#if IS_REACHABLE(CONFIG_PWM)` i=
n the
> ADC driver as David suggested in the other thread. I'll probably do that =
and
> drop the changes to PWM.
>=20
> I first thought of using `#ifdef CONFIG_PWM`, but couldn't convince mysel=
f about
> that from the relatively small number of ifdef use-cases in IIO.
>=20
> Thanks,
> Marcelo
>=20
> >=20
> > - Nuno S=C3=A1
> >=20
> > > Best regards
> > > Uwe

