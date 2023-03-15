Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C996BB8E5
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Mar 2023 17:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbjCOQAx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 15 Mar 2023 12:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbjCOQAe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 15 Mar 2023 12:00:34 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04089EC4C
        for <linux-pwm@vger.kernel.org>; Wed, 15 Mar 2023 08:59:59 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id y5so3648958ybu.3
        for <linux-pwm@vger.kernel.org>; Wed, 15 Mar 2023 08:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678895980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Hkb0Z/tYYZSdI2YGR7CKQ+EDo9PzMXn0G/3i+Y5MwM=;
        b=HAvxY2y0K98/w3C339mOOAQzkXNU7suKDrE+oReOnAWfju0KoSCgolXdK+X4r8CHgN
         afroLwSaC3Wk3W9YQ9WmLcLtBWLq8ohidkk5GyWA1ua9r58tBWi716eqikZ6WWjMnjX6
         3HpK5Y2MjFvO5Aecw1aUn4xEjsk4IEZARbMPHMmUNRYnyEhc0dERnPIcwEuIIkioSz7v
         qKI+pEHFV4AV5vKJV1pVlmlnx2C71iwjsEtqfre5+RK9YuC6r4JpoqlgV4jx+mwjv5MN
         YZZwlGAnv7UcksfYDh5vmrh1x+tyvVOnmpRCxVj0cqWkzGXgUIafjbjn2mn/k7pBylNJ
         wBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678895980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Hkb0Z/tYYZSdI2YGR7CKQ+EDo9PzMXn0G/3i+Y5MwM=;
        b=BnVLQYTtrOeQDTEzYgLiApiAnfjTtZ1cXKV/o1OmNZ6crVNCgTvBfxrpqGfzUGD/eE
         O49/AVlG0oPzyrwrJvs5oOaBsM5Cvy/AJQr/Xs6TITI/pNduFxUgdbkrtyuvdGwmjsmQ
         LnhdwZGDuiCCz+brGaw0YLbgcOMpVcfZl8El5UfYHkPUq3bXhqBoOA6pj/5cMmIQOuXw
         MFPPSElDO7GQwbzBfIWIS82+2p+Ou24IB/lqJRQbE9LzPeHeHisQEDksDirDom16MhrI
         Tt+wHg/Yio4dteIfBwicu6dHfJagGpIimWlrnLBbOfz3tfYeTvQMx6lirKy3/YJN5UxV
         4zDg==
X-Gm-Message-State: AO0yUKWjLEh9+rhA9iUaxCS3dbEIDjpJ6UH6JK9TuBGACPlatxNvCSir
        0D52Z10VzEwZG9hSm3m7T2b93th52RSHZ5yuGHOlZw==
X-Google-Smtp-Source: AK7set+cRmZtlbO9MMeDKr/hukXl0wpMQ3FA/Xz+syeKJfKfZEuF5mOSKngD+5GIMx1/X8Swm2YFxI5NP785yU6JIh0=
X-Received: by 2002:a5b:386:0:b0:b0a:7108:71e9 with SMTP id
 k6-20020a5b0386000000b00b0a710871e9mr12111573ybp.4.1678895980181; Wed, 15 Mar
 2023 08:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230220-display-v1-0-45cbc68e188b@baylibre.com>
 <20230220-display-v1-21-45cbc68e188b@baylibre.com> <4b4d4749-c5ea-3a02-190e-3db703623977@linaro.org>
In-Reply-To: <4b4d4749-c5ea-3a02-190e-3db703623977@linaro.org>
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 15 Mar 2023 16:59:29 +0100
Message-ID: <CAFGrd9pQJWYpdruUvbZNcQRZk5viyOAUCDpJcu5anA13E26Unw@mail.gmail.com>
Subject: Re: [PATCH 21/21] panel: startek-kd070fhfid015: add support of this display
To:     neil.armstrong@linaro.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Xinlei Lee <xinlei.lee@mediatek.com>,
        Guillaume La Roque <glaroque@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Fabien Parent <fparent@baylibre.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Neil,

Le jeu. 9 mars 2023 =C3=A0 15:51, Neil Armstrong
<neil.armstrong@linaro.org> a =C3=A9crit :
> > +
> > +#include <drm/drm_crtc.h>
>
> Is this include needed ?

Seems not, I remove it.

> > +     struct gpio_desc *enable_gpio;
> > +     struct gpio_desc *reset_gpio;
> > +     struct gpio_desc *dcdc_en_gpio;
>
> Isn't this "DCDC" a regulator ???

According to the panel datasheet, this is an input signal needed
passing through TFT connector (PIN30):
"Power IC supply enable, High active"

> > +     /* Interface setting, video mode */
> > +     ret =3D mipi_dsi_generic_write(dsi,
> > +                     (u8[]){DSI_REG_IS, 0x14, 0x08, 0x00, 0x22, 0x00},=
 6);
> > +     if (ret < 0) {
> > +             dev_err(dev, "failed to set display interface setting: %d=
\n",
> > +                     ret);
> > +             return ret;
> > +     }
>
> Use mipi_dsi_generic_write_seq(dsi, DSI_REG_IS, 0x14, 0x08, 0x00, 0x22, 0=
x00); instead,
> it's simpler and doesn't need explicit return check.

"mipi_dsi_generic_write_seq" doesn't exist but I will add it below
"mipi_dsi_dcs_write_seq" in drm_mipi_dsi.h
I must keep the return check to jump out of "stk_panel_init" if
something goes wrong, but I can drop the error print.

> > +static int stk_panel_enable(struct drm_panel *panel)
> > +{
> > +     struct stk_panel *stk =3D to_stk_panel(panel);
> > +
> > +     if (stk->enabled)
> > +             return 0;
> > +
> > +     backlight_enable(stk->backlight);
> > +
> > +     stk->enabled =3D true;
> > +
> > +     return 0;
> > +}
>
> Is this really needed ? the backlight core will enable it automatically.

Ok, it's managed by drm_panel.c driver.
Then I can also remove stuff from stk_panel_disable.


Regards,
Alex
