Return-Path: <linux-pwm+bounces-1100-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A6083F299
	for <lists+linux-pwm@lfdr.de>; Sun, 28 Jan 2024 01:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11F94287610
	for <lists+linux-pwm@lfdr.de>; Sun, 28 Jan 2024 00:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92CD1361;
	Sun, 28 Jan 2024 00:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PaIY0Vx9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C325EED9
	for <linux-pwm@vger.kernel.org>; Sun, 28 Jan 2024 00:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706402314; cv=none; b=akl8TYywELe3Tgw7jX7LtyNLLcVvWwYoGIuCy+OVzboW7RJntxjNkXoi7zPJ5zNbC4qCFSgsyYoDV2Y0TuHwTqOz7OLeXCSNc1l4ts6XmRA+41bUl/Hept1oIRF3Ayw8B35oOzZVgvZ2GXPI3tJXSfxiQm3GTFTR6NbDOA7ps4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706402314; c=relaxed/simple;
	bh=20VxjnC/DVrpafsaGFXR/BO6pfT9P2BzgGcsskAYZw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MXEpiwb4ew/xwjrfovqoYfKVa3WRpxmmBPs+pD0+WYupOWaaa71SYSdWZnEurf38xUevbGkAknPaAJBWsK647FXmnM1Pjy3OIshilUnDBg05BfvUi0lw8NA4P6vnD0v381aHRLm5UyAyNDkZAV6dHK8OT5D7Ta381wXYF+i77oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PaIY0Vx9; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-602d222c078so16892047b3.0
        for <linux-pwm@vger.kernel.org>; Sat, 27 Jan 2024 16:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706402311; x=1707007111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20VxjnC/DVrpafsaGFXR/BO6pfT9P2BzgGcsskAYZw8=;
        b=PaIY0Vx9lf07f5eu9wJaQhMrzlP6dw9ZLA1WMyvB/nT5RDUynOZ07ci0RtN7+VUVcD
         A7+Z9JgZRL3Fn5TFH2KfULMtFnBm3ycpYJLzJ0yAnjAcOu12BRrD6pH+kTB39fL2iIJl
         o84DSHw673ZnyvauVJvtq/mo2chpldjH0LwZNM7+fC16TlTJZtF+ZiEqyVNuJLlDcZix
         Zj0vxknajYrXxh0haUANUzz6gQrkfzezhPsMr6gT8EvLGflGUxdL5qFZcJjcsS0QAc45
         uSbWHahi83x7Dn2TpTAyqRXZRPEsY6y9vpKQJuECD1s3KxDg9Ycms7ggtkxBcFy0A2oY
         hJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706402311; x=1707007111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20VxjnC/DVrpafsaGFXR/BO6pfT9P2BzgGcsskAYZw8=;
        b=FL6vaa2cxhzVdFnLuoiPwRnO7r0jRh1SztrlQdxN0B5Ldqi7HrcMhCP/gj/hQzhmkX
         fQVkV78D/wBg9KQ6UFPbJ9GUO2W8UZwKGgjd+1JyG+arr56obWJJsyLZ2C7MRvnsRmoL
         JIOnE6NB0p9DmQ9RESv2saSfxmm3a1zCzMG3vdKCME0OlstOF8Ou3cmgOEEfRP9kVC2q
         rgDqZF5GPStHRM3OoZ07HFawiehyY/8jRIwtWbWtk7HG1B5Rmw1A88VFmp542u4/kFqy
         eytbEhfWLet8uf6/Sqv1IRRp+H5oBhhV28+aZkhUBvF3HN+zSPqIVlvvg4N4f3Fb3LCf
         4jlQ==
X-Gm-Message-State: AOJu0YzUu/aiO8qSXyIWsq/YmR5uYxKuuQy6+X9uaoNqttJ7xCLU3K6v
	Lk0vjR94nPPtERgeRawrbO/SArC90HNmUDPowGjUUpH26HcYs9Wkf+NVKjq+qff+Ca9W/VGx/uf
	Fl5/QgMb1GULT7eMGXCBQFVjWBkLr33C8LX0SUw==
X-Google-Smtp-Source: AGHT+IExuIwhWtdXw01jLakexqA83EomdUNsNnPHCThjyC2O3H+JirNWs6ck0woxBKXEyprueNCLRn45ZryZ7l5hqjs=
X-Received: by 2002:a05:690c:d84:b0:5fc:d2aa:c792 with SMTP id
 da4-20020a05690c0d8400b005fcd2aac792mr2773628ywb.53.1706402310258; Sat, 27
 Jan 2024 16:38:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5521796b-d51e-42a3-831a-7fbf75247726@gadgetoid.com> <bd2771f5-3452-4089-aa00-34663a64513d@gmx.net>
In-Reply-To: <bd2771f5-3452-4089-aa00-34663a64513d@gmx.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 28 Jan 2024 01:38:19 +0100
Message-ID: <CACRpkdbXJkS8Amjj_wmSNF+n6=cWEocZo7mj33H0w40Sdxn+xg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] pwm: pwm-gpio: New driver
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Philip Howard <phil@gadgetoid.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	andy.shevchenko@gmail.com, Angelo Compagnucci <angelo.compagnucci@gmail.com>, 
	linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, 
	Rob Herring <robh@kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-gpio@vger.kernel.org, 
	Nicola Di Lieto <nicola.dilieto@gmail.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, 
	oliver@schinagl.nl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 8:37=E2=80=AFPM Stefan Wahren <wahrenst@gmx.net> wr=
ote:

> i was working on this a little bit during the holiday. Personally i
> prefer Vincent's approach [1], which is easier to read and more
> consequent by rejecting sleeping GPIOs. So i prepared a WIP branch [2],
> which was tested on a Raspberry Pi 3 B Plus + a cheap Logic analyzer. So
> maybe you want to give it a try. I will try to send a proper series soon.
>
> Changes:
> - rebased Vincent's last patch series on top of Linux 6.7
> - cherry picked some improvements from Nicola's series
> - tried to address Uwe's, Linus' and Andy's comments
> - tried to avoid glitches during probe

This looks good, I guess you will just squash and send it Co-developed-by?

Thanks for looking into this!

Yours,
Linus Walleij

