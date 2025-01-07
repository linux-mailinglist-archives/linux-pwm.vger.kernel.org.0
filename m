Return-Path: <linux-pwm+bounces-4547-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84423A039D1
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Jan 2025 09:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 430D27A2902
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Jan 2025 08:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491DF1E049F;
	Tue,  7 Jan 2025 08:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WbIxZBcb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1878B1E0DB0
	for <linux-pwm@vger.kernel.org>; Tue,  7 Jan 2025 08:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736238535; cv=none; b=gzQeHVK4PTbGzczz68zCyrRfpmzsyWN8pyOlI1b21xMi3zFX0XlHWwIsTyEkFS7jiVeesMRaCiXkdmCSYDwsKi+kyn8Tn0oMkILRhXkv5BL7Tv8Eted3v03RKU0TOOb1h1PxMU7I/hXXWzJ2yJVPsuVcpoafkq2BcXSmcHzIyEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736238535; c=relaxed/simple;
	bh=KppWSIngGaY7dPjUjaUwC/ZQsQtvE8wkP05GAZfgcbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a7pYqT0vtlrMT4EyTbh2ftFniwAN2AT/cSY7z3Gx+Ll+Or2mB+dq+xUwWXaPMKygogaTB2FHYL57mjiUq0HzPEX4IjwZ50UtpptGIRAeqA1CpLvQrb+jn2TfO2A/fL73vc5aW5vJlYRIPnHlQeBT2oieSPDucM6Ju2ElWujVxCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=WbIxZBcb; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4affbb7ef2dso10312120137.0
        for <linux-pwm@vger.kernel.org>; Tue, 07 Jan 2025 00:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1736238531; x=1736843331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KppWSIngGaY7dPjUjaUwC/ZQsQtvE8wkP05GAZfgcbM=;
        b=WbIxZBcbuUa/uk9iNqArFHtpFyojPzi7WWOxuvUoqvS0R/Fro2L7NFw3AUg7OXRDV9
         kMxAPUwyd3iQ4Ed32Bjf1HUvdpSTx1LEYjiJk6jN4s36El2t94k2LuyO8Fafp/9v+x2l
         2FcjBLpFboLaBJsSoGMnxQ/o6br3tC7hb+9WzCuosbiyKs/pjVbZYhyooZpO9ELwcFqC
         4SR5m1cpO0tZ6JCqJRhtKBP3oQy3KFtCh9uOKbABbeuz/+aghI+cHO6P7Dl3Vp+7MsLW
         w+zENzorCatwRKshP7sz0GT/T3/ta7dMaxoWPvcac2dSvf2MzbE/8ittVMV0g/Su/QNN
         8f0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736238531; x=1736843331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KppWSIngGaY7dPjUjaUwC/ZQsQtvE8wkP05GAZfgcbM=;
        b=u+B3H65TxPCdMg7HeLH37WPqfeI8fQq9udr+U7Dyu9hJRDU448CySYYec1/TDTM+x8
         m8bzF2MkSS1cENic4PQoy/Al9nba46Y8Ke2eb8QvVIYdFWI88Ym0NfZXoFIfBDwCLwMM
         jfYFgouooc4XrbG3wpMakas+ZqIjnd1F9qds8vOViw9U71/Myp7JCuZy/vJl5U5c7MoM
         R74e/dbgb7xXZc4h+Xeh/oXgNfu3l1EsvKRmJHpGi5cWQivpSwP35JUdcw/6XHoBE8Mf
         BPdxxAocgScdcw75pN5R+Cy5W6pFQUrZsdD6+RXcSoaNMFOKG7S0NKjvlOfuolAhMIhe
         Fhrg==
X-Forwarded-Encrypted: i=1; AJvYcCUisr3yvPv9qQjS51TvMTvAm8sTmUjHVpBfEOmOvARbrwtpj1CyOlCFCreEMKJuYl/F0RhO8lCst0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcLGfeiRh/U3016IMd6xs4KXqtN/7vM/2cGhW+2zjsgo3H1cdB
	tIhSpf16jUylNhyJUzkopOxSAM7kiN5k5hSnXMr9EpMPyxki6bXkJflFTYi6wLr9QVMp576lnm6
	9ZpQQbefzfSLSHTT8yFY8x48DPkdDbYld2uQ3Rg==
