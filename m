Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6366770897
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Aug 2023 21:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjHDTHI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Aug 2023 15:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjHDTG4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Aug 2023 15:06:56 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBC54EDD;
        Fri,  4 Aug 2023 12:06:53 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31768ce2e81so2146823f8f.1;
        Fri, 04 Aug 2023 12:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691176012; x=1691780812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+mKs9GVqXrgLKiydu37dkxuWRwX9m6vUvXBGA4iGEQ=;
        b=pJXcyaij59wykiKOA9tCEB8S4gg3Z1GHrOT8L9w9quvTeK3CJwd93TcMmgeH9qsTmX
         jA5YMPXtem49OKIeZuBW/B7z7dS8WFJdH65DKww5XyYHLXhgTnbsAwscbEHTb6mbtrZZ
         BZa8BIBGOH4Q+SkpavEdH0otXnzRijACuCopeESvO+XHcmL3ZXNW9EGslJl77px9Boeb
         GqQnVqw0k6HMm2l7+XHIGKAPYRVqgCsnRSsJE1fnLs2Nj797U07C0NurMSGCn8/yNgCc
         lDyCVZnGxxnzNo6RW2GsgNpucmHIvVKiEjxprA51NTiam2O4cd25vg7MKR2tt8ini3Xu
         IdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691176012; x=1691780812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+mKs9GVqXrgLKiydu37dkxuWRwX9m6vUvXBGA4iGEQ=;
        b=Wu7jjT0EN/N9IwppfS2wmhz7vgwLoqwyYLMDOVKcfT2rl3x1tAu4K2Zbz9/6hdsoqg
         M0MTH/AhDnfvVqpwLx9JN38lajFNpDFkp6wb3RjjTz8aYMi7bngw1Te1XOIuIRcMGmTr
         cdegJcsi26D44SOj493R7lRKyXxlSK+wob7eJ/rCVYJtxTKFxew32M9uDAvb+Fn6Z2dK
         NjzOr7q+TgEVyb+G5Ay0nkTZJJ9417MpxvSiwr7g3rBep9zpGPtBhN6PEmcW/bObp4s1
         UfMhJDKV4kfM9ze8d2CPvFyHJZlU30YfjA3oeLmb0fgbkYVH4B/6+6SFIyEmvOmMn1Yo
         kXKw==
X-Gm-Message-State: AOJu0YzOuCrurJQ/Vd40QRJu8aeK54FXEIoK4xMpF4EAodSntAruZkt1
        lbsBxCk1zbS1dHhbMibFdKg=
X-Google-Smtp-Source: AGHT+IHpybGIS5pubkiM9vt8iNkqlu2gS6LosaHfJR1MT91WNa9XG7Bef9hWZF/8p1yMJF9KzrDRaA==
X-Received: by 2002:a5d:4a4a:0:b0:317:6175:95fd with SMTP id v10-20020a5d4a4a000000b00317617595fdmr1855584wrs.43.1691176011920;
        Fri, 04 Aug 2023 12:06:51 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id x12-20020adfec0c000000b0031274a184d5sm3143402wrn.109.2023.08.04.12.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 12:06:51 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jonathan =?ISO-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Michael Walle <michael@walle.cc>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Hammer Hsieh <hammerh0314@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Sean Anderson <sean.anderson@seco.com>,
        Michal Simek <michal.simek@amd.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anjelique Melendez <quic_amelende@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev, linux-mips@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 1/2] pwm: Manage owner assignment implicitly for drivers
