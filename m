Return-Path: <linux-pwm+bounces-4883-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EB7A35AED
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 10:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D2E91892677
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 09:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF5D25743B;
	Fri, 14 Feb 2025 09:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y/8soyW5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ACD253B63
	for <linux-pwm@vger.kernel.org>; Fri, 14 Feb 2025 09:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739526985; cv=none; b=VrTqWKGoN8ylWUZdgnv9KVWVCWinZPxqOEm4KsdxSmGH19XZjlQXeeHZRDJmrTFrEDM0wrwC/Rtbz93tBaUnaF2zlwwE27b4rnHUAMqcQt1v0Ppn+nbpGqzMR4FKZosGDkZj3XXWeRE/Dsx/MthhgmJvFR5fkUa2LhIQgJCcjJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739526985; c=relaxed/simple;
	bh=2AsCrWbVyGKPdXvfmBx4a9snB6Aw/WrgC/hdNdtKs30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J0TpEzVjEFXhyD21CN0z9elePztMtU7HFJCZX1cK/njE93dKdVz73KoYqDKsxgezYaVFFnfz+goaIJldhdGaOqU2NR5rPFhhHR7MreqBoKHkzzRIxItJeR+PgHfaiz/IZ60JLKM6xTmrFTAY/AGZr3A5kTHUggyFduaT7uFHyts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y/8soyW5; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5452d9d0d47so126476e87.1
        for <linux-pwm@vger.kernel.org>; Fri, 14 Feb 2025 01:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739526981; x=1740131781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AsCrWbVyGKPdXvfmBx4a9snB6Aw/WrgC/hdNdtKs30=;
        b=y/8soyW5CwNUoYqNTFX6lyGU8Qk9Avts8muHSffQeW/9/dTMOKJKVOg7Qok88c2s1V
         5nw4+Yi/2I18rJ727ag4Cpn1hS+I4uomvGEziAnRkXTRLM+TwzH1xW8X/zNtUQj8n7u5
         5Tz6GLZ0MnZlJJzbTRuEkPYhz048KOmgTgh9QngV9W/q9Mb+/x8+/o1OwBAAmT5QWO6L
         njNdK+QjD0AnWIttmNTk+qYIn7Qr1H+5nK/B0DZdHW4CQMA8yeGHO4eMyFAikSFo4TN7
         bCdquKPd4jaOl6bjjCWt7qpw53/ipnoEJ/6xD33MAGBCd/Jfi2fmt8gbX6kdrWz2lT9h
         YBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739526981; x=1740131781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2AsCrWbVyGKPdXvfmBx4a9snB6Aw/WrgC/hdNdtKs30=;
        b=EtsMQdzhEXFkguiypnRFoOJm1rYNT0rUMCXQZloKCG58gYNHKz4vDjoQTc9eYCs4RL
         jNZ1GYFE5VyZbbyiDnuUwHDL4Trr/aCXcGXjP/uhrsqxr4BBCXPAnP4OvH+Jw+SkMmrZ
         ezGqPUefqBUryFVuD6RcpWjCz/2vBS+doTuHEfIm280USwJZGIwHpq/KP0+biXCUgmxn
         VsdxhkKDA9NJK4O6ksaq2h9MQWeNQZaAlbjTezSSafkMzutTWnrmJgQskWQvq/8G8IbN
         bKOpwBYlP97fyi+t8LM+fGOsCCgSb2YAyCMrjInlxo2VlA0t50+AoVFX2lLwzINw8vej
         9tVA==
X-Forwarded-Encrypted: i=1; AJvYcCVjJfrg7Mz4ljbm2YyHWDetE1iSmhNMW4KUaF+EZyxYx12A320BwLlS1L8e16ksp6g3gX0YABiutIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfqEZGHHZlZDku3rvm0VAMTJlzuQ9fvKvrBVVo2HTzd9xZZJcn
	wlfYrjxHLvb8eajs9QxtjXwMQJMhW2xYYwV1i+A7ewThm40SpNpbeVfDt5IFPQVVHzzljguGMYV
	Wa1qphOSzObCOLKQlsT8GqdIIDf3U9kdYzmRGbbDWqb95quWhgYQ=
X-Gm-Gg: ASbGnctYrfcy2naYYt3v7UR40XJrctZfPZKg0LQIQwFJgbHV5sYlmMsml2LCGoRBSaF
	ieVHR/5ExHVy841/px/Gn4re+iFJb5HOfPNjoxzHSzcg8EohSDnmDbtLmWGAi3tl+OOHl9sUW
X-Google-Smtp-Source: AGHT+IGBcbrZEU3WtspasRr8y5DGBmF7RSzDcVPvB+A0GtrhyVirdFfGoibdROQWEv1N6aRSxdNWZYR6heUIRHTOP7E=
X-Received: by 2002:a05:6512:138f:b0:544:ead:e1d6 with SMTP id
 2adb3069b0e04-54518178efbmr3191247e87.38.1739526981311; Fri, 14 Feb 2025
 01:56:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211-gpio-set-retval-v1-0-52d3d613d7d3@linaro.org>
In-Reply-To: <20250211-gpio-set-retval-v1-0-52d3d613d7d3@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Feb 2025 10:56:09 +0100
X-Gm-Features: AWEUYZmo1A8kyC_1nRo1MhdajxMnD6e7V4G-rNnAAebgBMCC6AkDlJN1o-MAiIs
Message-ID: <CACRpkdYL4odi-00YDi-cFuVgw8uBncA+ZxGYnRRhuYR7eZuBWw@mail.gmail.com>
Subject: Re: [PATCH 00/14] gpiolib: indicate errors in value setters
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Michael Walle <mwalle@kernel.org>, Bamvor Jian Zhang <bamv2005@gmail.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Keerthy <j-keerthy@ti.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 1:10=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> The value setter callbacks (both for single and multiple lines) return
> void even though we have many types of controllers that can fail to set
> a line's value: i2c, SPI, USB, etc.

Yeah this is a remnant from the design that was done of gpiolib,
at the time (by David Brownell) assumed to be simple MMIO register
writes, so not much could go wrong there.

> This series proposes to start the process of converting the setters to
> returning int thus making it possible to propagate any errors to the
> user.

My worry is that this project will be another one that stalls at
85% completion (like with the eternal descriptor rewrite project)
but I guess the upside outweighs the downside, and I also trust
your proven grittiness so:

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
for the series +/- minor nitpicks I may send that I am sure
you would address anyway.

Yours,
Linus Walleij

