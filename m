Return-Path: <linux-pwm+bounces-4884-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5553BA35B48
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 11:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B81BC3AC312
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 10:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBED257437;
	Fri, 14 Feb 2025 10:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="B+TmeMG7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A61256C62
	for <linux-pwm@vger.kernel.org>; Fri, 14 Feb 2025 10:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739528100; cv=none; b=RtLmneok1ve0/EsGBKoCBEk5BmfphOF3XX/wxF1GLm2XF76s000UHdme2Ye+NbG7b04P39GN74/uo+TcElCYm/HAYjMRSTY5MWq8q/rn1F1ZkHUKe8SLA9vpPLvfHjS3DbGe1wYs+pw+P4+vTOMVuAlJPNBiLc8Wg46I5TR3iac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739528100; c=relaxed/simple;
	bh=96IUlvA4Kab/E8aWKKJlXMsjG5KwQVnXCwIZK25zn9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YCy37B1ajdbwC/ebdzLzLyOMbQnRIA4JXnetCuUGB4NrVZpJPMhpFVGn4nHoVFNDv4FFfbkGv06QNJrbwAPC5RkvPP5p/yXspzcKCQMXn8wvbAj5CJ1Pm+U1QEksMhBlg2xC/QLsA0D0BZX5NxCUPgd6YiY9blvUTzGAac/QYfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=B+TmeMG7; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5450475df04so1879179e87.0
        for <linux-pwm@vger.kernel.org>; Fri, 14 Feb 2025 02:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739528097; x=1740132897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96IUlvA4Kab/E8aWKKJlXMsjG5KwQVnXCwIZK25zn9I=;
        b=B+TmeMG7fChE+5sf5xiiZZNZjtKynx3/vb2uM6xsOuuI4xcwSKb2M7EhOdwZ0DqBhc
         a/lspK+dm+4XaaOwpAr38tpgV6tRkMGuUzmCMIPibqUfJekZ3Gk+fDmwD6tgsalvkl0m
         cYzslemXfpyKPqezcPV9Ku6y6LNGyH9ZepaYOTAA1J0WHV0lh3TLOQPJwAFE4lkx6DOz
         VkI7Ia+Z99BjX1Bs7P9Ks9xu3esMlb9wQrk9nBeyXKCf0lTNfQhKVo5JKiXzQvBUaHrB
         jTBDd0VQVuLr6qHNgl1essykKGo9K0j2+KLHvk3Eh9qUCXOuvm5hpbFKx4BF2KaT6f9J
         faFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739528097; x=1740132897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96IUlvA4Kab/E8aWKKJlXMsjG5KwQVnXCwIZK25zn9I=;
        b=aTpYsgbCvtXss5Bvn40ldShWjLDRYmKgRQC6clg7RVLOfYmr2NALRrF0391RhuGXej
         g+JrGtgEgrQz/oi+FURML+Ejy7vM2pLiI51roqa6N5kyX92HHkAJur6xXclYX6NKCTu7
         vgRfr/s7OdmUTy57VUTgR84FbWumWsKjqXvhC1Mhq2h+wQGeGEiLEyy3qnF++YxbzTHJ
         ml51WCN/fv6Qf9+V9adwBkeVDNbVTDRtdlnvJZtyEk0Ygyzdmg0oHwLbf1ibbHD+9lNV
         MRVrHHCEQ2VgMc7vxSjeeVbCBxPvUwpVJtlIRDkFVKRYhPKtJyoHf5ngxnDHUXGknQp4
         vJIA==
X-Forwarded-Encrypted: i=1; AJvYcCWxdRR/4+xqALslIglfaMyWnOheRx/YGkUhOFG8We9e+8wbMgp4bdue9jthsco2S0uEbF7xJq7//70=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsy7GrH4SWw5z1wFUM0+L9/8QEDcyrG0podo6O8XUquNE1DvPm
	KIyrOs3+DQv8Parn9J5yYFTRVA3djonFQmZQYcPbTej49mzG474facVc1qiwPRFkTnh/KnVWsiI
	v996FirqLy9dRNeUiz8qHr/MQUDjXTAjLe8+CQQ==
X-Gm-Gg: ASbGncs6P86n+HChynPSgAV2FdaPT93z9A3oVmZUfXgXcutYXZLVBxpA6CGPLVawdUU
	IkcMiZuYjPQt/FJd7Vj+AQvJJFGVYrqMT7+kRqU4ZZZlOAxOKowemH6jtAV1TClEpINyGYB8cPv
	5YAy+7EQs3KVoNR2clXzejfbHNuFo=
X-Google-Smtp-Source: AGHT+IGIHT58DThOkHUQCnE0Th1WDTQk4pOddXfAj+W59mKK6nphQZOjUH2rQySGLrnHMOPeaMVkwqsD4JIkTWJHbzc=
X-Received: by 2002:a05:6512:230d:b0:545:c51:4a0f with SMTP id
 2adb3069b0e04-545180ea93emr3217951e87.4.1739528096595; Fri, 14 Feb 2025
 02:14:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211-gpio-set-retval-v1-0-52d3d613d7d3@linaro.org> <CACRpkdYL4odi-00YDi-cFuVgw8uBncA+ZxGYnRRhuYR7eZuBWw@mail.gmail.com>
In-Reply-To: <CACRpkdYL4odi-00YDi-cFuVgw8uBncA+ZxGYnRRhuYR7eZuBWw@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 14 Feb 2025 11:14:45 +0100
X-Gm-Features: AWEUYZlEKbgfCg5LM4mAcnDmuKyPgH0ZcuCi6oqVDIjGsTxRu9-K5fCxAVSS7C4
Message-ID: <CAMRc=McEgpm+rafr64N-NeOEqk9OzwaEb=7u5ZXQ6vwnQBgyTQ@mail.gmail.com>
Subject: Re: [PATCH 00/14] gpiolib: indicate errors in value setters
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Michael Walle <mwalle@kernel.org>, Bamvor Jian Zhang <bamv2005@gmail.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Keerthy <j-keerthy@ti.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 10:56=E2=80=AFAM Linus Walleij <linus.walleij@linar=
o.org> wrote:
>
> On Tue, Feb 11, 2025 at 1:10=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
>
> > The value setter callbacks (both for single and multiple lines) return
> > void even though we have many types of controllers that can fail to set
> > a line's value: i2c, SPI, USB, etc.
>
> Yeah this is a remnant from the design that was done of gpiolib,
> at the time (by David Brownell) assumed to be simple MMIO register
> writes, so not much could go wrong there.
>
> > This series proposes to start the process of converting the setters to
> > returning int thus making it possible to propagate any errors to the
> > user.
>
> My worry is that this project will be another one that stalls at
> 85% completion (like with the eternal descriptor rewrite project)
> but I guess the upside outweighs the downside, and I also trust
> your proven grittiness so:
>

Unlike the descriptor API, the changes here are quite trivial. There
are about 350 drivers that need changing but can be done relatively
fast.

Bart

> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> for the series +/- minor nitpicks I may send that I am sure
> you would address anyway.
>
> Yours,
> Linus Walleij

