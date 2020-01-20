Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30D6B14244A
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Jan 2020 08:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgATHeJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 20 Jan 2020 02:34:09 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46859 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgATHeJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jan 2020 02:34:09 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1itRZY-0001W4-AV; Mon, 20 Jan 2020 08:34:08 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1itRZX-00010y-8l; Mon, 20 Jan 2020 08:34:07 +0100
Date:   Mon, 20 Jan 2020 08:34:07 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     yu kuai <yukuai3@huawei.com>
Cc:     thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhengbin13@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH] pwm: remove set but not set variable 'pwm'
Message-ID: <20200120073407.ck2fmk7qdvqsfqsy@pengutronix.de>
References: <20200119122202.14502-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200119122202.14502-1-yukuai3@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

$Subject ~= s/not set/not used/

On Sun, Jan 19, 2020 at 08:22:02PM +0800, yu kuai wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/pwm/pwm-pca9685.c: In function ‘pca9685_pwm_gpio_free’:
> drivers/pwm/pwm-pca9685.c:162:21: warning: variable ‘pwm’ set but
> not used [-Wunused-but-set-variable]
> 
> It is never used, and so can be removed.
> 
> Signed-off-by: yu kuai <yukuai3@huawei.com>

Fixes: e926b12c611c ("pwm: Clear chip_data in pwm_put()")

> ---
>  drivers/pwm/pwm-pca9685.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> index 168684b02ebc..b07bdca3d510 100644
> --- a/drivers/pwm/pwm-pca9685.c
> +++ b/drivers/pwm/pwm-pca9685.c
> @@ -159,13 +159,9 @@ static void pca9685_pwm_gpio_set(struct gpio_chip *gpio, unsigned int offset,
>  static void pca9685_pwm_gpio_free(struct gpio_chip *gpio, unsigned int offset)
>  {
>  	struct pca9685 *pca = gpiochip_get_data(gpio);
> -	struct pwm_device *pwm;
>  
>  	pca9685_pwm_gpio_set(gpio, offset, 0);
>  	pm_runtime_put(pca->chip.dev);
> -	mutex_lock(&pca->lock);
> -	pwm = &pca->chip.pwms[offset];
> -	mutex_unlock(&pca->lock);

Did you check that dropping the locking is save? (I didn't)

I'd assume that no harm is introduced, but mentioning that in the commit
log would be good.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
