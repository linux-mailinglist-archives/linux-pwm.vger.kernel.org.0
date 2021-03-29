Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3285E34D61A
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Mar 2021 19:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhC2ReY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Mar 2021 13:34:24 -0400
Received: from mail.pqgruber.com ([52.59.78.55]:57490 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230258AbhC2Rd6 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 29 Mar 2021 13:33:58 -0400
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 60714C729F1;
        Mon, 29 Mar 2021 19:33:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1617039237;
        bh=ZFwt0JGTIyq6uB7FeKFEuWXBuJCfFDDYJw0dZcvtP3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l0FKQTSNCWdepn5bTdxYgxAfBkGqtH9ZwxHp2jdv/DQHk7WdtJx2wDQZfzhiAzq+n
         U0jadktl0PdrQcIBeKhrr+6BlACUcNCrzg3ptf67z4WPj16gDJPoqxu7/HRu+9l9sA
         t3ETewZMQ8fjRsPQo1NRdIwqTom3TmP80u3fk+p8=
Date:   Mon, 29 Mar 2021 19:33:56 +0200
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v6 6/7] pwm: pca9685: Restrict period change for
 prescaler users
Message-ID: <YGIPhCqM32QrqcrL@workstation.tuxnet>
References: <20210329125707.182732-1-clemens.gruber@pqgruber.com>
 <20210329125707.182732-6-clemens.gruber@pqgruber.com>
 <20210329171559.rfelpt42shlebct5@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210329171559.rfelpt42shlebct5@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Mar 29, 2021 at 07:15:59PM +0200, Uwe Kleine-König wrote:
> On Mon, Mar 29, 2021 at 02:57:06PM +0200, Clemens Gruber wrote:
> > @@ -330,14 +345,22 @@ static int pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> >  
> >  	if (!state->enabled || duty < 1) {
> >  		pca9685_pwm_set_duty(pca, pwm->hwpwm, 0);
> > +		clear_bit(pwm->hwpwm, pca->prescaler_users);
> 
> Hmm, so if "my" channel runs at say
> 
> 	.duty_cycle = 2539520 ns
> 	.period = 5079040 ns
> 
> and I call pwm_apply_state(mypwm, { .duty_cycle = 0, .period = 5079040,
> enabled = true }); it might happen that another channel modifies the
> period and I won't be able to return to the initial setting.

Yes, that's correct.

But that also applies to PWMs set to 100%:

pwm_apply_state(mypwm, { .duty_cycle = 5079040, .period = 5079040,
enabled = true });

As this sets the full ON bit and does not use the prescaler, with the
current code, another channel could modify the period and you wouldn't
be able to return to the initial setting of 50%.

> 
> So I think it's sensible to only clear the user bit if the PWM is
> disabled, but not if it is configured for duty_cycle = 0.
> 
> Does this make sense?

With both cases in mind, you are suggesting we block modifications of
the prescaler if other PWMs are enabled and not if other PWMs are using
the prescaler?

Clemens
