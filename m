Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 778EBBC1D6
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Sep 2019 08:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393474AbfIXGj3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 24 Sep 2019 02:39:29 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53615 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389156AbfIXGj3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 24 Sep 2019 02:39:29 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iCeTu-0000ja-Ta; Tue, 24 Sep 2019 08:39:26 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iCeTu-00055Q-5i; Tue, 24 Sep 2019 08:39:26 +0200
Date:   Tue, 24 Sep 2019 08:39:26 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, kernel-team@android.com,
        Mark Salyzyn <salyzyn@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org, Fenglin Wu <fenglinw@codeaurora.org>
Subject: Re: [PATCH 1/2] pwm: Add different PWM output types support
Message-ID: <20190924063926.vb3cxcdybv33owpg@pengutronix.de>
References: <1568415464-20267-1-git-send-email-gurus@codeaurora.org>
 <20190916140146.GC7488@ulmo>
 <20190924054343.GA12462@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190924054343.GA12462@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Sep 23, 2019 at 10:43:43PM -0700, Guru Das Srinagesh wrote:
> On Mon, Sep 16, 2019 at 04:01:46PM +0200, Thierry Reding wrote:
> > On Fri, Sep 13, 2019 at 03:57:43PM -0700, Guru Das Srinagesh wrote:
> > > From: Fenglin Wu <fenglinw@codeaurora.org>
> > > 
> > > Normally, PWM channel has fixed output until software request to change
> > > its settings. There are some PWM devices which their outputs could be
> > > changed autonomously according to a predefined pattern programmed in
> > > hardware. Add pwm_output_type enum type to identify these two different
> > > PWM types and add relevant helper functions to set and get PWM output
> > > types and pattern.
> > > 
> > > Change-Id: Ia1f914a45ab4f4dd7be037a395eeb89d0e65a80e
> > > Signed-off-by: Fenglin Wu <fenglinw@codeaurora.org>
> > > Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> > > ---
> > >  drivers/pwm/core.c  | 26 ++++++++++++++++++++
> > >  drivers/pwm/sysfs.c | 50 ++++++++++++++++++++++++++++++++++++++
> > >  include/linux/pwm.h | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 146 insertions(+)
> > 
> > This doesn't seem right to me. Are you describing a PWM pin that's
> > actually driven in GPIO mode? We usually configure that using pinctrl.
> > 
> > Thierry
> 
> Sorry, let me clarify.
> 
> Some Qualcomm PMICs have a PWM block called the Light Pulse Generator (LPG).
> This block allows for the generation of a HW-controlled PWM "pattern", i.e. a
> sequential altering of duty cycle, in addition to the normal PWM "fixed" duty
> cycle operation, which is what the framework does currently. This pattern is
> user-configurable in the form of a look-up table in the devicetree. The LPG's
> registers have to be configured with the data in the look up table in order to
> start the generation of the pattern. An example of a pattern is the "breath"
> pattern, which simply ramps up the duty cycle and then ramps it down.

I'll try to describe it in my words to check if I got it right: So the
mode you want to add needs a sequence of PWM states and the hardware is
expected to apply them in turn, each for a configurable count of
periods. If I understand this right, this is expected to be cyclic?

> This "pattern" mode is what has been defined as PWM_OUTPUT_MODULATED in this
> patch. I see that the use of the term "modulated" is misleading - a more
> accurate term would be PWM_OUTPUT_PATTERN perhaps.

Not sure "pattern" is better. 

The PWM on the newer imx SoCs (using the imx27 driver) has a FIFO with
length 4 that allows to program changing settings. Only the duty cycle
can be modified and as repeat count only 1, 2, 4 and 8 are available. I
assume the FIFO can be fed by the dma engine.

Note I only know this feature from reading the reference manual and
never used it.

> This patch merely adds framework support to differentiate between the "fixed"
> and "pattern" modes of operation. Actions such as configuring the LPG with the
> devicetree pattern and setting it up for generating the pattern are performed
> in the driver only if the output type is read as "pattern" and not otherwise.

Up to now I'm not convinced that this extension is a good one that can
be supported by several PWM implementations. I'd say we should collect
first some details about different implementations and what these could
implement to get a picture what kind of API is sensible.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
