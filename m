Return-Path: <linux-pwm+bounces-2853-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C42937572
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Jul 2024 11:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED1E71C21796
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Jul 2024 09:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08A87E583;
	Fri, 19 Jul 2024 09:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWIsad0+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B2B5CB8;
	Fri, 19 Jul 2024 09:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721379722; cv=none; b=VrTmIPgKQk7cAtvk/dWp5SZhdq7eVx1QDiEje3tynvijmHNqfjnlz9usEPJ2mY346g13Izs7gPOwsxCJMw8XcSPCnAPyr4czGRNZJorlN1nJnd8jYhWMxSP5bJLPwjt1BCnRWXhmhYaFAzBMbxsn1S4v+GLp5jmh+TKhPXOKsuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721379722; c=relaxed/simple;
	bh=e8NqB4UXXfRhq7xibWmOKgLLvVoy7/cBoXSoL07ZZd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o76o0GYU4/fcYeuwHK+BWb06TB4fXqRK36oTmn0JKf3fqjR2NnsTF2+AlH+7RzdjN4EFS6tU9edE7Cvki8xE6n0G1rjb/2mh8psPL8d5vCh7rN8Q7mjZ5swKLvk1OeuiU635LhtWSTkj5924WDIyp3EzwS1sYxmGJFzykEjlRXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWIsad0+; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4926a732a8dso594491137.0;
        Fri, 19 Jul 2024 02:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721379720; x=1721984520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8NqB4UXXfRhq7xibWmOKgLLvVoy7/cBoXSoL07ZZd8=;
        b=gWIsad0+rK05aE2J0pIqWynBQvX5NXxf+dO/jYm9yr8gV2jqJIFwANJusPXVqMCmrH
         jniY/TQ61EdnV3WrOK/m9w8eU8bnfzeGCqwv/T5TEBv22Iruk+HPMaNPkyq0PBhF4EWu
         /YS8kjVlE/Kyw1qqiTFYSkOX6nn1357bZsLBFMfPjiEOrYNM1YkbdTJNywd5jzha9nnP
         RyGOh2FhRjY+QkqikTJ7ZRyJQIwOsVcYVOXOYMQdNBmpQVZ6JZCb4TbtGKD7n4cf0/Tp
         YR7ypVSick/YoE4JUY3Q4YUhETlTRznq5DOMZT9gXi1MxgcaeAhU+XfTJdUs119eqse3
         iAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721379720; x=1721984520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e8NqB4UXXfRhq7xibWmOKgLLvVoy7/cBoXSoL07ZZd8=;
        b=anXTFeDXvOgCp2jA0B2jP4IylWxt6720HtgVze121XboLnJ5RqGWWHLGYC3dhhg/pc
         NmlD6YVWA0ccooEfXppi+hgRTHcITD3mUjls66T2ndN0bew8W+80FNysBeTkOD3fwp0J
         t4tBMdniC8HhG3fWmBeG5UHtIjTAJ/lmY7/bxYl8B0yfPmOU3OU/WhQe1hxtEHEYB5jy
         eoZkijlM8uLnx6tRW7Z/q9XxfjlbLWa3Nxq1+fMX5DOBwxyAQrbsf0a/UDNSTMjLjosq
         3xev6uBi0vKauhfELu07o2k7tksBYYtyYpDhdJBhsKw19J89cIuSokfWjTWZrEnUhqvG
         2jYg==
X-Forwarded-Encrypted: i=1; AJvYcCViLsYqEB55E+Q2g0PR2N5Di2yzjY7QDgldXn+lNBJDClTW1dRo07iDRzO9Qt5QZu64j3wfbQ+Jt7LRjUZHpv8cpDMLdO8jPegIFMsbAcHjg9vqT+IpO+2Dt/R2groU7oeAxS/WdD+Z4NoyWzMoUACCwQWqc6PRQAP+1VrrPf0Cn0yvJwb+pCkbN/S074O5uOHeEqMD7y+wKzlWlDVb5mITRCu9Q9gbRfdw4aLJhnTOlP8qmTn1CYBAwRPdZkKbw/LtjiW/pJKnK+ultQDMXR8260A3kb3tQZ0slW7dDEcoQEYNzUaiEKZUenJP5vnl7rWehy1U2SY0J8kSnDlB/7jtQvxzC9EthZXa6YhMxgEaTtrhoU+u25AD4SQL0+wpEs4kSNlPmMNWSjE+NnTwPlq7VsPrFy3Lr3nkUY4aS1LJkoCtgsipKvh5YxPxIuxIlCs=
X-Gm-Message-State: AOJu0YwT/5FysG9Is/GOIs0KT6geaz7AuOgWhS71fCORHg6Zh331R5rD
	nH38otIhsT1rJOU7bxEiErQFxjktzz7wrpCGwLmU4KhtXpiYzHf5BiceGFYcgV3Wi9iQ1JkUzvt
	L9cLL9Q2b43tU4OpQjXsJyvH3GyE=
