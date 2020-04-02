Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 883F219CC3F
	for <lists+linux-pwm@lfdr.de>; Thu,  2 Apr 2020 23:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbgDBVQl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 2 Apr 2020 17:16:41 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:52329 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgDBVQl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 2 Apr 2020 17:16:41 -0400
Received: from mail-qv1-f50.google.com ([209.85.219.50]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MKbwg-1jckY00eB2-00KuMS; Thu, 02 Apr 2020 23:16:40 +0200
Received: by mail-qv1-f50.google.com with SMTP id g4so2530578qvo.12;
        Thu, 02 Apr 2020 14:16:39 -0700 (PDT)
X-Gm-Message-State: AGi0PubW960BbOYGA+eCL/BGLcnc4bI5yp2vWsrxMCKd/gUbcFctl7hQ
        fw3HCFhXGnHMvPvzMNwyeNHAzY5mQMPlLFN+IP0=
X-Google-Smtp-Source: APiQypJGA8+k1W79tcyerK0UIap1gN48lClpbItZKUsRTQsWMzf1R1BJyzlohgyMqPgn9cM9EZAnuMgggZ49T4oS3UY=
X-Received: by 2002:a0c:ec49:: with SMTP id n9mr5282512qvq.197.1585862198851;
 Thu, 02 Apr 2020 14:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1584667964.git.gurus@codeaurora.org> <5aae102e21c0e63ad2588ae1e174b48b06d25e96.1584667964.git.gurus@codeaurora.org>
 <CAK8P3a0qUMMMDmbp2FM-7D-U0Ys_zv0paYguFeyifafZurndEw@mail.gmail.com>
 <20200330204359.GB5107@codeaurora.org> <CAK8P3a1VC6+0Tydm=BoK2NvHB1ZCPjE1Gfi-sTE5O-xnu3Ya3A@mail.gmail.com>
 <20200331202058.GB25781@codeaurora.org> <20200331204929.GC2954599@ulmo> <20200402201654.GA9191@codeaurora.org>
In-Reply-To: <20200402201654.GA9191@codeaurora.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 2 Apr 2020 23:16:22 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3mc_sYczyKiaDoQLTTwDj2odwHJ5LFNAOb4RaRyh0YLQ@mail.gmail.com>
Message-ID: <CAK8P3a3mc_sYczyKiaDoQLTTwDj2odwHJ5LFNAOb4RaRyh0YLQ@mail.gmail.com>
Subject: Re: [PATCH v11 06/12] pwm: imx27: Use 64-bit division macro and function
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        David Collins <collinsd@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:xEGTmJejjOhevVW+LS3wPVrxEq9GUWLio507mu2afaZHP1sMEhE
 Ucfjy9sio/Rl8gyi91sw29MzHc5gRRGOwjmkwC2nKaOULSOm9k2lsYJ+Qc0HVmtqJMnZIvH
 +YAwGsOG1JGGIeN76PGxBIOTkLXFVjChuDzrqC9SmMB5LGiALJnNVhSuxdkyTVr38Nu4cHL
 PdlVHh8qMGVIZHutZCl/w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xBQCXjWELaM=:X+fZoPAw8rfvW0h8IvN7HV
 w0jWj2O2rk0zJiEDk4OsYR/6gnWZLg/lHXcu+8DEH+aAL0qByNtGFw8TOt3AvIKq++2A2frQW
 +DGS4DQWZCit3TzkGuEtqU/f4v5IWX65cnXDmDsW03VI1Pk2qbX1I9BRwLvojIsroaRiNBPii
 jcHEXdYGdxfCizUi3IPJQhk9KOrskKbItWS9dZsTWm1qcE5XFa0ydRy+GKhDY9jKBnxsHjfHy
 RKOP+qnPbZ1A1135v6Jr029/L5dEcAfhGasNGZ0xkzAOVMXMVmhCcSLaUxyxGRpa/DwLaVoLN
 CQG4Rp4JJLurZOwPNe1XEgeXWrep6gTnCu+bzUrnDp5gEJb38o8hDjYnBdLEE7mZvCqfA0Q1F
 8nWGGgHCq39IK0/Jda/eLAhy+ZMEKqTphfEhXFsmUh7hriA9d16Sv8F0ykdva6rDw3g6o+9ja
 7CcPLjmSv+SuqsLKwczity5807vLwr6nTevPmGDsIeSVWcsh86PkP1qXtL4dB8oDohElOa6Uw
 dVZ4bPbWNzm59jGU5+nQY7lay3qW93y9vxZ5wShss4u1613/xvazpaJwG77gwY6Ga8cI7p7IJ
 PfpxuYJ+0Dy3jylSc6qigs1k7fmMCaUK3mbyNzuHtQGQE+xQuJq4xuO9JNV5YMpnhnIO/k+iV
 KPMuT1P6u3OZbD2QVbZqlYGrk/+jMIZcPmFAsdDmiOdOSNtH+R292+AiAv74GWrKWb/PW8fpe
 FfNygJQjdzeovTpfBx/A/kvceNlc28+2sX08p90eHB4tWHzGg5eG9pIaPUPLiHjsJSOq5PG3W
 1J3wneLlC/ICLRPFvYfS8qNP3qb/nD6Z9sfHzagewug4y1COqo=
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Apr 2, 2020 at 10:16 PM Guru Das Srinagesh <gurus@codeaurora.org> wrote:
> On Tue, Mar 31, 2020 at 10:49:29PM +0200, Thierry Reding wrote:
> > Doesn't that mean that anything below a 1 second period will be clamped
> > to just 0?
>
> True. How about this then?
>
> int pwm_imx27_calc_period_cycles(struct pwm_state state,
>                                  unsigned long clk_rate,
>                                  unsigned long *period_cycles)
> {
>         u64 c1, c2;
>
>         c1 = clk_rate;
>         c2 = state->period;
>         if (c2 > c1) {
>                 c2 = c1;
>                 c1 = state->period;
>         }
>
>         if (!c1 || !c2) {
>                 pr_err("clk rate and period should be nonzero\n");
>                 return -EINVAL;
>         }
>
>         if (c2 <= div64_u64(U64_MAX, c1)) {
>                 c = c1 * c2;
>                 do_div(c, 1000000000);
>         } else if (c2 <= div64_u64(U64_MAX, div64_u64(c1, 1000))) {
>                 do_div(c1, 1000);
>                 c = c1 * c2;
>                 do_div(c, 1000000);
>         } else if (c2 <= div64_u64(U64_MAX, div64_u64(c1, 1000000))) {
>                 do_div(c1, 1000000);
>                 c = c1 * c2;
>                 do_div(c, 1000);
>         } else if (c2 <= div64_u64(U64_MAX, div64_u64(c1, 1000000000))) {
>                 do_div(c1, 1000000000);
>                 c = c1 * c2;
>         }
>
>         *period_cycles = c;
>
>         return 0;
> }
>
> ...
>
> ret = pwm_imx27_calc_period_cycles(state, clk_get_rate(imx->clk_per),
>                                    &period_cycles);
> if (ret)
>         return ret;
>
> I unit tested this logic out by calculating period_cycles using both the
> existing logic and the proposed one, and the results are as below.
>
> --------------------------------------------------------------------------------
>  clk_rate               period            existing            proposed
> --------------------------------------------------------------------------------
> 1000000000      18446744073709551615     18446744072    18446744073000000000
>                       (U64_MAX)
> --------------------------------------------------------------------------------
> 1000000000           4294967291          4294967291         4294967291
> --------------------------------------------------------------------------------
>
> Overflow occurs in the first case with the existing logic, whereas the
> proposed logic handles it correctly. As for the second case where there are
> more typical values of period, the proposed logic handles that correctly
> too.

This looks correct, but very expensive, and you don't really have to
go this far, given that c1 is guaranteed to be a 32-bit number, and
you divide by a constant in the end.

Why not do something like

#define SHIFT 41 /* arbitrarily picked, not too big, not too small */
#define MUL 2199 /* 2^SHIFT / NSEC_PER_SEC */
period_cycles = clk_get_rate(imx->clk_per) * ((state->period * MUL) >> SHIFT);

        Arnd
