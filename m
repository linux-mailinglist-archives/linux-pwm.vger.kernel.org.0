Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 352D9199989
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2020 17:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbgCaPZN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 31 Mar 2020 11:25:13 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:52749 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730521AbgCaPZM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 31 Mar 2020 11:25:12 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M9Ezx-1jO07V3KvH-006PYC; Tue, 31 Mar 2020 17:25:11 +0200
Received: by mail-qt1-f178.google.com with SMTP id 10so18660145qtp.1;
        Tue, 31 Mar 2020 08:25:10 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0WvgddEofi/sD9iSTFdZf1ZFrD+ydZJuI4bP2SBrbgWfC8yZ3s
        hFDTb+CTcOLkthkc8EdLpwBg3fWU7jGPNLh+SAw=
X-Google-Smtp-Source: ADFU+vuGxItc+BDKGw2bG/q+aGH1FiI4EuHE9CVQ5PM1NsMHPuQM0rEiioydqcPcPPcfUQl0MjAMFe5xwohyA60jNJM=
X-Received: by 2002:aed:20e3:: with SMTP id 90mr5499597qtb.142.1585668309499;
 Tue, 31 Mar 2020 08:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1584667964.git.gurus@codeaurora.org> <5aae102e21c0e63ad2588ae1e174b48b06d25e96.1584667964.git.gurus@codeaurora.org>
 <CAK8P3a0qUMMMDmbp2FM-7D-U0Ys_zv0paYguFeyifafZurndEw@mail.gmail.com> <20200330204359.GB5107@codeaurora.org>
In-Reply-To: <20200330204359.GB5107@codeaurora.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 31 Mar 2020 17:24:52 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1VC6+0Tydm=BoK2NvHB1ZCPjE1Gfi-sTE5O-xnu3Ya3A@mail.gmail.com>
Message-ID: <CAK8P3a1VC6+0Tydm=BoK2NvHB1ZCPjE1Gfi-sTE5O-xnu3Ya3A@mail.gmail.com>
Subject: Re: [PATCH v11 06/12] pwm: imx27: Use 64-bit division macro and function
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     Linux PWM List <linux-pwm@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:GSzAx50iyDLxh24eDIM6aDFhYcEePjipAkmPSKNmdEFbfhwY1GY
 CGIDdmp+iJOiD90sOyAX2dgQqrmdft4JfTkzwj+kvaeRKetaWW/zxUFso7eY9V9etgWa2bo
 OkJwLNHNEAGM9qq5zfPJosG4kjZiASYMmpveypIvRqhNsF72jhYoMO28jZcYurWWfV/Y/ju
 9IkPVEL2i49Ttnk2mJGBA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GFnIVILSpSI=:WmWVTmzCRM9vjQAnPaDqIZ
 wYK+GA/Ltn1HLg/5JMw7S8xfF6ki4Vd/fHdv93vGa3ySkHI2uL6cgv48TGHc/eukBax4tsEsD
 7QwNaBeuRl0mHymKFGxo9BafQPj25FyJrmm2nC/6x5KRI5Ove/jte01yjDSuBxXWpuXIsFO3w
 gZIvfMi3Fm34dZjbKg/OLKEtoBUd6d8Rg2k/h483bEHeB/0VRYrGeU6ynb2pgiHGcIWWVEVh8
 nTJ169BMm7zWb+oa3sXyZhyvf2iRfvzhPHxCaHltVjAIfYx0+JxHwrGGaW3V7BZ5Xys0ILubF
 +6P5fuLIK39wVIbAvbKYiCFf384d/fV6O22Y3gZ4A7LO0yesWcvvOcoGx777WKHks205+iXsH
 J83/a+mAFJ/S7VSuU+y8+f3YC8mjodrF/Wv0Z1eoX9cIVioG7ik1owAMRZz6VDmHxHucVnHje
 rbSLefNJrc3TmVehhWjO0V4So7mDhViq0cNs+7GmtXTAP65HulG/L0eLn9XB6FC8iIj7zlqmH
 R6/7UE5Em48nLw+l+5wjxzKFiXOVkmBinAncup/1BoDllI26CNiImVQvrkm5jYYGjcT8Dj2hr
 xEbxZb2NrtyBhx/sNoZlFetiAkXrXvIgc4wZb1HvT799hCUqgu8lB7P8RXcKrF2fB/LWjT7Dt
 0e4+P1+zmrgHAxID9cKp6ptvwhXCL658puMxglrGpwJ3qk5OoIEVPm/2D9soptmqmuT6tiCyz
 IAAC8M23tR8s+BnfSB7Y20cze0fFMRlbhXbriV6VxISyEzKE95JyRWBYxpqRimwPlJhMXWDyM
 brn6yrm5gqFkXUlFiLU+XW4u6LclSZxC9TtFILcYoPpYqJDjeo=
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Mar 30, 2020 at 10:44 PM Guru Das Srinagesh
<gurus@codeaurora.org> wrote:
>
> On Fri, Mar 20, 2020 at 06:09:39PM +0100, Arnd Bergmann wrote:
> > On Fri, Mar 20, 2020 at 2:42 AM Guru Das Srinagesh <gurus@codeaurora.org> wrote:
> >
> > > @@ -240,8 +240,7 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > >
> > >         period_cycles /= prescale;
> > >         c = (unsigned long long)period_cycles * state->duty_cycle;
> > > -       do_div(c, state->period);
> > > -       duty_cycles = c;
> > > +       duty_cycles = div64_u64(c, state->period);
> > >
> >
> > This change looks fine, but I wonder if the code directly above it
> >
> >         c = clk_get_rate(imx->clk_per);
> >         c *= state->period;
> >         do_div(c, 1000000000);
> >         period_cycles = c;
> >
> > might run into an overflow when both the clock rate and the period
> > are large numbers.
>
> Hmm. Seems to me like addressing this would be outside the scope of this
> patch series.

I think it should be part of the same series, addressing bugs that
were introduced
by the change to 64-bit period. If it's not getting fixed along with
the other regressions,
I fear nobody is going to go back and fix it later.

      Arnd
