Return-Path: <linux-pwm+bounces-5116-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6E8A56167
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Mar 2025 08:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 602D818898EE
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Mar 2025 07:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5182A19F13F;
	Fri,  7 Mar 2025 07:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="NBpNOax/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9175D193409
	for <linux-pwm@vger.kernel.org>; Fri,  7 Mar 2025 07:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741331040; cv=none; b=mr4VJ/2yaKKTmD4L8nJvb0T75QMbcXUWCFEaH5P5eTK8wZ3fE++ZFuu6utk394qPN/PXsVDPkHrAOpe02aSVaYT09TBqWl23gXE5WNJcvKXg81E3leaGJAl3mTgaOhyiBTm7OkDhBym17RKK12IrbbiPMcotJ/7ZHYeL0MNbIu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741331040; c=relaxed/simple;
	bh=8nAP95098N8VvC8hTlm0/7kaa5VzZNLWpFxVGQC8zIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OdnbvJCdZc7f38WWl/QW41mRjKtEzPqq7M2ruV3uultfj2hZ1IR5EL9us7fD3keSqx6WwujGpmwS6HerRwuQ62WEYmbfDBl1t4/GSBBEPvh5kB0U2s1ExMFUCPNVf3I6kINY31AjH8pUpsGEHqsUwdXECuJdmOczpCsDpX3E/EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=NBpNOax/; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5497e7bf2e0so1665620e87.3
        for <linux-pwm@vger.kernel.org>; Thu, 06 Mar 2025 23:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741331037; x=1741935837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d8LoLRLGkxYV0alNGYR4F1xsTkZ1FzcA8kkUjGyENl4=;
        b=NBpNOax/CZHtsObwQ+j9vkhKb73k8QXBUXREtiC78ss0qZSbHFhODQIDFK8TpN4Gb7
         SDzBNR9toP7ylsS5y1BJBldZcrbQu84d7HK8HoMUOJsT9j8yBZOaiNEoXRruv4cxAkOb
         Jni4ggK+sBXSovS2MnKggxUT0w79wHRVl77bewo8rL9BDP0sWFphrRxVEdrHHkeic+ml
         tAWYAS9JZPfe9g0ta1Ta0kwdfxZcnrHCu5scbsc8E6YPfR8iZ9920SgU34vS/ywgYPjW
         bubUv7rD3HcK6UbBDyaU1RJJ4svI3zPMFfra3cy6x1jAD3g9ty8nyLrdyiDdzqgxx1A4
         dg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741331037; x=1741935837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d8LoLRLGkxYV0alNGYR4F1xsTkZ1FzcA8kkUjGyENl4=;
        b=pbPYuV3URmgDwNJkYAY0fSzMHVzEhy8QGMsFnD28oDgqtu4zdGqJ4rxNWSLTDtRB6K
         7uOKunjpmsffvcFOHD5dl62uSEXpAtSIJcslYz1JEzLwC2Y+gols4DJyMxaGYaOXWhRy
         +7oWdRa0p+djYqFBeCmHMakhKr2fJRNs2EYxk2jXTBYEmrR19mwz/lf1qL0AHahp48b+
         jgWEB4Ec9YZ2MYNZPeqqjxQzIFRvrXdhvEoX043u2KT2LAWQ02FfrIlJZgt3lEA3oswk
         43RZJSyz9LWe78fIWATZyE/HGqimczVgHkUGLzMp0ebGZ2rypZqTS4PWBLaP6rUQ/cKe
         2MWQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7/p75nqoUSFEjtc4reOFJb13iFWcMgiXvTeO98OR1Kls4Q0Dp++6FsjHVpOBE9oAD0AXrECRu+OU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJj3++dg+rG91guTfrfy0N6U72AQdIurRXiV6g04xPWTQ5qZrv
	hunE42AVnw7cDVbZ01rmrwxSuHvCu08LIkZXK7sU91r9rbZOVW01BOjfgzqxTbShUK+BaZnRDa/
	WpWITQWnv7lsCh4ZcIQN4XouMwlvHRekxG1ZGYA==
X-Gm-Gg: ASbGncvPV/AOpeppmOefqdkPTK05GpmOahap+nSoeRs0nCXLHzrVBNetPGE0EYdF4f9
	JrrubzPhJzO/hEGBL+Tj3pVNG2dDe4U+0EzuvNf2NTtJUlIrEmMLS+xTmCCNln+blcXHdZw502G
	mH3jyFlYaX1ql+4EYn/qdNp7FkRtAbbJBZZJzMSGnx7w3EOdLHyVR1CWPa
X-Google-Smtp-Source: AGHT+IGLPbU3KJLosa62LrFtSyjSM1FYRo5hnluiTpHzUxw8rr6zT37TRHuDWK6vB1cV68vxHCUY1m2s2IV4pZHIHLY=
X-Received: by 2002:a05:6512:281b:b0:545:2f0d:8836 with SMTP id
 2adb3069b0e04-54990eaae1amr630800e87.40.1741331036524; Thu, 06 Mar 2025
 23:03:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220-gpio-set-retval-v2-0-bc4cfd38dae3@linaro.org>
 <20250220-gpio-set-retval-v2-1-bc4cfd38dae3@linaro.org> <174130146134.987559.8662566490718210141.b4-ty@kernel.org>
In-Reply-To: <174130146134.987559.8662566490718210141.b4-ty@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 7 Mar 2025 08:03:45 +0100
X-Gm-Features: AQ5f1JrsRCTzGeQkxb8NcRBJre4S54OYANop1Qs9itP8zmv8yOQ5lBl5rfQBlgo
Message-ID: <CAMRc=MdQcxtXMUCt00=JbGY47cMMWcW8=r3-ZrMKjQkViqnxvA@mail.gmail.com>
Subject: Re: (subset) [PATCH v2 01/15] leds: aw200xx: don't use return with
 gpiod_set_value() variants
To: Lee Jones <lee@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Michael Walle <mwalle@kernel.org>, 
	Bamvor Jian Zhang <bamv2005@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Keerthy <j-keerthy@ti.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Pavel Machek <pavel@kernel.org>, 
	linux-leds@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 11:51=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
>
> On Thu, 20 Feb 2025 10:56:58 +0100, Bartosz Golaszewski wrote:
> > While gpiod_set_value() currently returns void, it will soon be convert=
ed
> > to return an integer instead. Don't do `return gpiod_set...`.
> >
> >
>
> Applied, thanks!
>
> [01/15] leds: aw200xx: don't use return with gpiod_set_value() variants
>         commit: 5d5e2a6f15a6c5e0c431c1388fd90e14b448da1e
>

Hi Lee!

Can you please drop it from your tree? You acked v1 of this patch
after I had already sent v2 (this patch remained unchanged) folded
into a respin of the bigger GPIO series that had triggered build bots
to point this issue out in the first place. I picked the entire series
up and this commit is already in next as
129fdfe25ac513018d5fe85b0c493025193ef19f.

Thanks,
Bartosz

