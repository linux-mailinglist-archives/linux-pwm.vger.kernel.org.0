Return-Path: <linux-pwm+bounces-1651-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE92B86A10F
	for <lists+linux-pwm@lfdr.de>; Tue, 27 Feb 2024 21:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67DDF28788B
	for <lists+linux-pwm@lfdr.de>; Tue, 27 Feb 2024 20:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1093614DFF5;
	Tue, 27 Feb 2024 20:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2LWMRG1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8328B1D6A8;
	Tue, 27 Feb 2024 20:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709066865; cv=none; b=FhNhAuzwV5gj2ZZppUV/A0c5vZ+a7JSr2CbFjLPP0iBs6nUBzlF0aCD2ZmvPief62EzPaRLHney9Jox4MgQ++GjriJJhE0QzqEGDmE9sO8T1koDA04lFd9rTWfjda9+a08nrker+XNO4QXO3qJhp8CGntG5lRsEdN7vfvt+XgZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709066865; c=relaxed/simple;
	bh=OUADjx4SOc5A1Ri6Vi34pFWMGjuDJOR9dIkKdh9E9Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=II5LfYUMn8E3P8lJyRTBp/tRZB6WCMTJ7TIfeHDZ9sOssiiPMkbvTUSvvgQZF+LhaXfqOEiX1sUoBzZEN1bkXYyDKPvxTPZHNNLM+jRyxz5FqHtji1iaOdl/slBNuklsZPwnk014XPJTl5y5C0mc4xNx22Pe44VbE/3zO/c0tJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2LWMRG1; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3e7ce7dac9so539278666b.1;
        Tue, 27 Feb 2024 12:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709066862; x=1709671662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGt7UYMc7sk+QFfwDQiPohUDlq3sHFZgI2iybV829Cw=;
        b=h2LWMRG1+9ta7VhBZAdd+1og1b9wLoKe3ta/oLvTSUL093h4cJi0HEVl8vAIaIpMmF
         b9WFachrujMnx6+VGBT+5fAKo0bfgtyf8CqD/2DaF6YlWjsx2R+DOk+6/WgrmswEbw2P
         3M/m3+mEDeok7x1gzQrfJtgCZxSLSDvV6exRG8RXYafoTPFKYRjiFdjKxU+OMDt9e1c0
         Dde0kR83F4Xh0IkWmYAVZVGx++HJ99RgimXYRnUMn1SCN2NlutpWEKvAOEjGkoCY98Uz
         dCAYCO+RrrsrOKvq04nLQ9dKXBpB921z4QsUJrkpWdFUdLziiBKs/VXFWJGTLfvmJ1OK
         ODpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709066862; x=1709671662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tGt7UYMc7sk+QFfwDQiPohUDlq3sHFZgI2iybV829Cw=;
        b=VIqIB1Iq0bVQirGFSgXN3NvfKhiKXcnm5n4mFk0SgAmdPAIJCuPZ47KupoWTKmn9BQ
         NHcN33bm+1K9F9jTbBjlht0cdy4kdMUdNGdUwmPopsnRFw+UKkNnOKAszZ789nT3Aquo
         mdv0oPdnNjJgeDJQM5NMgneNyglcOaoEY5GwVbcJPoVRenGZH/3aAsvo4+R/VfqxPUbH
         TcPA5zf7wVVvBAxtnCimxfnm1E8wV51JWK9X9hzU3Oeuh9KJlJj2oUiuAemFWiXHpTeq
         YGt+2UrS76E0ifKFx3mNG1/y+Q8qNarWDXQjJgUu0j7P/5OFxGeTPagUdrvIRT3x+hVP
         8Wyg==
X-Forwarded-Encrypted: i=1; AJvYcCWRyNjpuzXM1HyVeieTJjLWshAp4NLo28E0+jPs6eKs6r+TjVunxLxRynL9TtF0C6qAOG0OSDH5B6GcLJ8IKcEsgC7vSyCbRkYg1BtVsztB5krjPB97bfj+ybmz9sr6euON8UXmrC/g8011cW1z5o16GJWItpPMt1y0UXDQTq3d/eo=
X-Gm-Message-State: AOJu0YyfkA60Pcg099GV+8metVyKNwnniRtvA9ug5RREmBsVAzpt7enM
	vMerm3SHYtpHataDYpolbBUdaigzuzOsQrjd5mhJ2tlLHcUa83VDgmm9D5c2SXXBVWDz998sjmB
	icGT7FYm8CXU7RpKulLtp0S0wnZU=
X-Google-Smtp-Source: AGHT+IHEN2PWdgzpnChJ+QhemSSTknAuMPhJxhSAphB3nWS/x+S6z+kPZLBlofJjhUMYYoqgmKMj9fhnK/XhzPyrKWI=
X-Received: by 2002:a17:906:4bd4:b0:a3d:994a:791d with SMTP id
 x20-20020a1709064bd400b00a3d994a791dmr7669046ejv.59.1709066861803; Tue, 27
 Feb 2024 12:47:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204220851.4783-1-wahrenst@gmx.net> <20240204220851.4783-3-wahrenst@gmx.net>
 <Zd4QpBsyTnuM8hwt@smile.fi.intel.com> <4a6d8417-402e-4d40-96c5-15c2f1dba887@gmx.net>
In-Reply-To: <4a6d8417-402e-4d40-96c5-15c2f1dba887@gmx.net>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 27 Feb 2024 22:47:05 +0200
Message-ID: <CAHp75VdLJi2eiFmwjskMmp2adG8k7zO5aDRb-5=4eQKHhB=PXg@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] pwm: Add GPIO PWM driver
To: Stefan Wahren <wahrenst@gmx.net>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Angelo Compagnucci <angelo.compagnucci@gmail.com>, Philip Howard <phil@gadgetoid.com>, 
	Sean Young <sean@mess.org>, Linus Walleij <linus.walleij@linaro.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 10:25=E2=80=AFPM Stefan Wahren <wahrenst@gmx.net> w=
rote:
>
> Hi,
>
> Am 27.02.24 um 17:41 schrieb Andy Shevchenko:
> > On Sun, Feb 04, 2024 at 11:08:51PM +0100, Stefan Wahren wrote:
> > ...
> >
> >> +    if (gpiod_cansleep(gpwm->gpio)) {
> >> +            return dev_err_probe(dev, -EINVAL,
> >> +                                 "sleeping GPIO %d not supported\n",
> >> +                                 desc_to_gpio(gpwm->gpio));
> > Do not use plain GPIO numbers.
> Uwe already complained this, but i didn't receive a reply on the
> question how do we provide a useful log message (reference to the
> affected GPIO) here? AFAIK the GPIO names are optional.

You have a firmware node path, also you may add a label to GPIO, but
it's unrelated to the message (as it's constant).
%pfw


--=20
With Best Regards,
Andy Shevchenko

