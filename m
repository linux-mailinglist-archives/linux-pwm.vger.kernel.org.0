Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF07198472
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2020 21:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgC3TaK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Mar 2020 15:30:10 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:56673 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727437AbgC3TaJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Mar 2020 15:30:09 -0400
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 30 Mar 2020 12:30:09 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg05-sd.qualcomm.com with ESMTP; 30 Mar 2020 12:30:08 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id A28B34BC4; Mon, 30 Mar 2020 12:30:08 -0700 (PDT)
Date:   Mon, 30 Mar 2020 12:30:08 -0700
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     Joe Perches <joe@perches.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: Re: [PATCH v11 08/12] pwm: stm32-lp: Use %llu format specifier for
 period
Message-ID: <20200330193008.GA5107@codeaurora.org>
References: <cover.1584667964.git.gurus@codeaurora.org>
 <5ea1fa27dd036ce732c1c7a1a5d84362752a911f.1584667964.git.gurus@codeaurora.org>
 <f957b11abb70457e7bd8c2652d41e7f07024e301.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f957b11abb70457e7bd8c2652d41e7f07024e301.camel@perches.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Mar 20, 2020 at 03:45:35AM -0700, Joe Perches wrote:
> On Thu, 2020-03-19 at 18:41 -0700, Guru Das Srinagesh wrote:
> > Since the PWM framework is switching struct pwm_args.period's
> > datatype to u64, prepare for this transition by using the right
> > specifier for printing a 64-bit value.
> []
> > diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
> []
> > @@ -61,7 +61,7 @@ static int stm32_pwm_lp_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> >  	do_div(div, NSEC_PER_SEC);
> >  	if (!div) {
> >  		/* Clock is too slow to achieve requested period. */
> > -		dev_dbg(priv->chip.dev, "Can't reach %u ns\n",	state->period);
> > +		dev_dbg(priv->chip.dev, "Can't reach %llu ns\n", state->period);
> >  		return -EINVAL;
> >  	}
> 
> Doesn't this introduce a warning now without the
> actual change to the type of state->period?

You're right, it does.

> Likely these patches should either not be separated
> or this should also use a cast to avoid introducing
> intermediate compilation warnings.

Only this patch has this specific issue, so I'll squish it with the
final patch in this series ("pwm: core: Convert period and duty cycle to
u64") that modifies the framework structs. Thanks for pointing this out.

Thank you.

Guru Das.
