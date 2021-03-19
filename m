Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C25341D96
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Mar 2021 13:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhCSM7Z (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 19 Mar 2021 08:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbhCSM7B (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 19 Mar 2021 08:59:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6383FC06174A
        for <linux-pwm@vger.kernel.org>; Fri, 19 Mar 2021 05:59:01 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1lNEiR-0005Ft-2T; Fri, 19 Mar 2021 13:58:59 +0100
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1lNEiQ-0005Od-6P; Fri, 19 Mar 2021 13:58:58 +0100
Date:   Fri, 19 Mar 2021 13:58:58 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 1/4] pwm: Make of_pwm_xlate_with_flags() work with
 #pwm-cells = <2>
Message-ID: <20210319125858.b2roeeeinowhxkxy@pengutronix.de>
References: <20210315111124.2475274-1-u.kleine-koenig@pengutronix.de>
 <20210315111124.2475274-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210315111124.2475274-2-u.kleine-koenig@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 13:58:07 up 107 days,  3:04, 44 users,  load average: 0.17, 0.08,
 0.01
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On 21-03-15 12:11, Uwe Kleine-König wrote:
> The two functions of_pwm_simple_xlate() and of_pwm_xlate_with_flags() are
> quite similar. of_pwm_simple_xlate() only supports two pwm-cells while
> of_pwm_xlate_with_flags() only support >= 3 pwm-cells. The latter can
> easily be modified to behave identically to of_pwm_simple_xlate for two
> pwm-cells. This is implemented here and allows to drop
> of_pwm_simple_xlate() in the next commit.
> 
> There is a small detail that is different now between of_pwm_simple_xlate()
> and of_pwm_xlate_with_flags() with pwm-cells = <2>: pwm->args.polarity is
> unconditionally initialized to PWM_POLARITY_NORMAL in the latter. I didn't
> find a case where this matters and doing that explicitly is the more
> robust approach.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index b1adf3bb8508..39b0ad506bdd 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -126,8 +126,7 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle_args *args)
>  {
>  	struct pwm_device *pwm;
>  
> -	/* check, whether the driver supports a third cell for flags */
> -	if (pc->of_pwm_n_cells < 3)
> +	if (pc->of_pwm_n_cells < 2)
>  		return ERR_PTR(-EINVAL);

Wouldn't this introduce regressions with old dtb's?

Regards,
  Marco
