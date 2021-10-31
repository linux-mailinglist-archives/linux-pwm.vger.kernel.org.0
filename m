Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279B4440DD9
	for <lists+linux-pwm@lfdr.de>; Sun, 31 Oct 2021 11:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhJaKmK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 31 Oct 2021 06:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhJaKmK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 31 Oct 2021 06:42:10 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573EEC061570;
        Sun, 31 Oct 2021 03:39:38 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 30383C63FB; Sun, 31 Oct 2021 10:39:34 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mess.org; s=2020;
        t=1635676774; bh=uhJMdNnrBQp8vDJjBnlyia4UxjQNMMW0JmjLg7bCz7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e1YebnWFKr+SwciHOLCYzoOIlMGOwnzYkfNhJedo5+jvjmaKM9M4rVMkIYDL10imf
         XAtKAt3J48dij/4ZQIVp7zAYRDG1kp8yK4RW2QyOEHk1qXwyLAOkruhSliCCRKNw7c
         9ZkzpY7l0iFoTVqN0p9B7ZZSWflUWJTzOHjJxsFhGUHf5Yx99nUy5CrcPJLb15kgnf
         /T/7yekoWZ56bNOF3qDJcJJ+/0dquOV9ZVxShg/uCQXPmGnsQ0UUcnW+R5wswekQVw
         8nKUwlsbLN/UvChUOt9Hq9wP38xS9BTHKPHNcuL9VtmOfrlH9/Ic6biY2Ydtu0Kw8/
         nbodbbyb5XsLA==
Date:   Sun, 31 Oct 2021 10:39:34 +0000
From:   Sean Young <sean@mess.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>,
        mchehab@kernel.org, thierry.reding@gmail.com, lee.jones@linaro.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v4] media: rc: pwm-ir-tx: Switch to atomic PWM API
Message-ID: <20211031103933.GA28316@gofer.mess.org>
References: <YXlxhpZWf2mxJaMi@fedora>
 <20211028064513.guziv6uaivzlk6ki@pengutronix.de>
 <20211028091442.GA16514@gofer.mess.org>
 <20211028111535.x7xgz7domx2lpyfh@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211028111535.x7xgz7domx2lpyfh@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Thu, Oct 28, 2021 at 01:15:35PM +0200, Uwe Kleine-König wrote:
> On Thu, Oct 28, 2021 at 10:14:42AM +0100, Sean Young wrote:
> > We still have the problem that the pwm drivers calculate the period
> > incorrectly by rounding down (except pwm-bcm2835). So the period is not
> > as good as it could be in most cases, but this driver can't do anything
> > about that.
> 
> Yeah, some time ago I started coding a round_state function
> (wip at
> https://git.pengutronix.de/cgit/ukl/linux/commit/?h=pwm-wip&id=ae348eb6a55d6526f30ef4a49819197d9616391e)
> but this was pushed down on my todo-list by more important stuff.
> 
> If you want to experiment with that ...

I was thinking about this problem this morning. 

- The pwm-ir-tx driver gets a carrier set in Hz, which it has to convert to
  a period (1e9 / carrier). There is loss of accuracy there.
- When it gets to the pwm driver, the period is converted into the format
  the pwm hardware expects. For example the pwm-bcm2835 driver converts
  it into clock cycles (1e9 / 8e8).

Both calculations involve loss of accuracy because of integer representation.

Would it make more sense for the pwm interface to use numer/denom rational
numbers?

struct rational {
	u64 numer;
	u64 denom;
};

If pwm-ir-tx would like to set the carrier, it could it like so:

	struct rational period = {
		.numer = NUSEC_PER_SEC,
		.denom = carrier,
	};

	pwm_set_period(&period);

Now pwm-bcm2835 could do it like so:

	int bcm2835_set_period(struct rational *period)
	{
		struct rational rate = {
			.numer = NUSEC_PER_SEC,
			.denum = clk_get_rate(clk),
		};

		rational_div(&rate, period);

		int step = rational_to_u64(&rate);
	}

Alternatively, since most of the pwm hardware is doing scaling based on the
clock (I think), would not make more sense for the pwm driver interface to
take a frequency rather than a period? Then the integer calculations can be
simpler: just divide the clock rate by the required frequency and you have
the period.

Just some thoughts.


Sean
