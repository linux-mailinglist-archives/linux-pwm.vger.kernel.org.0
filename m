Return-Path: <linux-pwm+bounces-467-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C7F80A9F2
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Dec 2023 18:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49E1828161C
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Dec 2023 17:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F448374D0;
	Fri,  8 Dec 2023 17:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="epC/ZO2u"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF767D54;
	Fri,  8 Dec 2023 09:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1702054886; bh=0qFeptaVkBsmj5kyQRxzgnQQfozxB3P91OikGk9d6cE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=epC/ZO2uTJ4Zn/UcJOhtNv/kkrvpLb8GaMOQxaP/LYWGBRGqVpVS3v014yYA98UV8
	 MYvvYpaX6sQ1KgXK9ujvYCYF/cKElPsf3SMv3UNz6YEfpPhsDJbCLDN8sXtUAburNn
	 piT2eVnZFFdm0+7GmL2FYH8JyfGSm5LmTowobSA/svH10Zd6jvaLK2zr//Clf9i88C
	 Hf7pKQK+kH6T/Gxmh9hPcY3NnfUPbbGX0iNrEpMcUgIFa6cEQsUhDbHZEaGRKhE/yY
	 ibu2Sbqosc+ncAf4kpC6j8xW+1W+q80DsMwDVZEYXZqQ7nXCAbFWYGYLxN83D1urBN
	 23VVLFxFlmwUw==
Received: by gofer.mess.org (Postfix, from userid 1000)
	id 83520100091; Fri,  8 Dec 2023 17:01:26 +0000 (GMT)
Date: Fri, 8 Dec 2023 17:01:26 +0000
From: Sean Young <sean@mess.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/4] pwm: bcm2835: allow pwm driver to be used in
 atomic context
Message-ID: <ZXNL5upeUPc4gC1R@gofer.mess.org>
References: <cover.1701248996.git.sean@mess.org>
 <179dc1ce85702a8b64b43c0e0df656b0c5e3ce30.1701248996.git.sean@mess.org>
 <ZXNC3JYy7CTfYsyC@orome.fritz.box>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXNC3JYy7CTfYsyC@orome.fritz.box>

On Fri, Dec 08, 2023 at 05:22:52PM +0100, Thierry Reding wrote:
> On Wed, Nov 29, 2023 at 09:13:36AM +0000, Sean Young wrote:
> > clk_get_rate() may do a mutex lock. Fetch the clock rate once, and prevent
> > rate changes using clk_rate_exclusive_get().
> > 
> > Signed-off-by: Sean Young <sean@mess.org>
> > ---
> >  drivers/pwm/pwm-bcm2835.c | 31 +++++++++++++++++++++----------
> >  1 file changed, 21 insertions(+), 10 deletions(-)
> 
> s/pwm/PWM/ in the subject. Although, I guess you could just drop the
> "PWM" altogether because the subject prefix implies that this is for
> PWM.

$ git log --no-merges --oneline drivers/pwm/ | sed -r 's/^\w* ([^:]+): .*/\1/' | sort | uniq -c
   1197 pwm
      1 PWM
  ...

The vast majority of the commits use pwm: as a prefix, only one uses PWM:. 
In fact if you look across the tree almost everywhere lower case is used
for the prefix.

I'm just trying to follow convention.

Having said that, I think the prefix is totally redundant, it is clear from
the commit files what they are affecting. I am not sure what it really adds.

> Also, please capitalize after the subject prefix.

$ git log --no-merges --oneline drivers/pwm/ | grep -E '^\w* ([^:]+): [A-Z]' | wc -l
217
$ git log --no-merges --oneline drivers/pwm/ | grep -E '^\w* ([^:]+): [a-z]' | wc -l
1069

Although not as clear, convention seems to be lower case for commits. The
first line of a commit is not really a sentence, there is no trailing
period.

I am happy to oblige, just wanted to point this out. Sorry if this starts
a bikeshed discussion.

Thanks,

Sean

