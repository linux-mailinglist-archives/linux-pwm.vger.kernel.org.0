Return-Path: <linux-pwm+bounces-4256-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BE29E5B4C
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Dec 2024 17:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C83D31884DAD
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Dec 2024 16:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE8221D5B3;
	Thu,  5 Dec 2024 16:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="3ZpoIMZn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D1121D591
	for <linux-pwm@vger.kernel.org>; Thu,  5 Dec 2024 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733415902; cv=none; b=ZLWURPSPYzw2hmt/oyqDGCa4F+EC4t/KsmM4vmlNVaKQDbd0Wns+h1hDBk8xQQT8rLhIxIbrAZ2+72crI7A1x6nchzfR46sNSnhtyiu+P5d2Glo6sqLtRjoWPREVkvAU8SM99lXxxRSs876f3Z5E5VWl9mRb3EDc/BWOwxwIDnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733415902; c=relaxed/simple;
	bh=R7CVb9LI65y/3Qu32CYYXvSxOe5U0ZYewJNDLJ5FwCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FM5HR8Pgp5Njq4Wo339ucuAt8Nn0faem34HwYyOssFDbeN3+z2ymfGJpKcUE1oqONtINhTSZYXTiBy+xwexXuqVoNuYqpIhtnaqv9KezOdqCJ8DPki6Rq1C5Foabpl/lhpQB/C5JkB/doU3fl6Snfn1/Rjjltk1ho7Dea5f8K5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=3ZpoIMZn; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53e203d77a9so1020582e87.0
        for <linux-pwm@vger.kernel.org>; Thu, 05 Dec 2024 08:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733415897; x=1734020697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItHEVA7I8S1EP8oyTKl1F93KEEHRVDFUauUtw/1Acb0=;
        b=3ZpoIMZnwjCl4Vv5bu6PGSXVdDmY7k4Cj1zgHc6F/cvtw8CM1rNR1LTJDsCfgmd0g2
         BceSlvbQiLyYiwl1rdWJ3jv2Ns4UxCWRnsrFu4TQEusFPgx7FkT2UIodCH6L3llBjvZX
         XNAHzd6Taqadu0P2fGi/yUIsqcbc2LJaCMf0KU5YlqUl8Ra8J04m6hedyjqo7k0PtBfa
         YzZpvhommBUg5ON/+IUYW1PeMHGPsGOGeDu3G435iCu3IM89jIWqEOC9Hd0bT3dOemUj
         +5wiSeoDLmTU2wBbs3vqgyCGSboeppp2+z3qZoXORDMgU0UpKaORWbQqfQFXw+JpXtdd
         NE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733415897; x=1734020697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItHEVA7I8S1EP8oyTKl1F93KEEHRVDFUauUtw/1Acb0=;
        b=ZBNcdpbX5AyHlr4ode+aWAnGmr61Kg0ceh1XatH0U28fvslEgQktt8QztWbojmW1VA
         g/AgUeF+lx2pmcFdU4gu2OhhfpoFH+vDk2MbdpZ241HhQncvT2V0sUunAVaO4CxT4hea
         I7HCXPeOqmAX5f7KB7RuMxnScVuOuEW9lkTmVSZg9taoSZ5LvbcUMaV/Sglec9SUVh4s
         9JI5LMLuFMSxcn0oGZEE6D9sBL4cLXlCYW9Q1qGps2qkvyA8paneXXuz9dJZGZA97tad
         kIUiOUXMGbKS6ZvMqFrRT4YjbEu8OjQLScQjgY68wm+ZZGOgB3oNMLbg0lAX/pgJVEkT
         7Dpg==
X-Forwarded-Encrypted: i=1; AJvYcCVQyAfIdL/1r7MdzPixtMug/oN+ZHHGLUjUqKasQiRGmgNXmO1fLmpZV8d+yu+glM9IreZzoBkhIts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx71gO0P3egg3Fxx1QW3Uhp3CPKXKAEFsX7Lbnuf9Uxw8LdLHey
	1xrJIa4YnuccKcH6FK6YEurSMvamY9Rft8YTh1cRhCY4I6H1lvHySg8ZGcZZZaYT3BlJ09Rycnl
	G2hswJHtMIjyEWCXfiNeDXDPXvxB6+JFWao8omQ==
X-Gm-Gg: ASbGncsyRyz3RwSDyDxVPrNYWv7yPLHlMOAwysyk7i25iDgAokcJiKp2umNbMfw/RpR
	wV01K4XqrwQIzvCHFnnhccqt9G39CYz60J9FFd57RKPXGEiT4MxZgsX7FdI/BfQ==
X-Google-Smtp-Source: AGHT+IErYJU9bnmgh/S4XgU0jcrMWfkUEiJSX94XfyJ1xliCjLlWQwaDM6P30GxT6teJ6fjjXCYzQKweIZQ1ynm3Yi8=
X-Received: by 2002:a05:6512:4006:b0:53d:f6bc:23ec with SMTP id
 2adb3069b0e04-53e216f74ecmr1077273e87.5.1733415897149; Thu, 05 Dec 2024
 08:24:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205-const_dfc_done-v3-0-1611f1486b5a@quicinc.com> <20241205-const_dfc_done-v3-8-1611f1486b5a@quicinc.com>
In-Reply-To: <20241205-const_dfc_done-v3-8-1611f1486b5a@quicinc.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 5 Dec 2024 17:24:46 +0100
Message-ID: <CAMRc=Mf--vRm15N2au-zvP89obcxRuk+3OOLqFtrjgg61_LotA@mail.gmail.com>
Subject: Re: [PATCH v3 08/11] gpio: sim: Remove gpio_sim_dev_match_fwnode()
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-sound@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux1394-devel@lists.sourceforge.net, arm-scmi@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-gpio@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
	linux-hwmon@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-scsi@vger.kernel.org, open-iscsi@googlegroups.com, 
	linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, 
	netdev@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 1:15=E2=80=AFAM Zijun Hu <zijun_hu@icloud.com> wrote=
:
>
> From: Zijun Hu <quic_zijuhu@quicinc.com>
>
> gpio_sim_dev_match_fwnode() is a simple wrapper of device_match_fwnode()
> Remvoe the unnecessary wrapper.
>
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/gpio/gpio-sim.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
> index 370b71513bdb529112e157fa22a5451e02502a17..b1f33cbaaaa78aca324f99c45=
a868e7e79a9d672 100644
> --- a/drivers/gpio/gpio-sim.c
> +++ b/drivers/gpio/gpio-sim.c
> @@ -413,11 +413,6 @@ static int gpio_sim_setup_sysfs(struct gpio_sim_chip=
 *chip)
>         return devm_add_action_or_reset(dev, gpio_sim_sysfs_remove, chip)=
;
>  }
>
> -static int gpio_sim_dev_match_fwnode(struct device *dev, const void *dat=
a)
> -{
> -       return device_match_fwnode(dev, data);
> -}
> -
>  static int gpio_sim_add_bank(struct fwnode_handle *swnode, struct device=
 *dev)
>  {
>         struct gpio_sim_chip *chip;
> @@ -503,7 +498,7 @@ static int gpio_sim_add_bank(struct fwnode_handle *sw=
node, struct device *dev)
>         if (ret)
>                 return ret;
>
> -       chip->dev =3D device_find_child(dev, swnode, gpio_sim_dev_match_f=
wnode);
> +       chip->dev =3D device_find_child(dev, swnode, device_match_fwnode)=
;
>         if (!chip->dev)
>                 return -ENODEV;
>
>
> --
> 2.34.1
>
>

Please use get_maintainers.pl to get the complete list of addresses to Cc.

Bartosz

