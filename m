Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3658F3521E9
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Apr 2021 23:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbhDAVxz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 1 Apr 2021 17:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbhDAVxz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 1 Apr 2021 17:53:55 -0400
Received: from mail.pqgruber.com (mail.pqgruber.com [IPv6:2a05:d014:575:f70b:4f2c:8f1d:40c4:b13e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2186DC0613E6;
        Thu,  1 Apr 2021 14:53:55 -0700 (PDT)
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 48BF7C729F1;
        Thu,  1 Apr 2021 23:53:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1617314033;
        bh=0N8Xv5M2r8DuA0G72Eh5WJ4TQMU7XOSE5/H0mYt14VA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jZNJzO5feCcaWCsJY6YrHmOqx2LgB3TJkW0gS09OzzdJHoA4LttrhVahRm3i9sE9V
         yc2sWiZxQa9cE+T8zNFiNtpF78P6ZgbM4tkZSwyeq2QAPWhDYxI5lYoW0dLQpAWoou
         7OmqfWqPsiQcRVeX0M9QBH5OaNpkpo9mEqQqPlss=
Date:   Thu, 1 Apr 2021 23:53:51 +0200
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/7] pwm: pca9685: Support staggered output ON times
Message-ID: <YGZA75SDBpt3Wt1Z@workstation.tuxnet>
References: <20210329125707.182732-1-clemens.gruber@pqgruber.com>
 <20210329125707.182732-4-clemens.gruber@pqgruber.com>
 <20210329170357.par7c3izvtmtovlj@pengutronix.de>
 <YGILdjZBCc2vVlRd@workstation.tuxnet>
 <20210329180206.rejl32uajslpvbgi@pengutronix.de>
 <YGRqZsi4WApZcwIT@workstation.tuxnet>
 <YGR/ZYj+GZIonU/J@workstation.tuxnet>
 <20210401205936.nnraoeeyo5nx3elf@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210401205936.nnraoeeyo5nx3elf@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Apr 01, 2021 at 10:59:36PM +0200, Uwe Kleine-König wrote:
> On Wed, Mar 31, 2021 at 03:55:49PM +0200, Clemens Gruber wrote:
> > On Wed, Mar 31, 2021 at 02:26:14PM +0200, Clemens Gruber wrote:
> > > On Mon, Mar 29, 2021 at 08:02:06PM +0200, Uwe Kleine-König wrote:
> > > > On Mon, Mar 29, 2021 at 07:16:38PM +0200, Clemens Gruber wrote:
> > > > > On Mon, Mar 29, 2021 at 07:03:57PM +0200, Uwe Kleine-König wrote:
> > > > > > On Mon, Mar 29, 2021 at 02:57:04PM +0200, Clemens Gruber wrote:
> > > > > > > The PCA9685 supports staggered LED output ON times to minimize current
> > > > > > > surges and reduce EMI.
> > > > > > > When this new option is enabled, the ON times of each channel are
> > > > > > > delayed by channel number x counter range / 16, which avoids asserting
> > > > > > > all enabled outputs at the same counter value while still maintaining
> > > > > > > the configured duty cycle of each output.
> > > > > > > 
> > > > > > > Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> > > > > > 
> > > > > > Is there a reason to not want this staggered output? If it never hurts I
> > > > > > suggest to always stagger and drop the dt property.
> > > > > 
> > > > > There might be applications where you want multiple outputs to assert at
> > > > > the same time / to be synchronized.
> > > > > With staggered outputs mode always enabled, this would no longer be
> > > > > possible as they are spread out according to their channel number.
> > > > > 
> > > > > Not sure how often that usecase is required, but just enforcing the
> > > > > staggered mode by default sounds risky to me.
> > > > 
> > > > There is no such guarantee in the PWM framework, so I don't think we
> > > > need to fear breaking setups. Thierry?
> > > 
> > > Still, someone might rely on it? But let's wait for Thierry's opinion.
> > > 
> > > > 
> > > > One reason we might not want staggering is if we have a consumer who
> > > > cares about config transitions. (This however is moot it the hardware
> > > > doesn't provide sane transitions even without staggering.)
> > > > 
> > > > Did I already ask about races in this driver? I assume there is a
> > > > free running counter and the ON and OFF registers just define where in
> > > > the period the transitions happen, right? Given that changing ON and OFF
> > > > needs two register writes probably all kind of strange things can
> > > > happen, right? (Example thought: for simplicity's sake I assume ON is
> > > > always 0. Then if you want to change from OFF = 0xaaa to OFF = 0xccc we
> > > > might see a period with 0xacc. Depending on how the hardware works we
> > > > might even see 4 edges in a single period then.)
> > > 
> > > Yes, there is a free running counter from 0 to 4095.
> > > And it is probably true, that there can be short intermediate states
> > > with our two register writes.
> > > 
> > > There is a separate mode "Update on ACK" (MODE2 register, bit 3 "OCH"),
> > > which is 0 by default (Outputs change on STOP command) but could be set
> > > to 1 (Outputs change on ACK):
> > > "Update on ACK requires all 4 PWM channel registers to be loaded before
> > > outputs will change on the last ACK."
> > 
> > This would require the auto-increment feature to be enabled, then
> > multiple registers could be written before the STOP condition:
> > LEDn_ON_L, LEDn_ON_H, LEDn_OFF_L & LEDn_OFF_H
> > (With OCH=0 in MODE2)
> 
> Maybe a continued START would work, too?!

Yes, maybe. But according to the datasheet bus transaction examples,
it's enough to have one START condition and write multiple (continuous)
registers using the auto-increment feature. And repeated START does not
seem to be supported via regmap..?

Clemens
