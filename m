Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA6C180DDD
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2020 03:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbgCKCLZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 Mar 2020 22:11:25 -0400
Received: from gofer.mess.org ([88.97.38.141]:46303 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbgCKCLZ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 10 Mar 2020 22:11:25 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id EF0C3C6372; Wed, 11 Mar 2020 02:11:22 +0000 (GMT)
Date:   Wed, 11 Mar 2020 02:11:22 +0000
From:   Sean Young <sean@mess.org>
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v8 04/12] ir-rx51: Use 64-bit division macro
Message-ID: <20200311021122.GA13338@gofer.mess.org>
References: <cover.1583889178.git.gurus@codeaurora.org>
 <fdb2c5092005f5f149ff71123ff1b895fc3a2249.1583889178.git.gurus@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdb2c5092005f5f149ff71123ff1b895fc3a2249.1583889178.git.gurus@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Mar 10, 2020 at 06:41:13PM -0700, Guru Das Srinagesh wrote:
> Since the PWM framework is switching struct pwm_state.period's datatype
> to u64, prepare for this transition by using DIV_ROUND_CLOSEST_ULL to
> handle a 64-bit dividend.
> 
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Richard Fontana <rfontana@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Kate Stewart <kstewart@linuxfoundation.org>
> Cc: Allison Randal <allison@lohutok.net>
> Cc: linux-media@vger.kernel.org

Acked-by: Sean Young <sean@mess.org>

> 
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> ---
>  drivers/media/rc/ir-rx51.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/rc/ir-rx51.c b/drivers/media/rc/ir-rx51.c
> index 8574eda..9a5dfd7 100644
> --- a/drivers/media/rc/ir-rx51.c
> +++ b/drivers/media/rc/ir-rx51.c
> @@ -241,7 +241,8 @@ static int ir_rx51_probe(struct platform_device *dev)
>  	}
>  
>  	/* Use default, in case userspace does not set the carrier */
> -	ir_rx51.freq = DIV_ROUND_CLOSEST(pwm_get_period(pwm), NSEC_PER_SEC);
> +	ir_rx51.freq = DIV_ROUND_CLOSEST_ULL(pwm_get_period(pwm),
> +			NSEC_PER_SEC);
>  	pwm_put(pwm);
>  
>  	hrtimer_init(&ir_rx51.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
