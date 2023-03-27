Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED98C6CA92D
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Mar 2023 17:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbjC0PiJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 Mar 2023 11:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjC0PiG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Mar 2023 11:38:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF6C4680;
        Mon, 27 Mar 2023 08:38:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 188846131B;
        Mon, 27 Mar 2023 15:38:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF93C433A8;
        Mon, 27 Mar 2023 15:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679931481;
        bh=3XmuKg7477g2NoJtqEb5iNb4ATj0+FqT6dHhTQ0IQGs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h77Uyo826XxSmu3DX6sM0b4XADQ6cucMcCdMFfq7hWdB9LMN+NZbrVrVR34v9X6t2
         myxVy3WUwLigNSHR92LJN2VS1wiVsGo0xjSDCNJ+ObeVsK688j/0l1LsLvWSGI31wQ
         tao0pMm7Bqv3I1jm2g8t9/U29uCUIsKC6VH5qhfCl/kLDW4+3oEuahwHSWpJhdL3bq
         Qm+yH6ZakaD3gzVKjb8Ms8dsOdev3pdfpMV+720yF88lmTd52ZTdk43rhqTtAFNEuA
         e4zszYx9LY6unv9pvpgYNEZlvN8wiuq25Q2gWWNPEjjQDlztVbWr+iAq7yszrfWjvv
         oyjhRwBt5B39g==
Received: by mail-lj1-f181.google.com with SMTP id 20so9514036lju.0;
        Mon, 27 Mar 2023 08:38:01 -0700 (PDT)
X-Gm-Message-State: AAQBX9cXfByS76kzG3JGtDsxlFj3Th9LF/4rFE6CKtjJhe4Y4Uycw3oL
        3xv4Bg3EpC6eH2coR3/A+pcKTlQn6TajNRfVpw==
X-Google-Smtp-Source: AKy350a/drZtpde24N1RhyJMimhp9a0kDjKzSFBl49N+1lgOAUv7hKCRbn9292vlLz1kg5xb2w8lratj4rv3wLsalcQ=
X-Received: by 2002:a2e:7017:0:b0:295:bb34:9c2 with SMTP id
 l23-20020a2e7017000000b00295bb3409c2mr3663347ljc.10.1679931479496; Mon, 27
 Mar 2023 08:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230220-display-v1-0-45cbc68e188b@baylibre.com> <20230220-display-v1-18-45cbc68e188b@baylibre.com>
In-Reply-To: <20230220-display-v1-18-45cbc68e188b@baylibre.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 27 Mar 2023 23:37:47 +0800
X-Gmail-Original-Message-ID: <CAAOTY__=p3pyrX8r55iTR19PiJB3HciS1W9zHF7vR_cVxYgg+Q@mail.gmail.com>
Message-ID: <CAAOTY__=p3pyrX8r55iTR19PiJB3HciS1W9zHF7vR_cVxYgg+Q@mail.gmail.com>
Subject: Re: [PATCH 18/21] drm/mediatek: dsi: Improves the DSI lane setup robustness
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
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi, Xinlei:

Could you help to review this patch?

Regards,
Chun-Kuang.

Alexandre Mergnat <amergnat@baylibre.com> =E6=96=BC 2023=E5=B9=B43=E6=9C=88=
9=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8810:23=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Currently, mtk_dsi_lane_ready (which setup the DSI lane) is triggered
> before mtk_dsi_poweron. lanes_ready flag toggle to true during
> mtk_dsi_lane_ready function, and the DSI module is set up during
> mtk_dsi_poweron.
>
> Later, during panel driver init, mtk_dsi_lane_ready is triggered but does
> nothing because lanes are considered ready. Unfortunately, when the panel
> driver try to communicate, the DSI returns a timeout.
>
> The solution found here is to put lanes_ready flag to false after the DSI
> module setup into mtk_dsi_poweron to init the DSI lanes after the power /
> setup of the DSI module.
>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 3b7d13028fb6..35c36cc05c04 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -667,6 +667,8 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
>         mtk_dsi_config_vdo_timing(dsi);
>         mtk_dsi_set_interrupt_enable(dsi);
>
> +       dsi->lanes_ready =3D false;
> +
>         return 0;
>  err_disable_engine_clk:
>         clk_disable_unprepare(dsi->engine_clk);
>
> --
> b4 0.10.1
