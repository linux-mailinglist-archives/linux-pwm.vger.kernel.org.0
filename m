Return-Path: <linux-pwm+bounces-7226-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C95EB3ABCF
	for <lists+linux-pwm@lfdr.de>; Thu, 28 Aug 2025 22:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51EAC567E80
	for <lists+linux-pwm@lfdr.de>; Thu, 28 Aug 2025 20:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F7E29DB73;
	Thu, 28 Aug 2025 20:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NcLlezA0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4F12980A8
	for <linux-pwm@vger.kernel.org>; Thu, 28 Aug 2025 20:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756413602; cv=none; b=TOIwX2LmToosGAdvJ6xzImIRbQc6s8tR05ni/37kfxdJQMexJId52yxbKE0xoF15/ZmmF6mOqFbneYcDWpfM3nZlGNZLAVdaJhXS8Ic0I8gHMYpe7Ua1gkB2psaFnt6A0494d6pdpcnfxSn9VWgw/Dftc8QGOG38/XHzH2BDeEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756413602; c=relaxed/simple;
	bh=uMbygbPZ6lp27UzGsQQZR6ABSzimBNrHU3kdVj894r0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NlcK/JWuLWJjFVAckNVL50Di26LDvDfrqeAU+KXjFaNuOJhAZEr5MHzOoCruTVpKt5jPTGb1Wr11wxIdKl34gmWXs0m5ZMZnVDvjfRXXaONUfYouxDSu0XKHv86Vr9HEi4LOHsoUSo2Ns8EJ1bZNPvzz4Eem3H0SHZYwoxlb9Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NcLlezA0; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-33693226e47so12405171fa.2
        for <linux-pwm@vger.kernel.org>; Thu, 28 Aug 2025 13:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756413598; x=1757018398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMbygbPZ6lp27UzGsQQZR6ABSzimBNrHU3kdVj894r0=;
        b=NcLlezA0C/RKlvpmTFfuTKj2oVT7oabLqVO1bvl4XzZepWbF5LipnuAimHWJzYbRCp
         Dy3J229Ii90/ShZ4rJe0VrJYKhdaZoHER+zW+ZDl5vxb+n+WA1uJddXYf1ho3w2Pjp52
         Qal3wsSsT/AmvxWC/yMCiC0+INM9MO8g8LREg/xsz+YWpWNN4KdbgYW08vb58tWOuJYt
         fWGJFvT1x4lCliEO/N1/60SkNufd2sLZc+m6swz0acRkDdC1T3q6RCKXGBOGEU2eewfM
         bYOYGeQ5xjyc8UyWqkPSuNYCyJvM7b5/wzDaidsg957X71LM5UVkscvcdh4w0HTH4qA9
         qn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756413598; x=1757018398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMbygbPZ6lp27UzGsQQZR6ABSzimBNrHU3kdVj894r0=;
        b=SBLp+G3BCxdD7NGDTJv07PDb12NdMdzwBhocQT5RbMCKIyaac0UrmIIL2HoDxs4CmQ
         XgxDoft/FIRbJeap5kx8S84hAYBpss76oQxCf943er18jgN4QbCRivBYvuuXYVQ5z2Uw
         VtXtZnebsl6uss+kPduviNK6lQYfO1G1YM6dHCnIWwmRoMuaodew9xF4pCwj0tN+fnYP
         lVsdnUyvOunS18TQLDzToBjocyrY9Qif8ZEnttlyRfhZQr2jTL6n2ROIUiAnGAD27GES
         JKCiGRZY8/SBEjjNN+ZMzsarW5cL3hB3ZezoPxDkdncEZU71cZdun+lb0LLwgM9fkn+Q
         /YDQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8+BZP+U7HqrSI9DWwau9Bihqow5fdHVxq0fAV/Kll0ft5bEfEOvejvI7HAyw+3ctPJ5xfKRGnT8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhShWkxPwmmcsMxYbf3e6NgyhcPFs3RcoT8ar/hM6iVJwPDfIB
	lnTVi7wbXVb1FXS3kbQ/XtgR4CT1BMLjoMXgrnhO0CCkmBi9lYk3QxVAedoLPrjTyp7g4UEhYYG
	wmj+wK78ZOcXAmAC4cCxNlDb8ITg0dbvn5ZwoR0LQoA==
X-Gm-Gg: ASbGncuji66xMzLCvn4B1mou4p+1YjE4oWER0BlD8nojb7EDawENusdM0ogtna5rH7d
	HnGxLpnJAzjqiVDM/C02dm2l3kPUl4X/OpuYJmufSUvXBLqmO0Q2WDOaOCv6fJDEbCSQkwA4+vV
	vo4IsrtEmCMjV9Ubq0Jnty9lnpvnqBVpOGijls01sqhEG94xm6XC+htFP3fPQv7iwXphDRCDgId
	dyFyYdD6nZpwwkYxw==
X-Google-Smtp-Source: AGHT+IFyEWOuQG1fDf1ksdaTJASZAGtsBlaDN9tGze2bxNvZnscAfatszOqEDWcWQi8cu6lP0CXjxEkjw09XegfiPKU=
X-Received: by 2002:a2e:bea0:0:b0:336:af88:ce61 with SMTP id
 38308e7fff4ca-336af88d0efmr5543851fa.40.1756413598261; Thu, 28 Aug 2025
 13:39:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826-gpio-dbg-show-base-v1-0-7f27cd7f2256@linaro.org>
In-Reply-To: <20250826-gpio-dbg-show-base-v1-0-7f27cd7f2256@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 28 Aug 2025 22:39:44 +0200
X-Gm-Features: Ac12FXzQsryYs9cHpNdLp9yIX0je4QdVRt-NW8EFXmMKnqh-BUifcsfX0FEg61k
Message-ID: <CACRpkdYBZTLpEGS+7m_B8MrFtUvh+0yaS0bsen4jkUcf0C8gjw@mail.gmail.com>
Subject: Re: [PATCH 0/6] gpio: remove references to gpio_chip::base from
 debugfs callbacks
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-gpio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-pwm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 11:54=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:

> We've stopped displaying the global GPIO numbers from core GPIOLIB
> debugfs callbacks. Start dropping it from drivers too.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The series looks good!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