X-Gm-Gg: ASbGncuiyurXCHLhOOnxQctoJc8rSej4eQIRe/pX7QQnSn4XUX407HSGZxdxEkwrZ/B
	DXUWG2VOrNs4OFH4LTp3tyETqrbBYCpXolWY5HlQW
X-Google-Smtp-Source: AGHT+IFRlyN63rDxZSRVE78WlCeoEuMuGOCLoomP75LzMdg4FjXQSjVinxY9uwYfnRZePt4VYnzvFEkA9dHEIzOx7qA=
X-Received: by 2002:a05:6102:548f:b0:4b2:ae3e:3ff with SMTP id
 ada2fe7eead31-4b2cc48a5eemr42728948137.27.1736238530976; Tue, 07 Jan 2025
 00:28:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222081231.213406-1-nylon.chen@sifive.com>
 <20240222081231.213406-4-nylon.chen@sifive.com> <jvwgsszvs4jtcytcphsdjulzgqfqzdp4sisu236ddwsqgmvriw@ngi4ljgh5b74>
 <CAHh=Yk92=hp+kaTJWL13_jwJ5gzAAi8gbRF=Ns9=yq2trRUQEg@mail.gmail.com>
 <xf6ympnaljfjztptb5w5qdpuluckptozdz5a7gtuycsev32ngr@x2ovibqv6evr>
 <CAGKtFavQAZOof5QSTFCEaRJEPETm5aBqzkV4g24n3ioiBAOgDA@mail.gmail.com>
 <p6rqpx3yrn2ib4ulmby7tbnpbg4bjyt4dt6snrmhuyw6hx6izl@lywssban54et>
 <CAHh=Yk-iFGULUQc-U-PNjx-st7d5KER3J+t54SNERVaNr++qoQ@mail.gmail.com> <c5zjujxi7wsuabdpttojkrwnvkwna56gz3gnapxskg7tdzmo2f@frvbwzguizdt>
In-Reply-To: <c5zjujxi7wsuabdpttojkrwnvkwna56gz3gnapxskg7tdzmo2f@frvbwzguizdt>
From: Nylon Chen <nylon.chen@sifive.com>
Date: Tue, 7 Jan 2025 16:28:40 +0800
X-Gm-Features: AbW1kvaf4bo-YxvlaMSY-WcDD0SjBcDDTRKQ82-uo3kHXd1gXlTC1T4DmcDAT0s
Message-ID: <CAHh=Yk8U+NK=Sk2UkwjL284-RJR3BLDUe+WCPXm_nH5J6soqPA@mail.gmail.com>
Subject: Re: [PATCH v9 3/3] pwm: sifive: Fix the error in the idempotent test
 within the pwm_apply_state_debug function
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Nylon Chen <nylon7717@gmail.com>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, conor@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com, 
	paul.walmsley@sifive.com, aou@eecs.berkeley.edu, thierry.reding@gmail.com, 
	vincent.chen@sifive.com, zong.li@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> =E6=96=BC 2025=E5=B9=
=B41=E6=9C=887=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8812:52=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> Hello Nylon,
>
> On Mon, Jan 06, 2025 at 05:00:32PM +0800, Nylon Chen wrote:
> > Hi Uwe, I have made the following adjustments based on your
> > requirements. Does this align with what you had in mind?
> > - period
> > seq 5000 1 15000 | while read p; do echo $p >
> > /sys/class/pwm/pwmchip0/pwm0/period echo "Testing period: $p" done
> >
> > - duty cycle
> > for duty in $(seq 0 1 10000); do echo $duty >
> > /sys/class/pwm/pwmchip0/pwm0/duty_cycle echo "Testing duty cycle:
> > $duty" done
>
> That + doing the same test backwards (i.e. using seq 15000 -1 5000 for
> the period test and seq 10000 -1 0 for duty_cycle) should catch most
> rounding bugs.
>
Hi Uwe, I understand what you mean now (testing must consider both
backwards and forwards).

Thank you for taking the time to explain it to me.
> Best regards
> Uwe

