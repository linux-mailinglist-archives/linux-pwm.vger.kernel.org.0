Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC69496C93
	for <lists+linux-pwm@lfdr.de>; Sat, 22 Jan 2022 14:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbiAVN14 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 22 Jan 2022 08:27:56 -0500
Received: from mail.pqgruber.com ([52.59.78.55]:37468 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233097AbiAVN1z (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 22 Jan 2022 08:27:55 -0500
X-Greylist: delayed 511 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Jan 2022 08:27:55 EST
Received: from workstation (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 0104EC761B2;
        Sat, 22 Jan 2022 14:19:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1642857562;
        bh=mo/iXRjVQjaw/Siv2eQFTsooZeilkHT2tSxV1V8c66c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GMqqUgTHNEsp1j7D2JIt6IuU5/j0afVqgsxJzEEuYAp4vnxPycyBTQAPTJOKaIHIM
         3hxi185anKXw2n821X3/GKrbgS/sH4b1akdfs4BQDyhL/KD8QV0bfGBew4ZTKo+Bf3
         UJJer2sIX9/DHzPmZu2BqY01LVT5IjQ2pzcNwRCE=
Date:   Sat, 22 Jan 2022 14:19:20 +0100
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Lionel Vitte <lionel.vitte@gmail.com>
Cc:     linux-pwm@vger.kernel.org, thierry.reding@gmail.com
Subject: Re: [PATCH] pwm: pca9685: Set ALL_LED_OFF_L to POR value
Message-ID: <YewEWDGWhXiqPCvT@workstation>
References: <20220122065819.69150-1-lionel.vitte@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220122065819.69150-1-lionel.vitte@free.fr>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, Jan 22, 2022 at 07:58:19AM +0100, Lionel Vitte wrote:
> During the driver probe, registers are not set to their POR value.
> 
> Signed-off-by: Lionel Vitte <lionel.vitte@free.fr>
> ---
>  drivers/pwm/pwm-pca9685.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> index c56001a790d0..c91fa7f9e33d 100644
> --- a/drivers/pwm/pwm-pca9685.c
> +++ b/drivers/pwm/pwm-pca9685.c
> @@ -560,10 +560,10 @@ static int pca9685_pwm_probe(struct i2c_client *client,
>  	pca9685_write_reg(pca, PCA9685_MODE1, reg);
>  
>  	/* Reset OFF/ON registers to POR default */
> -	pca9685_write_reg(pca, PCA9685_ALL_LED_OFF_L, LED_FULL);
> +	pca9685_write_reg(pca, PCA9685_ALL_LED_OFF_L, 0);
>  	pca9685_write_reg(pca, PCA9685_ALL_LED_OFF_H, LED_FULL);
>  	pca9685_write_reg(pca, PCA9685_ALL_LED_ON_L, 0);
> -	pca9685_write_reg(pca, PCA9685_ALL_LED_ON_H, 0);
> +	pca9685_write_reg(pca, PCA9685_ALL_LED_ON_H, LED_FULL);
>  
>  	pca->chip.ops = &pca9685_pwm_ops;
>  	/* Add an extra channel for ALL_LED */
> -- 
> 2.34.1
>

Good catch! Resetting the ON registers to 0 is no longer necessary and
the ALL_LED_OFF_L write with LED_FULL was a mistake.

Maybe you could have chosen another subject as you are not only fixing
the ALL_LED_OFF_L mistake. Maybe ".. Fix OFF/ON register reset to POR"
or something similar.

Other than that:

Acked-by: Clemens Gruber <clemens.gruber@pqgruber.com>

Regards,
Clemens
