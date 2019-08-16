Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 170F690990
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Aug 2019 22:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbfHPUoH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 16 Aug 2019 16:44:07 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:59233 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfHPUoH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 16 Aug 2019 16:44:07 -0400
X-Originating-IP: 90.65.161.137
Received: from localhost (lfbn-1-1545-137.w90-65.abo.wanadoo.fr [90.65.161.137])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 00F6AFF807;
        Fri, 16 Aug 2019 20:43:57 +0000 (UTC)
Date:   Fri, 16 Aug 2019 22:43:57 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 4/3] pwm: atmel: document known weaknesses of both
 hardware and software
Message-ID: <20190816204357.GG3545@piout.net>
References: <20190815214133.11134-1-uwe@kleine-koenig.org>
 <20190816093748.11769-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190816093748.11769-1-uwe@kleine-koenig.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 16/08/2019 11:37:48+0200, Uwe Kleine-König wrote:
> Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
> ---
>  drivers/pwm/pwm-atmel.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> index 42fe7bc043a8..1ddb93db9627 100644
> --- a/drivers/pwm/pwm-atmel.c
> +++ b/drivers/pwm/pwm-atmel.c
> @@ -7,6 +7,16 @@
>   *
>   * Reference manual for "atmel,at91sam9rl-pwm":
>   *   http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-11032-32-bit-ARM926EJ-S-Microcontroller-SAM9G25_Datasheet.pdf
> + *
> + * Limitations:
> + * - Periods start with the inactive level.
> + * - Hardware has to be stopped in general to update settings.
> + *
> + * Software bugs/possible improvements:
> + * - When atmel_pwm_apply() is called with state->enabled=false a change in
> + *   state->polarity isn't honored.
> + * - Instead of sleeping to wait for a completed period, the interrupt
> + *   functionality could be used.

This is definitively not trivial to do right. The main reason it is not
done so is that reading PWM_ISR will clear all the bits so it is
necessary to be very careful to avoid race conditions. I'm not sure it
is worth the effort.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
