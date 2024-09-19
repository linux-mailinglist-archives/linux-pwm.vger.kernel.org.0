Return-Path: <linux-pwm+bounces-3292-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A051897C60F
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Sep 2024 10:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A762E1C212DD
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Sep 2024 08:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590F31991A5;
	Thu, 19 Sep 2024 08:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxqfnCPu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB600198A30;
	Thu, 19 Sep 2024 08:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726735246; cv=none; b=TAHo8GZgpn1K1cERAhS37dnPVZka11ovKWPldfiPyoIMQ+/uObhxHzz/uO7EEkW5UPxLAgCdj7UgpHq/XDlSa2asLAU3c4rYllOYWx3lANHh8i/pY+N5uuWehTUBZuAigg2jT9Uz1zVHouT+0OsxSI8VphmSM9rMRiUb/F1lqGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726735246; c=relaxed/simple;
	bh=D0CUj5d6cc8AqQcicr95QuM3BKdQKimPOjS1AgGc/c8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IkcprS9+ZmMhn2MFFjqOAxn2MRuj5Lxj1xEgKtDoOCtnPw3lD74iJa5ILn+fsctWayUL3DF14hYpMH9fBhd6V78Haai2cKNDfStxaMiBxlD8dZ3pW0o3VbidrDGIOLiJXNdmSZt3y0qJPbtf75bnEAENhLLCgAL7pEieK4cPCkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxqfnCPu; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-49bcd11fc37so182383137.3;
        Thu, 19 Sep 2024 01:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726735243; x=1727340043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xykemnfjHLjw1rPIo+7O6AS00C6CkkoCorxyDrzMaEQ=;
        b=IxqfnCPuWq0aTqLERSIlOiIpwacHfWTvlWFPPxTksJjhS2vt2ntz05f1qmnClbD4fJ
         PU2FGlTIpcvJTwYIzDBlNRHCYjxYLOpMsN/y9lbup76w1SoJvMuYl9LKzx5On+C0dTzJ
         /c7rPL2JrdEx7vyVukXKaFL0+KdveXPN9ZihOvVBjx2F52BtdhwYUX5ntVNmOEXLLwFV
         STH4K1tBf5nU9Tfwzcu8ShIf/iP1JG7cxZy6UqvNkVxzlWTKWOHCse7UFgnEmaV4oZZK
         e0jFcHCQaScxd78NckHpONcqgsPzX4fnsL3+5xffXPJS83fFO2d6u2o5HDA2CVuuKTmu
         uD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726735243; x=1727340043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xykemnfjHLjw1rPIo+7O6AS00C6CkkoCorxyDrzMaEQ=;
        b=qWsKzq9CSSGC/i/ctk+2yZjt3ZhibOnLsFPovwK69lswussNOSWq1aCXO6IbUVLVHk
         LTd/FhXdlIWNFKF5TYA2z/C9z+Fj9VqdoP1c/aT/otP+Yd+skRlFI6/DOvPtd3gJWGor
         k6zFlS8F13+cJCg0QdHOCsB0AG8tw1UVaRw8hGexdW6+ZNcyjBBjCrvX10vipA5mi/wA
         yB97X6z8X+DgzHgDDBvCL9uNjodK2kCU7aOlwrApm/jkV0pwnHso+fKgrvF6qWaACkUz
         g3aF2ligj4nuZ+rKOYJdDNI31lhIr8jHbtkfj7F930evnaMjH9bim2raUN+sMNOauZj0
         UfDA==
