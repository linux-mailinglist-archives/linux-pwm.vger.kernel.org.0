Return-Path: <linux-pwm+bounces-6927-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C633B17FD8
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Aug 2025 12:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2A61A84210
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Aug 2025 10:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB40320E030;
	Fri,  1 Aug 2025 10:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="oRQ3WxiZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40FD43169
	for <linux-pwm@vger.kernel.org>; Fri,  1 Aug 2025 10:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754042457; cv=none; b=PA8s8EHQ1AsKwwJFmkZL2nJTejrntu5u+dW+e0qWVHS9FLlxzqydhLObvS/yUs6hHg8xaU6yp2qGEDGqKa6geX7QpSsZd9GMEU9DHriOMCH1M6DwULmehw4/GTIcVthTGklQRJIA5BxhFwxqH7s9fwSGUvGd4/Z7OhSWVVDM7Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754042457; c=relaxed/simple;
	bh=4XYhOafYN+ZHDRA+V7FvzuQA5dE7qf9zd85mMyDYO00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VFGWDA8ZUiqEJfGWnboYJb3SelTg68AzJ2Mm8FNJ/UPNIbKCRcK0a8uEt97xIUpPOSF4nRmOacWHKo8qSKUMXE0V56VCTLkf3uxSlNQHgnzcT5X5ddSFF9UwP+MQFdwK/p0YGRnn9LsHuRuOJUvPfEQR7a84lrcK/Sc2oNAF+n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=oRQ3WxiZ; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55b80332144so2134510e87.1
        for <linux-pwm@vger.kernel.org>; Fri, 01 Aug 2025 03:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1754042452; x=1754647252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XYhOafYN+ZHDRA+V7FvzuQA5dE7qf9zd85mMyDYO00=;
        b=oRQ3WxiZ5Z16m4oVlBI8RKRve+08ln1Of9iL087TJNpKt4CB+wxtDO6KABSZGWzRZL
         XlIMO8gJKmtHgNqgtmzC71QuUwzGAY3AoajM5QEqdPdhnALuc1f66VTQARROrklQetAl
         NBcGyMhpVF6khZZitTANN/W/+VbbI7mynNQCsrKqev0jJz4E29VrqaR2Mpe9Y7SNb8G1
         adOuvl9F6QZ0g31pg/GloOjow1yUKSaE2unrgSpyzmVYxmzp3mtMW/n3OMlDnNgXIiCW
         0d16lIfac/Yd9X4JEDWFN7gNtaxgOAQ32xrlZYWqqKmkDSGOjNTk7kgby6w7yRbVpvrS
         8iOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754042452; x=1754647252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4XYhOafYN+ZHDRA+V7FvzuQA5dE7qf9zd85mMyDYO00=;
        b=hfyI7Ky+rUbnZ8S3NEMhLx4WN/10UFO2ZxMQ8s/I5QMyKZ0vSxnvY0mvjlWPW+O48b
         uIMeX0XTZzGCstl43guW6KmeV+oCL/Nx4zVM5cUnHKx+BNzH9FMYo4GtxCkVwtQC1RgE
         96xlEHZXOvV/jBeVNSAbwZ0R6IU2v2g4Lx3u+L8mXETzUDFIJ6TreZP+ubNOzKF5oHk6
         FSKlmbHHymioKbgyS49s5DvA/H/i12rujmWO6K+vx5s+Q5nnc8BXtZk0D1ASH7dxNHhr
         V2pyBsuiK7Prz7iigxuTYxqLw2HaDBMNHgmJ9IULaPtHoKWkxuqCSrAgJXwGt4XQ18Ts
         jQMw==
X-Gm-Message-State: AOJu0Yx7Bu0fCpWA7z2ILRb6RQQDEF74YMn8167Vs/2rc8j1SGluSIGj
	Uh6FSlgNkn8FiXC3m9k7dlgOyxXrNvtHpMlETmthUmkWmtNHrqTmyQmcdEqCM6xhEARmwHqx2bi
	qq7aTshuerno8kI7OQUOKhSI+D+JaCr5PnrM5lqlOUg==
X-Gm-Gg: ASbGncuC0mzO9oWXuph4pR9UFO5Tw7kMh4ETkJSF5w1utQ5SQmAmhYADd6/qFKAdAeW
	/mY3UTTqIL4pVwGlCYHYh2weYrK716uQYcUv+TAog73nzlUQbIu2jFptp1qkzy/K8DNcaCGhwDt
	QvGUo2kV0QEG9MFy6aa81teTdeYGuJ7mlK2mz3P/86OjYVtZDLLlbrhHGkXGuCgMFL4tJ4bPoww
	oB58Txdx8QAzoxJLQGH+aVaq1ecEOYz1taVpG4=
X-Google-Smtp-Source: AGHT+IGsfrj9/UcZZ3IT9iN0ClFRP1dOgRmNT9aB9KdZPdUecIUpJsmwJ7SM430Goouo+yALYiWE6n4XHTxcPyFccvA=
X-Received: by 2002:a05:6512:6089:b0:55b:8e2e:8cc7 with SMTP id
 2adb3069b0e04-55b8e2e90ffmr768638e87.42.1754042451689; Fri, 01 Aug 2025
 03:00:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717073859.1777226-2-u.kleine-koenig@baylibre.com> <yr7eydif5mguqpflydthhigpsenfum3agqie4wufbf3624tvjb@3kog3guxiwin>
In-Reply-To: <yr7eydif5mguqpflydthhigpsenfum3agqie4wufbf3624tvjb@3kog3guxiwin>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 1 Aug 2025 12:00:40 +0200
X-Gm-Features: Ac12FXyybl5vv3P0ZuJnGuswI6rYy8pXe3j6y__RU3PEiUiKTCeBq9RQGvo6Nl0
Message-ID: <CAMRc=Mdz1b4UxtQBTc2j7HjQQDjxmwODjZSEhfmiOMnJ4aSZPA@mail.gmail.com>
Subject: Re: [PATCH] pwm: Provide a gpio device for waveform drivers
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-pwm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, 
	Clemens Gruber <clemens.gruber@pqgruber.com>, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 11:58=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Hello,
>
> On Thu, Jul 17, 2025 at 09:38:59AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > A PWM is a more general concept than an output-only GPIO. When using
> > duty_length =3D period_length the PWM looks like an active GPIO, with
> > duty_length =3D 0 like an inactive GPIO. With the waveform abstraction
> > there is enough control over the configuration to ensure that PWMs that
> > cannot generate a constant signal at both levels error out.
> >
> > The pwm-pca9685 driver already provides a gpio chip. When this driver i=
s
> > converted to the waveform callbacks, the gpio part can just be dropped.
> >
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
>
> Applied to
>
> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/fo=
r-nexxt
>
> as 6.18-rc1 material.
>

What about the v2[1]?

Bartosz

[1] https://lore.kernel.org/all/20250717151117.1828585-2-u.kleine-koenig@ba=
ylibre.com/

