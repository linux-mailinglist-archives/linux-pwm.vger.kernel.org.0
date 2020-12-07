Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3462D1E51
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Dec 2020 00:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgLGXZT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Dec 2020 18:25:19 -0500
Received: from mail.pqgruber.com ([52.59.78.55]:37054 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbgLGXZT (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 7 Dec 2020 18:25:19 -0500
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id F1E15C89267;
        Tue,  8 Dec 2020 00:24:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1607383477;
        bh=Q/A+34G5azvLVAZzItgJc85p8GcJ5sBbiHPF0QxmJ30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Spmsib/FDvuF4031BVT+j5DAbyWmFvh7w7gIafR1NUkkzYeOKQXfy8q7kw/MAgUFG
         34Bfr1CQR6jBz4eLZQnVUYIqbV3c1M5TBU1iXEadt6eT+nWm37h3c4kY64qkAiegdI
         K+F2+i6QLg9fkkbgwB6RQstkiBiGDL1qw2YiP98o=
Date:   Tue, 8 Dec 2020 00:24:35 +0100
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v4 1/4] pwm: pca9685: Switch to atomic API
Message-ID: <X865s8SRLEn4EAIi@workstation.tuxnet>
References: <20201207193629.493241-1-clemens.gruber@pqgruber.com>
 <20201207220025.42b6g76wq7ph5nvb@pengutronix.de>
 <CAGngYiW6_T8GjLvHrzNk+nUN5L81BwivBTRQ4GofF8LOf1qexA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGngYiW6_T8GjLvHrzNk+nUN5L81BwivBTRQ4GofF8LOf1qexA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Dec 07, 2020 at 05:34:58PM -0500, Sven Van Asbroeck wrote:
> Hi Uwe,
> 
> On Mon, Dec 7, 2020 at 5:00 PM Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > This is not acceptable, if you have two PWM outputs and a consumer
> > modifies one of them the other must change. So if this chip only
> > supports a single period length of all channels, the first consumer
> > enabling a channel defines the period to be used. All later consumers
> > must live with that. (Also the first must be denied modifying the period
> > if a second consumer has enabled its PWM.)
> 
> That makes sense. However, a possible wrinkle: when more than one pwm channel
> is requested, which one is able to change the period?
> 
> Example:
> 1. start with all pwms free
> 2. pwm_request(0), pwm_apply(period=200Hz)
> 3. pwm_request(1)
> 4. pwm_apply(1, period=400Hz) fails?
> 5. pwm_apply(0, period=400Hz) succeeds?
> 
> And if (5) succeeds, then pwm_get_state(1) will still return period=200Hz,
> because the pwm core doesn't realize anything has changed. Are you ok
> with this behaviour?

I think we'd have to deny the pwm_apply in step 5 as well. So, only the
first consumer is allowed to change the period and only as long as it is
the only one that is in use / was requested.

But that's definitely a breaking change.

Thanks,
Clemens
