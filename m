Return-Path: <linux-pwm+bounces-3294-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E8597C97F
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Sep 2024 14:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89BAE1C21CA3
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Sep 2024 12:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640ED19DFB3;
	Thu, 19 Sep 2024 12:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTvUIWUA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AA819D88C;
	Thu, 19 Sep 2024 12:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726750239; cv=none; b=NDIA2Hf4+RWNFhyf6H5yPQ74rwSod9CRu/T3nCjpBdhRy3KXvi28nr6J19GDdYkNIja4Jy5TG1Cxec7ohtXDv/acweCxdOjLXArdWQfsBNr50TiiaB37Rip+JbVZ/W6LgeblqAax7ExxZbuQJTpJ7GsDQCMYjVy7vb1ZCQLvqCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726750239; c=relaxed/simple;
	bh=P2CnPHZ3uuaFOCRYko5ENjgy3AttJLJU7pg7w5qMQhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V4X1uoTcRSF+XXl8QgGvVfWlt4HyWTsQmVokli6uBBXruMhtZrstUE/akmnwnDqI6H5v2tTV9NxZlpXN41DNa8NPj530LuyjkwEEF+fxZSeakTFCUSWzzkKkxu74/v2FA54J9gpIH/4w2gI02kNzp2Eh1/WTfWGzzdZEdLW1zrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTvUIWUA; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-49bd76fa981so296206137.3;
        Thu, 19 Sep 2024 05:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726750236; x=1727355036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lynh9AqoNJtlb54yCwbo34NdMY498MNudPm3PDmLEVM=;
        b=hTvUIWUA7iyITPEypNFVLojrZBi8omlrpCTRUiSOT052NuBYyTlKnaePx1d9j78TTl
         XRdBVbfNvHG3U/uM/IGdGTAUqSAIRyPWjgm2g60xKVXwmhOjlENckdFN9wYVSehb+ltA
         ZJtNottFFiyODkPQdklcZ23FnS/Fdyw9uS8YY6ptI1XfABocPVOnPIUG5+ycM34duarn
         HCsdMr0EAsj14jxgstzxVWMKSWpRlLD4Ke4F/4RwLXEKo9Mg1Fvh2qGGxh5dmaDi1oRd
         QizA6ODRWgw0TVHfO177j6HThethwAoB3LyuxYfzRU2XPkMPlYy6NLfBAFFDMaaJ6ieR
         1iTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726750236; x=1727355036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lynh9AqoNJtlb54yCwbo34NdMY498MNudPm3PDmLEVM=;
        b=ZyRuvlouTR+Oeb3kZgpoMQHw3VdVLo1g2yLnnJoVza+BVID3PQ9gjRoyqjYrLWrt3i
         Nq6F8aiBXuwMNvRjLc1u4quIfZGlit+Xd+HDrJFANgCXyLr5Ij9SUPcr3zqkxK1MiZOP
         zDYAgfB4Uwz/sI2rj17vD/uzMq7Xf8UApmQLxXCAOMYTdat91Be20x+1MusQSp/YAG62
         3GkZswPLiREbEGX+ZBkfG09mRVDathXWA4qiZ7sg7RSf/3jM6Kh1C9DuXsK3h7ieAZIh
         mKmtcu1nkNXHbOAUpbiEEKWzY5Ukg8F6yKMHsL9mNWg7NbVzM/vPasFy1QPcL6Q+n6o5
         O1qg==
X-Forwarded-Encrypted: i=1; AJvYcCUSHiylbsSN41D8k4GRSh8iiSjYbxpfWTjaEH5pnk+qjtzjV6uRPNg9YVxsAKsIJ0pjNW/nQx7u71zH@vger.kernel.org, AJvYcCUpvIrvzHiyroGhnRKyriApawf/s+WUh2bxPlDAbLo3hX4I++oj7kTcLw4A/+86hV5sz5irtCWPn5MC@vger.kernel.org, AJvYcCV4gadrXPyOWoDWiYqmwox/jvfrk/MyjCx+Y73tqM9hnnqd1D20Qdi8T4CQzCtf5qbeldy9voi6Tnc=@vger.kernel.org, AJvYcCVOuhd4vZ5JoE+kF/NbLiNwXbZoetc0sdgLa+G2d0N5zUcoxcA6DJYrmY5jeu/LZZUzFY/Wtu0+REfa5w==@vger.kernel.org, AJvYcCVt6m8Ivjh/Ib8bojdbHucfdLqFK5T/gktl+VcMWE2SoU5OUSYZR4Bp45i7DTgHz6K+VtmDAvJ9/zM8oYjLn3ceNCM=@vger.kernel.org, AJvYcCWlnrM/aAJYAXSyLEqSk/IWQcZhJzsJzjexUJX2rMcc2LLPCGdRhBnlsTUEjpcXpupKUg83EzFihzyVmKs=@vger.kernel.org, AJvYcCXAJ45z2X1scgJn9URla5GOVF5tvL8SIh/VvShMh+awDYcVS5fWYTso0rlKhT0iuinWC1ctPHKBpZXTNmGl@vger.kernel.org, AJvYcCXVhh8NjI+bRlKMM+iduhmE1SIiDpvfbsFn8QPgilV8U1sMPZcQ9NxQE6b+E27lgxhbtpJVT9h6MtTY@vger.kernel.org, AJvYcCXvU2AC1rZAABd1JeUNp78w1qyFDPu3mWQgg4uqfuozCeiTlVLkyahhwYGdpJUsnU6h5B2PC8VPR836JNezbg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+U1uOxND4t4oQhX1nyw40gVrPxlU8jPOETFME31LdPf0XFrjE
	l5x45mCvozUc7/bHc5oN97BWrEg+P7uI4UCM7L+2lDoIhCH7nOmmZPZ7u6p9FwxQYWqZxAlEwfG
	spfJ1lemH0MS9AaYxq7VE4u1KgjU=
