Return-Path: <linux-pwm+bounces-708-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8CE829138
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Jan 2024 01:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99D31B25654
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Jan 2024 00:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBD47EF;
	Wed, 10 Jan 2024 00:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WGpJBoC1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B3C7ED
	for <linux-pwm@vger.kernel.org>; Wed, 10 Jan 2024 00:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a28ee72913aso797529466b.1
        for <linux-pwm@vger.kernel.org>; Tue, 09 Jan 2024 16:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704846184; x=1705450984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kAqGhucPMVtfo1InPdfTFWkdNUtgMKoqN9J3JzON2c=;
        b=WGpJBoC1zQDY/+xKZMnmg3rglYNyP4/W4jFoqeraadr3/G7D3zuzxO4nEtDmN/ounG
         ONCRJcPsUIRGWp/YRk0CHlst9rfV2fDPoQT7hQxXJtTunqoki147KExMP9ZOXcR2skEV
         bfEitFh2xdWHcRSPyG7nqBqoj230SrQnm1Pe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704846184; x=1705450984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5kAqGhucPMVtfo1InPdfTFWkdNUtgMKoqN9J3JzON2c=;
        b=F2qaXhY+gayiDGKJrQXhutomNRE/vB4UiytQ0ukFN0JKf2neMdhC7SP8hGxus7hX+d
         TtngGE3Ud42zwDRYvGRBuX4fSWq+LsH/h8PecfoIc+SWjfVaEASPURRWI3wBAcyZwlvs
         hP3l7CZX6T1idYEmPhfOg57SDUczo5+TikZoLqSUTnQxAAyRx5KsVk0cfauJNXsQPhhP
         /4LK7ubKr2esr4rDoxd4sDEZU93WM97PIJ3k9HgOicWcDmmDfkQylbm53hFDynvyGrHg
         LeSbYP92S+stgfwL+ITG3JwykXRrw0SxZ8xZc4yA/o/HvoYfv6lhbC36b5RD1OWk9Rgj
         MFRA==
X-Gm-Message-State: AOJu0Yz50aU8+l+aKgZ+29gJgdOzmGdM6VAf9w3Zon91nSIOCr8+Z9t0
	N8nPTpZwcyd1m0ZgrSSdlhqXsSLq2ILxNryAceG62Agf+QseCdw=
X-Google-Smtp-Source: AGHT+IHRltMNk61bxBt53XNpqKgn/W2hkvv/KIAPhgn6t6akwyLvxs2WlTNWGDwL9u0gMWNyJDFdQA==
X-Received: by 2002:a17:906:7c8d:b0:a2b:a027:467d with SMTP id w13-20020a1709067c8d00b00a2ba027467dmr278791ejo.36.1704846183804;
        Tue, 09 Jan 2024 16:23:03 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id k9-20020a1709065fc900b00a26abf393d0sm1519008ejv.138.2024.01.09.16.23.03
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 16:23:03 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e4afe9ea7so10385e9.1
        for <linux-pwm@vger.kernel.org>; Tue, 09 Jan 2024 16:23:03 -0800 (PST)
X-Received: by 2002:a05:600c:43c5:b0:40d:5fee:130 with SMTP id
 f5-20020a05600c43c500b0040d5fee0130mr62920wmn.5.1704845704513; Tue, 09 Jan
 2024 16:15:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1704835845.git.u.kleine-koenig@pengutronix.de> <53d8c545aa8f79a920358be9e72e382b3981bdc4.1704835845.git.u.kleine-koenig@pengutronix.de>
In-Reply-To: <53d8c545aa8f79a920358be9e72e382b3981bdc4.1704835845.git.u.kleine-koenig@pengutronix.de>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 9 Jan 2024 16:14:49 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UyoSc7fpvaO08Bhj54UG5b1OGteXV95tCVkpDzrvzwsw@mail.gmail.com>
Message-ID: <CAD=FV=UyoSc7fpvaO08Bhj54UG5b1OGteXV95tCVkpDzrvzwsw@mail.gmail.com>
Subject: Re: [PATCH 2/5] pwm: Drop useless member .of_pwm_n_cells of struct pwm_chip
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Alexander Shiyan <shc_work@mail.ru>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, dri-devel@lists.freedesktop.org, 
	kernel@pengutronix.de, linux-pwm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 9, 2024 at 1:35=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Apart from the two of_xlate implementations this member is write-only.
> In the of_xlate functions of_pwm_xlate_with_flags() and
> of_pwm_single_xlate() it's more sensible to check for args->args_count
> because this is what is actually used in the device tree.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c |  1 -
>  drivers/pwm/core.c                    | 22 +++-------------------
>  drivers/pwm/pwm-clps711x.c            |  1 -
>  drivers/pwm/pwm-cros-ec.c             |  1 -
>  drivers/pwm/pwm-pxa.c                 |  4 +---
>  include/linux/pwm.h                   |  2 --
>  6 files changed, 4 insertions(+), 27 deletions(-)

I haven't done massive thinking about this, but it seems reasonable to
me. I remember being confused about why we needed some of these extra
checks ages ago when I looked at this code, so getting rid of them
makes sense to me.

I've been involved with both the ti-sn65dsi86.c and the pwm-cros-ec.c
code and both looks fine to me.

I'm an official reviewer for ti-sn65dsi86.c and I'm fairly happy with
this tag for it:

Acked-by: Douglas Anderson <dianders@chromium.org>

...and I think it would be fine to go through the PWM tree. If one of
the senior drm-misc maintainers disagrees with me, however, then you
should listen to them rather than me.

-Doug

