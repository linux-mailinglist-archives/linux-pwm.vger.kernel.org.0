Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F776B7BCA
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Mar 2023 16:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjCMPVZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 13 Mar 2023 11:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjCMPVY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 13 Mar 2023 11:21:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE23667836;
        Mon, 13 Mar 2023 08:21:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C90D561345;
        Mon, 13 Mar 2023 15:21:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B96C433EF;
        Mon, 13 Mar 2023 15:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678720882;
        bh=wOHm5m6ReGiTMjg65yU9qaHxrijWEjIw7pPKeJiQgZU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OUUHQodE9JDEhnimPb4A+ScsqyQWzs2ZXXN56JZUxx013GW7PBsqzY2YzYB4iYFT/
         7o4gdJUaWQvP3x5cZhLFhQrnNFyx4J9sfDqS1Bhqo2UnCTtJ1YjjlALi/zckbPdQ5N
         ymDPvXulN2SHf5q3ji061uodkQKq00m/6YHwHxgBvpgwhSLvStTdfmJZ9I6RmP/XHI
         rjd0nrnk/s/dFkXEFhLer1DWz5Zbgw8QWbYm1meM45C29w2ChJCzYt2UZYjovp1K9t
         oPRNcx1c7VtU60XzJQMh5XJNaztVN1Zl6yT3mEmrTgcaadgxieLmCV7WbRVFMyhF8D
         fxCurl6qT/6Rg==
Received: by mail-lf1-f42.google.com with SMTP id s22so16167633lfi.9;
        Mon, 13 Mar 2023 08:21:22 -0700 (PDT)
X-Gm-Message-State: AO0yUKUOwLHS/SDmajPKi0D8pu0BAtgVl0zLmAxUK8vrHjgks5z9C91d
        1n40elY/M8yOkjjeMWjTwJHJY4RCyN7rjb2WmA==
X-Google-Smtp-Source: AK7set8c5sO7hWTagu0j7z99ZxWvxbRa9EwPdzCx0PtR3FDTJLZOe1sVBKQ3Vev10nkQOZOgZI/r80Ju5W7KnZEDkS0=
X-Received: by 2002:ac2:52a9:0:b0:4e8:3fba:621d with SMTP id
 r9-20020ac252a9000000b004e83fba621dmr1728626lfm.7.1678720880217; Mon, 13 Mar
 2023 08:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230220-display-v1-0-45cbc68e188b@baylibre.com> <20230220-display-v1-19-45cbc68e188b@baylibre.com>
In-Reply-To: <20230220-display-v1-19-45cbc68e188b@baylibre.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 13 Mar 2023 23:21:08 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-wEzu6JavEAyRo8njOLRMq3i3wEcemNsuMaK00W9QqpQ@mail.gmail.com>
Message-ID: <CAAOTY_-wEzu6JavEAyRo8njOLRMq3i3wEcemNsuMaK00W9QqpQ@mail.gmail.com>
Subject: Re: [PATCH 19/21] drm/mediatek: dpi: add support for dpi clock
To:     Alexandre Mergnat <amergnat@baylibre.com>
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
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi, Alexandre:

Alexandre Mergnat <amergnat@baylibre.com> =E6=96=BC 2023=E5=B9=B43=E6=9C=88=
9=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8810:23=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> From: Fabien Parent <fparent@baylibre.com>
>
> MT8365 requires an additional clock for DPI. Add support for that
> additional clock.
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediate=
k/mtk_dpi.c
> index 4317595a15d1..474c6e5bbf04 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -68,6 +68,7 @@ struct mtk_dpi {
>         struct device *dev;
>         struct clk *engine_clk;
>         struct clk *pixel_clk;
> +       struct clk *dpi_clk;
>         struct clk *tvd_clk;
>         int irq;
>         struct drm_display_mode mode;
> @@ -464,6 +465,7 @@ static void mtk_dpi_power_off(struct mtk_dpi *dpi)
>         mtk_dpi_disable(dpi);
>         clk_disable_unprepare(dpi->pixel_clk);
>         clk_disable_unprepare(dpi->engine_clk);
> +       clk_disable_unprepare(dpi->dpi_clk);
>  }
>
>  static int mtk_dpi_power_on(struct mtk_dpi *dpi)
> @@ -473,10 +475,16 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi)
>         if (++dpi->refcount !=3D 1)
>                 return 0;
>
> +       ret =3D clk_prepare_enable(dpi->dpi_clk);
> +       if (ret) {
> +               dev_err(dpi->dev, "failed to enable dpi clock: %d\n", ret=
);
> +               goto err_refcount;
> +       }
> +
>         ret =3D clk_prepare_enable(dpi->engine_clk);
>         if (ret) {
>                 dev_err(dpi->dev, "Failed to enable engine clock: %d\n", =
ret);
> -               goto err_refcount;
> +               goto err_engine;
>         }
>
>         ret =3D clk_prepare_enable(dpi->pixel_clk);
> @@ -489,6 +497,8 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi)
>
>  err_pixel:
>         clk_disable_unprepare(dpi->engine_clk);
> +err_engine:
> +       clk_disable_unprepare(dpi->dpi_clk);
>  err_refcount:
>         dpi->refcount--;
>         return ret;
> @@ -1044,6 +1054,12 @@ static int mtk_dpi_probe(struct platform_device *p=
dev)
>                 return ret;
>         }
>
> +       dpi->dpi_clk =3D devm_clk_get_optional(dev, "dpi");

For MT8365, DPI clock is not optional, so make sure that MT8365 DPI
should have this clock.

Regards,
Chun-Kuang.

> +       if (IS_ERR(dpi->dpi_clk)) {
> +               return dev_err_probe(dev, ret, "Failed to get dpi clock: =
%p\n",
> +                                    dpi->dpi_clk);
> +       }
> +
>         dpi->irq =3D platform_get_irq(pdev, 0);
>         if (dpi->irq <=3D 0)
>                 return -EINVAL;
>
> --
> b4 0.10.1
