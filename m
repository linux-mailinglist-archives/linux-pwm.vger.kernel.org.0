Return-Path: <linux-pwm+bounces-1604-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CE185E3AD
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Feb 2024 17:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF8951F24DE4
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Feb 2024 16:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EF1839E0;
	Wed, 21 Feb 2024 16:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="by2d1YeX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917BF81AA5;
	Wed, 21 Feb 2024 16:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708534005; cv=none; b=VWtjXFFKUS2i2g/5E+XH0x5aHQzB38TJDSYG9s54QZIYRF5x+xnOoNaFhpNIjAeF6tQDkY1TmnQM6RGTchGsz5cKxBZ8OGWN6wQ7K2bqWX7OZGHZvXhkl5wXM2qmuFhXhD26UPqCztxyMXIrv1gImBqcmH205ultMh4SpoIVuiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708534005; c=relaxed/simple;
	bh=N/zANKAOXLtJOnwvt/ZeC439Alr3gN4TlPfRDwuoXgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hqstGDMvtWnaE5fYKIv+pHjuNPBqUyyTnCDQVRQoO+HEgQMtVET/gUGHBTw8Qp/Npk9iRO+PrCFPscikwF96b09VK1Dpoy311H23duNqMM9esIb/C1TvQGXe6/V5Nkov2fvXjx7jvA6F5NCNGwcl9rjj6MzhsyCkQHig63YjL/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=by2d1YeX; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5640fef9fa6so6673574a12.0;
        Wed, 21 Feb 2024 08:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708534002; x=1709138802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FiquvFGrHOxoq2O6Kk+k8nKguDO2IkwcepkCWrE5URQ=;
        b=by2d1YeXi5DP3VI+gRFm2L8a4LP+991godd3IAXQWN6VKKl0J3Yk/s5ZuVcUfTD/8F
         oMnzNTKOUiurwy45/g00o2LtKeCmJZwXpTF5IQ44O1eoXlFJcTm9aFHmVwleSk2kEF3y
         rPmS8vMXiKkSs+MpBbfuGx9sKfnyKBLyPcV2crJcy+EYlCvCvgUXWeLveuoka9U0qkcy
         3FlVOl9/EsVjwmeiUnewknfGZ60mxf9tZqhhbdllR8Je10/41Gf/KR2ZkQWWjO+DTJG/
         RrtMydxzXzatzSkaeOBIc8DIGsIfoPyw8YNxRmW85jCXIFms5lKKC+o2Sl30SV7m1ZZY
         86tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708534002; x=1709138802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FiquvFGrHOxoq2O6Kk+k8nKguDO2IkwcepkCWrE5URQ=;
        b=M460ca3TSj4j0WE1qufl2HGbeQpkS/8RaPqengKnV+LmZC8p0q8HrElxEYJtlQmoYw
         VwTvSCY+dijSqoF7SQGlDGJlp/alGTYHOhAsHgLB5/S6F/sHcV7t6x1LY9Y/Y7jnKZNk
         psePP4G+pVmz00f9LVsQpTs3l9b1sXpY+orLegK+Tk10Iyq2qmmQZgemU4kP0eRxh1W4
         3OgMpbvwSQP8tauG7EmL1/fhL9yfrFaCBjLhRFM6S95BOWIAPSxeXJKwkmkq/8aPgdqN
         QyoLHBTjVnhI8v3YZfv1s6WoAFinf3bcDvphx3fd5+LCPkmf16BpYCfVKkRgvtCYAE0/
         TxJg==
X-Forwarded-Encrypted: i=1; AJvYcCVZeyx6RG79Ea+XltQ4oXhvYZs4iy0l+hYFf7e21SSPTEYWgaBVTKrmAMkDhJSas5vOs37zAdXjaxrQokOnpgUhcAKInolluy7Q9cGEIqLWRRi38hL4P83tdXfXBE7bESk6blzB950zcv5aHeZvOaEoZR4lcQMl2ZUpzf1I2+57UpBM5Q==
X-Gm-Message-State: AOJu0YzkXjkG1MRe5+nUleLzeO1Z7b7X+FYNpl9Xo1ZAoq7KI2yOJuui
	P7qXxOKe4tBHjvAAKYUEEHg3Yvx4vaPXeAhzI0XbiRqyBP3s2ngjoK09VC47n260y+aT5Cebomv
	rh/BHPEkn/ezPgou8DhTxR7r0log=
X-Google-Smtp-Source: AGHT+IELCO8/rOlGRFhmp6Sf0DgpQM+GJ/uSgRBEDg2OCFsOud+nGutzcrwV4xVoy/cWwvdUC3Yw0+jnFMRS1jylMo4=
X-Received: by 2002:a17:906:b858:b0:a3f:4fd6:b016 with SMTP id
 ga24-20020a170906b85800b00a3f4fd6b016mr1486739ejb.28.1708534001522; Wed, 21
 Feb 2024 08:46:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221094324.27436-1-tzimmermann@suse.de> <20240221094324.27436-2-tzimmermann@suse.de>
 <ZdYJ4FhJ9vhzUeiW@smile.fi.intel.com> <2667387f-f768-4057-a1d0-abbc2cb40d89@suse.de>
In-Reply-To: <2667387f-f768-4057-a1d0-abbc2cb40d89@suse.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 21 Feb 2024 18:46:05 +0200
Message-ID: <CAHp75VcoAuSiTa+QExmtCt9mXDbu6nktg190MRcmpcdzN5yoJQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] backlight: Match backlight device against struct fb_info.bl_dev
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Andy Shevchenko <andy@kernel.org>, lee@kernel.org, daniel.thompson@linaro.org, 
	jingoohan1@gmail.com, deller@gmx.de, robin@protonic.nl, javierm@redhat.com, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 5:45=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
> Am 21.02.24 um 15:34 schrieb Andy Shevchenko:
> > On Wed, Feb 21, 2024 at 10:41:28AM +0100, Thomas Zimmermann wrote:
> >> Framebuffer drivers for devices with dedicated backlight are supposed
> >> to set struct fb_info.bl_dev to the backlight's respective device. Use
> >> the value to match backlight and framebuffer in the backlight core cod=
e.

...

> >>      if (!bd->ops)
> >>              goto out;
> >> -    if (bd->ops->check_fb && !bd->ops->check_fb(bd, evdata->info))
> >> +    else if (bd->ops->check_fb && !bd->ops->check_fb(bd, info))
> > What's the point of adding redundant 'else'?
> >
> >>              goto out;
> >> +#if IS_ENABLED(CONFIG_FB_BACKLIGHT)
> >> +    else if (info->bl_dev && info->bl_dev !=3D bd)
> > Ditto.
>
> They group these tests into one single block of code; signaling that
> these tests serve the same purpose.

Commit message has nothing about this.
Also if needed, it should be a separate change.

> >> +            goto out;
> >> +#endif

--=20
With Best Regards,
Andy Shevchenko

