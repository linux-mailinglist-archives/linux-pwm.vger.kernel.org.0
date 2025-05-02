Return-Path: <linux-pwm+bounces-5796-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C20EEAA6BAF
	for <lists+linux-pwm@lfdr.de>; Fri,  2 May 2025 09:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 632493B20E9
	for <lists+linux-pwm@lfdr.de>; Fri,  2 May 2025 07:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EBA26560F;
	Fri,  2 May 2025 07:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3Ng1JI0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4ED18E050;
	Fri,  2 May 2025 07:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746171310; cv=none; b=lsMRt02wj1A3+HyyBtcD7sbiyPo0bL0LkdvNPBHKnZJEOhmmz3rAxqmuv6vXtSqwlRpRYI/XXhWaZ3fwhe4ZppUOz2XpLcZitm8Ldedo3tqihGN/VdJRe+/2BSSXurDiG/9NH84SyXQ2ADplo4VgS+be962iSxoFL1tRptrfOlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746171310; c=relaxed/simple;
	bh=1yJjFCEtWLyqf6H3uwtKasAJas/mm3ZRprjp/SEQh+o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WeUBoFuau1T65qLF+u/95jbLG7q0mP3+c7iP708vrhGUbtnqrzPJc6GjegNkKiJd4QQiDEvNlfQWIltDKvApIqTObsKwDOppdAdTVgEzRDE/EjPYYEKbdZ7fzZX5lTSWPrl5kZYnDWhc9NXymjKs4lrCRSZOxBXr4S85h2Km8h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3Ng1JI0; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39ee57c0b8cso1440628f8f.0;
        Fri, 02 May 2025 00:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746171307; x=1746776107; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1yJjFCEtWLyqf6H3uwtKasAJas/mm3ZRprjp/SEQh+o=;
        b=A3Ng1JI0mfroXgC53mv6dX1/MtgXY9OT1hqN3tQ/W8H2L0Ky9Ikl+Uk4sbLd4ktDFo
         SFXALuhd1cMXcuFkXUXGsQtV+3kMxy//rOn84mEn8RTLMWeOgJK5wxlFeQkXo4NZjO0U
         GDVWVQV4NPaaiYT8RAtUqrvSB7+rla7MkzKxnZbjevnGzyooSUjEJccNvqTRgwrnqvCv
         2X65RtzrfjLKKxjEk3W/U/MItwlRdOt7vgio/2O93Kt2nyfk4eWSYMsamnKxxEzb2jX/
         2fEurzTBHsJSNfR+fCL3/0lfwcVX4SouGRy+h/tU/D9JbembM1nIErs41snVMFkne45b
         nyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746171307; x=1746776107;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1yJjFCEtWLyqf6H3uwtKasAJas/mm3ZRprjp/SEQh+o=;
        b=DxXvT6LxXAaE1fQnLb920hjSG+KNtCYNQoFqoqTJDzJnwsPyD10aN6nkLr/SkftCkn
         Gxk5y3htOa/L9aAn3sxOjl/X4ARI2Gc0pV5L5NnXFumQ6t5PTPRsyUbda/meL+1YyK+L
         RvMqgtBb+aSGKc+Oza9Y8hO6YjBZQTV/clF2fl0ELk+472VbGftE2kzKvsbmgR18ux+9
         q6/tWuSAeG/kRaEwWgOVmH7coJy/qvM+r+xoS1tBQxMAWvit2QuBnouu+cv3QgwTcQDp
         watcNgVFws/q3yc0hGFaqsSVPUtBpN+Nd6XEXo6K+PgCsF5ie8/KDf4sGjrNij5XcLEG
         9yuA==
X-Forwarded-Encrypted: i=1; AJvYcCUlrEIAztlZ1De3AlkqlxnWVF+JbeGpveRCxUZZU02qSabnHvrPR2WKulWjQ2b/iZKFHhiyr0JwoiLT@vger.kernel.org, AJvYcCW7W5BUfEJMRIJuTr2XEFjCm02YTfvy/sL7pEUG8Ye++5RDdr4ATGJlfSi73mN2penffU5D1ES6zRfJ@vger.kernel.org, AJvYcCXehcrF2pc7CNppB+nz9GpdIDNZ2/8aelZ9NaqoxleFldHnUMBZJM+dPkXBs8gBPFCRQgaWJaDOoJYl0W4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUCQW287+iSlPA+/h5lQOkp7K2aHOulBBips7L4W4LykS01uvQ
	TCDAMc7zX8OKe0pKguiVWDahE4+wsNVHayeqmndW0LoSiT4Ir9I6
X-Gm-Gg: ASbGncve+Gghsloh66u3fJN61ZadUIlX8IelFe9fPzI0qrAqVFcTNv6h3mCH43SjSIo
	t0YE2DhmAvNfZlhp2ULPZ4ltsRkMZALBFpGYunyyZe9KsltWAONfnhulyvcUVjAaPBoPnSoFtVO
	yS8n3FktHxrWvP/XhvjYoT98TXZpl5qrD3SsO3v66dATYVPWcymZgCUftT03si2M2beDxWRHWFO
	KRgh7dHTd36ya/IxkRQ6JaAgFuXVwxxSEPehUH3H3nvfDnHgaVpSCUieFozcAtvSAtlHejuWsv0
	J4KNpaeO+AGopLUkcSSWAxlHrpOA34jok1Xo+JQ5H1CykjQTgIwUa0KA2bkzpv0485CCzqsRt5g
	ifRhPFPT8vGBF
