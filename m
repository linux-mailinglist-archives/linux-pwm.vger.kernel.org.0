Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC545D215A
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Oct 2019 09:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732912AbfJJHH4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 10 Oct 2019 03:07:56 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58471 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbfJJHHz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 10 Oct 2019 03:07:55 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iISY7-0004f8-Fx; Thu, 10 Oct 2019 09:07:47 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iISY1-0003fP-PN; Thu, 10 Oct 2019 09:07:41 +0200
Date:   Thu, 10 Oct 2019 09:07:41 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     thierry.reding@gmail.com, alexandre.torgue@st.com,
        benjamin.gaignard@st.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] pwm: stm32: add comment to better describe breakinput
 feature
Message-ID: <20191010070741.jhkpqgmfpqp2jteo@pengutronix.de>
References: <1570534887-26181-1-git-send-email-fabrice.gasnier@st.com>
 <20191008144531.pjt525xuz7n5a3hq@pengutronix.de>
 <5c05893b-e938-4db8-e33a-803b1a498f97@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c05893b-e938-4db8-e33a-803b1a498f97@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Oct 09, 2019 at 11:51:05AM +0200, Fabrice Gasnier wrote:
> On 10/8/19 4:45 PM, Uwe Kleine-König wrote:
> > On Tue, Oct 08, 2019 at 01:41:27PM +0200, Fabrice Gasnier wrote:
> >> Add a comment to better describe the purpose of breakinput feature that
> >> can be found on some STM32 timer instances. Briefly comment on the
> >> characteristics of this input for PWM, and pinmuxing as suggested in [1].
> >>
> >> [1] https://lkml.org/lkml/2019/10/1/207
> >>
> >> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> >> ---
> >>  drivers/pwm/pwm-stm32.c | 8 +++++++-
> >>  1 file changed, 7 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> >> index 359b085..6406ebb 100644
> >> --- a/drivers/pwm/pwm-stm32.c
> >> +++ b/drivers/pwm/pwm-stm32.c
> >> @@ -522,8 +522,14 @@ static int stm32_pwm_apply_breakinputs(struct stm32_pwm *priv,
> >>  					     sizeof(struct stm32_breakinput));
> >>  
> >>  	/*
> >> +	 * Some timer instances can have BRK input pins (e.g. basically a fault
> >> +	 * pin from the output power stage). The break feature allows a safe
> >> +	 * shut-down of the PWM outputs to a predefined state. Further details
> >> +	 * are available in application note AN4277, "Using STM32 device PWM
> >> +	 * shut-down features..."
> > 
> > Without having read the application note I don't understand the purpose.
> > Not sure if this should be a show stopper though.
> 
> Hi Uwe,
> 
> I can rephrase this. Do you think the bellow comment would be more
> relevant and easy to understand ?
> 
> /*
>  * The break feature allows a safe shut-down of the PWM outputs.
>  * It's based on the BRK event signal defined in the dt-bindings
>  * by <index level filter> values.
>  * Because "st,breakinput" parameter is optional do not make probe
>  * failed if it doesn't exist.
>  */

I still fail to understand. This is an input that determines the actual
value of the output pin? What makes a shutdown of outputs safe? What is
a shutdown anyhow?

Apart from that: s/do not make probe failed/don't fail to probe/.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
