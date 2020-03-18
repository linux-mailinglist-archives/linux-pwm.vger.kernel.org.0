Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C21E718A106
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Mar 2020 18:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgCRRAO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Mar 2020 13:00:14 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:38355 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726638AbgCRRAO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Mar 2020 13:00:14 -0400
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 18 Mar 2020 10:00:13 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg04-sd.qualcomm.com with ESMTP; 18 Mar 2020 10:00:10 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id DDA914BAA; Wed, 18 Mar 2020 10:00:10 -0700 (PDT)
Date:   Wed, 18 Mar 2020 10:00:10 -0700
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux PWM List <linux-pwm@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexander Shiyan <shc_work@mail.ru>
Subject: Re: [PATCH v9 04/11] pwm: clps711x: Use 64-bit division macro
Message-ID: <20200318170010.GA26509@codeaurora.org>
References: <cover.1584473399.git.gurus@codeaurora.org>
 <587f9ccae68ad7e1ce97fa8da6037292af1a5095.1584473399.git.gurus@codeaurora.org>
 <CAK8P3a2Hi_AoRC3g7qKth4e_Y1jZrbBDhWUb3YPZm10FWMu-ig@mail.gmail.com>
 <20200317233003.GA11350@codeaurora.org>
 <CAK8P3a2a-QEwFfDE5FbFCVdDS+t9jirgbHWJQQv0i5_OMCYXJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2a-QEwFfDE5FbFCVdDS+t9jirgbHWJQQv0i5_OMCYXJg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Mar 18, 2020 at 10:49:34AM +0100, Arnd Bergmann wrote:
> On Wed, Mar 18, 2020 at 12:30 AM Guru Das Srinagesh
> <gurus@codeaurora.org> wrote:
> >
> > On Tue, Mar 17, 2020 at 11:22:06PM +0100, Arnd Bergmann wrote:
> > > > diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
> > > > index 924d39a..ba9500a 100644
> > > > --- a/drivers/pwm/pwm-clps711x.c
> > > > +++ b/drivers/pwm/pwm-clps711x.c
> > > > @@ -43,7 +43,7 @@ static void clps711x_pwm_update_val(struct clps711x_chip *priv, u32 n, u32 v)
> > > >  static unsigned int clps711x_get_duty(struct pwm_device *pwm, unsigned int v)
> > > >  {
> > > >         /* Duty cycle 0..15 max */
> > > > -       return DIV_ROUND_CLOSEST(v * 0xf, pwm->args.period);
> > > > +       return DIV64_U64_ROUND_CLOSEST(v * 0xf, pwm->args.period);
> > > >  }
> > >
> > > Is it actually going to exceed U32_MAX? If not, a type cast may be
> > > more appropriate here than the expensive 64-bit division.
> >
> > With the final change in this patch series, the framework will support
> > periods that exceed U32_MAX. My concern is that using a typecast would
> > mean that in those cases, this driver will not support > U32_MAX values.
> > Using DIV64_U64_ROUND_CLOSEST makes the driver future proof and able to
> > handle > U32_MAX values correctly. What do you think?
> 
> Ah, so if the period can actually be larger than U32_MAX, you need to
> handle that case. However, I see that the divident in this code (v * 0xf)
> is still a 32-bit number, so a correct and efficient implementation could be
> 
>    if (pwm->args.period > (UINT_MAX / 0xf))

Shouldn't the if condition be the following? Or am I missing
something here?

     if (pwm->args.period > (UINT_MAX / (v * 0xf)))
     					^^^^^^^^^

>           return 0;
>    return DIV_ROUND_CLOSEST(v * 0xf, (u32)pwm->args.period);

Thank you.

Guru Das.