X-Google-Smtp-Source: AGHT+IEEXrAtw5qdg+6Tlto0/IkkAm7AL1K/G5e76SlvQXcdxQq43WWyLQGsGDvFSp5tU2oxcT8DtAITdKNEJ/5OAbQ=
X-Received: by 2002:a05:6102:512a:b0:48f:eb37:fd86 with SMTP id
 ada2fe7eead31-491599ec471mr8207968137.30.1721379719734; Fri, 19 Jul 2024
 02:01:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618-starqltechn_integration_upstream-v3-0-e3f6662017ac@gmail.com>
 <20240618-starqltechn_integration_upstream-v3-2-e3f6662017ac@gmail.com>
 <wnf3mfgdm4p4f5wrxdtlx4wccnizdvohc7iiyu5t22eeb67r57@xun3r73hksrg>
 <ad04e203-4244-4cd3-9c9a-fae002962990@linaro.org> <lwrz4rvn6ogseea5v6j7plc3yi3xnzo76dvrsl3muat3iswlkb@zmwa3xo3xgw4>
 <85e03d10-59a2-4f15-bb85-7b2c0354a5d1@linaro.org>
In-Reply-To: <85e03d10-59a2-4f15-bb85-7b2c0354a5d1@linaro.org>
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Fri, 19 Jul 2024 12:01:48 +0300
Message-ID: <CABTCjFBxOEdpbdYnbvPyf2MRE5m-3gfvHtaPbDF5PmkQZ2kV1w@mail.gmail.com>
Subject: Re: [PATCH v3 02/23] gcc-sdm845: Add rates to the GP clocks
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sebastian Reichel <sre@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lee Jones <lee@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
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

Why cannot max values be defined as ((2 ^ mnd_width) - 1) and ((2 ^
hid_width) - 1)?

=D0=B2=D1=82, 18 =D0=B8=D1=8E=D0=BD. 2024=E2=80=AF=D0=B3. =D0=B2 22:12, Kon=
rad Dybcio <konrad.dybcio@linaro.org>:
>
>
>
> On 6/18/24 20:55, Dmitry Baryshkov wrote:
> > On Tue, Jun 18, 2024 at 08:50:52PM GMT, Konrad Dybcio wrote:
> >>
> >>
> >> On 6/18/24 19:50, Dmitry Baryshkov wrote:
> >>> On Tue, Jun 18, 2024 at 04:59:36PM GMT, Dzmitry Sankouski wrote:
> >>>> sdm845 has "General Purpose" clocks that can be muxed to
> >>>> SoC pins.
> >>>>
> >>>> Those clocks may be used as e.g. PWM sources for external peripheral=
s.
> >>>> Add more frequencies to the table for those clocks so it's possible
> >>>> for arbitrary peripherals to make use of them.
> >>>>
> >>>> See also: bf8bb8eaccf(clk: qcom: gcc-msm8916: Add rates to the GP cl=
ocks)
> >>>
> >>> Each time I look at the table attached to the GP CLK, I feel that it'=
s
> >>> plain wrong. In the end the GPCLK can in theory have arbitrary value
> >>> depending on the usecase.
> >>>
> >>> Bjorn, Konrad, maybe we should add special clk_ops for GP CLK which
> >>> allow more flexibility than a default clk_rcg2_ops?
> >>
> >> If we can somehow get max m/n/d values for all possible parents, sure
> >
> > Calculate them at runtime?
>
> We'd be calculating the mnd values for a frequency that's either equal or
> reasonably close to the one requested. My worry is that we somehow need
> to get the maximum values they can take (unless they're well-known)
>
> Konrad

