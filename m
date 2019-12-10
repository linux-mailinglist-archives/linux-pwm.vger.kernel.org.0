Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 128E81180CD
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Dec 2019 07:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfLJGwc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 Dec 2019 01:52:32 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55951 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbfLJGwc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 Dec 2019 01:52:32 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ieZNm-0002nD-1i; Tue, 10 Dec 2019 07:52:30 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1ieZNl-0004eE-Cp; Tue, 10 Dec 2019 07:52:29 +0100
Date:   Tue, 10 Dec 2019 07:52:29 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, wahrenst@gmx.net,
        Thierry Reding <thierry.reding@gmail.com>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH] pwm: bcm2835: Allow building for ARCH_BRCMSTB
Message-ID: <20191210065229.hopmnq5qlwtl7gzw@pengutronix.de>
References: <20191209232503.7252-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191209232503.7252-1-f.fainelli@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Dec 09, 2019 at 03:25:03PM -0800, Florian Fainelli wrote:
> BCM7211 is supported using ARCH_BRCMSTB and uses this PWM controller
> driver, make it possible to build it.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/pwm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index bd21655c37a6..0bb8a40c8d6c 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -100,7 +100,7 @@ config PWM_BCM_KONA
>  
>  config PWM_BCM2835
>  	tristate "BCM2835 PWM support"
> -	depends on ARCH_BCM2835
> +	depends on ARCH_BCM2835 || ARCH_BRCMSTB

It would be nice to allow this driver to be compiled with COMPILE_TEST,
too. But also without this:

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
