Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 204D019E6F1
	for <lists+linux-pwm@lfdr.de>; Sat,  4 Apr 2020 19:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgDDR6k (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 4 Apr 2020 13:58:40 -0400
Received: from mail.pqgruber.com ([52.59.78.55]:33680 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbgDDR6k (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 4 Apr 2020 13:58:40 -0400
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 7A939C726E3;
        Sat,  4 Apr 2020 19:58:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1586023117;
        bh=FSaQXyl6p5dDf1hyRrzuS++ijCcj+bUa5tWL8aMZrlE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZqGj66iw/5w2R3m+qc759I+GUdOvqwOW4NGJjT82stJNkXXTkP3wYFMsmJ614v/hH
         KDARReV5jqhcNr6Wucf9qcmnrVjZ8RVIgnXaINlJ2x0zewiKBJvpCjBvx1kr4sNvg/
         eqeooYkPAZCKLOHVj1GxA94NWtvqRsjYGD6kEtKk=
Date:   Sat, 4 Apr 2020 19:58:36 +0200
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] pwm: pca9685: re-enable active pwm channels on pwm
 period change
Message-ID: <20200404175836.GB55833@workstation.tuxnet>
References: <20200403235324.27437-1-TheSven73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200403235324.27437-1-TheSven73@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On Fri, Apr 03, 2020 at 07:53:24PM -0400, Sven Van Asbroeck wrote:
> In order to change the pwm period, this chip must be put in sleep
> mode. However, when coming out of sleep mode, the pwm channel
> state is not completely restored: all pwm channels are off by
> default.
> 
> This results in a bug in this driver: when the pwm period is changed
> on a pwm channel, all other pwm channels will be deactivated.
> 
> Fix by clearing the RESTART bit when coming out of sleep mode - this
> will restore all pwm channels to their pre-sleep on/off state.
> 
> Reported-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Cc: Clemens Gruber <clemens.gruber@pqgruber.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: linux-pwm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Link: https://lore.kernel.org/lkml/32ec35c2b3da119dd2c7bc09742796a0d8a9607e.camel@ew.tq-group.com/
> Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
> ---
> 
> I no longer have access to pca9685 hardware, so I'm unable to test:
> - if this is indeed a bug
> - if this patch fixes it
> 
> Made against:
> Tree-repo: git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git
> Tree-branch: for-next
> Tree-git-id: 9cc5f232a4b6a0ef6e9b57876d61b88f61bdd7c2
> 
>  drivers/pwm/pwm-pca9685.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> index 76cd22bd6614..0a16f0122e0e 100644
> --- a/drivers/pwm/pwm-pca9685.c
> +++ b/drivers/pwm/pwm-pca9685.c
> @@ -59,6 +59,7 @@
>  
>  #define LED_FULL		(1 << 4)
>  #define MODE1_SLEEP		(1 << 4)
> +#define MODE1_RESTART		(1 << 7)
>  #define MODE2_INVRT		(1 << 4)
>  #define MODE2_OUTDRV		(1 << 2)
>  
> @@ -271,6 +272,15 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  			/* Wake the chip up */
>  			pca9685_set_sleep_mode(pca, false);
>  
> +			/* If any pwm channels were active when the chip was put
> +			 * in sleep mode, re-activate them.
> +			 */
> +			if (!regmap_read(pca->regmap, PCA9685_MODE1, &reg) &&
> +			    reg & MODE1_RESTART)
> +				regmap_update_bits(pca->regmap, PCA9685_MODE1,
> +						   MODE1_RESTART,
> +						   MODE1_RESTART);
> +
>  			pca->period_ns = period_ns;
>  		} else {
>  			dev_err(chip->dev,
> -- 
> 2.17.1
> 

According to the PCA9685 datasheet revision 4, page 15, the RESTART bit
is not only cleared by writing a 1 to it, but also by other actions like
a write to any of the PWM registers.

This seems to be the reason why I could not reproduce the reported
problem.

If I understand this correctly, clearing the RESTART bit would only be
necessary if we wanted every ON/OFF register to stay the same, but in
.config we might also get a different duty_ns value, so we have to
reprogram the ON/OFF time regs.
(Optimization: We could check if duty_ns to period_ns ratio stayed the
same and if so, clear the RESTART bit and return without reg writes)

Clemens
