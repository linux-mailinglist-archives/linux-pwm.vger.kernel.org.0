Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69461403CDA
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Sep 2021 17:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349648AbhIHPwI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 8 Sep 2021 11:52:08 -0400
Received: from smtp1.axis.com ([195.60.68.17]:19179 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235678AbhIHPwH (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 8 Sep 2021 11:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1631116260;
  x=1662652260;
  h=date:to:cc:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:from;
  bh=Ytxiloi0Se8cNDvzRVv5HQoxBt4Apdn3R7pe7pmPhwU=;
  b=N1tuqMh6SWyHGuGwtzywEwN/9NVE/Ql5zSGEwc/Knrpq2fRQ8e2+3AdJ
   jdHWzRrIArbFSPi7yQkO9kAu5OQjNY87wA09owBfoqfHhZfs4GgMVblke
   YGuGHUboU3jDqUWKowt4GqJ1URD3ypHc08bUEGZPCpuPSzrlNG1OLu4P7
   Y9tF3zeYI7h6yM4dMUAtHTVomJsuLMqlCqLdZ9BautRYldciGMZokpp77
   XPDNzXaDDruCPMqj9CKyjZmjth9EQeCJ1XNA0cFvwwVFVw6JNAcLBhDgC
   cvTLRA2/XNTrmI6zi2K8Yi7sibWsezMA3nRArcGkH90WVwIhEvQLVF6mS
   Q==;
Date:   Wed, 8 Sep 2021 17:50:58 +0200
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     =?iso-8859-1?Q?M=E5rten?= Lindahl <Marten.Lindahl@axis.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        kernel <kernel@axis.com>
Subject: Re: [PATCH] pwm: pwm-samsung: Trigger manual update when disabling
 PWM
Message-ID: <20210908155058.GA3587@axis.com>
References: <20210908142708.14145-1-marten.lindahl@axis.com>
 <fc40e31d-16a2-33f3-1eb0-4af81fc27065@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc40e31d-16a2-33f3-1eb0-4af81fc27065@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
From:   Marten Lindahl <martenli@axis.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Sep 08, 2021 at 04:54:04PM +0200, Krzysztof Kozlowski wrote:
> On 08/09/2021 16:27, Mårten Lindahl wrote:
> > When duty-cycle is at full level (100%), the TCNTn and TCMPn registers
> > needs to be flushed in order to disable the signal. The PWM manual does
> > not say anything about this, but states that only clearing the TCON
> > auto-reload bit should be needed, and this seems to be true when the PWM
> > duty-cycle is not at full level. This can be observed on an Axis
> > ARTPEC-8, by running:
> > 
> >   echo <period> > pwm/period
> >   echo <period> > pwm/duty_cycle
> >   echo 1 > pwm/enable
> >   echo 0 > pwm/enable
> > 
> > Since the TCNTn and TCMPn registers are activated when enabling the PWM
> > (setting TCON auto-reload bit), and are not touched when disabling the
> > PWM, the double buffered auto-reload function seems to be still active.
> > Lowering duty-cycle, and restoring it again in between the enabling and
> > disabling, makes the disable work since it triggers a reload of the
> > TCNTn and TCMPn registers.
> > 
> > Fix this by securing a reload of the TCNTn and TCMPn registers when
> > disabling the PWM and having a full duty-cycle.
> > 
> > Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> > ---
> >  drivers/pwm/pwm-samsung.c | 25 +++++++++++++++++++++----
> >  1 file changed, 21 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
> > index f6c528f02d43..7d90652402a0 100644
> > --- a/drivers/pwm/pwm-samsung.c
> > +++ b/drivers/pwm/pwm-samsung.c
> > @@ -105,6 +105,9 @@ struct samsung_pwm_chip {
> >  static DEFINE_SPINLOCK(samsung_pwm_lock);
> >  #endif
> >  
> > +static void __pwm_samsung_manual_update(struct samsung_pwm_chip *chip,
> > +				      struct pwm_device *pwm);
> > +
> >  static inline
> >  struct samsung_pwm_chip *to_samsung_pwm_chip(struct pwm_chip *chip)
> >  {
> > @@ -278,17 +281,21 @@ static void pwm_samsung_disable(struct pwm_chip *chip, struct pwm_device *pwm)
> >  
> >  	our_chip->disabled_mask |= BIT(pwm->hwpwm);
> >  
> > +	/*
> > +	 * In case the PWM is at 100% duty cycle, force a manual
> > +	 * update to prevent the signal from staying high.
> > +	 */
> > +	if (readl(our_chip->base + REG_TCMPB(pwm->hwpwm)) == (u32)-1U)
> > +		__pwm_samsung_manual_update(our_chip, pwm);
> 
> I did not test it but looks reasonable. Just please move it above
> setting "our_chip->disabled_mask", so the code will be close to
> pwm_samsung_enable.
> 

Hi Krzysztof!

Thank you for the quick reply! I will do so.

Kind regards
Mårten

> 
> Best regards,
> Krzysztof
