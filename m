Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC48719DE66
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Apr 2020 21:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgDCTNj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Apr 2020 15:13:39 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:47575 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728352AbgDCTNj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Apr 2020 15:13:39 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MlwO3-1it7Pn3N5f-00j5R7; Fri, 03 Apr 2020 21:13:37 +0200
Received: by mail-qk1-f176.google.com with SMTP id z15so3054076qki.7;
        Fri, 03 Apr 2020 12:13:36 -0700 (PDT)
X-Gm-Message-State: AGi0PuaL4luxDuENPbnTJrl+ErrJtKPg1sZ4PfUqKarrDt6PzGTAnMdk
        gMCTQ1XjT7f2tFwPw3vwGnKxypMjBhtvig2Nph0=
X-Google-Smtp-Source: APiQypImXcWILk8psZ1HbQ+URsHm2HQvUCoXZxFfG8y4E1K8GXE0CD5ruo9/1xtIjmfts83SW1YI3czSBgpBBLrTAhs=
X-Received: by 2002:a37:8707:: with SMTP id j7mr10525965qkd.394.1585941215318;
 Fri, 03 Apr 2020 12:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1584667964.git.gurus@codeaurora.org> <5aae102e21c0e63ad2588ae1e174b48b06d25e96.1584667964.git.gurus@codeaurora.org>
 <CAK8P3a0qUMMMDmbp2FM-7D-U0Ys_zv0paYguFeyifafZurndEw@mail.gmail.com>
 <20200330204359.GB5107@codeaurora.org> <CAK8P3a1VC6+0Tydm=BoK2NvHB1ZCPjE1Gfi-sTE5O-xnu3Ya3A@mail.gmail.com>
 <20200331202058.GB25781@codeaurora.org> <20200331204929.GC2954599@ulmo>
 <20200402201654.GA9191@codeaurora.org> <CAK8P3a3mc_sYczyKiaDoQLTTwDj2odwHJ5LFNAOb4RaRyh0YLQ@mail.gmail.com>
 <20200403173719.GA6169@codeaurora.org>
In-Reply-To: <20200403173719.GA6169@codeaurora.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 3 Apr 2020 21:13:18 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2Ua5v67vLLzQxsLPZfX9z5D7o-sfFpurQVWVykRK8sEQ@mail.gmail.com>
Message-ID: <CAK8P3a2Ua5v67vLLzQxsLPZfX9z5D7o-sfFpurQVWVykRK8sEQ@mail.gmail.com>
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
X-Provags-ID: V03:K1:mY5hMDk2oGkHhn3FEaOf3l2YiuPpE+jbgloYAV8BK3QwCBHgX+G
 D/F79J+PUTgTEEyAtIa6MKy01EgzNpOoP3x+M36Ovemr5J61A78qKyF3cOUuUqaSPpiczz9
 OAohAFI308mxuISAW22YxD4UAEerQySl3MReMvsNsWLX/IhrbxWjeWZYV+x67OfOw66YLcD
 Y16+pQQagfjcwJArMy5OQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BteBetvnX/E=:pi9W/I8o0q00Dg8x8fAMbi
 JlveBaHhqnkPudt87h2i3WOhxOc/xeJW3A9bXdrONYad6YRd/469L7mX2AI5/VDwRZLsedZUX
 hgN9EiVKADgL4xNrlJm7SRhE7kTBdFCRqTYhz046erXpnpls8aRJcNg6MVrZ9vtd3CYNCF7Uw
 UgKzqpX0XFlWBxIfUEKg3cTJguf4Fick6UDlRHC8Mjc09HzVn4GlWZjq2/yrjPaYvo0oco0q+
 HwvigSSLUg3ebquM+z03EkYrLnHXX6a8JNC7vEGrPgjN+0l1jpMgjTcqS9AQze7UlEIiyxLgY
 E4UT48STKeDYdirl/iS/se6FzMLrwxOe+UoBzrL1zdXbDH/kFfRNPRm6Rr7Y5oRUE9WzpaZxv
 Q+VyaHnjeP5+dHaSav9SAk3lNmBG5FCMBCqwP8X8kj1GIB+cRzHcfXWW3ZZ4vUvdqIWwUugkA
 S2v8wJ24mohqk/fE2/pH82L2oeK7h/3E8ksMxkSiRl9T1Jq6JW1K8gFibvqAoohLCDBrk2Lcx
 6DhzEpQuWW2kPU5SKwQ29rbQd+4HnWcnSlsnVkLsxw0SqhhM+tc9YVn6tJ6eIxfaLd8mBewWP
 HZqVfnFIVyVX2CjnhrDrEk79vpa0SSKjwUVT2sxZetjhGYafJlNqhmrWWc/wLKNEcEZuBJ99h
 jQpP/+dzMImDEgDtVZ2LOXSBzctChJRN1WYaTEFNCtD2XV3fzw4KTmGdEk+q8c90omgLXFqSy
 E9cx9HVMXAWBqI/E7bs65cyqndTYNaKOiXXdB2kSligTRP/z2la4oKum+T7e5LwAI2pFB4Azo
 YIJpHnLbAe2qt3OT4cpfSSiAQtCffgL6g5ommyYsiwMvhsD2WY=
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Apr 3, 2020 at 7:37 PM Guru Das Srinagesh <gurus@codeaurora.org> wrote:
>
> On Thu, Apr 02, 2020 at 11:16:22PM +0200, Arnd Bergmann wrote:
> > This looks correct, but very expensive, and you don't really have to
> > go this far, given that c1 is guaranteed to be a 32-bit number, and
> > you divide by a constant in the end.
> >
> > Why not do something like
> >
> > #define SHIFT 41 /* arbitrarily picked, not too big, not too small */
> > #define MUL 2199 /* 2^SHIFT / NSEC_PER_SEC */
> > period_cycles = clk_get_rate(imx->clk_per) * ((state->period * MUL) >> SHIFT);
>
> I have two concerns with this:
>
> 1. This actually results in the division by 1000010575.5125057 instead
>    of NSECS_PER_SEC whereas both the existing as well as the proposed logic
>    divide exactly by NSECS_PER_SEC.
> 2. What method shall be used to pick the SHIFT value? How is this to be
>    chosen?

I picked one that would result in a fairly accurate rounding and did not
seem too likely to overflow.

> Also, this seems sort of similar to my initial attempt at this
> problem, where period was being pre-divided prior to the multiplication,
> which was (rightly) NACKed.
>
>         c *= div_u64(state->period, 1000000000);

Ah, right, I did make the same mistake here. What I actually indended
was to do two separate shifts that add up to 41. I suppose there is also still
the fundamental problem that without bounds checking the calculation can
always overflow for large inputs.

       Arnd
