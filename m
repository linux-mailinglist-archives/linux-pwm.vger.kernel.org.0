Return-Path: <linux-pwm+bounces-116-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A06337F3217
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 16:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 414CC1F22382
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 15:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9F256745;
	Tue, 21 Nov 2023 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GFjDWc5t"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287C9100
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 07:16:15 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5401bab7525so8214281a12.2
        for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 07:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700579770; x=1701184570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWrMwoT0xATigsoxyGO5GWTJCAnmKZt5B07C02bK/Eo=;
        b=GFjDWc5ttimcv3fgAt2uMc33dtISLTeNXK262UbK5RAb7TMDR6G6+JraTeWHqW7Jb6
         8rYsBNxRY2iRxT7XSCBV9KU2f8aKKJ964/ADFraV3AJScBKw+UUtXex+/nhwFP7gqkKD
         2bJvi3Q7lkfHUNg2a8r8fY0RWD/9oYAjS/XTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700579770; x=1701184570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWrMwoT0xATigsoxyGO5GWTJCAnmKZt5B07C02bK/Eo=;
        b=PzyGSPQ/VKhNrO3jCP5gT7W7/BIB7xTJ4PZzwCOxXHj3l8OakJLHI8M1eq74o7ZyF8
         cYbF/b85yp25aEeEV0P70mkbu+8vGUmvG/K2sJcdXdtcPBGG4Aoro1iWFqCzyeGmLID6
         9bLETj185/yNjb2+8PfmoYzi8tbJFHTV3FWZXqUCiVJQHmnoC/AwFwNAwxJaTb+/mcCF
         KJn3oNGA5ZPj3BnF9SzIcObjvtvYGGKhhzepfx/6aP0eKrIGpOb+by0Q3D8FeCVS0sbH
         SWvNF/Dn0V4eGrLLA6ZkbhRvkpqRs0fhdyiCh1V6aNSc8JJ8HoZy8VhNwBozsX/gIdv1
         DdUw==
X-Gm-Message-State: AOJu0Yy6+7oZLqq/SyKRj5C34Tk8G6ULXWlzEn1wwJ23kDc46yrnFMeW
	JuQnuEH0+SjKdD4SuwZRpd6NiWeAPuySduhkyJqjl37h
X-Google-Smtp-Source: AGHT+IHVp7BT5Zr2dIXnThu3DJe4H+OOa4SOeUezOgU9iOkW8QoCwYcMSWcq1belG3egZnJQk+LtDg==
X-Received: by 2002:a17:906:2253:b0:a00:4162:5d98 with SMTP id 19-20020a170906225300b00a0041625d98mr3154716ejr.19.1700579770465;
        Tue, 21 Nov 2023 07:16:10 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id n8-20020a1709062bc800b009dd8473559dsm5353928ejg.110.2023.11.21.07.16.09
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 07:16:10 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40b2993e167so48265e9.0
        for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 07:16:09 -0800 (PST)
X-Received: by 2002:a05:600c:518a:b0:405:320a:44f9 with SMTP id
 fa10-20020a05600c518a00b00405320a44f9mr898wmb.5.1700579769077; Tue, 21 Nov
 2023 07:16:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de> <20231121134901.208535-102-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20231121134901.208535-102-u.kleine-koenig@pengutronix.de>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 21 Nov 2023 07:15:51 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Vz7TuUH=U8t0XVhj5rzoci9KBjSZXJruMQyXiARY+Z_Q@mail.gmail.com>
Message-ID: <CAD=FV=Vz7TuUH=U8t0XVhj5rzoci9KBjSZXJruMQyXiARY+Z_Q@mail.gmail.com>
Subject: Re: [PATCH v3 101/108] drm/bridge: ti-sn65dsi86: Make use of
 devm_pwmchip_alloc() function
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Thierry Reding <thierry.reding@gmail.com>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, dri-devel@lists.freedesktop.org, 
	kernel@pengutronix.de, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 21, 2023 at 5:52=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> This prepares the pwm driver of the ti-sn65dsi86 to further changes of
> the pwm core outlined in the commit introducing devm_pwmchip_alloc().
> There is no intended semantical change and the driver should behave as
> before.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi86.c
> index c45c07840f64..cd40530ffd71 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -197,7 +197,7 @@ struct ti_sn65dsi86 {
>         DECLARE_BITMAP(gchip_output, SN_NUM_GPIOS);
>  #endif
>  #if defined(CONFIG_PWM)
> -       struct pwm_chip                 pchip;
> +       struct pwm_chip                 *pchip;
>         bool                            pwm_enabled;
>         atomic_t                        pwm_pin_busy;
>  #endif
> @@ -1372,7 +1372,8 @@ static void ti_sn_pwm_pin_release(struct ti_sn65dsi=
86 *pdata)
>
>  static struct ti_sn65dsi86 *pwm_chip_to_ti_sn_bridge(struct pwm_chip *ch=
ip)
>  {
> -       return container_of(chip, struct ti_sn65dsi86, pchip);
> +       struct ti_sn65dsi86 **pdata =3D pwmchip_priv(chip);
> +       return *pdata;
>  }
>
>  static int ti_sn_pwm_request(struct pwm_chip *chip, struct pwm_device *p=
wm)
> @@ -1585,22 +1586,28 @@ static const struct pwm_ops ti_sn_pwm_ops =3D {
>  static int ti_sn_pwm_probe(struct auxiliary_device *adev,
>                            const struct auxiliary_device_id *id)
>  {
> +       struct pwm_chip *chip;
>         struct ti_sn65dsi86 *pdata =3D dev_get_drvdata(adev->dev.parent);
>
> -       pdata->pchip.dev =3D pdata->dev;
> -       pdata->pchip.ops =3D &ti_sn_pwm_ops;
> -       pdata->pchip.npwm =3D 1;
> -       pdata->pchip.of_xlate =3D of_pwm_single_xlate;
> -       pdata->pchip.of_pwm_n_cells =3D 1;
> +       /* XXX: should this better use adev->dev instead of pdata->dev? *=
/
> +       pdata->pchip =3D chip =3D devm_pwmchip_alloc(pdata->dev, 1, sizeo=
f(&pdata));

Yes, it should be "adev->dev". See recent commits like commit
7b821db95140 ("drm/bridge: ti-sn65dsi86: Associate DSI device lifetime
with auxiliary device").

I also think the size you're passing is technically wrong. The private
data you're storing is a pointer to a "struct ti_sn65dsi86". The size
of that is "sizeof(pdata)", not "sizeof(&pdata)".

Other than the above, this looks OK to me. Once the dependencies are
in I'd be happy to apply this to drm-misc. I could also "Ack" it for
landing in other trees and I _think_ that would be OK (the driver
isn't changing much and it's unlikely to cause conflicts), though
technically the Ack would be more legit from one of the drm-misc
maintainers [1].

[1] https://drm.pages.freedesktop.org/maintainer-tools/repositories.html?hi=
ghlight=3Dmaxime#the-drm-misc-repository

