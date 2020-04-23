Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2681B5832
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Apr 2020 11:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgDWJad (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 23 Apr 2020 05:30:33 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35593 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgDWJac (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 23 Apr 2020 05:30:32 -0400
Received: by mail-ot1-f68.google.com with SMTP id e26so4942693otr.2;
        Thu, 23 Apr 2020 02:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DAFEaIw+YJECIu6KkXt28inGdxPuKLoHycQLyEzAFf0=;
        b=dlHWsQQ+cHS/6+/tj0qoBjmLigbGbjCeieiG/H9SeOFZ635x4EQUDw5q17b9cuo6fY
         7XovfF80DoMM25FpTaBWe1J0zdcFL5W1YZdbmUCKRHa4lqGlCmUgObA8kurYJEwb6MzS
         mTpmn6mTdlUTIpajKApSJnaZ6bitmuENgr00LKmUgtTPwNpeRvOY0eNN2EwncY2sBLvr
         19ssFu2DwdtqRXQCzyZg9MCN25VSPTjKMNZbLpfEQd3ZfiNWIZaXwItG56fb+HbsNpfH
         6POvyCdDdVimkokXEkt7blyruK0iazd50vdxh/2+6ScovvIb5pSnq9T/f0HBCfU22mNC
         nxXQ==
X-Gm-Message-State: AGi0PuaGF4rmfraaIK4YNYoVSAgDhrwiCntAYTFbuSKYzzgG0qHeNfJ+
        PxMEOCdv3cBxgH8d7miDFwEiffSTp1IM8yoQ6l4=
X-Google-Smtp-Source: APiQypJ/MjDmYMAVFpik1Y3Kh+6Z77kX5eWDhDlNhIRS30WEwE5L3s/peKKj7PbA0eAB5hjp0LeyXSEfeVp33ZIRQp8=
X-Received: by 2002:aca:d50f:: with SMTP id m15mr2340991oig.54.1587634230791;
 Thu, 23 Apr 2020 02:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1587523702.git.gurus@codeaurora.org> <02ba64d8289bf84a8d140f5a3c38ed64a9474d3b.1587523702.git.gurus@codeaurora.org>
In-Reply-To: <02ba64d8289bf84a8d140f5a3c38ed64a9474d3b.1587523702.git.gurus@codeaurora.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 23 Apr 2020 11:30:19 +0200
Message-ID: <CAMuHMdVOPKWL9u_4QCvcBZKFrW-7aKZonXjODqUx9HwS=CF09g@mail.gmail.com>
Subject: Re: [PATCH v13 04/11] pwm: clps711x: Cast period to u32 before use as divisor
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     Linux PWM List <linux-pwm@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Apr 22, 2020 at 5:00 AM Guru Das Srinagesh <gurus@codeaurora.org> wrote:
> Since the PWM framework is switching struct pwm_args.period's datatype
> to u64, prepare for this transition by typecasting it to u32.
>
> Also, since the dividend is still a 32-bit number, any divisor greater
> than the numerator will cause the quotient to be zero, so return 0 in
> that case to efficiently skip the division.
>
> Cc: Alexander Shiyan <shc_work@mail.ru>
> Cc: Arnd Bergmann <arnd@arndb.de>
>
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> ---
>  drivers/pwm/pwm-clps711x.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
> index 924d39a..0d368ac 100644
> --- a/drivers/pwm/pwm-clps711x.c
> +++ b/drivers/pwm/pwm-clps711x.c
> @@ -43,7 +43,10 @@ static void clps711x_pwm_update_val(struct clps711x_chip *priv, u32 n, u32 v)
>  static unsigned int clps711x_get_duty(struct pwm_device *pwm, unsigned int v)
>  {
>         /* Duty cycle 0..15 max */
> -       return DIV_ROUND_CLOSEST(v * 0xf, pwm->args.period);
> +       if ((u32)pwm->args.period > (v * 0xf))

Shouldn't the cast be removed from the expression above?
Else a period larger than or equal to 2^32 may be accepted, but truncated
silently.  And even cause a division by zero error.


> +               return 0;
> +
> +       return DIV_ROUND_CLOSEST(v * 0xf, (u32)pwm->args.period);
>  }
>
>  static int clps711x_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
