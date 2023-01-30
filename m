Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB07681795
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jan 2023 18:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235920AbjA3R35 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Jan 2023 12:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237831AbjA3R34 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Jan 2023 12:29:56 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED200F762
        for <linux-pwm@vger.kernel.org>; Mon, 30 Jan 2023 09:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675099794; x=1706635794;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MPZQ/63M+omAVxPKJcSisYuO3g1GReuv1Ji34fmNcmc=;
  b=NBaNJdr/X7wo6b+N7/Zjn6V2bVpbkf0aUWcpOxlzPTjEXshTELEBmNtL
   Uuxezc+7evDzYLBBEbl/+2AcK8DodNpaaPSAUBWzVC5FghDRmT2bckZRB
   1EUP8pYDUmi1NbetiC47Pl1IZz7I3v1vb5EKsHblzofrp3hVSsoOJ7wEv
   +UL8X3zU96BEJnSnaCu0Q+IPCW46SGYVB7PWRvrrPeqtUlIUNToyuPDm1
   QMqrD93Sdz2yvC6CDqycON6r4Bjtid9NK5kwdvjPEujRnh3HcJaaniWCK
   6+sE3EfeZmXwdwNk5GCC8OZhLeH23LNDX4MRqdrZ0+cCpsP81xRNxcrhO
   A==;
X-IronPort-AV: E=Sophos;i="5.97,258,1669100400"; 
   d="scan'208";a="198029907"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jan 2023 10:29:53 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 10:29:42 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.16 via Frontend
 Transport; Mon, 30 Jan 2023 10:29:40 -0700
Message-ID: <77464f22-7017-9200-e965-e3e3c8baf2a6@microchip.com>
Date:   Mon, 30 Jan 2023 18:29:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] pwm: atmel: drop unused header
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
CC:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pwm@vger.kernel.org>, <kernel@pengutronix.de>
References: <20210909080903.307314-1-u.kleine-koenig@pengutronix.de>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20210909080903.307314-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Thierry,

On 09/09/2021 at 10:09, Uwe Kleine-König wrote:
> Since commit 52eaba4cedbd ("pwm: atmel: Rework tracking updates pending
> in hardware") the driver doesn't make use of mutexes any more, so the
> header defining these doesn't need to be included.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

It looks like this (trivial) patch was forgotten for some time even if 
Acked by several of us: aka ping.

> ---
>   drivers/pwm/pwm-atmel.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> index e748604403cc..98b34ea9f38e 100644
> --- a/drivers/pwm/pwm-atmel.c
> +++ b/drivers/pwm/pwm-atmel.c
> @@ -24,7 +24,6 @@
>   #include <linux/err.h>
>   #include <linux/io.h>
>   #include <linux/module.h>
> -#include <linux/mutex.h>
>   #include <linux/of.h>
>   #include <linux/of_device.h>
>   #include <linux/platform_device.h>
> --
> 2.30.2
> 

-- 
Nicolas Ferre

