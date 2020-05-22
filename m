Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4B11DF2DA
	for <lists+linux-pwm@lfdr.de>; Sat, 23 May 2020 01:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbgEVXTF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 22 May 2020 19:19:05 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:61712 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731161AbgEVXTF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 22 May 2020 19:19:05 -0400
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 22 May 2020 16:19:05 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg03-sd.qualcomm.com with ESMTP; 22 May 2020 16:19:04 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id 9E1E24DEF; Fri, 22 May 2020 16:19:04 -0700 (PDT)
Date:   Fri, 22 May 2020 16:19:04 -0700
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH v14 04/11] pwm: clps711x: Cast period to u32
 before use as divisor
Message-ID: <20200522231904.GB2873@codeaurora.org>
References: <cover.1589330178.git.gurus@codeaurora.org>
 <1d6918c3fc2976bdbdb687bf54a2ef09fc1558db.1589330178.git.gurus@codeaurora.org>
 <20200521101934.j5ivjky4e6byveut@holly.lan>
 <20200521202525.GA24026@codeaurora.org>
 <20200522093738.cko5rj4wrxfd4hxu@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522093738.cko5rj4wrxfd4hxu@holly.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, May 22, 2020 at 10:37:38AM +0100, Daniel Thompson wrote:
> On Thu, May 21, 2020 at 01:25:25PM -0700, Guru Das Srinagesh wrote:
> > On Thu, May 21, 2020 at 11:19:34AM +0100, Daniel Thompson wrote:
> > > On Wed, May 20, 2020 at 03:55:57PM -0700, Guru Das Srinagesh wrote:
> > > > Since the PWM framework is switching struct pwm_args.period's datatype
> > > > to u64, prepare for this transition by typecasting it to u32.
> > > > 
> > > > Also, since the dividend is still a 32-bit number, any divisor greater
> > > > than the numerator will cause the quotient to be zero, so return 0 in
> > > > that case to efficiently skip the division.
> > > > 
> > > > Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> > > > ---
> > > >  drivers/pwm/pwm-clps711x.c | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)> > > 
> > > > diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
> > > > index 924d39a..da771b1 100644
> > > > --- a/drivers/pwm/pwm-clps711x.c
> > > > +++ b/drivers/pwm/pwm-clps711x.c
> > > > @@ -43,7 +43,10 @@ static void clps711x_pwm_update_val(struct clps711x_chip *priv, u32 n, u32 v)
> > > >  static unsigned int clps711x_get_duty(struct pwm_device *pwm, unsigned int v)
> > > >  {
> > > >  	/* Duty cycle 0..15 max */
> > > > -	return DIV_ROUND_CLOSEST(v * 0xf, pwm->args.period);
> > > > +	if (pwm->args.period > (v * 0xf))
> > > > +		return 0;
> > > 
> > > This doesn't look right to me.
> > > 
> > > DIV_ROUND_CLOSEST() does rounded division and the short circuit doesn't
> > > implement that.
> > 
> > My initial patch [1] was to simply use DIV64_U64_ROUND_CLOSEST(), but I
> > got review feedback to add a short-circuit (same thread, [2]). I feel
> > like I should skip the short-circuiting and type casting and simply just
> > use DIV64_U64_ROUND_CLOSEST() - what do you think?
> 
> A trivial review of pwm-clps711x.c suggests that the period is always
> 32-bit anyway so why not just throw away the short circuit entirely and
> replace with a comment saying that CLPS711X has a hard coded period
> that is always >1000000000 ?

Sorry, I don't follow the significance of 1000000000 - could you please
explain?

Just to clarify, what I was saying in my previous email was the
following: I think it might be simpler to just throw away the short
circuit and just do:

	s/DIV_ROUND_CLOSEST/DIV64_U64_ROUND_CLOSEST

like in another patch in this series [1]. That should handle the
rounding properly as per design. Is that okay?

[1] https://lore.kernel.org/lkml/ca783e0f5ff7b517ce0854908f0e89b07551bfe5.1588616856.git.gurus@codeaurora.org/

Thank you.

Guru Das.
