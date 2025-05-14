Return-Path: <linux-pwm+bounces-5985-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55958AB6979
	for <lists+linux-pwm@lfdr.de>; Wed, 14 May 2025 13:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D671617A911
	for <lists+linux-pwm@lfdr.de>; Wed, 14 May 2025 11:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3580720F091;
	Wed, 14 May 2025 11:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNBJwSsI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FFA46426;
	Wed, 14 May 2025 11:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747220653; cv=none; b=LO89QRl34Mz0XIabdIyUUgD8/sKqyHE24rkb2nSZhIyIU1A14qHAB6cF8S58QDEZX4G/OSb7p9pxSOlBR0crdcO2oQWvuBOrQ0u7gEFExozFk0rOHyEDCwmdcGDeRBrKVLLXXzZpFlA41raInZEhZOdHAQiSv765KqG0zFrNGQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747220653; c=relaxed/simple;
	bh=XGSyPkFZDwgvVlbyfakAmIyF6hAXQLf1XFUvkk9s1Mw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aO8xwTQKlSEf4V275EszRy9FZ+k3pcPkCSyCt9JUU7Tujsw49qIvm7pvjYRTOqu2crPVOAx1UXqEXzOMC6If1S3irDzXWyO9bckUu4nW1J4u58xGbpLLVnA9NKsVW8VPB/xtWa9iQwJJ0YuInfRpOpGen1lxx26V+CDthrg5wwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNBJwSsI; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ad4d5bb4d0eso369834366b.1;
        Wed, 14 May 2025 04:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747220650; x=1747825450; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JUvXpoA//rp9n3qbk93hyiULThV2g2dVteuXQqb+BSs=;
        b=FNBJwSsIXp9AiyMNKpP7adXRtFfxWb6+qetd6h5Qb3sbjfKoZfaz/wkwlowsIWWCU3
         1POvpNsXHQOZUkXsNHHSqQ0m9LEExKt99t3sWqFBnM97VT7FbFZdiP5PLMxKAu0FlDZt
         Ts5oPxE3iGCVKh1G4eUUIVoDPlhjl6zjeE9CmmI/WFQ66fJHluR60kAjK2ibLXJsS4PZ
         gY5e+XPlYxJbGhcj3dnb/5pky5qlMPsZMS0WRz5S9uPOyZJXxdH8ZxUte+p4cfLexwjt
         wfCuRGsy1qYLll1NYukgniv2To9pF/ZpEwSNRoQ07bvkyeoiSbAq4rqcpeAmpzu/En3H
         xikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747220650; x=1747825450;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JUvXpoA//rp9n3qbk93hyiULThV2g2dVteuXQqb+BSs=;
        b=Wu5xfcAHjFD2eta5DtkPMmlV4qYsZrYHHLfAE8c2HT8fD0uBZCtCM9duuVp3qAGMy4
         oa3rkawfEcd+UbOrN5GVuYSoibd+1ZvSqZM1O0sLtvmlnWkaY3vVDDCFSpMhwZs2Ik+x
         tMh/6ZsWjXATps2PZ/Eveb4In4nRKagbtb1kZ8e6np22VFpUiW0h9rWKBb85ErxWGR3M
         eJvKM2+GqjE8DkvsCFUbOnXLLb017kd0uFgzb1Dbwn4vX68OUeF/XnW8XLQDVtMVu3oe
         XUtmXVTM298AyfwswoMZHHAS2iwQc/0ha79iyv2rK3nBjuQLdAvRo99LJQYhP5g8sMBc
         Abbg==
X-Forwarded-Encrypted: i=1; AJvYcCWMRxva1mGU19RsmRzZPsbQjsG3+ixd+MhsLJqqRG4XMIqdBK9Q02n32PUBSCB2yJtiQeBLC+j5JID8SWU=@vger.kernel.org, AJvYcCXhe2rqWkU2TAQ6DSj33KPeylRkQAwxOmWDprLT37MNTnquVto/ZL238JSMh9uLwpBsGOd74GexNi64@vger.kernel.org, AJvYcCXv/1VcuwNSeg9czSJ9tIdWBzjNkFOgOY3UfPk9s6PiuYKT1dYdGiXJs7vpdNU8f8XtXJqkou8DQbBZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzW1Iba7sfras/Sr02zwmgAnJdDBdRxfJ2Fs3v75lmjIXwNh2FP
	e32M1csQhhnjyB0xCTBSwMNfyHBlz0E1bc3D4PkJ7C0UbTj7g6+l
