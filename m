Return-Path: <linux-pwm+bounces-3606-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 663F499AD13
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Oct 2024 21:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FBDE1C2214E
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Oct 2024 19:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC811D12E5;
	Fri, 11 Oct 2024 19:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l2LSqeHN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ABA1D0E30
	for <linux-pwm@vger.kernel.org>; Fri, 11 Oct 2024 19:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728676130; cv=none; b=dsAbMzPyYzT8VwC1Qk3BYAFXW5OHOgZOPMGFVDOkMXfhz2piaSQkRt8y763zGZIjLrkKfy5rOW1v92O4M+rxmgG67/41qqjc3j+CL57BAPCAL/zQGvYwvMvPq7LF55HYGu+Lb8DRe/22qJouH+KPALDfj/K1b//n929TekXq9VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728676130; c=relaxed/simple;
	bh=nPrrWFEkh/n2rwW9DN6U89zucgrkrCgU+Jm4I59wVB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J5SZBwpplRtsrFVS2ka5hw2uIs5lfAQjwqoqxlp0AvDUZ2U01aHZJPZHnUdfHcxltqm6yM8zPyyKpf0ymy+ViLHV7LcujKbjKmM7cKJnCF32TAa3PB4cEaAS9SRY2G7fBvVduERJXPqW+sSthpBV5xGKsHA+B9CVl6fl5Qu+WYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l2LSqeHN; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e314136467so22524937b3.0
        for <linux-pwm@vger.kernel.org>; Fri, 11 Oct 2024 12:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728676127; x=1729280927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPrrWFEkh/n2rwW9DN6U89zucgrkrCgU+Jm4I59wVB4=;
        b=l2LSqeHNrPE8sEGGeFbmBXTt2+BCxSfXWqfmcyRwfoWpuCUCGvJZeAVYNvR+ykUqCo
         b2iWibJH9z/PuViVNVrbkz3JsqsDTpapSVPLE4xBFVOaYhlWzpKTa8U04uVFtpMYqLye
         vMUQUrsNIF+4QW7XJXkL5HJU53ajZZrtPxQwgoEooi633B+bLzgJw2iSWpgle8aiJ0P4
         xeEmAeUs/UicS5gbtoZrj1dU6xARWJVxoiFziGx/Dfd+/c5ZLUlMYr2gzX48si58AN1W
         HMzDT9BSoJEvswGkJqwyhG1HHR4/0TGYmtAys+Tfc6Wd2BeMpQY/++pvLue6LyrFVmNF
         GEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728676127; x=1729280927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPrrWFEkh/n2rwW9DN6U89zucgrkrCgU+Jm4I59wVB4=;
        b=F5WHeiHVNmw2aa04Hs9+kqzjFO/Ei+MIyJzKJx/EERJVw6tgMNmKILtTKI0Bg8vqUy
         8en6trWVFBrDze+//L+UhCtiWfeM1wCbFkb2G40CV2XIm25uc+5IBqxvlMf4Ocvo5eL/
         aEGEFpZbJqX/hFEkZ+CRJUlMehvnPCzuN5MMTIQepeFiUB2ksUAp7DWzBvt4mka1TJ+0
         ow0cYDuLV5T7euh5TEWmEgBW7tvnN+jRIJnFU9nPvlBwLNrkaMI7VUKq90eercLDEsPV
         2hfL5DaePKkALXDLhmPEyhqLxEtALN+zsPX5++8LzqCsUOok2KVKiAbriyt6dU8HMxOJ
         O1PA==
X-Forwarded-Encrypted: i=1; AJvYcCW6kvUqZwH18Ew9HuhfuYL1syTkIoBC24qhd9inDX49xaZK8UViBRZeSBo7f4N22dfh84txcGuOBq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiHl1CGQPL0DmaY/Ak7JXXavc/xiZtkP1zRBpJ5kUI+uSjn/No
	GJSbXRZFRDw0C8LtTSN6S2ixN/708GXxuGeZm6RpAS+0Vlzu//SfCKOEfic6VsEYKvBrcTCC2YJ
	3youzA1+48n9ofyX0FVBMGCruJE6HB8eSHRdH2A==
X-Google-Smtp-Source: AGHT+IGcgArKV9Ezyx2JxXIT5g/tpC2AAQqsWGKx7COvsSQwXw4Ct7g3+6rTQ0Ix418MqQv3uMJC5A57ho9IASI8Obs=
X-Received: by 2002:a05:690c:7442:b0:6e3:1d8c:1224 with SMTP id
 00721157ae682-6e32f29c8e7mr61767057b3.20.1728676127524; Fri, 11 Oct 2024
 12:48:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008081555.23465-1-brgl@bgdev.pl>
In-Reply-To: <20241008081555.23465-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Oct 2024 21:48:34 +0200
Message-ID: <CACRpkdbO6cQL37DNozuePACe5nT-DWgzrrBN8SLEYzrFrJKXPQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: mvebu: drop dependency on OF_GPIO
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 10:15=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> This driver doesn't really depend on interfaces from OF_GPIO so the
> Kconfig dependency can be dropped.
>
> Suggested-by: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

