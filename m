Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2D8677ED4
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Jan 2023 16:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjAWPMV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Jan 2023 10:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbjAWPMU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Jan 2023 10:12:20 -0500
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0AE976F
        for <linux-pwm@vger.kernel.org>; Mon, 23 Jan 2023 07:12:20 -0800 (PST)
Received: by mail-vk1-xa34.google.com with SMTP id b81so6092519vkf.1
        for <linux-pwm@vger.kernel.org>; Mon, 23 Jan 2023 07:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOYn37Kzz7UT5OjuarLO6dELvwi+HvDsiTTvNIZfI/c=;
        b=p5/HBVV4nyFMzfpQL82ckv7xcrV855WYAulTjyVpKePTMC73WP/c5Ix3p4+j4EIv/7
         FduUac7Q7quHSnRZlKHOn2LriPbIf1UQI3SDSgfYCwg55LBlumWKkJfViWjhXrc5gag1
         J1BW/daUSvCzhUgzgRUh+W18TA1JHAqqYMirzLWMtdq6eVBu60dfIBVFZiM0pYY0zKWd
         VuQGCiOyE72cLXoKDFTeK/qc7/qSn0AuwXkESBj+9PnS+a9paZDSLfO2da/7bnDjFNyp
         FqtlY3jFPHA1Mhvk4XJrpq3WXyoRyyrkbEAWWvpUdGYwTrfPVdo99RWTO6AVmrMEpWGM
         /8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tOYn37Kzz7UT5OjuarLO6dELvwi+HvDsiTTvNIZfI/c=;
        b=7XQzk3kRImQvM5lUE0E46skl8VaBCEv0TLK9FuQnNrWDTs9+5xHEcX22m1x+8P8Rz1
         qDbbjUaJ6Zdv9EuPgdnTNvEuArYRhEXWiKZbKNij8hA474EZAS7F+mBZZIWh0qAK6dSU
         jDG9nRaQiIAtzL1GqxWw7B3dzQA5+pPSOBS/59tuv/PskDrJXOcLGlOZKFQyU2lNeYzs
         8VOBGNrAiw45kfBzXlBo+milxZwzz6sYYtDapFTJ2pLzkUDEyzxZSB/I8hDelA3FnHfJ
         P0ygjlMk+Y4dot9nXH7KRpoc4ahFP1N5zfjZTkVN2b3PEr4IbCQQgXipE947ls1if03M
         nySA==
X-Gm-Message-State: AFqh2koeNaza+2oHL6F2eB2jJyNhJlIf8FE2zrw+vWsekQPyOTtZLb7Q
        zWM5BsPf3QcKkQhQWDQMCg6wtbPlV6cLDe+PHxJKFg==
X-Google-Smtp-Source: AMrXdXuxp9FC8rIx6ZdvOjegXM1mL5T8T9KdzILazCupaAewyGisElsh3TVHlQH65p4Skth7GVbO5NrIkZDZtBQc/As=
X-Received: by 2002:a1f:9b53:0:b0:3e1:db78:6cd9 with SMTP id
 d80-20020a1f9b53000000b003e1db786cd9mr2007544vke.25.1674486739191; Mon, 23
 Jan 2023 07:12:19 -0800 (PST)
MIME-Version: 1.0
References: <20230120075333.142223-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230120075333.142223-1-u.kleine-koenig@pengutronix.de>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 23 Jan 2023 16:12:08 +0100
Message-ID: <CAMRc=MdX=2nMZ3AkWpzeh6zbB+QM66j1ieQT-r+EuRTaYRuFhg@mail.gmail.com>
Subject: Re: [PATCH] gpio: mvebu: Use IS_REACHABLE instead of IS_ENABLED for CONFIG_PWM
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Jan 20, 2023 at 8:53 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> To check if a certain function (here e.g. pwmchip_add()) can be called
> IS_REACHABLE is the better check. The relevant difference to IS_ENABLED
> is that IS_REACHABLE evaluates to 0 if the current code is builtin but th=
e
> checked symbol is =3Dm and so must not be used.
>
> Today there is no practical impact as CONFIG_PWM is a bool.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/gpio/gpio-mvebu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> index 91a4232ee58c..a68f682aec01 100644
> --- a/drivers/gpio/gpio-mvebu.c
> +++ b/drivers/gpio/gpio-mvebu.c
> @@ -1002,7 +1002,7 @@ static int mvebu_gpio_suspend(struct platform_devic=
e *pdev, pm_message_t state)
>                 BUG();
>         }
>
> -       if (IS_ENABLED(CONFIG_PWM))
> +       if (IS_REACHABLE(CONFIG_PWM))
>                 mvebu_pwm_suspend(mvchip);
>
>         return 0;
> @@ -1054,7 +1054,7 @@ static int mvebu_gpio_resume(struct platform_device=
 *pdev)
>                 BUG();
>         }
>
> -       if (IS_ENABLED(CONFIG_PWM))
> +       if (IS_REACHABLE(CONFIG_PWM))
>                 mvebu_pwm_resume(mvchip);
>
>         return 0;
> @@ -1228,7 +1228,7 @@ static int mvebu_gpio_probe(struct platform_device =
*pdev)
>         devm_gpiochip_add_data(&pdev->dev, &mvchip->chip, mvchip);
>
>         /* Some MVEBU SoCs have simple PWM support for GPIO lines */
> -       if (IS_ENABLED(CONFIG_PWM)) {
> +       if (IS_REACHABLE(CONFIG_PWM)) {
>                 err =3D mvebu_pwm_probe(pdev, mvchip, id);
>                 if (err)
>                         return err;
> --
> 2.39.0
>

Applied, thanks!

Bart
