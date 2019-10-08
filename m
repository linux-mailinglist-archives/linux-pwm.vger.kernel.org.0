Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32886CFCB7
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Oct 2019 16:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbfJHOpj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Oct 2019 10:45:39 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36713 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfJHOpi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Oct 2019 10:45:38 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iHqk0-0001Zs-Vp; Tue, 08 Oct 2019 16:45:32 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iHqjz-0001yc-As; Tue, 08 Oct 2019 16:45:31 +0200
Date:   Tue, 8 Oct 2019 16:45:31 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     thierry.reding@gmail.com, alexandre.torgue@st.com,
        benjamin.gaignard@st.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] pwm: stm32: add comment to better describe breakinput
 feature
Message-ID: <20191008144531.pjt525xuz7n5a3hq@pengutronix.de>
References: <1570534887-26181-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1570534887-26181-1-git-send-email-fabrice.gasnier@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Oct 08, 2019 at 01:41:27PM +0200, Fabrice Gasnier wrote:
> Add a comment to better describe the purpose of breakinput feature that
> can be found on some STM32 timer instances. Briefly comment on the
> characteristics of this input for PWM, and pinmuxing as suggested in [1].
> 
> [1] https://lkml.org/lkml/2019/10/1/207
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  drivers/pwm/pwm-stm32.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> index 359b085..6406ebb 100644
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -522,8 +522,14 @@ static int stm32_pwm_apply_breakinputs(struct stm32_pwm *priv,
>  					     sizeof(struct stm32_breakinput));
>  
>  	/*
> +	 * Some timer instances can have BRK input pins (e.g. basically a fault
> +	 * pin from the output power stage). The break feature allows a safe
> +	 * shut-down of the PWM outputs to a predefined state. Further details
> +	 * are available in application note AN4277, "Using STM32 device PWM
> +	 * shut-down features..."

Without having read the application note I don't understand the purpose.
Not sure if this should be a show stopper though.

>  	 * Because "st,breakinput" parameter is optional do not make probe
> -	 * failed if it doesn't exist.
> +	 * failed if it doesn't exist. The pinctrl handle must hold the BRK
> +	 * pin(s) when using "st,breakinput" property.

Is this a comment that has a better place in the binding doc?

Best regards
Uwe


-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
