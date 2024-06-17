Return-Path: <linux-pwm+bounces-2493-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB31990AC8A
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Jun 2024 13:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB3771C21216
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Jun 2024 11:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E33288BD;
	Mon, 17 Jun 2024 11:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YElRHHtu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD012381A1;
	Mon, 17 Jun 2024 11:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718622089; cv=none; b=g6GOvI79RJOufNyrJFsSyDe1yHFWm7JRPLdvUVqsUFoNYg6soG3K6J0y37ti7C+7EZISI5pYldhwbXKpDvP7+eOtliGMlq9FFD6kK5286S5FslbpIpnvDwFgEpGSRM/CrZ0kOn9dy8qr3j1BFwQzDkhUpxlcQ1d+1z66h/544mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718622089; c=relaxed/simple;
	bh=aXrsEorqV27TsaHzSIp9daL/Gd1q/102esAXS6wbGfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oiiBbniChuK0Fr8zRzzbxCmaC7m7GhXSQ/NbWZX2Rcg3727NMKUQFq17GevZ1goANqHL6mM2HGVINkq0OWijG8HHEaHsu1foZphx/JpZU6oo8pnEU7nS50vlh6EDR3b+TZY5Hyrfh3LWJtlwuBQi8l4PAyxX8ssLAFZrdBeAXvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YElRHHtu; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6266ffdba8so424283166b.1;
        Mon, 17 Jun 2024 04:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718622086; x=1719226886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXrsEorqV27TsaHzSIp9daL/Gd1q/102esAXS6wbGfA=;
        b=YElRHHtuhjj5G3URe3O8BzrM+q3BuSZi4oo2toW1Yg+6luOsh09vMWwCfCpcbIq+6u
         MRPlaNkzv+PkyDaYd1XZSVDTvhuL+EHyqr+cFbW5J1d9UGX88ILG3XgKXRTlYDJgXPmc
         FF+O+2qXObJwSj7guvueBt+lsJEMW6l7DSONGlXq8bT1vLrOFME+lD16VfVLVOruXmN2
         w7TD9/GzDetek7v94WeCbd+OHYvyRx9KVZhkiMv2gCQDkW7B4camfn9DmREM5jXJli4g
         osP8W/f1PNheh/ax5DMNP9J9Fl7/aCYnO9JjknTfSogDTuDSpDrTEyEoxZqH0zlq7dSO
         qb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718622086; x=1719226886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXrsEorqV27TsaHzSIp9daL/Gd1q/102esAXS6wbGfA=;
        b=xTWdXZ4GH1tPYepd3+JzfleR9p7K1VV2PluNhO3dvM5CJioENwdd71LGNkWtsQM6dO
         pCsEs4pdDKAvKw17xBailRTYgkJUYVqJq4aVvhtYzeLIlP8uttbNJzDry6Lx0PXDnwLa
         vW6oZsBI4DfcjGoITc/oGsoVksegan0iOnfEcRBuDogj936aVMan5yug8en6Uznr7bMM
         N4bsVtnJK/ptNhwluMG3kc72Uc823fv2WeYn1vdLuLyYwEHiwlsp17r9gtJyVl8gkgAb
         1jx3W4xHCwLF5ThgO99KutAG9x2n59RbgVGuEWTscCgs4c8Qq5Dsb1liWezBNpCU19R5
         gtRw==
X-Forwarded-Encrypted: i=1; AJvYcCVWV92vMzJ/X4Tk/+JugfQk/FhAi2qgPopv2d9Nw+nE9bor/JGdWzs7S8Pg2weO+FQAcIHHG5rpyv9ZK1SkoQ4KPnfELpq47xCDSS8JfTUI5ixi+iLHDL76feYfHuGCUpE2/ylqdFqu
X-Gm-Message-State: AOJu0YwHRuRp3OjTqAv3lRoaM5FzeLTH2lbyaobJAQmBOLaTlTZZ5YJg
	/+WWE3pSvtUyDzJ4kjqGzroOl19HYFA8FeMSzrpMvSBXjXPdR5D1a7e+vXfAPAd7s27++lEXhHF
	QiOBCGyOifhGsjS+aQK4hM7U8+7U=
X-Google-Smtp-Source: AGHT+IF976uDJnhP4QDJdov/DzoJd5I4aPHLyWfc2Ahy9yFEJIdQ9MOW2yDGG1QLLjUPyFAs9Z/yALG+IIqeYIJpmEY=
X-Received: by 2002:a17:907:9412:b0:a6f:4f3f:e6d8 with SMTP id
 a640c23a62f3a-a6f60d20ecdmr929788066b.20.1718622085854; Mon, 17 Jun 2024
 04:01:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-ep93xx-v10-0-662e640ed811@maquefel.me> <20240617-ep93xx-v10-13-662e640ed811@maquefel.me>
In-Reply-To: <20240617-ep93xx-v10-13-662e640ed811@maquefel.me>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 17 Jun 2024 13:00:49 +0200
Message-ID: <CAHp75VcMS_xp6gT1OCudxKstMnF8uXE5_TXWF3JYs27k3jPDMA@mail.gmail.com>
Subject: Re: [PATCH v10 13/38] pwm: ep93xx: add DT support for Cirrus EP93xx
To: nikita.shubin@maquefel.me
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 11:38=E2=80=AFAM Nikita Shubin via B4 Relay
<devnull+nikita.shubin.maquefel.me@kernel.org> wrote:
>
> From: Nikita Shubin <nikita.shubin@maquefel.me>
>
> Add OF ID match table.

...

> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Not a big deal, but this is a bit weird. It doesn't prevent the patch
from landing upstream, but in the future just use the most recent one.

--=20
With Best Regards,
Andy Shevchenko

