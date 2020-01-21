Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E53C143583
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Jan 2020 03:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgAUCAR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 20 Jan 2020 21:00:17 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35971 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbgAUCAR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jan 2020 21:00:17 -0500
Received: by mail-qk1-f194.google.com with SMTP id a203so1245434qkc.3;
        Mon, 20 Jan 2020 18:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=upNueX43qx8SNiTkkymLpWe1nZzcm1rfEbeUh4i39po=;
        b=IFupxmd60gC+cjVHiSKGpYfpmgQ/wjjHeohRWFcSHq/k2/sV+q9HSle4UMjyAIsz5X
         DAZAEHs+ZHF57rw9lqwOk7NW6PPmI3eneDGvx+Ac/GusWGZkrc05xuGy8xHtuAQxV3e3
         Geu6jk+DTGgjZLM059mWRXqskObBKD6R1MAp3SBV1r0sSIgNUqfZ1/7jlLlAb9HMqMGS
         qjOT3GdpnWI9nD9S1ysiGOOngvVD5s0bsIAwM/NgNbrLRstU+nxKryGa2smYcPpCf6xS
         wbCWKPjzf1eFq3GXBOl1P7eBrGk64eYgqUvtjJud8K9SaxPvM77BceJzrxrHYlQED2gL
         mR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=upNueX43qx8SNiTkkymLpWe1nZzcm1rfEbeUh4i39po=;
        b=OvOth2iJTikPgijYlReNiHLQQGfp5uGDzJNEK1QkZqzml1MiLtRyCbcia5nFzhwhdt
         TFz2b4uhEDr44CKyI0cQhafM7w37WTDhMuMs2fBIqV+WolgnZfQYQJJ5d1GE0QAQI9sQ
         lS63SyixmgkrufaBba3eN6VDphWys+anbfU2WUhWtVY4Y3sqDl4a4efitxUXDjE0HsVA
         /dp90r3dFtSTGQEcB58EVskq/WyFWTiKwVBUVYjVrFtw8tBjR0lZvPpqZcpBtT0q63KN
         BsC6AACrBl/1oRNUcp3+gQK7En5d9SVChADkGhYLQQWMg5GLe/UigY2HI5kNv42H6Jj0
         1Umg==
X-Gm-Message-State: APjAAAUqu+qK+2xVdOHOEO9bOYBtfpX+HenqMe8mofIXTeK9GlElM06D
        7bq2V/6R9dfwBh7/DsaFTfqDNAOHTAVQNxq/Y+8=
X-Google-Smtp-Source: APXvYqy/kX8nvfjkwgUvD3CgwDoEmqiPhRp2Xir/IzRoqOTnx5cVtKlMi3AzJkpSEHZqIIXm0tVxDgbFh6vxtqzz3Zg=
X-Received: by 2002:a37:5d0:: with SMTP id 199mr2327381qkf.131.1579572016362;
 Mon, 20 Jan 2020 18:00:16 -0800 (PST)
MIME-Version: 1.0
References: <20200120193328.17007-1-uwe@kleine-koenig.org>
In-Reply-To: <20200120193328.17007-1-uwe@kleine-koenig.org>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Mon, 20 Jan 2020 18:01:04 -0800
Message-ID: <CA+E=qVeEscYryOjD4FB+EH=JqFg6bVA3PHbx7sWrR7=9Zn003g@mail.gmail.com>
Subject: Re: [PATCH] ARM: s3c24xx/rx1950: switch to atomic pwm API
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Jan 20, 2020 at 11:33 AM Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.o=
rg> wrote:
>
> Stop using the legacy PWM API which only still exists because there are
> some users left.
>
> Note this change make use of the fact that the value of struct
> pwm_state::duty_cycle doesn't matter for a disabled PWM and so its value
> can stay constant simplifying the code a bit.
>
> A side effect of the conversion is that the pwm isn't stopped in
> rx1950_backlight_init() by the call to pwm_apply_args() just before
> reenabling it when rx1950_lcd_power(1) is called.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org>

Reviewed-by: Vasily Khoruzhick <anarsoul@gmail.com>

> ---
>  arch/arm/mach-s3c24xx/mach-rx1950.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/mach-s3c24xx/mach-rx1950.c b/arch/arm/mach-s3c24xx/=
mach-rx1950.c
> index 29f9b345a531..03d8f27cdc32 100644
> --- a/arch/arm/mach-s3c24xx/mach-rx1950.c
> +++ b/arch/arm/mach-s3c24xx/mach-rx1950.c
> @@ -377,6 +377,7 @@ static struct pwm_lookup rx1950_pwm_lookup[] =3D {
>  };
>
>  static struct pwm_device *lcd_pwm;
> +static struct pwm_state lcd_pwm_state;
>
>  static void rx1950_lcd_power(int enable)
>  {
> @@ -429,15 +430,16 @@ static void rx1950_lcd_power(int enable)
>
>                 /* GPB1->OUTPUT, GPB1->0 */
>                 gpio_direction_output(S3C2410_GPB(1), 0);
> -               pwm_config(lcd_pwm, 0, LCD_PWM_PERIOD);
> -               pwm_disable(lcd_pwm);
> +
> +               lcd_pwm_state.enabled =3D false;
> +               pwm_apply_state(lcd_pwm, &lcd_pwm_state);
>
>                 /* GPC0->0, GPC10->0 */
>                 gpio_direction_output(S3C2410_GPC(0), 0);
>                 gpio_direction_output(S3C2410_GPC(10), 0);
>         } else {
> -               pwm_config(lcd_pwm, LCD_PWM_DUTY, LCD_PWM_PERIOD);
> -               pwm_enable(lcd_pwm);
> +               lcd_pwm_state.enabled =3D true;
> +               pwm_apply_state(lcd_pwm, &lcd_pwm_state);
>
>                 gpio_direction_output(S3C2410_GPC(0), 1);
>                 gpio_direction_output(S3C2410_GPC(5), 1);
> @@ -493,10 +495,13 @@ static int rx1950_backlight_init(struct device *dev=
)
>         }
>
>         /*
> -        * FIXME: pwm_apply_args() should be removed when switching to
> -        * the atomic PWM API.
> +        * This is only required to initialize .polarity; all other value=
s are
> +        * fixed in this driver.
>          */
> -       pwm_apply_args(lcd_pwm);
> +       pwm_init_state(lcd_pwm, &lcd_pwm_state);
> +
> +       lcd_pwm_state.period =3D LCD_PWM_PERIOD;
> +       lcd_pwm_state.duty_cycle =3D LCD_PWM_DUTY;
>
>         rx1950_lcd_power(1);
>         rx1950_bl_power(1);
> --
> 2.24.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
