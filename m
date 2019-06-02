Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E391324B7
	for <lists+linux-pwm@lfdr.de>; Sun,  2 Jun 2019 22:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfFBUDV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 2 Jun 2019 16:03:21 -0400
Received: from gofer.mess.org ([88.97.38.141]:49077 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726798AbfFBUDV (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 2 Jun 2019 16:03:21 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id B29A260474; Sun,  2 Jun 2019 21:03:18 +0100 (BST)
Date:   Sun, 2 Jun 2019 21:03:18 +0100
From:   Sean Young <sean@mess.org>
To:     Stefan Wahren <wahrenst@gmx.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Andreas Christ <andreas@christ-faesch.ch>
Subject: Re: [PATCH] pwm: bcm2835: increase precision of pwm
Message-ID: <20190602200318.ymyewngns745m2vx@gofer.mess.org>
References: <20190602102350.zzwmfvlky3mnlqln@gofer.mess.org>
 <0e6eef35-244a-4d52-2d87-e8ff22355f09@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e6eef35-244a-4d52-2d87-e8ff22355f09@gmx.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Stefan,

On Sun, Jun 02, 2019 at 06:45:44PM +0200, Stefan Wahren wrote:
> Am 02.06.19 um 12:23 schrieb Sean Young:
> > If sending IR with carrier of 455kHz using the pwm-ir-tx driver, the
> > carrier ends up being 476kHz.
> >
> > A carrier of 455kHz has a period of 2198ns, but the arithmetic truncates
> > this to 2.1ns rather than 2.2ns. So, use DIV_ROUND_CLOSEST() to reduce
> > rounding errors, and we have a much more accurate carrier of 454.5kHz.
> >
> > Reported-by: Andreas Christ <andreas@christ-faesch.ch>
> > Signed-off-by: Sean Young <sean@mess.org>
> > ---
> >  drivers/pwm/pwm-bcm2835.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
> > index 5652f461d994..edb2387c49a2 100644
> > --- a/drivers/pwm/pwm-bcm2835.c
> > +++ b/drivers/pwm/pwm-bcm2835.c
> > @@ -63,14 +63,14 @@ static int bcm2835_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> >  {
> >  	struct bcm2835_pwm *pc = to_bcm2835_pwm(chip);
> >  	unsigned long rate = clk_get_rate(pc->clk);
> > -	unsigned long scaler;
> > +	unsigned int scaler;
> according to the commit log i wouldn't expect this change. Maybe it's
> worth to mention.

Yes, you are right, that needs explaining. I am trying to avoid an
unnecessary 64 bit division. I'll roll a v2.


Sean
