Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481D9527111
	for <lists+linux-pwm@lfdr.de>; Sat, 14 May 2022 14:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbiENMw4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 14 May 2022 08:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiENMwz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 14 May 2022 08:52:55 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859D71A048
        for <linux-pwm@vger.kernel.org>; Sat, 14 May 2022 05:52:54 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id fd25so352171edb.3
        for <linux-pwm@vger.kernel.org>; Sat, 14 May 2022 05:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WO6AgLCozZ3wyGfGPtWW8oIaWuQ2FPFTNopFE1zWXCk=;
        b=1ocVqVOjl+AiZN8QRXqQsVoIAZEVlvK3+xwSuhpZ0SAAm9IEHKmRNazgZwPSuZAzaM
         ZcsWn5gcMB6r7v/11YznNEEZcuTzkfOF6HomjGtEessS+FtHm2VaE/HzAz5BRKmtWxf8
         DnjhwiNZ+AMtxWMRh3XgaFHdZ5pcCE1yY7Ns+jBwPmw/g4nYuyxVuK9VpHN4vwwPo6zA
         V0zazsl7NX58V7upR8q10MTx9xU5plVnMPaA8v3Fd32V39BIADrYe2qMhKbF6W4LTU3N
         ZQn8TOiHMs0i6l7lUEBoFTWLmOCFJ9cIw5+0fWGeEe7HYiOPPXzdMR6dnDrLi2zXeJAq
         iV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WO6AgLCozZ3wyGfGPtWW8oIaWuQ2FPFTNopFE1zWXCk=;
        b=mqe+XHs6wG7hDX6ItHn58giCGcyZql5aQk1sagUZIGZOhE6SmNIKGpxq7j+HxRj2db
         BoUH1mfELexP1iWR/7H18o1S+4ufihsDVWdmQVOZCqir76UllJP76xXkjqXozpe2PS1r
         U3AgI05yhQbB+piToc/38DWmnj69vFHfbLWT9q1IIIFpnMYHRklXJXPAobnfqgwglxcs
         rjKFdyIBDzi1Gmo89S2iPb1CU8pgqnGwwLc6joEcs7QyXMH/u6lxE7KQ8+Aru/4FtVV5
         EK4GmO68KvzpLqudZv4YdikeUZWy/R+B2LPUCN2AXX9Ttnwo+rNQ2IE6gU+aD0gJhcYg
         iNrw==
X-Gm-Message-State: AOAM532aggf9PIug/KsRpWmNM/ivmRFt3XtsivSBhERIdti2Vbh9WI8a
        +cTGZ5SJmJSBdn7Y+n8m0eXJHMd/3tnb0F+Uxe0X+w==
X-Google-Smtp-Source: ABdhPJwUmJb43pzTm/L8s79tD1jHSHyjOMK3KWZ616L87t9f6hhh7jX+ZEQ48khCBGU5R0kTsjVnkDq9PNJRv0ShmnE=
X-Received: by 2002:aa7:da12:0:b0:427:b434:a374 with SMTP id
 r18-20020aa7da12000000b00427b434a374mr3644706eds.408.1652532773139; Sat, 14
 May 2022 05:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220511075856.88687-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20220511075856.88687-1-u.kleine-koenig@pengutronix.de>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Sat, 14 May 2022 14:52:42 +0200
Message-ID: <CAMRc=Mf4XfBMwt-M39kxXknf7LN4YkYEVe4Jyx13qEo0FLZk3Q@mail.gmail.com>
Subject: Re: [PATCH] gpio: mvebu/pwm: Refuse requests with inverted polarity
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        Rob Herring <robh@kernel.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, May 11, 2022 at 9:59 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> The driver doesn't take struct pwm_state::polarity into account when
> configuring the hardware, so refuse requests for inverted polarity.
>
> Fixes: 757642f9a584 ("gpio: mvebu: Add limited PWM support")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/gpio/gpio-mvebu.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> index 4c1f9e1091b7..92ecaea2d5d4 100644
> --- a/drivers/gpio/gpio-mvebu.c
> +++ b/drivers/gpio/gpio-mvebu.c
> @@ -707,6 +707,9 @@ static int mvebu_pwm_apply(struct pwm_chip *chip, str=
uct pwm_device *pwm,
>         unsigned long flags;
>         unsigned int on, off;
>
> +       if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +               return -EINVAL;
> +
>         val =3D (unsigned long long) mvpwm->clk_rate * state->duty_cycle;
>         do_div(val, NSEC_PER_SEC);
>         if (val > UINT_MAX + 1ULL)
>
> base-commit: 3123109284176b1532874591f7c81f3837bbdc17
> --
> 2.35.1
>

Applied, thanks!

Bart
