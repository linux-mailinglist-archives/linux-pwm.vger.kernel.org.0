Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DF9642BB7
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Dec 2022 16:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbiLEP1t (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 5 Dec 2022 10:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbiLEP1G (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Dec 2022 10:27:06 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C586FD8
        for <linux-pwm@vger.kernel.org>; Mon,  5 Dec 2022 07:25:53 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id m19so16224082edj.8
        for <linux-pwm@vger.kernel.org>; Mon, 05 Dec 2022 07:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTJwoP5lG4Epq30dmXniWxiUN6BJbqz5YEza2fXmANY=;
        b=mFdsqee89kncMviuE6OeVl4OrSJuG1WCQGLbWlN3sjX+4ZIz46ZeeSlaI/8x7Z31S9
         vPrsVP+urGFWd4EUahl0Q2IcJkC5EhycvZ1hkIBEiWIvjtCZs7gq0KvU8tWEJy74Q/E4
         Ezo0BACdRUfhjD1jSp+qiNYfd1QA4kH2ica4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DTJwoP5lG4Epq30dmXniWxiUN6BJbqz5YEza2fXmANY=;
        b=U6Z6q2ADCk/HbXGxkGActZ8m4vfvJzQrfo/ke3Yn9mrcliAkU2RSat7TOERczAgNp6
         M0f44TsPq53NtoUOpPuec5XpTuCOXn3Z6GAELQD2CgQPhMPLLk/aTdY3S8wMnIjJICPe
         DbOdCDM77z9Y0nJwoMbqQaKyL978hscqmW8z/l0Fb3NKBps4xk6dewT/ljxSDj9nBkTq
         21zgU1hhnJx0XgxmY9c07knuNfOQx5OYmTdVd/C4Lk3TSbOtGeJLto31P2g+fR2zipA3
         Wp3A2zi5K0pl6tfVlyzZ77pHC4VM2vXuw4vA0QM/QzxBsVxJx1ULUjhpfN/xYVBLdTv1
         rkqQ==
X-Gm-Message-State: ANoB5pkTlddVRbnoBN4I7h0g0JonMQw+WqYuRBbM4GrlNW9gjvk+ulBE
        JjUeBFW/H7HfWGapDmUHAs1gAW5moWEcoJHFDC4=
X-Google-Smtp-Source: AA0mqf5Sa59mGXWrjizpchA+qNxOjgRulBMgSJ9hv+//ev3dCVHdxAhdJ4US1gFxYJs6PPbq6AfnOQ==
X-Received: by 2002:a05:6402:43cc:b0:46c:d5e8:30e7 with SMTP id p12-20020a05640243cc00b0046cd5e830e7mr2994612edc.268.1670253951446;
        Mon, 05 Dec 2022 07:25:51 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id g20-20020a170906539400b0078128c89439sm1258676ejo.6.2022.12.05.07.25.49
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 07:25:49 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id n9-20020a05600c3b8900b003d0944dba41so5604761wms.4
        for <linux-pwm@vger.kernel.org>; Mon, 05 Dec 2022 07:25:49 -0800 (PST)
X-Received: by 2002:a05:600c:1e12:b0:3cf:9ad3:a20e with SMTP id
 ay18-20020a05600c1e1200b003cf9ad3a20emr50907306wmb.151.1670253948745; Mon, 05
 Dec 2022 07:25:48 -0800 (PST)
MIME-Version: 1.0
References: <20221130152148.2769768-1-u.kleine-koenig@pengutronix.de>
 <20221130152148.2769768-4-u.kleine-koenig@pengutronix.de> <20221204210940.qygblu244zvlenxz@pengutronix.de>
In-Reply-To: <20221204210940.qygblu244zvlenxz@pengutronix.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 5 Dec 2022 07:25:36 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XEpf1N7dwXffw94e0QR-oZU0anto1A3QeRgoURsGVehA@mail.gmail.com>
Message-ID: <CAD=FV=XEpf1N7dwXffw94e0QR-oZU0anto1A3QeRgoURsGVehA@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] drm/bridge: ti-sn65dsi86: Propagate errors in
 .get_state() to the caller
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Maxime Ripard <maxime@cerno.tech>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On Sun, Dec 4, 2022 at 1:09 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> my initial Cc-list wasn't optimal. So I added a few people here.
>
> On Wed, Nov 30, 2022 at 04:21:40PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > .get_state() can return an error indication. Make use of it to propagat=
e
> > failing hardware accesses.
> >
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/br=
idge/ti-sn65dsi86.c
> > index 6826d2423ae9..9671071490d8 100644
> > --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > @@ -1512,19 +1512,19 @@ static int ti_sn_pwm_get_state(struct pwm_chip =
*chip, struct pwm_device *pwm,
> >
> >       ret =3D regmap_read(pdata->regmap, SN_PWM_EN_INV_REG, &pwm_en_inv=
);
> >       if (ret)
> > -             return 0;
> > +             return ret;
> >
> >       ret =3D ti_sn65dsi86_read_u16(pdata, SN_BACKLIGHT_SCALE_REG, &sca=
le);
> >       if (ret)
> > -             return 0;
> > +             return ret;
> >
> >       ret =3D ti_sn65dsi86_read_u16(pdata, SN_BACKLIGHT_REG, &backlight=
);
> >       if (ret)
> > -             return 0;
> > +             return ret;
> >
> >       ret =3D regmap_read(pdata->regmap, SN_PWM_PRE_DIV_REG, &pre_div);
> >       if (ret)
> > -             return 0;
> > +             return ret;
> >
> >       state->enabled =3D FIELD_GET(SN_PWM_EN_MASK, pwm_en_inv);
> >       if (FIELD_GET(SN_PWM_INV_MASK, pwm_en_inv))
>
> It would be great to get an Ack to take this patch and patch #1 via the
> PWM tree. (Both got an Ack by Douglas Anderson, I'm unsure if that is
> already enough.)

I'm probably the main person who reviews patches to ti-sn65dsi86.c
these days and I'm also typically the one landing patches, but
officially this driver goes through "drm-misc". IMO it's fine for this
to go through your tree and that's what I intended by my Ack. It seems
highly unlikely to cause any merge conflicts. That being said, since
we're drm-misc it means that the "adults" in the room (the ones who
have to deal with fallout if there are merge conflicts) are supposed
to be "Daniel, Jani and Sean" according to the docs [1].  ...though it
seems like the drm-misc-next pull requests these days come from
Maxime, so maybe he would be the right person to confirm that it could
go through your tree?

[1] https://people.freedesktop.org/~jani/html/drm-misc.html#
