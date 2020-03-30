Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFA7197D31
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2020 15:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbgC3Nmd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Mar 2020 09:42:33 -0400
Received: from mail.pqgruber.com ([52.59.78.55]:56392 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727276AbgC3Nmc (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 30 Mar 2020 09:42:32 -0400
X-Greylist: delayed 460 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Mar 2020 09:42:32 EDT
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id A6693C63E20;
        Mon, 30 Mar 2020 15:34:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1585575291;
        bh=VG82nfwYd6WzyYlvHoW4q92Umm0iCjQRTg+niBTxir0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QCoR/o/dgwzlMUKs9HcFFf7ZvgMInZCN1pFqHer6AnO/z/eEj9ZktkqUsY9O4GHfJ
         rDLJCbCFZgiUtUUg/6zCny3QpG3bEQm5Mu0Zi1KAA+0p7jnm4hczo3V2Gdz4Pemymd
         PQkMmMd0Wn9/rPx0DOv3xOepGUWBAwG3zEnYTCRE=
Date:   Mon, 30 Mar 2020 15:34:50 +0200
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com
Subject: Re: [PATCH 2/4] pwm: pca9685: remove ALL_LED PWM channel
Message-ID: <20200330133450.GA1530@workstation.tuxnet>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
 <20200226135229.24929-2-matthias.schiffer@ew.tq-group.com>
 <20200330130757.GC2431644@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330130757.GC2431644@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On Mon, Mar 30, 2020 at 03:07:57PM +0200, Thierry Reding wrote:
> On Wed, Feb 26, 2020 at 02:52:27PM +0100, Matthias Schiffer wrote:
> > The interaction of the ALL_LED PWM channel with the other channels was
> > not well-defined. As the ALL_LED feature does not seem very useful and
> > it was making the code significantly more complex, simply remove it.
> > 
> > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > ---
> >  drivers/pwm/pwm-pca9685.c | 115 ++++++--------------------------------
> >  1 file changed, 17 insertions(+), 98 deletions(-)
> 
> Applied, thanks.
> 
> Thierry

I was not reading the mailing list in the last weeks, so I only saw the
patch today.

We are using the ALL_LED channel in production to reduce the delay when
all 16 PWM outputs need to be set to the same duty cycle.

I am not sure it is a good idea to remove this feature.

Best regards,
Clemens
