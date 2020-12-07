Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619322D1490
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Dec 2020 16:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgLGPWI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Dec 2020 10:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgLGPWG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Dec 2020 10:22:06 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBBCC061794
        for <linux-pwm@vger.kernel.org>; Mon,  7 Dec 2020 07:21:26 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id y24so12782283otk.3
        for <linux-pwm@vger.kernel.org>; Mon, 07 Dec 2020 07:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ug6sR1NNxKyqJuNn9raTOZ0eBcqiGnpeBz5iiMjv4F0=;
        b=IGJXa4Yd6GTWtmVpZ/E/xABvvp56vBip6jTohEvkdis43Z0ehvgpQTM/isJlrjJIgl
         mHS+iA1hb/8j5k9XxB9Y7Ll5CpxXnEWlPGvY1QeC3Sh/pfAIN9o2qb8cPYtLGEpjTBxN
         53fPBfq+1MFoD95//mTaKjRZdX8UIsPehOLDMNSvbufm2MtEvrOx1fDQ/4YrRTD1QnLA
         cR0JNw1cWjegPEjEKj1j03kVMLu4cc0vT4vtf5S2isY5aYgPQorg0BnziqTLHNo/m78m
         up642AJkdDo3Cs/oubKyi9XWEk6mB8T/F0oIa33cksmAMWxYA+g7ytxK3q0h7hr2Y9ix
         umRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ug6sR1NNxKyqJuNn9raTOZ0eBcqiGnpeBz5iiMjv4F0=;
        b=R7K1DJ4DodUi8E4V7A8xUrlUHLGq12JnAm6RYFm/D4ScyaoiEVfSw0HOMslw73ULOY
         yKa65VSgi4OZG5XvE0UMiLT8As2jmM7RcxTRVibebAtkZpZLTNQ0S9mJzI98STVYcZKa
         MSOFIfuSykMEgrReo5bVOHQqQS6QrULrj9ARYeQHoo06YUqwtRtw7Qsbylg3SFTwSzn2
         DBwmtAa1BQRPPa9QDPRYJGcm4fG7rG3ArCPjAT9IWD5xpCAY7R1aal98DJICj62n0E1X
         w8q8pxIKL6NAYT0ndx7b1dYX3Vwp089c1/2XKU/az6sw7nLm6fDzyP1lDq/LHGENHHaf
         8QlA==
X-Gm-Message-State: AOAM532+5nbEaXkTSGUZGCbux+xzeAoBlHTHaGP8MqGLPMxyy/0K2wZY
        AyP776cF/dy0X/AQPBr5qOitcNUgPKHIu7i2og==
X-Google-Smtp-Source: ABdhPJwjeRwPRB2w5x61eO54Zk84xI4iJaxOtx5bfvgiUIkbijUbYE103qS96N7CqIAWFNVsEig2AaoE2otaX2vIHnk=
X-Received: by 2002:a9d:269:: with SMTP id 96mr13125388otb.174.1607354486264;
 Mon, 07 Dec 2020 07:21:26 -0800 (PST)
MIME-Version: 1.0
References: <20201207141324.25945-1-uwe@kleine-koenig.org>
In-Reply-To: <20201207141324.25945-1-uwe@kleine-koenig.org>
From:   Johannes Pointner <h4nn35.work@gmail.com>
Date:   Mon, 7 Dec 2020 16:20:12 +0100
Message-ID: <CAHvQdo2hEdxzV8REEGs1Q-=z1jiq9B43iD4M4EMw8W=GdaLTdQ@mail.gmail.com>
Subject: Re: [PATCH] pwm: imx27: fix overflow for bigger periods
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Uwe,

On Mon, Dec 7, 2020 at 3:13 PM Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org=
> wrote:
>
> The second parameter of do_div is an u32 and NSEC_PER_SEC * prescale
> overflows this for bigger periods. Assuming the usual pwm input clk rate
> of 66 MHz this happens starting at requested period > 606060 ns.
>
> Splitting the division into two operations doesn't loose any precision.
> It doesn't need to be feared that c / NSEC_PER_SEC doesn't fit into the
> unsigned long variable "duty_cycles" because in this case the assignment
> above to period_cycles would already have been overflowing as
> period >=3D duty_cycle and then the calculation is moot anyhow.
>
> Fixes: aef1a3799b5c ("pwm: imx27: Fix rounding behavior")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org>

This fixes my issue with the pwm-backlight, thanks.

Tested-by: Johannes Pointner <johannes.pointner@br-automation.com>

> ---
> Hello,
>
> for a similar patch I said "that looses more precision than I thought at
> first", but I think this was wrong. And if it looses precision the same
> applies to the calculation of period_cycles which uses the same
> operations.
>
> I'm a bit at doubt how urgent this patch is. The regression was
> introduced in 5.8-rc1.
>
> Best regards
> Uwe
>
>  drivers/pwm/pwm-imx27.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> index c50d453552bd..86bcafd23e4f 100644
> --- a/drivers/pwm/pwm-imx27.c
> +++ b/drivers/pwm/pwm-imx27.c
> @@ -235,8 +235,9 @@ static int pwm_imx27_apply(struct pwm_chip *chip, str=
uct pwm_device *pwm,
>
>         period_cycles /=3D prescale;
>         c =3D clkrate * state->duty_cycle;
> -       do_div(c, NSEC_PER_SEC * prescale);
> +       do_div(c, NSEC_PER_SEC);
>         duty_cycles =3D c;
> +       duty_cycles /=3D prescale;
>
>         /*
>          * according to imx pwm RM, the real period value should be PERIO=
D
> --
> 2.29.2
>