X-Google-Smtp-Source: AGHT+IE462/3Vr/Fm+Ou7ErV++OCNIsLm/NS7QrOnO3K4+T858gZZkrQ4SQRY9/tyvuJpfd9mg9b6g==
X-Received: by 2002:a5d:598e:0:b0:39e:cc5e:147 with SMTP id ffacd0b85a97d-3a099af1575mr1166522f8f.55.1746171306601;
        Fri, 02 May 2025 00:35:06 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b2449dsm1314268f8f.101.2025.05.02.00.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 00:35:05 -0700 (PDT)
Message-ID: <d78a923a7da54292f98746c71ff84160a5c42963.camel@gmail.com>
Subject: Re: [PATCH v2 00/17] mfd: adp5585: support keymap events and drop
 legacy Input driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Lee Jones <lee@kernel.org>, Laurent Pinchart
	 <laurent.pinchart@ideasonboard.com>
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, Nuno
 =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=	
 <ukleinek@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Liu Ying <victor.liu@nxp.com>,  Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>
Date: Fri, 02 May 2025 08:35:11 +0100
In-Reply-To: <20250502071336.GA3865826@google.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
	 <174610080338.3792828.16902042195346769114.b4-ty@kernel.org>
	 <20250501140958.GB6838@pendragon.ideasonboard.com>
	 <20250502071336.GA3865826@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-05-02 at 08:13 +0100, Lee Jones wrote:
> On Thu, 01 May 2025, Laurent Pinchart wrote:
>=20
> > Hi Lee,
> >=20
> > On Thu, May 01, 2025 at 01:00:03PM +0100, Lee Jones wrote:
> > > On Tue, 15 Apr 2025 15:49:16 +0100, Nuno S=C3=A1 wrote:
> > > > The adp5585 MFD driver was introduced in 6.11 adding support for gp=
io
> > > > and PWM. However, the gpio part of it was already supported as part=
 of
> > > > the keyboard driver:
> > > >=20
> > > > https://elixir.bootlin.com/linux/v6.14-rc6/source/drivers/input/key=
board/adp5589-keys.c#L532
> > > >=20
> > > > On top of that it also overlapped with my refactoring of the above
> > > > driver [1]
> > > > to drop usage of platform data and use FW properties instead.
> > > >=20
> > > > [...]
> > >=20
> > > Applied, thanks!
> > >=20
> > > [01/17] dt-bindings: mfd: adp5585: ease on the required properties
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 commit: 3a2ea3e9f369bdae93=
9bcccff67a77a6281dca74
> > > [02/17] mfd: adp5585: enable oscilator during probe
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 commit: 7353f196fd73b79e30=
ff750d93caf096ed660e1b
> > > [03/17] pwm: adp5585: don't control OSC_EN in the pwm driver
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 commit: 7c7e9f08a1a9bf16b6=
c1942c2e0cb919da855970
> > > [04/17] mfd: adp5585: make use of MFD_CELL_NAME()
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 commit: e72e9148d017535b39=
500d0aad624d0a0fcd2ce7
> > > [05/17] dt-bindings: mfd: adp5585: document adp5589 I/O expander
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 commit: 6da01b9d833c5efbce=
7c2e30dde276e0d29105f8
> > > [06/17] mfd: adp5585: add support for adp5589
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 commit: 382dc0327b8a9ee03c=
901df9b85134c68917becc
> > > [07/17] gpio: adp5585: add support for the ad5589 expander
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 commit: cff3cef09595001140=
bd29aedf33fc84998bf77c
> > > [08/17] pwm: adp5585: add support for adp5589
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 commit: 333b66fd3edfe18db4=
dc16041328a89144b73067
> > > [09/17] dt-bindings: mfd: adp5585: add properties for input events
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 commit: 7bdb41d7a85e1c6244=
da57d4dcc491df962ff3fb
> > > [10/17] mfd: adp5585: add support for key events
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 commit: 8814ac45c75fcce558=
96bc376a97b56f392925c3
> > > [11/17] gpio: adp5585: support gpi events
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 commit: 8f3d9b44c5c5ada312=
d0ef71ec0181011854a95b
> > > [12/17] Input: adp5585: Add Analog Devices ADP5585/89 support
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 commit: a53fc67a1e21a85078=
21263946b1d65687b0284f
> > > [13/17] Input: adp5589: remove the driver
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 commit: 216c99cf1002a42f89=
6b54fab09823e8ba46b218
> > > [14/17] mfd: adp5585: support getting vdd regulator
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 commit: 63a8717f744d51ea0c=
8228e09db4233d48f2f9ba
> > > [15/17] dt-bindings: mfd: adp5585: document reset gpio
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 commit: 49c887f0547bc14eb5=
0ba20e1c8acb7255af3b86
> > > [16/17] mfd: adp5585: add support for a reset pin
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 commit: 01c328823459456fb9=
9469cc37f270f70d41fd2a
> > > [17/17] pwm: adp5585: make sure to include mod_devicetable.h
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (no commit info)
> >=20
> > I'm a bit surprised, didn't you ask for changes, calling for a v3 ?
>=20
> Yes, sorry.=C2=A0 My fault.=C2=A0 Tooling error.=C2=A0 Please disregard.

I was wondering the same...

- Nuno S=C3=A1

