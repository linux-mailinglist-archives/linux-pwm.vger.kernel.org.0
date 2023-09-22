Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349BB7AB555
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Sep 2023 17:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjIVP7W (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 22 Sep 2023 11:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjIVP7W (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 22 Sep 2023 11:59:22 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A9D83;
        Fri, 22 Sep 2023 08:59:13 -0700 (PDT)
Received: from mail.denx.de (unknown [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: festevam@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 276BE8646A;
        Fri, 22 Sep 2023 17:59:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1695398346;
        bh=sErq8NJlreRkeeEbGvAm57zpF27Gru13ThY6NB0gH5g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zTwEhzX5UPOFkW9IhycQs/kb9GdIQoyVtmmM3o0U4sOIzFjPd65MM4z3Y/bGZz+Ms
         Xdm+PNF0wGQckrYuA4+/IA0yeFgg+KpAzOt/POjHM+/SwxHJjqo1u4gsr2mmBcpDp9
         mBUaEQ9ggMy47VXe3Q9CB/Mzg8qNRt74POoC3XSF0T2SqNxm4ZUAYEJKqDxEjhzPBi
         v4tE2MKmjtxovNMtiohGPuKcrdcL3jXwyH5HcNWHYADe+TqF4oTeyVw2KB5tpo+VOI
         hPZMj6DTj488hlG/vomhCLRibtRkYfjLVpeT1vjZza6SU/NBX9KMeEZD8JY0u98c8p
         vCEwjn0MQmINA==
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 22 Sep 2023 12:59:06 -0300
From:   Fabio Estevam <festevam@denx.de>
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de, Rogan Dawes <rogan@dawes.za.net>
Subject: Re: [PATCH] leds: pwm: Don't disable the PWM when the LED should be
 off
In-Reply-To: <20230922142304.1685985-1-u.kleine-koenig@pengutronix.de>
References: <20230922142304.1685985-1-u.kleine-koenig@pengutronix.de>
Message-ID: <4b5874469878821a7144fb85f143a88d@denx.de>
X-Sender: festevam@denx.de
User-Agent: Roundcube Webmail/1.3.6
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On 22/09/2023 11:23, Uwe Kleine-König wrote:

>  	led_dat->pwmstate.duty_cycle = duty;
> -	led_dat->pwmstate.enabled = duty > 0;
> +	led_dat->pwmstate.enabled = 1;

Thanks for the fix.

Nit: I would suggest:

led_dat->pwmstate.enabled = true;

Reviewed-by: Fabio Estevam <festevam@denx.de>
