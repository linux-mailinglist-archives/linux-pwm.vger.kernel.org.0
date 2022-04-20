Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0C1508F11
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Apr 2022 20:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381398AbiDTSLk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Wed, 20 Apr 2022 14:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381413AbiDTSLf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 20 Apr 2022 14:11:35 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBDC43ADF;
        Wed, 20 Apr 2022 11:08:48 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id f22so1552634qtp.13;
        Wed, 20 Apr 2022 11:08:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zyOE8mDZ00P3MdY5kzGazi0B5mOpofh1HCzN73tPPe4=;
        b=HnoUU1Z2Lu7B8Za0tIfoBOKolJbUbtL9CvFiUxrGSA29IU80s0M4ED6vOs4DUiwskw
         6dmm1eVJjY8SR86Cphic/EcdFqIIWcuwnB8JeSTl5siOYyJVdOUpZdwnyYGeF0vxCnP5
         +wDJzWzs8vhlZtOTRCSvKPxFUqZSyJ4clOHdSlWP6sCy3XrpHJ13AJZ/KiOOnVXThl8V
         KGMEDfs5/R3KvxGlv4e8uvvApKxW/URObe0UN4TcYpuw/99cNcx4vEAr59fZ/Vv3smxi
         rnoptXZPe0Lwq9xgce9e0W1iFsNElqCD0vcoSrkawiBpDAjeTPhd3lYPF6u3d4ipzEC/
         zv5A==
X-Gm-Message-State: AOAM531ghmmGc2JJtN+Zx5mhCFk6mCZGmHX5+0/R03cTZJTBqEd3C8eZ
        o7ch/LhYQXVmQS5TODm4nfhBnAChv18DGdrv
X-Google-Smtp-Source: ABdhPJwITNFXRo2RrY3Gd2Ua2PNn5zdfkThq3k7YM4Cmm41YLv8HEAG+1fh1Sso2CUw3HLlEIZCHFQ==
X-Received: by 2002:a05:622a:40d:b0:2f3:3d14:6959 with SMTP id n13-20020a05622a040d00b002f33d146959mr5046440qtx.519.1650478126983;
        Wed, 20 Apr 2022 11:08:46 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id k66-20020a37ba45000000b0069c5adb2f2fsm1867663qkf.6.2022.04.20.11.08.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 11:08:46 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id j2so4394720ybu.0;
        Wed, 20 Apr 2022 11:08:46 -0700 (PDT)
X-Received: by 2002:a25:3492:0:b0:645:6f78:b3b4 with SMTP id
 b140-20020a253492000000b006456f78b3b4mr965359yba.546.1650478126065; Wed, 20
 Apr 2022 11:08:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220420121240.67781-1-u.kleine-koenig@pengutronix.de> <20220420121240.67781-6-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20220420121240.67781-6-u.kleine-koenig@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 20 Apr 2022 20:08:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWL=eLbd-U3hjgt9NkyDGQSxC4SfNxdf-odNFGskf1cUw@mail.gmail.com>
Message-ID: <CAMuHMdWL=eLbd-U3hjgt9NkyDGQSxC4SfNxdf-odNFGskf1cUw@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] pwm: renesas-tpu: Improve maths to compute
 register settings
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Wed, Apr 20, 2022 at 2:12 PM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
> The newly computed register values are intended to exactly match the
> previously computed values. The main improvement is that the prescaler
> is computed without a loop that involves two divisions in each step.
> This uses the fact, that prescalers[i] = 1 << (2 * i).
>
> Assuming a moderately smart compiler, the needed number of divisions for
> the case where the requested period is too big, is reduced from 5 to 2.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks for your patch!

> --- a/drivers/pwm/pwm-renesas-tpu.c
> +++ b/drivers/pwm/pwm-renesas-tpu.c
> @@ -244,7 +244,6 @@ static void tpu_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
>  static int tpu_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>                           int duty_ns, int period_ns, bool enabled)
>  {
> -       static const unsigned int prescalers[] = { 1, 4, 16, 64 };
>         struct tpu_pwm_device *tpd = pwm_get_chip_data(pwm);
>         struct tpu_device *tpu = to_tpu_device(chip);
>         unsigned int prescaler;
> @@ -254,26 +253,47 @@ static int tpu_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>         u32 duty;
>         int ret;
>
> +       clk_rate = clk_get_rate(tpu->clk);
> +
> +       period = clk_rate / (NSEC_PER_SEC / period_ns);
> +
>         /*
> -        * Pick a prescaler to avoid overflowing the counter.
> -        * TODO: Pick the highest acceptable prescaler.
> +        * Find the minimal prescaler in [0..3] such that
> +        *
> +        *      period >> (2 * prescaler) < 0x10000

scripts/checkpatch.pl:
WARNING: please, no space before tabs

> +        *
> +        * This could be calculated using something like:
> +        *
> +        *      prescaler = max(ilog2(period) / 2, 7) - 7;

WARNING: please, no space before tabs

The rest LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
