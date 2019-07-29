Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3AE778669
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jul 2019 09:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfG2HfT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Mon, 29 Jul 2019 03:35:19 -0400
Received: from smtp180.sjtu.edu.cn ([202.120.2.180]:40790 "EHLO
        smtp180.sjtu.edu.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfG2HfT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Jul 2019 03:35:19 -0400
Received: from mta04.sjtu.edu.cn (mta04.sjtu.edu.cn [202.121.179.8])
        by smtp180.sjtu.edu.cn (Postfix) with ESMTPS id 8916710089E1C;
        Mon, 29 Jul 2019 15:35:15 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mta04.sjtu.edu.cn (Postfix) with ESMTP id 6A8B0180610F8;
        Mon, 29 Jul 2019 15:35:15 +0800 (CST)
X-Virus-Scanned: amavisd-new at 
Received: from mta04.sjtu.edu.cn ([127.0.0.1])
        by localhost (mta04.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7dS9vcJ9Qf-l; Mon, 29 Jul 2019 15:35:15 +0800 (CST)
Received: from mailstore19.sjtu.edu.cn (mailstore19.sjtu.edu.cn [202.121.179.19])
        by mta04.sjtu.edu.cn (Postfix) with ESMTP id 3F0A0180610F7;
        Mon, 29 Jul 2019 15:35:15 +0800 (CST)
Date:   Mon, 29 Jul 2019 15:35:14 +0800 (CST)
From:   Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Yash Shah <yash.shah@sifive.com>,
        thierry reding <thierry.reding@gmail.com>,
        palmer <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-pwm@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>
Message-ID: <310108829.9436429.1564385714781.JavaMail.zimbra@sjtu.edu.cn>
In-Reply-To: <20190729062548.4pio5sfuxfwwxecr@pengutronix.de>
References: <20190727070916.2960-1-xywang.sjtu@sjtu.edu.cn> <20190729062548.4pio5sfuxfwwxecr@pengutronix.de>
Subject: Re: [PATCH] pwm: avoid disabling clk twice
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [202.120.40.82]
X-Mailer: Zimbra 8.8.9_GA_3798 (ZimbraWebClient - GC73 (Linux)/8.8.9_GA_3744)
Thread-Topic: avoid disabling clk twice
Thread-Index: 5H4ORNZJT/EZAbsON7ampQXHnGMF2w==
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



----- On Jul 29, 2019, at 2:25 PM, Uwe Kleine-König u.kleine-koenig@pengutronix.de wrote:

> Hello,
> 
> On Sat, Jul 27, 2019 at 03:09:16PM +0800, Wang Xiayang wrote:
>> Similar to commit 63fd4b94b948 ("serial: imx: fix error handling
>> in console_setup"), as ddata->clk has been explicitly disabled two
>> lines above, it should avoid being disabled for the second time.
>> clk_unprepare() suits here better.
>> 
>> Signed-off-by: Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
>> ---
>>  drivers/pwm/pwm-sifive.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
>> index a7c107f19e66..00f6fab5bd3b 100644
>> --- a/drivers/pwm/pwm-sifive.c
>> +++ b/drivers/pwm/pwm-sifive.c
>> @@ -312,7 +312,7 @@ static int pwm_sifive_remove(struct platform_device *dev)
>>  	if (is_enabled)
>>  		clk_disable(ddata->clk);
>>  
>> -	clk_disable_unprepare(ddata->clk);
>> +	clk_unprepare(ddata->clk);
>>  	ret = pwmchip_remove(&ddata->chip);
>>  	clk_notifier_unregister(ddata->clk, &ddata->notifier);
> 
> I think this patch is wrong.
> 
> After a successfull call to .probe the clock is left prepared and
> enabled. This is undone in the unconditional call to
> clk_disable_unprepare that you removed.

Thank you very much for pointing out the issue. I did miss the normal path:(

> There is however still a problem: If Linux is started with the pwm
> enabled (such that .get_state returns state->enabled = true) then
> disabling the pwm has one clk_disable too much.
> 

There is another path of double-disabling: pwm_sifive_enable() may disable
ddata->clk as required by the 'enable' flag.
pwm_sifive_apply() calls it and passes the flag. However, there is
a clk_disable(ddata->clk) just below invoking pwm_sifive_enable()
in pwm_sifive_apply().
