Return-Path: <linux-pwm+bounces-4715-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A33A1A383
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Jan 2025 12:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ECFC16D878
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Jan 2025 11:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A177D20E33A;
	Thu, 23 Jan 2025 11:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6/5urNE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E080220E6E4;
	Thu, 23 Jan 2025 11:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632756; cv=none; b=kHCkkiZqWJi5X6Qd7EsxMuKTifIO5S6bQ/VRZxlFvO+UR5SI+Ou6DzDDSdg8aMxYa/fBDzMzwA+76dTIAiYXEFtTpLpX7GCnEgXvclUpGdsGEr5QKWb+L8kj/1CZtXtUor783qsIsjs9ojArlOUyvILXNrwwx+DGKIzElRnVL4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632756; c=relaxed/simple;
	bh=rBOgOxZNd0ESxYLiJ6t6AcqdwB3MVsE0EYS0CORxWQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YxwX8yWY9WuIhXIkfbf7bDNJ/rmehG0HvqgqK8YUV8L5Np8wd/6OYiS6IvYhN+aNTlx8AopjfPrN6ehDsX9srhalfNdbjT3F1JPgJQO1fgcKEqQ9DG9JzNmIzS2GBIF+QKvLpvj57crGpqJvLpIW7O/IEASgdUL6EqkSQjgxgBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6/5urNE; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aafc9d75f8bso148340066b.2;
        Thu, 23 Jan 2025 03:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737632753; x=1738237553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBOgOxZNd0ESxYLiJ6t6AcqdwB3MVsE0EYS0CORxWQU=;
        b=Z6/5urNErDDITmbx82CTNnAdOcgIREIhvXprFdTnnC6QJweBzmghTf3rropdXfJK6U
         8G5iBJNdRVTC2t6yBi1UgBnqZiEzRwOq2PERw7wTCpvS/wZHi5YAgTR8KmqSHqcAP/MA
         rXrjuV1VHo87B2+7wRvCHdAqNQBfnJjDdh0mFDb7JgD3JEBlM3nsPtBISZnHliTXXvSc
         WQ7NxhTOrFUtJUyHEqv8+ruEEnjzWS7Yb0NYtPfU6cK+0p+WPeGUSVB/wfb2K7b0wQJR
         AFbedD9o3tRdxFp580bb9QOS0uV217isC7r7dV/cIeLjWVJrm8SW+qh6zd6e//EY3cHQ
         2QLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737632753; x=1738237553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rBOgOxZNd0ESxYLiJ6t6AcqdwB3MVsE0EYS0CORxWQU=;
        b=YTOSiiQg8Pj4lnNLpYWdzJHuBrcD2nhWTB0QhWvDvHFyart5c+cDO2Vha+xpREZdcR
         V+ToONvT/2qEJfqGig4IwQ2Hh5axYdLTe7R0ZGq0Zr1NvIL6LGoFF5jqIMRS6toULeOR
         1+HiFFatVP/ohnx7/Fijqj3XhyGzsqSRezXFVPg3tiFigr17+ZNY44x87HmB8ekVcdyT
         UD0GJpAE97WqT1th9SFRoqcfz5mmkfhNHCqNbq1nzcc0tNTe2JI6DJCiCaxZl0e8VhM3
         2CfwesO3caU/bG48f060Ihrki/aw6buXwwkZROq86hpMZVyAFenGBDhCSl0s/I8+mevL
         PO2A==
X-Forwarded-Encrypted: i=1; AJvYcCU+WLOqhNcdpNOOwyvVdv7hCB5Vq5IQftc435wv0rbdZ4jZeao3AkaEjP5qXyPIsBTlh18PFqfzpMgI@vger.kernel.org, AJvYcCXNRMRfr9Yjc9k85vwF7eBhj0vOMPW1iTDk1xd1iRUVy6XZ7TKe8HI0XsjLmIEp/EVPsg09bUt1ejQ2@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/6oE/ejzbyHHIIdz8bhKIsLY87M3bhUu5GumkdGYfGJ5hRb/9
	VhAlYlfW19p4qoqO/bPC/SdNZ3IwdScLQom1GHMD7NTqE8DXghQv7AGTi1Oer89sgJ8xopUewQl
	Ul0FBgkgmVtBZimdktf9EDNvi988sHl59
X-Gm-Gg: ASbGncv+vMXrGexW9QfO4m2byhARlPI0KYwI0H+CFfFq7sZPTVv+Nx/BKhla9+bPrdr
	N0OvFrSE7K7nt4d8uC9JY4FfV1NVZwfIuyep3Kjjda1a/6iloSIFwHoYPHCEksE6i
X-Google-Smtp-Source: AGHT+IEts0k8NBiyO+thYjEiMK042k+33X4Aooaif2LC6ypV/6jdQLW8bahVwNZqScLYNV33sLnd3tDbus7+Gwpvc6o=
X-Received: by 2002:a17:907:7eaa:b0:aac:439:10ce with SMTP id
 a640c23a62f3a-ab38b2cef0bmr2611572166b.27.1737632753115; Thu, 23 Jan 2025
 03:45:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123101110.339337-4-u.kleine-koenig@baylibre.com> <20250123101110.339337-5-u.kleine-koenig@baylibre.com>
In-Reply-To: <20250123101110.339337-5-u.kleine-koenig@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 23 Jan 2025 13:45:17 +0200
X-Gm-Features: AbW1kvbb_N_GsPUdnrHfwEynRD0I-fpvzVEOHvhgNuQYmg3kyuKk1dLn2hL8SH0
Message-ID: <CAHp75VekFNu8Jzfit5euj2pKeesGHs3DQS4hJdT==RM7MONb4g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] pinctrl: intel: Import namespace for pwm_lpss function
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-pwm@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 12:11=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> The intel pinctrl driver can provide a PWM device and for that needs to
> call the function devm_pwm_lpss_probe(). That function is provided by
> the pwm-lpss driver which intends to export it in the "PWM_LPSS"
> namespace. To prepare fixing the pwm-lpss driver to indeed use the
> "PWM_LPSS" namespace, import that namespace when used.

...

> +#if IS_REACHABLE(CONFIG_PWM_LPSS)

> +#endif

Why?

--
With Best Regards,
Andy Shevchenko

