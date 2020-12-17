Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5F52DCB94
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Dec 2020 05:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbgLQECz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Dec 2020 23:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbgLQECz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Dec 2020 23:02:55 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491BFC061794;
        Wed, 16 Dec 2020 20:02:15 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id n18so8754765ual.9;
        Wed, 16 Dec 2020 20:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hc9MgMxjle8tsx50fauYlXYI4l9YIYzfEW4JfNC1jYU=;
        b=ePvsx85fjmj4j/HPlD1uky6PKm64FW/6BjOxKVDdTHRCx9Yr8HpsmKZegJ/UQK9Jnp
         kyq51hRJ9sft30QIfMb/Cn/LJD3uK2B1/fWKgzF6FpP8ZO503GqORmNKev02z+mX4PKL
         ARW8EkU6rJKGrZjaAZwrSe7m8Jgbw9jYdy3xokC0xMQmdptp7y+0tFYTSKBiqlloU9lK
         /+OO93ZesQeytr3Gqyor5OoS3zrD67bHcL0RKVxzr3oTqSanOT5xHtCQDcnK6Fh7dN0n
         KqB2v2QeDh7NEa9ujrT1aYUnPDWHVla1CXL21CgiH/NkN7sae11cpuL3kx00gL1U/nhu
         DNwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hc9MgMxjle8tsx50fauYlXYI4l9YIYzfEW4JfNC1jYU=;
        b=tUIv3rGHZfzMK2OMKQL9I3PflPs0UevADMe6F7CKoGCgDreoCgA1VgHLg6Kqk33BBa
         bosJZ8pt1ZS0vwe61/cNa89p1za6dmjlvrIll5HrglW9or7mtoHraTXGb7ByS5nlk5rI
         pjIu5gNIALoSgHrvLUjZB9OgHzLKzujtm1fs1H59QLYKVEwUMolTRCoJmf6Lo0K4ZiO2
         F8DcejiRjnfUCuRESLjKCiqA6vvYSTy7WtnXvtx6iJbposZQUxH/QhRZA4VTryEn2XaK
         CQ3cqM1aQTx0anD9Xgi1inxqa0uwthh25mA7IQpWqhTy3YDAAlQjaTWASefq0iJgFQfc
         KOvQ==
X-Gm-Message-State: AOAM533dCllal3oa1QEd3x6PieKoHVXWK8q4obSs9PUotWKBVPrhafVt
        iGLadJi43mCsNB84Q7u1IB4OA8YUoiPZJVobQ3Q=
X-Google-Smtp-Source: ABdhPJyn0yPpTonScWqZTYeJE8+x2WlZYwtWZBmtvZ9gbYfDAf0wNPhOJ8liZLM4NiDcEM8AwRcAwdQkn4uDXfR/6GM=
X-Received: by 2002:ab0:2a1a:: with SMTP id o26mr35600365uar.101.1608177734444;
 Wed, 16 Dec 2020 20:02:14 -0800 (PST)
MIME-Version: 1.0
References: <20201215212228.185517-1-clemens.gruber@pqgruber.com> <20201215212228.185517-4-clemens.gruber@pqgruber.com>
In-Reply-To: <20201215212228.185517-4-clemens.gruber@pqgruber.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 16 Dec 2020 23:02:03 -0500
Message-ID: <CAGngYiUj-4mnJKQYnyJXmvr21tCzhXJA-bGnCwMkJ-0RTSYnNw@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] pwm: pca9685: Reset registers to POR state in probe
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Clemens, minor nit below.

On Wed, Dec 16, 2020 at 7:53 AM Clemens Gruber
<clemens.gruber@pqgruber.com> wrote:
>
> Reset the prescale and ON/OFF registers to their POR default state in
> the probe function. Otherwise, the PWMs could still be active after a
> watchdog reset and reboot, etc.
>
> Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> ---
>  drivers/pwm/pwm-pca9685.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> index 7b14447f3c05..38aadaf50996 100644
> --- a/drivers/pwm/pwm-pca9685.c
> +++ b/drivers/pwm/pwm-pca9685.c
> @@ -47,6 +47,7 @@
>  #define PCA9685_ALL_LED_OFF_H  0xFD
>  #define PCA9685_PRESCALE       0xFE
>
> +#define PCA9685_PRESCALE_DEF   0x1E    /* => default frequency of ~200 Hz */
>  #define PCA9685_PRESCALE_MIN   0x03    /* => max. frequency of 1526 Hz */
>  #define PCA9685_PRESCALE_MAX   0xFF    /* => min. frequency of 24 Hz */
>
> @@ -446,9 +447,11 @@ static int pca9685_pwm_probe(struct i2c_client *client,
>         reg &= ~(MODE1_ALLCALL | MODE1_SUB1 | MODE1_SUB2 | MODE1_SUB3);
>         regmap_write(pca->regmap, PCA9685_MODE1, reg);
>
> -       /* Clear all "full off" bits */
> +       /* Reset ON/OFF registers to HW defaults (only full OFF bit is set) */
> +       regmap_write(pca->regmap, PCA9685_ALL_LED_ON_L, 0);
> +       regmap_write(pca->regmap, PCA9685_ALL_LED_ON_H, 0);
>         regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_L, 0);
> -       regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_H, 0);
> +       regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_H, LED_FULL);
>
>         pca->chip.ops = &pca9685_pwm_ops;
>         /* Add an extra channel for ALL_LED */
> @@ -470,8 +473,10 @@ static int pca9685_pwm_probe(struct i2c_client *client,
>         /*
>          * The chip comes out of power-up in the sleep state,
>          * but force it to sleep in case it was woken up before
> +        * and set the default prescale value
>          */
>         pca9685_set_sleep_mode(pca, true);
> +       regmap_write(pca->regmap, PCA9685_PRESCALE, PCA9685_PRESCALE_DEF);
>         pm_runtime_set_suspended(&client->dev);
>         pm_runtime_enable(&client->dev);

Consider making it clearer that prescale can only be touched when the chip is
in sleep mode. Suggestion:

    /* set the default prescale value - chip _must_ be in sleep mode */
    regmap_write(pca->regmap, PCA9685_PRESCALE, PCA9685_PRESCALE_DEF);

>
> --
> 2.29.2
>
