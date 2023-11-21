Return-Path: <linux-pwm+bounces-123-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EA07F3369
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 17:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D1F02818FA
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 16:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE915A0E8;
	Tue, 21 Nov 2023 16:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fwBrznWw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B727198
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 08:14:36 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a02d91ab195so80088666b.3
        for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 08:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700583272; x=1701188072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nURXwAGKPkBMiCxEYgbeoQZATAjDf6lDOeHeErDCpZ8=;
        b=fwBrznWwXVOrO6zjJpvrp0UVjviOda6Z3BC3bJZHJWm41NDW3exfz/pv49vUxwvz8S
         w0PthvIXX6+CZ+gptr/tD8GB2pq5UcrAnClPjgw3FXdXcU6D79R7C04//2IbEree3asB
         lcVLaMGjT3wSc263UuSs5Lj13eURpH4ULA+Lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700583272; x=1701188072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nURXwAGKPkBMiCxEYgbeoQZATAjDf6lDOeHeErDCpZ8=;
        b=Q8Zp94ZtfHEPOeE1UR3NViERh02j+TbghMFYz9TwNW3isE29EiexgXryl9xT+2EmyJ
         6WmzvS2DYAfk7a6Pma2rwfZ359x6NawU5MhrpYsshqWvyTIracwAgsIghaRLSwkT3EEA
         JCUbhLFsjENddEnc3Pdfsz4wCEurltjmNuQU5EP1pxMqNM2Red+7iEDwWdcE4EBYBiqh
         rrmUkzGBWWsD500gqHVTX0zXI6nDPwuhRw0Tbn+aOGHIrYMvMQUnBlXIhFEAhAQwQ0Ep
         g+MJmKJbji5wmR87qTy4OhkkglxNvQxWGiOzbmkZYBjoERDadf3c7KrZIFCx3N/53rnZ
         aERQ==
X-Gm-Message-State: AOJu0Yy/Dmrk5tNc3K8jMK78yb2nKolOHdCd1yHuMLDw3fB9NboYnV37
	KB8hG9j45FVoNfkcvDySMA4yxln/n/4cG0WaNKpw8Kyz
X-Google-Smtp-Source: AGHT+IE/gdEMCf4SFN+x88L45YqxqyBvGnSRuDgC4j5YrdwOdVLuwpnJ9vSnt0fv8PxI2RIfG669aw==
X-Received: by 2002:a17:906:5181:b0:a01:bc90:736d with SMTP id y1-20020a170906518100b00a01bc90736dmr1689128ejk.40.1700583272666;
        Tue, 21 Nov 2023 08:14:32 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id x15-20020a170906710f00b009bd9ac83a9fsm5374355ejj.152.2023.11.21.08.14.31
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 08:14:32 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40b2993e167so55215e9.0
        for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 08:14:31 -0800 (PST)
X-Received: by 2002:a05:600c:4d0e:b0:40a:483f:f828 with SMTP id
 u14-20020a05600c4d0e00b0040a483ff828mr10002wmp.4.1700583271626; Tue, 21 Nov
 2023 08:14:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
 <20231121134901.208535-102-u.kleine-koenig@pengutronix.de>
 <CAD=FV=Vz7TuUH=U8t0XVhj5rzoci9KBjSZXJruMQyXiARY+Z_Q@mail.gmail.com> <20231121160514.feveiq2cyemwvqni@pengutronix.de>
In-Reply-To: <20231121160514.feveiq2cyemwvqni@pengutronix.de>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 21 Nov 2023 08:14:14 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VK9Lz9dMFDETHyGLQRG6bWkOcF20TdnTd_jWr1u81NFw@mail.gmail.com>
Message-ID: <CAD=FV=VK9Lz9dMFDETHyGLQRG6bWkOcF20TdnTd_jWr1u81NFw@mail.gmail.com>
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

On Tue, Nov 21, 2023 at 8:05=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello Doug,
>
> On Tue, Nov 21, 2023 at 07:15:51AM -0800, Doug Anderson wrote:
> > > @@ -1585,22 +1586,28 @@ static const struct pwm_ops ti_sn_pwm_ops =3D=
 {
> > >  static int ti_sn_pwm_probe(struct auxiliary_device *adev,
> > >                            const struct auxiliary_device_id *id)
> > >  {
> > > +       struct pwm_chip *chip;
> > >         struct ti_sn65dsi86 *pdata =3D dev_get_drvdata(adev->dev.pare=
nt);
> > >
> > > -       pdata->pchip.dev =3D pdata->dev;
> > > -       pdata->pchip.ops =3D &ti_sn_pwm_ops;
> > > -       pdata->pchip.npwm =3D 1;
> > > -       pdata->pchip.of_xlate =3D of_pwm_single_xlate;
> > > -       pdata->pchip.of_pwm_n_cells =3D 1;
> > > +       /* XXX: should this better use adev->dev instead of pdata->de=
v? */
> > > +       pdata->pchip =3D chip =3D devm_pwmchip_alloc(pdata->dev, 1, s=
izeof(&pdata));
> >
> > Yes, it should be "adev->dev". See recent commits like commit
> > 7b821db95140 ("drm/bridge: ti-sn65dsi86: Associate DSI device lifetime
> > with auxiliary device").
>
> I'd do that in a separate commit and not change that hidden in patch
> like this one. Agree? Then I'd keep that as is and not address this in
> this series. Maybe it will take another cycle until this patch goes in
> anyhow ...

You could do it in a commit _before_ this one, but not a commit after
this one. Specifically before "${SUBJECT}" commit I think it was
benign to set pdata->pchip.dev to pdata->dev. Now you're starting to
use it for devm and the incorrect lifetime is worse, I think. Do you
agree?

NOTE: I don't actually have any hardware that uses the PWM here, so
you probably want to CC someone like Bjorn (who wrote the PWM code
here) so that he can test it and make sure it didn't break anything.


> > I also think the size you're passing is technically wrong. The private
> > data you're storing is a pointer to a "struct ti_sn65dsi86". The size
> > of that is "sizeof(pdata)", not "sizeof(&pdata)".
>
> sizeof(*pdata)?

No, that's also wrong. You're not storing a copy of the "struct
ti_sn65dsi86", you're storing a pointer to "struct ti_sn65dsi86".
That's "sizeof(pdata)".

Essentially I'm thinking of it like this. If you were storing 1 byte
of data then you'd pass 1 here. Then allocate and write you'd do:

u8 my_byte;
chip =3D devm_pwmchip_alloc(dev, 1, sizeof(my_byte));
*(u8 *)pwmchip_priv(chip) =3D my_byte;

Here you're storing a pointer instead of a byte, but the idea is the same.

void *my_ptr;
chip =3D devm_pwmchip_alloc(dev, 1, sizeof(my_ptr));
*(void **)pwmchip_priv(chip) =3D my_ptr;

-Doug

