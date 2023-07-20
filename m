Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F2F75B1AC
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Jul 2023 16:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjGTOvX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 20 Jul 2023 10:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjGTOvW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Jul 2023 10:51:22 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EDB26B0
        for <linux-pwm@vger.kernel.org>; Thu, 20 Jul 2023 07:51:20 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-481604cb9d8so315934e0c.1
        for <linux-pwm@vger.kernel.org>; Thu, 20 Jul 2023 07:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1689864679; x=1690469479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+O/muW1Nk3sbzumyk3oSyUNsgXn5aAFedNJT9XhjpY=;
        b=qHklILRYK8e+9ECBbaFZ7M9L25U5jR9UnSBshRGFdRVHmqpzNlXreFLJxybGBGyMLA
         JjOIhtWXcXsFXDkQWzdryG/qS0K+qMEB1GG285OY5nANiF5bBiiZqSfRjpAq4JN3qO/G
         VE1wh3ub6GNTxKYli8B9etbv3Syi4YaZAm8ewJzKDcudPtWv+mpGQnUWLOEpUyVi77HA
         L1nzjHd9LR1jd0d99mpisIGonQLildHSrZJKuMS/WToklyjf8Qvdn/zjfWDpMZSAG7cZ
         /maT4QCA9HKlmwzmuyLH+08Sr6TprdvFrIAJ1FYorUt4VLFQyyL7VA770EhWjclKTvfj
         KjvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689864679; x=1690469479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+O/muW1Nk3sbzumyk3oSyUNsgXn5aAFedNJT9XhjpY=;
        b=j/kUSwZYrZyahb31e3nH4alLVHOWR18OtaCZUPBLvLrchLsnbEk1vlSpacetFIi4Kk
         KfOP76xxWy7Y0uK8ap9LJIbFlkDXKjlbiSTqoK816Bz6q5WHjFWfS0lHUIfMovA87YdH
         srTmE9l7HwEANC3QEv+QVwx6+fi1vti7uzuL91yeKUssA6umBf8bLQvTbgpts1MwwDq2
         CcdAybOqKYPLZoMShu/a4f5YD7Gza5p+Aik8FdNRGCAcYZkgxH8jl5paqGtxW8Vd1HvU
         sRYy57/YfsLK0QnK1mx4ho0xu2Y3LSF+Uh3leooi0wrECDzXaLUmDTcvfCIj1ZNzaqkR
         4IRg==
X-Gm-Message-State: ABy/qLa7Iw/0l+NWk0ms0EveiLDtuMZkVqFN61kYZQnkS/xD7DLYygfK
        Fv0h6zpPvUNU1/DyaDkxGh31b5XbotrchfwIhEWqNA==
X-Google-Smtp-Source: APBJJlHzLfxkreBCbbsehsgY/9oCLGFmqhlHHCGSC7psLizhDkF/J99lwZeHjlYsqKv5zg/EMj03GOKDYYgPtq4NGEY=
X-Received: by 2002:a1f:3d44:0:b0:481:4092:99c with SMTP id
 k65-20020a1f3d44000000b004814092099cmr2773384vka.0.1689864676288; Thu, 20 Jul
 2023 07:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me> <20230605-ep93xx-v3-1-3d63a5f1103e@maquefel.me>
In-Reply-To: <20230605-ep93xx-v3-1-3d63a5f1103e@maquefel.me>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 20 Jul 2023 16:51:05 +0200
Message-ID: <CAMRc=MeXCLzwjPEap_OD7tA+xVsMOU1DNxMbxbZVPaWg4Xdr8w@mail.gmail.com>
Subject: Re: [PATCH v3 01/42] gpio: ep93xx: split device in multiple
To:     nikita.shubin@maquefel.me
Cc:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Lennert Buytenhek <kernel@wantstofly.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Lukasz Majewski <lukma@denx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Mark Brown <broonie@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Peters <mpeters@embeddedts.com>,
        Kris Bahnsen <kris@embeddedts.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
        netdev@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-input@vger.kernel.org, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Jul 20, 2023 at 10:29=E2=80=AFAM Nikita Shubin via B4 Relay
<devnull+nikita.shubin.maquefel.me@kernel.org> wrote:
>
> From: Nikita Shubin <nikita.shubin@maquefel.me>
>
> This prepares ep93xx SOC gpio to convert into device tree driver:
> - dropped banks and legacy defines
> - split AB IRQ and make it shared
>
> We are relying on IRQ number information A, B ports have single shared
> IRQ, while F port have dedicated IRQ for each line.
>
> Also we had to split single ep93xx platform_device into multiple, one
> for each port, without this we can't do a full working transition from
> legacy platform code into device tree capable. All GPIO_LOOKUP were
> change to match new chip namings.
>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
