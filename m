Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE8B40476C
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Sep 2021 10:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbhIII7K (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Sep 2021 04:59:10 -0400
Received: from mslow1.mail.gandi.net ([217.70.178.240]:45081 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbhIII7K (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Sep 2021 04:59:10 -0400
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 6BD8FD182C
        for <linux-pwm@vger.kernel.org>; Thu,  9 Sep 2021 08:53:54 +0000 (UTC)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 148CDC0013;
        Thu,  9 Sep 2021 08:52:52 +0000 (UTC)
Date:   Thu, 9 Sep 2021 10:51:59 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] pwm: atmel: drop unused header
Message-ID: <YTnLL0VoqFtl9NlD@piout.net>
References: <20210909080903.307314-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210909080903.307314-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 09/09/2021 10:09:03+0200, Uwe Kleine-König wrote:
> Since commit 52eaba4cedbd ("pwm: atmel: Rework tracking updates pending
> in hardware") the driver doesn't make use of mutexes any more, so the
> header defining these doesn't need to be included.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/pwm/pwm-atmel.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> index e748604403cc..98b34ea9f38e 100644
> --- a/drivers/pwm/pwm-atmel.c
> +++ b/drivers/pwm/pwm-atmel.c
> @@ -24,7 +24,6 @@
>  #include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> -#include <linux/mutex.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> -- 
> 2.30.2
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