Date:   Fri, 04 Aug 2023 21:06:45 +0200
Message-ID: <4820522.GXAFRqVoOG@jernej-laptop>
In-Reply-To: <20230804142707.412137-2-u.kleine-koenig@pengutronix.de>
References: <20230804142707.412137-1-u.kleine-koenig@pengutronix.de>
 <20230804142707.412137-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Dne petek, 04. avgust 2023 ob 16:27:06 CEST je Uwe Kleine-K=F6nig napisal(a=
):
> Instead of requiring each driver to care for assigning the owner member
> of struct pwm_ops, handle that implicitly using a macro. Note that the
> owner member has to be moved to struct pwm_chip, as the ops structure
> usually lives in read-only memory and so cannot be modified.
>=20
> The upside is that new lowlevel drivers cannot forget the assignment and
> save one line each. The pwm-crc driver didn't assign .owner, that's not
> a problem in practise though as the driver cannot be compiled as a
> module.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/gpio/gpio-mvebu.c             |  1 -
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c |  1 -
>  drivers/leds/rgb/leds-qcom-lpg.c      |  1 -
>  drivers/pwm/core.c                    | 24 ++++++++++++++----------
>  drivers/pwm/pwm-ab8500.c              |  1 -
>  drivers/pwm/pwm-apple.c               |  1 -
>  drivers/pwm/pwm-atmel-hlcdc.c         |  1 -
>  drivers/pwm/pwm-atmel-tcb.c           |  1 -
>  drivers/pwm/pwm-atmel.c               |  1 -
>  drivers/pwm/pwm-bcm-iproc.c           |  1 -
>  drivers/pwm/pwm-bcm-kona.c            |  1 -
>  drivers/pwm/pwm-bcm2835.c             |  1 -
>  drivers/pwm/pwm-berlin.c              |  1 -
>  drivers/pwm/pwm-brcmstb.c             |  1 -
>  drivers/pwm/pwm-clk.c                 |  1 -
>  drivers/pwm/pwm-clps711x.c            |  1 -
>  drivers/pwm/pwm-cros-ec.c             |  1 -
>  drivers/pwm/pwm-dwc.c                 |  1 -
>  drivers/pwm/pwm-ep93xx.c              |  1 -
>  drivers/pwm/pwm-fsl-ftm.c             |  1 -
>  drivers/pwm/pwm-hibvt.c               |  1 -
>  drivers/pwm/pwm-img.c                 |  1 -
>  drivers/pwm/pwm-imx-tpm.c             |  1 -
>  drivers/pwm/pwm-imx1.c                |  1 -
>  drivers/pwm/pwm-imx27.c               |  1 -
>  drivers/pwm/pwm-intel-lgm.c           |  1 -
>  drivers/pwm/pwm-iqs620a.c             |  1 -
>  drivers/pwm/pwm-jz4740.c              |  1 -
>  drivers/pwm/pwm-keembay.c             |  1 -
>  drivers/pwm/pwm-lp3943.c              |  1 -
>  drivers/pwm/pwm-lpc18xx-sct.c         |  1 -
>  drivers/pwm/pwm-lpc32xx.c             |  1 -
>  drivers/pwm/pwm-lpss.c                |  1 -
>  drivers/pwm/pwm-mediatek.c            |  1 -
>  drivers/pwm/pwm-meson.c               |  1 -
>  drivers/pwm/pwm-microchip-core.c      |  1 -
>  drivers/pwm/pwm-mtk-disp.c            |  1 -
>  drivers/pwm/pwm-mxs.c                 |  1 -
>  drivers/pwm/pwm-ntxec.c               |  1 -
>  drivers/pwm/pwm-omap-dmtimer.c        |  1 -
>  drivers/pwm/pwm-pca9685.c             |  1 -
>  drivers/pwm/pwm-pxa.c                 |  1 -
>  drivers/pwm/pwm-raspberrypi-poe.c     |  1 -
>  drivers/pwm/pwm-rcar.c                |  1 -
>  drivers/pwm/pwm-renesas-tpu.c         |  1 -
>  drivers/pwm/pwm-rockchip.c            |  1 -
>  drivers/pwm/pwm-rz-mtu3.c             |  1 -
>  drivers/pwm/pwm-samsung.c             |  1 -
>  drivers/pwm/pwm-sifive.c              |  1 -
>  drivers/pwm/pwm-sl28cpld.c            |  1 -
>  drivers/pwm/pwm-spear.c               |  1 -
>  drivers/pwm/pwm-sprd.c                |  1 -
>  drivers/pwm/pwm-sti.c                 |  1 -
>  drivers/pwm/pwm-stm32-lp.c            |  1 -
>  drivers/pwm/pwm-stm32.c               |  1 -
>  drivers/pwm/pwm-stmpe.c               |  1 -
>  drivers/pwm/pwm-sun4i.c               |  1 -

=46or sun4i:
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>  drivers/pwm/pwm-sunplus.c             |  1 -
>  drivers/pwm/pwm-tegra.c               |  1 -
>  drivers/pwm/pwm-tiecap.c              |  1 -
>  drivers/pwm/pwm-tiehrpwm.c            |  1 -
>  drivers/pwm/pwm-twl-led.c             |  2 --
>  drivers/pwm/pwm-twl.c                 |  2 --
>  drivers/pwm/pwm-visconti.c            |  1 -
>  drivers/pwm/pwm-vt8500.c              |  1 -
>  drivers/pwm/pwm-xilinx.c              |  1 -
>  drivers/staging/greybus/pwm.c         |  1 -
>  include/linux/pwm.h                   | 10 ++++++----



