Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10AD6B81E3
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Mar 2023 20:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjCMTya (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 13 Mar 2023 15:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjCMTy3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 13 Mar 2023 15:54:29 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316F230B18
        for <linux-pwm@vger.kernel.org>; Mon, 13 Mar 2023 12:54:28 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id cy23so53264739edb.12
        for <linux-pwm@vger.kernel.org>; Mon, 13 Mar 2023 12:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1678737266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r1TeuIm6ayHjIy24Lm3ETv+nxzgalcm9KhKyxrfJQ8k=;
        b=n0gE71gKXxWqBOLCKophLCySCKtpSftsMH7F/l6SBwyRZF5jWw9Abi8PCE62XAPeK1
         svIW3bisv86v4MpohTZsk8+nDvnD5b3a2WUxoDgtGxjj/Lo1+36VHPYNBWusuTA7ENrJ
         zdRM/NZ0Nzg7qbpcqX45TDA/NK/ynrOcvuQTzB3sAvI0OSFtYSbucMQiDC7X/aeAXdL6
         00rxYpwJttwC4j0Zbpx8u3ys19tO4GlmkzPY8JkPSBDqbThqpVz74pukLv01+g4cZWm0
         amsNufYYTmCXHna0gpUob69JRlA0k7nJsQawOb9S58jWzmslss/l2v42664VS3s3gmF/
         tRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678737266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r1TeuIm6ayHjIy24Lm3ETv+nxzgalcm9KhKyxrfJQ8k=;
        b=yFy6NZBL1al9PUR+Iar+AuIHePkq9PTWJ7+3zwmGDClfsWjLNcqFzTlW1JMBL3PNb6
         HigzIAMMUf6Zyq3UDeKGMolAAL7i0Gdf/Jr8aao6oLh0DfMmyRpQmoiVRWXw8DUqtVge
         Dt4d843UU9XMAac9uRiz3wg0/j6jM1BanLqCU+zt76Q/76qDYwN/nYIxRsToFXL1n4QB
         XR1u16qB6m3+BsLastIIt4S1P2KEdyMtQf4L8sK2Z4rjDkinFbsDHSZfdmOV2YZjWLb9
         aXt3Vg+WnzwSfPfx8GnIS5y3Sdvk/SrfOh7usmHL9dyPGb9u5Zdj+As3HY0X/ciH0K3Y
         f/LA==
X-Gm-Message-State: AO0yUKWqelPhTumciDtBC2NVGWr630ufhNh0z6hU9vUBQMaQyqfdI0zY
        ejGHJmvHcauTSCgIdvk+3GVq18wcNSzMDw+IthY=
X-Google-Smtp-Source: AK7set/ef1AFRFqDEKbt/RkM7VrxwvnKeYXk/ywKWy6Q/J+AZLdhDuawXgnw9h/yqAuThr4Qf/VobiC8GSdSIObal8I=
X-Received: by 2002:a17:906:1749:b0:8b1:2fff:8689 with SMTP id
 d9-20020a170906174900b008b12fff8689mr18339374eje.6.1678737266469; Mon, 13 Mar
 2023 12:54:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230310191405.2606296-1-u.kleine-koenig@pengutronix.de>
 <CAFBinCCfqgBkHq2fFy=d+8C6nwq=wehu9nzePfwuY5ndfLMWoQ@mail.gmail.com>
 <1ja60h106q.fsf@starbuckisacylon.baylibre.com> <20230313095121.fsjw2gk3givwabvj@pengutronix.de>
In-Reply-To: <20230313095121.fsjw2gk3givwabvj@pengutronix.de>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 13 Mar 2023 20:54:15 +0100
Message-ID: <CAFBinCDDLEB1O5mAVzNugPKdXz7VWTJvw-peTXtu4xkTwLKsKA@mail.gmail.com>
Subject: Re: [PATCH] pwm: meson: Explicitly set .polarity in .get_state()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-pwm@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Munehisa Kamata <kamatam@amazon.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Mar 13, 2023 at 10:51=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
[...]
> Another option is to do something like that:
>
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 16d79ca5d8f5..25a177a3fa00 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -162,8 +162,10 @@ static int meson_pwm_calc(struct meson_pwm *meson, s=
truct pwm_device *pwm,
>         duty =3D state->duty_cycle;
>         period =3D state->period;
>
> -       if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
> +       if (state->polarity =3D=3D PWM_POLARITY_INVERSED) {
> +               WARN_ONCE(1, "Wrongly trying to support inversed polarity=
. Please report to linux-pwm@vger.kernel.org if you rely on this\n");
>                 duty =3D period - duty;
> +       }
>
>         fin_freq =3D clk_get_rate(channel->clk);
>         if (fin_freq =3D=3D 0) {
>
> and then drop that faked support in a year or so if nobody spoke up.
>
> Disclaimer: I assume Thierry is not a fan of this approach, he opposed
> similar warnings in the past.
I personally think it's fine to have this warning.
If Thierry has no objections in this case then it'll help us find
whether we really need proper support in PWM core or we can just
remove this fake support from pwm-meson


Best regards,
Martin
