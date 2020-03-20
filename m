Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9C7018D52D
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2020 18:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgCTRBL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 20 Mar 2020 13:01:11 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:56023 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbgCTRBK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 20 Mar 2020 13:01:10 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MX0TX-1imu6v25lJ-00XPP7; Fri, 20 Mar 2020 18:01:08 +0100
Received: by mail-lf1-f51.google.com with SMTP id c20so5140092lfb.0;
        Fri, 20 Mar 2020 10:01:08 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1rHK5rlQjWw/XySbV+sZ/2LoVXs1uOeUHnh6FBsZzawPnhnek0
        iVwoQ2S0bthTqczRidse38AWaJbRiuHsnhnMBSE=
X-Google-Smtp-Source: ADFU+vs11pX+reUDgLeQDaNz7AxXUjMOz6ru7xtpyHb1hOnhmeTTSEtRFhdxQ1s9xNp2TquEQ7Y9zb6/vWld8Xi/00c=
X-Received: by 2002:a19:224f:: with SMTP id i76mr775476lfi.123.1584723667933;
 Fri, 20 Mar 2020 10:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1584667964.git.gurus@codeaurora.org> <ab7b568b1d287949276b3b1c9efdb1cad1f92004.1584667964.git.gurus@codeaurora.org>
In-Reply-To: <ab7b568b1d287949276b3b1c9efdb1cad1f92004.1584667964.git.gurus@codeaurora.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 20 Mar 2020 18:00:51 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0XrYGYBQ_hTKF4fVBr7DDZsLnR+8o=09cig_gAje=v3w@mail.gmail.com>
Message-ID: <CAK8P3a0XrYGYBQ_hTKF4fVBr7DDZsLnR+8o=09cig_gAje=v3w@mail.gmail.com>
Subject: Re: [PATCH v11 11/12] clk: pwm: Assign u64 divisor to unsigned int
 before use
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     Linux PWM List <linux-pwm@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:FkWxRtsVpntOKqotl01jYTid96TMvDAWVWKuR5UA91jb0xTVbDb
 FNkpLE4G+ia2YeYF+6+51lQ9owsRaxLCkfyrXCxDTV7P7EYu/3sbZjx3b9vo1bJkHfd+J1G
 4tvsjPQ1dp/nEIkTN9bFVGjfGpGzO5Y/EpmQc43W54XSNPyX4uxqbfX8nLlUFUemSe28piK
 qcaFY3Y0+Ib2UTw5sB9rw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vfeYetgxPG8=:ADg2pdzcsVuv8wCU6KA12o
 HQqGWuHott0KDj9TEgeU0SUSpeJDudJuQv6WUrwNlDf1oiV6P+254GiDP8CiQ5AXK7DsYJw2c
 fkGNf/6cnKFhluvIIF/+La7XP4L8ci8IJmJ9ryQ2edS//jJ7vLW0GkW5L9JZ1CAB5dO5C1chl
 wxA7eiI/fVRKrM14IqIROOnlwS/xrdMeokZZJlEurZOL0dC3sMpsdGqDPs7JlOi/lqMtXmhvh
 k/Zy+CV3zJi0EaImSl62sMctDmTSd4RK5wbCWOKCkixJjIL1nL9ZVw1I+4E11ZyYPe1B3CYl4
 nkNlr8HVgGS3PdoGrMBdb+iT85/kBFGujoItLaNJFeW7nnApeEkY39CPQWl6cXhlsMpLA6dfH
 iVgSSsG+LLpTbKS7T95mmjvncs4/BF16PAyoNly8dqmpo5Cn9zhbe4koWetgVPayYgzAXTmdo
 Ee+kjmchKimyjQ5i4u4S/WibTcIy1j+lim/uCKd3lBB1P8KK92jpmpp9LIbYynFEoMoV0gAHL
 56odaasQ7PH5NgX7oVFTbLJx/DU8KQBFyE+4d5+AXC2pQ6PpSauRwULLfXdHK4qFZZaIzNxjg
 2ze8HztDupH+D4S9ZJ/q+Ck2SaHFgUo9FWuYgBp8X2eyhu7GvR5Jgeza2maUquPzsAbZxeJsA
 ZILigSq9xL36WtSr/V4oHYcr/6OgpxyWf83bdtTAOiHQrR1calg6Cv9rXM43zrMB+a2aFT9OB
 FbBcskHOwxiIE1FbyeJp8Ym/5FVEtGypXiN44/7GSMqbuGZLf/IfJ9c4sSlibvOiwVrPuX83H
 25BZ/5rbkFV+StU4fQPeMDNzp7DF47R1wrvkNzDrJMlofTZFxs=
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Mar 20, 2020 at 2:42 AM Guru Das Srinagesh <gurus@codeaurora.org> wrote:
>
> Since the PWM framework is switching struct pwm_args.period's datatype
> to u64, prepare for this transition by assigning the 64-bit divisor to
> an unsigned int variable to use as the divisor. This is being done
> because the divisor is a 32-bit constant and the quotient will be zero
> if the divisor exceeds 2^32.
>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: David Laight <David.Laight@ACULAB.COM>
>
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> ---
>  drivers/clk/clk-pwm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/clk-pwm.c b/drivers/clk/clk-pwm.c
> index 87fe0b0e..c0b5da3 100644
> --- a/drivers/clk/clk-pwm.c
> +++ b/drivers/clk/clk-pwm.c
> @@ -72,6 +72,7 @@ static int clk_pwm_probe(struct platform_device *pdev)
>         struct pwm_device *pwm;
>         struct pwm_args pargs;
>         const char *clk_name;
> +       unsigned int period;
>         int ret;
>
>         clk_pwm = devm_kzalloc(&pdev->dev, sizeof(*clk_pwm), GFP_KERNEL);
> @@ -88,8 +89,9 @@ static int clk_pwm_probe(struct platform_device *pdev)
>                 return -EINVAL;
>         }
>
> +       period = pargs.period;
>         if (of_property_read_u32(node, "clock-frequency", &clk_pwm->fixed_rate))
> -               clk_pwm->fixed_rate = NSEC_PER_SEC / pargs.period;
> +               clk_pwm->fixed_rate = NSEC_PER_SEC / period;
>
>         if (pargs.period != NSEC_PER_SEC / clk_pwm->fixed_rate &&
>             pargs.period != DIV_ROUND_UP(NSEC_PER_SEC, clk_pwm->fixed_rate)) {

Doesn't this one need a check for "pargs.period>UINT_MAX" or
"pargs.period > NSEC_PER_SEC"?

It looks like truncating the 64-bit value to a 32-bit type can result in
unexpected behavior.

       Arnd