X-Forwarded-Encrypted: i=1; AJvYcCU7xw/JWmy52kWpzYNA1mWo2+wSEg2URjMVF3m8hJmFyrk7FQxeQh5wihK4xIhlWOzwcJaKV9YPIvyP@vger.kernel.org, AJvYcCUTHapgoPAyvgGgmuICY22biBM8n4in6wqMhv0YGxGIKtZRSmcpkvju1Iy+5c9/6MNIA7/pcsAy5Zs=@vger.kernel.org, AJvYcCUfHUs9OJDNRYYqkMmrBYo2SiM3JJOW06a0D/qCSLe4SL4ozzRJzky32ViCRO5krG7CI1APQsjYcwp2@vger.kernel.org, AJvYcCVHO9M0HTO9Big+vs6zrYqotjrdAE0oR9DDZG03pQbdbKu+fNsyfK6ra2XBzNz0qTuSQAvstRIUK4E1PbZp@vger.kernel.org, AJvYcCVu3G20I1T09Gcn0QBMq8Um3GuTOxm4VFW0DKaAmxCwVwHFlJkHkeCkdwE/akm46+fIejSd9qnYeG8eJQ==@vger.kernel.org, AJvYcCW/kkuYeNQZ/JL6RbuyAkviemGHVHvN/gkOLHFLFfFMpXTgaq81a8AS4m+NcTYm+CoiSITtz+aNzxRqGcY30w==@vger.kernel.org, AJvYcCXHKrkNQONjmFIzA1sLUoCUYLvao//e62WGcnlneDghfeziAmIrWYn4QInPTIdYSZoRsoquM76Dkzsu@vger.kernel.org, AJvYcCXJpdpLoxg67umQGfE4iBdNMdSZr0SHnS2bhl6VAJ1NC2GNW4rSjkM5CwRVPFcdaYlBVRwJhyC5ERy84sI=@vger.kernel.org, AJvYcCXn0kgOg1WcFfP7P6b/OAv3lK6ULCmTOKsPo0ncIEqGsSO2mBmF71daRkLAUDKZdp3W3JqGlYd9rLHtTO2Sc1++TPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzN3cEU7FsFpxo4NpzVagGxAY/UsgPmUVRqjndQ8zAeaUYELiO
	0KsDjK8fF7cn4oLurGNaMbvL2bjDwzNZSqyqNexSyiyOCOzTKx29i8JXS9rSPdxzxdPDls9UeuZ
	GHIqqlIEylGw4e6xs5gh7AbZipH4=
X-Google-Smtp-Source: AGHT+IEPF6qaPSTwKWIjFiNSfRRNnkJYm1P330LaZ6f6Fgj87ECtB4FGVzstCMCjXzBEMRn+f/qNz2tsedSZyWrs7oI=
X-Received: by 2002:a05:6102:38d1:b0:49b:f5ed:4bcb with SMTP id
 ada2fe7eead31-49d4157db8cmr17162683137.24.1726735243511; Thu, 19 Sep 2024
 01:40:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913-starqltechn_integration_upstream-v4-0-2d2efd5c5877@gmail.com>
 <20240913-starqltechn_integration_upstream-v4-8-2d2efd5c5877@gmail.com>
 <wywp6vj2pqqe7to55k7ssh5sbqrmy7emvwruvm2waytancf3r4@aygtw3y6huwx>
 <CABTCjFAvXYrRJS3Dwf-TMq3OW_vN1hskk+qPjosbRym7xOvy1Q@mail.gmail.com> <6886f561-b9e4-468b-9515-72053d57911f@kernel.org>
In-Reply-To: <6886f561-b9e4-468b-9515-72053d57911f@kernel.org>
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 19 Sep 2024 11:40:32 +0300
Message-ID: <CABTCjFDKuEM2wogLcJXX+0eCOTCDUSycPi7JCjvdRCbXaP2EOg@mail.gmail.com>
Subject: Re: [PATCH v4 08/27] mfd: max77693: remove unused declarations
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

=D1=87=D1=82, 19 =D1=81=D0=B5=D0=BD=D1=82. 2024=E2=80=AF=D0=B3. =D0=B2 10:0=
0, Krzysztof Kozlowski <krzk@kernel.org>:
>
> On 18/09/2024 14:53, Dzmitry Sankouski wrote:
> > =D0=BF=D0=BD, 16 =D1=81=D0=B5=D0=BD=D1=82. 2024=E2=80=AF=D0=B3. =D0=B2 =
12:10, Krzysztof Kozlowski <krzk@kernel.org>:
> >>
> >> On Fri, Sep 13, 2024 at 06:07:51PM +0300, Dzmitry Sankouski wrote:
> >>> Remove `enum max77693_irq_source` declaration because unused.
> >>>
> >>> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> >>> ---
> >>>  include/linux/mfd/max77693-private.h | 11 -----------
> >>>  1 file changed, 11 deletions(-)
> >>
> >> Please split your patchset per subsystems. There is no dependency on M=
FD
> >> bits from your DTS... (if there is, this needs to be fixed anyway)
> >
> > Indeed, my dts has no dependency on this patch.
> > However, my dts has dependency on MAX77705, so AFAIU,
> > I should send this patch separately, while leaving other drivers in sam=
e
> > patchset, right?
>
> How DTS could have dependency on MAX77705? It's a clear no go - broken
> patch. And something very weird, almost never happening for new hardware.
>
Oh right, dts only depends on driver bindings, not driver code, so I
can send dts
patches with bindings in separate series, and per subsystem series for new
driver code.