X-Gm-Gg: ASbGnctjX/85GbQjqbRR+0VtEy4AAE0rzfxvxBI0Xc7dHlHxN433mrL6kqWmcM9sa2j
	60J2O0gulCEbTGxoxvVhEcd2tenFcGPC/EvIaOQexlIvXPxGW3kJbGYeGxdZr47bgmsnTwbsq+2
	sZZ6SfpYhxLEebkaO8ChS3yv193LANRrxyHZ94iU85pkaZ6XG72KTTfuHxmbhl5V3Jko9CBXX8v
	q0qfwuxxFVvYYYLvb+mAAtNY6BRRjLJPFhVxXa+Tvz9gBIwc8RwIn7RJXrU9G6dSt2CB9N0V9Tq
	Qe2WA5+9Y3uBTj01UDzagqHhLDxNxxKwpjNw0WGQKY9aeT1YUHRb
X-Google-Smtp-Source: AGHT+IHkxzObWk58tLRXqleOkxcZaxaoLrZbXZ0NeCxry3VMUfTD7ioWwRp+V51ETLyBfEKA/3FD+A==
X-Received: by 2002:a17:907:9620:b0:ad2:1a63:3ba4 with SMTP id a640c23a62f3a-ad4f751b668mr273172466b.37.1747220649294;
        Wed, 14 May 2025 04:04:09 -0700 (PDT)
Received: from [10.5.0.2] ([91.205.230.203])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad219346b7asm929002166b.55.2025.05.14.04.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 04:04:08 -0700 (PDT)
Message-ID: <04b8a6d68fdc0c0eadf69fbbc6a130ecc6c49360.camel@gmail.com>
Subject: Re: [PATCH v3 00/22] mfd: adp5585: support keymap events and drop
 legacy Input driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Lee Jones <lee@kernel.org>, nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, Rob Herring	
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <ukleinek@kernel.org>,  Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, Dmitry Torokhov	 <dmitry.torokhov@gmail.com>,
 Laurent Pinchart	 <laurent.pinchart@ideasonboard.com>, Liu Ying
 <victor.liu@nxp.com>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 14 May 2025 12:04:09 +0100
In-Reply-To: <20250514082554.GY2936510@google.com>
References: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
	 <20250514082554.GY2936510@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-05-14 at 09:25 +0100, Lee Jones wrote:
> On Mon, 12 May 2025, Nuno S=C3=A1 via B4 Relay wrote:
>=20
> > Hi all,
> >=20
> > Here it goes v3. There was some major refactoring in this version due t=
o
> > Lee's and Laurent's feedback. There are some splits (and some explicit
> > requests) resulting in new patches being added. The biggest change is t=
he
> > effort in trying to minimize the usage of specific child device bits in
> > the top level device (mainly stuff related to the keymap). I think now
> > it's fairly self contained and the only thing that we really need to
> > handle in the top device are the unlock and reset events as those can b=
e
> > supported through both the input and gpio devices (via gpio_keys). This
> > results in a bit of more runtime complexity but well, that's life...
> >=20
> > Another change is Lee's suggestion of making use of templates (for
> > regmap and chip specific data) and fill things up at probe.
> >=20
> > I also refactored a bit the event handling so it's more generic now.
> > There were lot's of changes so odds are that I might have forgotten som=
e
> > feedback and so, my apologies in advance :).
> >=20
> > I also dropped the tags in:
> >=20
> > patch 16/22 ("gpio: adp5585: support gpi events") as it has some
> > significant changes (replacing .init_valid_masks() with .request() and
> > .free())
>=20
> Please run this set through checkpatch.pl before submitting again.
>=20

I've done that... It gave some issues but not sure there's anything to be d=
one:

=E2=97=8F 26ffbc19b2ce: mfd: adp5585: refactor how regmap defaults are hand=
led
  =E2=97=8F checkpatch.pl: drivers/mfd/adp5585.c:94: WARNING: struct regmap=
_config
should normally be const
  =E2=97=8F checkpatch.pl: drivers/mfd/adp5585.c:149: WARNING: struct regma=
p_config
should normally be const

The above is something we need given that we want to fill reg defaults duri=
ng
probe. Maybe we can go around that but not sure if it's worth it.

=E2=97=8F 6183fc9ef938: gpio: adp5585: add support for the adp5589 expander
  =E2=97=8F checkpatch.pl: drivers/gpio/gpio-adp5585.c:26: CHECK: Macro arg=
ument reuse
'n' - possible side-effects?

Again, not sure it's worth it to "fix" it and it was just copy pasted from =
the
header.

=E2=97=8F 3e0f3ba80ea5: Input: adp5589: remove the driver
  =E2=97=8F checkpatch.pl: drivers/input/keyboard/adp5589-keys.c:14: WARNIN=
G: added,
moved or deleted file(s), does MAINTAINERS need updating?

the above is lack of an entry in the original file...



> Not sure if we've discussed this, but W=3D1 wouldn't hurt either.

I used the kernel test bot... I assume W=3D1 is part of the builds.

- Nuno S=C3=A1

