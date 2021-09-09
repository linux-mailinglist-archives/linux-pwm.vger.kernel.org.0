Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB8B4047B3
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Sep 2021 11:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbhIIJZV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Sep 2021 05:25:21 -0400
Received: from smtp1.axis.com ([195.60.68.17]:54170 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232818AbhIIJZU (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 9 Sep 2021 05:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1631179451;
  x=1662715451;
  h=date:to:cc:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:from;
  bh=8yKQxOzbJX3oMJUiB0rw/AtRDsAlIREmsFIhtiMgZ7w=;
  b=kA+84TieewxS9ph5BHkdcsb3deBJhIUNoSBM0CkQLK3qHnrMMp4g11PJ
   i+O0LfoOrk4E+hioHX1x0ErLnSoIB1nUBp2o/FqAVhvWqDATwYYbRTegi
   gSaiXE3bPyfLEJe/JIs89Ox2WBP/51UmWNZlFJvoCsgS8c5+3KB7tLRIH
   +zg2mrnvLTrrZPg7HaxON4z7njx1IfZFj77cGOOLO19Elml9H17ZuVfd7
   0AJswe8u8rbjhMnw20ppbitYDc+56JBoXjfT+s9mqtZm54lL0tTqCm/wS
   fffgoVvwvtYB7aKjkjuZUCE9UGWfOg8HhJ0k0VGmKY9RFsjmAIXrzTNy/
   g==;
Date:   Thu, 9 Sep 2021 11:24:10 +0200
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     =?iso-8859-1?Q?M=E5rten?= Lindahl <marten.lindahl@axis.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <kernel@axis.com>
Subject: Re: [PATCH v2] pwm: pwm-samsung: Trigger manual update when
 disabling PWM
Message-ID: <20210909092409.GA11367@axis.com>
References: <20210908155901.18944-1-marten.lindahl@axis.com>
 <20210909080517.rsrohvdqqcnnjv2x@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210909080517.rsrohvdqqcnnjv2x@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
From:   Marten Lindahl <martenli@axis.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Sep 09, 2021 at 10:05:17AM +0200, Uwe Kleine-König wrote:

Hi Uwe!
Thanks for your feedback!

> Hello,
> 
> On Wed, Sep 08, 2021 at 05:59:01PM +0200, Mårten Lindahl wrote:
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
> > 
> > v2:
> >  - Move fix above setting of disabled_mask
> > 
> >  drivers/pwm/pwm-samsung.c | 25 +++++++++++++++++++++----
> >  1 file changed, 21 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
> > index f6c528f02d43..53edc0da3ff8 100644
> > --- a/drivers/pwm/pwm-samsung.c
> > +++ b/drivers/pwm/pwm-samsung.c
> > @@ -105,6 +105,9 @@ struct samsung_pwm_chip {
> >  static DEFINE_SPINLOCK(samsung_pwm_lock);
> >  #endif
> >  
> > +static void __pwm_samsung_manual_update(struct samsung_pwm_chip *chip,
> > +				      struct pwm_device *pwm);
> > +
> 
> If you move the definition of __pwm_samsung_manual_update before
> pwm_samsung_disable() you can drop this declaration:
> 

Yes, I will do that. Thanks.

> diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
> index d904a2480849..b405dd434ad6 100644
> --- a/drivers/pwm/pwm-samsung.c
> +++ b/drivers/pwm/pwm-samsung.c
> @@ -105,9 +105,6 @@ struct samsung_pwm_chip {
>  static DEFINE_SPINLOCK(samsung_pwm_lock);
>  #endif
>  
> -static void __pwm_samsung_manual_update(struct samsung_pwm_chip *chip,
> -				      struct pwm_device *pwm);
> -
>  static inline
>  struct samsung_pwm_chip *to_samsung_pwm_chip(struct pwm_chip *chip)
>  {
> @@ -120,6 +117,32 @@ static inline unsigned int to_tcon_channel(unsigned int channel)
>  	return (channel == 0) ? 0 : (channel + 1);
>  }
>  
> +static void __pwm_samsung_manual_update(struct samsung_pwm_chip *chip,
> +				      struct pwm_device *pwm)
> +{
> +	unsigned int tcon_chan = to_tcon_channel(pwm->hwpwm);
> +	u32 tcon;
> +
> +	tcon = readl(chip->base + REG_TCON);
> +	tcon |= TCON_MANUALUPDATE(tcon_chan);
> +	writel(tcon, chip->base + REG_TCON);
> +
> +	tcon &= ~TCON_MANUALUPDATE(tcon_chan);
> +	writel(tcon, chip->base + REG_TCON);
> +}
> +
> +static void pwm_samsung_manual_update(struct samsung_pwm_chip *chip,
> +				      struct pwm_device *pwm)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&samsung_pwm_lock, flags);
> +
> +	__pwm_samsung_manual_update(chip, pwm);
> +
> +	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
> +}
> +
>  static void pwm_samsung_set_divisor(struct samsung_pwm_chip *pwm,
>  				    unsigned int channel, u8 divisor)
>  {
> @@ -291,32 +314,6 @@ static void pwm_samsung_disable(struct pwm_chip *chip, struct pwm_device *pwm)
>  	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
>  }
>  
> -static void __pwm_samsung_manual_update(struct samsung_pwm_chip *chip,
> -				      struct pwm_device *pwm)
> -{
> -	unsigned int tcon_chan = to_tcon_channel(pwm->hwpwm);
> -	u32 tcon;
> -
> -	tcon = readl(chip->base + REG_TCON);
> -	tcon |= TCON_MANUALUPDATE(tcon_chan);
> -	writel(tcon, chip->base + REG_TCON);
> -
> -	tcon &= ~TCON_MANUALUPDATE(tcon_chan);
> -	writel(tcon, chip->base + REG_TCON);
> -}
> -
> -static void pwm_samsung_manual_update(struct samsung_pwm_chip *chip,
> -				      struct pwm_device *pwm)
> -{
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&samsung_pwm_lock, flags);
> -
> -	__pwm_samsung_manual_update(chip, pwm);
> -
> -	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
> -}
> -
>  static int __pwm_samsung_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  				int duty_ns, int period_ns, bool force_period)
>  {
> 
> )
> 
> Maybe split the patch to have it nice and reviewable?

If I only move up the definition of __pwm_samsung_manual_update, and
leave pwm_samsung_manual_update at its place, the patch becomes quite
straightforward and overviewable. Or do you prefer to group the definitions
of those two functions together?

Kind regards
Mårten

> 
> Orthogonal to your patch: I wonder what &samsung_pwm_lock actually
> protects and why it disables irqs. In general the pwm functions might
> sleep, at least some implementations do.
> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |


