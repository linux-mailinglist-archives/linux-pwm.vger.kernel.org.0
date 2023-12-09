Return-Path: <linux-pwm+bounces-473-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2BC80B363
	for <lists+linux-pwm@lfdr.de>; Sat,  9 Dec 2023 10:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46AE2B20A9B
	for <lists+linux-pwm@lfdr.de>; Sat,  9 Dec 2023 09:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33F9C8C6;
	Sat,  9 Dec 2023 09:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="IQ4YD9KN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75DEED;
	Sat,  9 Dec 2023 01:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1702113077; bh=+XGfAN7SRR5RmhM3v1fKPVw4izD0tUsQBMr5UhPJlcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IQ4YD9KNsSANLvdPn5aGGomMN2S5W4iiwx9H84Spbi7xMscnGX+4S6caE6qlZxIDu
	 QVbT50R/i3qVRPwhF9oh2qhn0ER6zdqWj1+9lIQa0o0LIu7eFoQj6Afc1trWwutp4T
	 6DkHBxLTStFigS9Nc67eh8T24U1ec1N1bRfI3yzWKKq/tC0POyq3FwkG8Bk4z4ZAkg
	 7pNEKdcG0tpoJsnOyBM+iwgshRCASJvhAojMW7Tld1jEfnHSAY51FOOPgC7kGBfLnw
	 DPSmX7+TSavS76RPGPZy1cJCxneKwtvpGB0V1VrfVZNKr43BtYQlApyqrahm/yWIzS
	 Lp+K255pbDxWw==
Received: by gofer.mess.org (Postfix, from userid 1000)
	id 77422100091; Sat,  9 Dec 2023 09:11:17 +0000 (GMT)
Date: Sat, 9 Dec 2023 09:11:17 +0000
From: Sean Young <sean@mess.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-media@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/4] pwm: bcm2835: allow pwm driver to be used in
 atomic context
Message-ID: <ZXQvNfLy9mySdrfM@gofer.mess.org>
References: <cover.1701248996.git.sean@mess.org>
 <179dc1ce85702a8b64b43c0e0df656b0c5e3ce30.1701248996.git.sean@mess.org>
 <ZXNC3JYy7CTfYsyC@orome.fritz.box>
 <ZXNL5upeUPc4gC1R@gofer.mess.org>
 <20231208172040.mgw7aicmwlw6yjyb@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231208172040.mgw7aicmwlw6yjyb@pengutronix.de>

On Fri, Dec 08, 2023 at 06:20:40PM +0100, Uwe Kleine-König wrote:
> On Fri, Dec 08, 2023 at 05:01:26PM +0000, Sean Young wrote:
> > On Fri, Dec 08, 2023 at 05:22:52PM +0100, Thierry Reding wrote:
> > > On Wed, Nov 29, 2023 at 09:13:36AM +0000, Sean Young wrote:
> > > > clk_get_rate() may do a mutex lock. Fetch the clock rate once, and prevent
> > > > rate changes using clk_rate_exclusive_get().
> > > > 
> > > > Signed-off-by: Sean Young <sean@mess.org>
> > > > ---
> > > >  drivers/pwm/pwm-bcm2835.c | 31 +++++++++++++++++++++----------
> > > >  1 file changed, 21 insertions(+), 10 deletions(-)
> > > 
> > > s/pwm/PWM/ in the subject. Although, I guess you could just drop the
> > > "PWM" altogether because the subject prefix implies that this is for
> > > PWM.
> > 
> > $ git log --no-merges --oneline drivers/pwm/ | sed -r 's/^\w* ([^:]+): .*/\1/' | sort | uniq -c
> >    1197 pwm
> >       1 PWM
> >   ...
> > 
> > The vast majority of the commits use pwm: as a prefix, only one uses PWM:. 
> > In fact if you look across the tree almost everywhere lower case is used
> > for the prefix.
> 
> Thierry doesn't want you to change the subject prefix, but only the
> second "pwm" to make it read:
> 
> 	pwm: bcm2835: allow PWM driver to be used in atomic context

Ah of course, my bad.

> While I understand Thierry here, I'm fine with a lowercase pwm here,
> too. In my book a PWM in all uppercase is the type of hardware and pwm
> in all lowercase is the framework's name. If you use "PWM driver" or
> "pwm driver" then doesn't matter much.
> 
> 	
> > 
> > I'm just trying to follow convention.
> > 
> > Having said that, I think the prefix is totally redundant, it is clear from
> > the commit files what they are affecting. I am not sure what it really adds.
> > 
> > > Also, please capitalize after the subject prefix.
> > 
> > $ git log --no-merges --oneline drivers/pwm/ | grep -E '^\w* ([^:]+): [A-Z]' | wc -l
> > 217
> > $ git log --no-merges --oneline drivers/pwm/ | grep -E '^\w* ([^:]+): [a-z]' | wc -l
> > 1069
> 
> Your matching things like:
> 
> 	pwm: pwm-tiehrpwm: Add support for configuring polarity of PWM
> 
> with the second command. These are perfectly fine as pwm-tiehrpwm is the
> driver name and so shouldn't be capitalized. With a bit more care here,
> we get:
> 
> 	$ git log --no-merges --oneline drivers/pwm/ | grep -E '^.+: [a-z][^:]*$' | wc -l
> 	114
> 	$ git log --no-merges --oneline drivers/pwm/ | grep -E '^.+: [A-Z][^:]*$' | wc -l
> 	1167
> 
> And the newest of the 114 with a small letter is from 2013.

Again, I stand corrected.

Thanks for pointing it out, I will fix in the next version.


Sean

