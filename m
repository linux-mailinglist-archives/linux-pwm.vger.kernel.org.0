Return-Path: <linux-pwm+bounces-2528-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2E890D54A
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 16:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED74A1C2025F
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 14:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F84153573;
	Tue, 18 Jun 2024 14:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbxyrMmM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4581514EE;
	Tue, 18 Jun 2024 14:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718720204; cv=none; b=spE5R/bsxJQUwP7nKqVvTFe5mic4yz+QKV4pbmzvzYt6ZY485RRWLjBzeVvuLIa4lYEbLoqOth3poExDH5LDrsQc/ld0q7pCmDX7XaDiRBgK3sq4Z35eCy7RxKMzRkKnoDBdof6J0jAR2apyuk+YK7eXC4gdwBPWrlJXhenTvkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718720204; c=relaxed/simple;
	bh=Om4iC8WD2JaG4NL4a3+9I68t3tIKpeGHX/9WOTfeeHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IpjIIjLzR1Mv87j8pV0/HOm0UPL4vXaukfGlM/jfenS8ONaiymMFHhptd1NaEWtak+Zx1t3sCDDq5Xq3xPLMD5XXUCeVi3SSZo5tDeL6t1oEVYjXwgrCfEjMyq4FesYJPwJNWLg51Y5Gpe9fQN3s5XIwQju12CVpkW43p7w1qwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbxyrMmM; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5c1996a197fso689506eaf.0;
        Tue, 18 Jun 2024 07:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718720202; x=1719325002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Om4iC8WD2JaG4NL4a3+9I68t3tIKpeGHX/9WOTfeeHU=;
        b=bbxyrMmMzubrCsARUdiK5w8f3pelzV8WXRbWKWyAF/woViyX9qOokkp9EgiTLmm8lZ
         7p+c5WF5EXbmLc9SC7bLu56uXDU+b/Y3yv/6urya6pdcIX63fDmZz5yhNgs0FJk9czUd
         dBhcZTJv3wqj82ppkaaRflOmOJ8Qi4MOvuGk6818Y/R6WaGsILDCPI+rgRZWDyIMrMDu
         L25R9bFzJisFKQUbpebtQe4Fqy42O1SqOS6BslIoMXFob4/BLO3SWenlAg27Y2el2hBU
         ZDm+ob8FeQUA1jOag0rPOwQp4Dy6lY9hBYjblFp/H9hP97B6/Ayiiiyo7sQ8JM+U81nn
         E+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718720202; x=1719325002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Om4iC8WD2JaG4NL4a3+9I68t3tIKpeGHX/9WOTfeeHU=;
        b=aBeOljCLbllDWfHOZdko6RW5F30NuwqpR+eTBc+OWvcDOObYQdFBcl3U4d3/nf8r7H
         Qzds0zgYSy9AfznUmBHZF/FANnvGEp3qTjs08abrdBmmEM94PUmYnmnTtIOyneDxr5tO
         yid/snpCG0Q/NEulW9A9C9/Q20uQqsO1v9cNnhlftus2pNHVn/qRRGzvFWZoL7N4b6is
         c/XTgJN5KqNUTuUEOFYwL3ddGH4oNnEuZneF/Z90rG0/uO5d35OrbKR8FT95yLhnsSkJ
         YdE6p/FAccKgom54iPmr48Fy3yXHlMizgXrUfcXrTsKvfnccsUV8vDx08TFM1d1fEIxh
         vmbA==
X-Forwarded-Encrypted: i=1; AJvYcCUUJMUwALnNHqCj8yh6Jj44A50K8Dh57dv8zFRNXFZ99k/ITXnldmTzcGdtA1Q3jOwVJBKCT+rdJsHDN5pB/s83F0G7rN1cXgRHllUUSMIWYE3H2LbPwURkE1gVlX9vuGzEc2vhZsBCfcfOkTO3EnIeij6/b2nptxadxHQcaSpZsptxulpY0VF8qD8KIO+Uv/ukWeSY7raWlv3mWbwJhy9MH7Y1Xu02Ghec9ysRGk73pIrRt4r31ydCTaBFY5IcxG7c4xdhHwQkXdjooiXpj+3zurAEAMbeRXsYVZ94lK3L9qQJtAiAX/JflNWGnCvEuQh8LzPBauWtYppoGOCxVzK99W26xgiexKetF2kka3H9VqtpVtsSfQpGyUIjUEFlR+ymsZpvmyf7yDd0Epp9EzvVqxMnvUI7qETfNK0r1fs03RiquQ1j1EwXO3CMdet4kqY=
X-Gm-Message-State: AOJu0YzqNK+TlOlC5zg32m8jfK8ql0e1F5oKtcKxYFLUark15dJuP05l
	2MT2E42xWkPA54RtIYrpbo7DKlJhQAl8tjBwEx3ni8DcQ86u+jBttRLKxuMMZ4ERfZNXxmdoW2W
	Mzthbb8QaLHyacDRkyC9Axut5KzQ=
X-Google-Smtp-Source: AGHT+IFVxJEPFbT79HYd7zoJLAxyrPm1gzxY90KGBgQZvvizvrURzGFMbP7julYl6JpqzUKt2q+uL/xgIcBmlrzc4oI=
X-Received: by 2002:a05:6870:b525:b0:259:ae64:9231 with SMTP id
 586e51a60fabf-259ae6493e7mr583749fac.15.1718720201642; Tue, 18 Jun 2024
 07:16:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618-starqltechn_integration_upstream-v3-0-e3f6662017ac@gmail.com>
 <20240618-starqltechn_integration_upstream-v3-22-e3f6662017ac@gmail.com> <e6a81932-0609-4476-82b6-43ee30b7de43@linaro.org>
In-Reply-To: <e6a81932-0609-4476-82b6-43ee30b7de43@linaro.org>
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 18 Jun 2024 17:16:29 +0300
Message-ID: <CABTCjFAKFMQJXdwELZitCKpZQn+irfrHW6uOpHzwvFv=T7zKDA@mail.gmail.com>
Subject: Re: [PATCH v3 22/23] arm64: dts: qcom: starqltechn: fix usb regulator mistake
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, phone-devel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 18 =D0=B8=D1=8E=D0=BD. 2024=E2=80=AF=D0=B3. =D0=B2 17:08, Kon=
rad Dybcio <konrad.dybcio@linaro.org>:
>
>
>
> On 6/18/24 15:59, Dzmitry Sankouski wrote:
> > Usb regulator was wrongly pointed to vreg_l1a_0p875.
> > However, on starqltechn it's powered from vreg_l5a_0p8.
> >
> > Fixes: d711b22eee55 ("arm64: dts: qcom: starqltechn: add initial device=
 tree for starqltechn")
> >
> > Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> > ---
>
> How did you confirm that?
Vendor kernel source code:
https://github.com/klabit87/twrp_android_samsung_kernel_sdm845/blob/e8bb630=
39008e1704a2f1bde68d39ded9c16ea88/arch/arm64/boot/dts/samsung/sdm845-sec-st=
arqlte-chnhk-r14_v2.1.dts#L10242
https://github.com/klabit87/twrp_android_samsung_kernel_sdm845/blob/e8bb630=
39008e1704a2f1bde68d39ded9c16ea88/arch/arm64/boot/dts/samsung/sdm845-sec-st=
arqlte-chnhk-r14_v2.1.dts#L23401
>
> Konrad