X-Google-Smtp-Source: AGHT+IEKMNbTQZXLRsS7SXG2H/9yDkohzhnwPtb9QKmG2n0WI6EVG/Fv5duzKAwAkVqQrCI53KiuMLSBZ1iaMAbwZsI=
X-Received: by 2002:a05:6102:e0d:b0:493:dee7:9b8a with SMTP id
 ada2fe7eead31-49d41513da0mr18959356137.13.1726750236464; Thu, 19 Sep 2024
 05:50:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913-starqltechn_integration_upstream-v4-0-2d2efd5c5877@gmail.com>
 <20240913-starqltechn_integration_upstream-v4-6-2d2efd5c5877@gmail.com> <bpujvanzp4yph2jkgog2rkvoywjtqad3jgk47kkex6v223flpb@66zporslyjzt>
In-Reply-To: <bpujvanzp4yph2jkgog2rkvoywjtqad3jgk47kkex6v223flpb@66zporslyjzt>
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 19 Sep 2024 15:50:25 +0300
Message-ID: <CABTCjFCTKoZK58rXBnTd22J2w_mkPp5=nx292eOwW5dAMbp9OA@mail.gmail.com>
Subject: Re: [PATCH v4 06/27] dt-bindings: mfd: add samsung,s2dos05
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Simona Vetter <simona@ffwll.ch>, 
	cros-qcom-dts-watchers@chromium.org, Konrad Dybcio <konradybcio@kernel.org>, 
	Simona Vetter <simona.vetter@ffwll.ch>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 16 =D1=81=D0=B5=D0=BD=D1=82. 2024=E2=80=AF=D0=B3. =D0=B2 12:1=
4, Krzysztof Kozlowski <krzk@kernel.org>:
>
> On Fri, Sep 13, 2024 at 06:07:49PM +0300, Dzmitry Sankouski wrote:
> > Add samsung,s2dos05 MFD module binding.
> >
> > Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> >
> > ---
> > Changes in v4:
> > - split long(>80) lines
> > - fix indentation
> > - merge with regulators binding
> > - drop pmic suffix
> > - drop unused labels in example
> > - correct description
> > ---
> >  .../devicetree/bindings/mfd/samsung,s2dos05.yaml   | 99 ++++++++++++++=
++++++++
> >  MAINTAINERS                                        |  1 +
> >  2 files changed, 100 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/samsung,s2dos05.yaml=
 b/Documentation/devicetree/bindings/mfd/samsung,s2dos05.yaml
> > new file mode 100644
> > index 000000000000..534434002045
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/samsung,s2dos05.yaml
> > @@ -0,0 +1,99 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mfd/samsung,s2dos05.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Samsung S2DOS05 Power Management IC
> > +
> > +maintainers:
> > +  - Dzmitry Sankouski <dsankouski@gmail.com>
> > +
> > +description:
> > +  This is a device tree bindings for S2DOS family of Power Management =
IC (PMIC).
>
> Drop this sentence, not really useful. I know that I put it into other
> Samsung PMIC bindings, but let's don't grow this pattern.
>
> > +
> > +  The S2DOS05 is a companion power management IC for the panel and tou=
chscreen
> > +  in smart phones. Provides voltage regulators and
> > +  ADC for power/current measurements.
> > +
> > +  Regulator section has 4 LDO and 1 BUCK regulators and also
> > +  provides ELVDD, ELVSS, AVDD lines.
>
> What are these? Input supplies?
>

ELVSS and ELVDD are common abbreviations for AMOLED panel backlight supplie=
s,
AVDD for panel electronics. I conclude that s2dos05 ic provides
ELVSS, ELVDD, AVDD from the facts, it can measure its current and power.
Those power lines are controlled by display hardware [1],
i.e. vendor kernel driver has no clue how to control those regulators.

I guess they just combined regular regulator ic with ELVSS, ELVDD, AVDD ic
like [2].

[1]: https://github.com/klabit87/twrp_android_samsung_kernel_sdm845/blob/an=
droid-8.0/drivers/gpu/drm/msm/samsung/S6E3HA8_AMB577PX01/dsi_panel_S6E3HA8_=
AMB577PX01_wqhd_octa_cmd.dtsi#L3508
[2]: https://www.st.com/resource/en/data_brief/stmp30.pdf

