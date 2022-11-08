Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3C8621C6C
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Nov 2022 19:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiKHSuK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Nov 2022 13:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiKHStw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Nov 2022 13:49:52 -0500
X-Greylist: delayed 502 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Nov 2022 10:48:59 PST
Received: from mail.mleia.com (mleia.com [178.79.152.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275A15E9E9
        for <linux-pwm@vger.kernel.org>; Tue,  8 Nov 2022 10:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
        t=1667932835; bh=ip+zIiFa6OmX3QdLTDbIxcLSa7l8jkE+o/hv5f2dDmw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jdAgEB+aUz4n64NAGHOA3jIEYLiT1UvGjvJBAj7jlJEi0je1CtvpT58/+nJMQa52Q
         xAvLE6+IUOE7NodqFW8xRxtwB0+tA6tMuy1pdjIfImqpYXBNa0T7t/ywD3Dujl10Wf
         SMSPOrKoHCuUmsZh9ysmvaLvgMl/i2e0kBAI+zBQYuFe6IFsdBp/h7SOHTpz34UY7B
         bvR2AnqXIWixfTmj1XpCY8Sa6eZvoJwnqlGkGhXEoagAYwyE6zliE8wPcxQGnUUqqB
         oQk/qo+1Qjr82AtPHYYHA4E3lW2Tsr08A+W4vatExFO0HS2x8SD0n3Qt4lGf9r/EWq
         HQEGuvvmZTjyA==
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 7E9783E9897;
        Tue,  8 Nov 2022 18:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
        t=1667932835; bh=ip+zIiFa6OmX3QdLTDbIxcLSa7l8jkE+o/hv5f2dDmw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jdAgEB+aUz4n64NAGHOA3jIEYLiT1UvGjvJBAj7jlJEi0je1CtvpT58/+nJMQa52Q
         xAvLE6+IUOE7NodqFW8xRxtwB0+tA6tMuy1pdjIfImqpYXBNa0T7t/ywD3Dujl10Wf
         SMSPOrKoHCuUmsZh9ysmvaLvgMl/i2e0kBAI+zBQYuFe6IFsdBp/h7SOHTpz34UY7B
         bvR2AnqXIWixfTmj1XpCY8Sa6eZvoJwnqlGkGhXEoagAYwyE6zliE8wPcxQGnUUqqB
         oQk/qo+1Qjr82AtPHYYHA4E3lW2Tsr08A+W4vatExFO0HS2x8SD0n3Qt4lGf9r/EWq
         HQEGuvvmZTjyA==
Received: from [192.168.1.102] (88-112-131-206.elisa-laajakaista.fi [88.112.131.206])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mleia.com (Postfix) with ESMTPSA id 2B0203E96EB;
        Tue,  8 Nov 2022 18:40:35 +0000 (UTC)
Message-ID: <87c27860-d6ff-7e2e-60c7-22f20fd3b715@mleia.com>
Date:   Tue, 8 Nov 2022 20:40:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH] pwm: lpc18xx-sct: Fix a comment to match code
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
References: <20221108153013.132514-1-u.kleine-koenig@pengutronix.de>
From:   Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <20221108153013.132514-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20221108_184035_538180_25113273 
X-CRM114-Status: GOOD (  12.19  )
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 11/8/22 17:30, Uwe Kleine-König wrote:
> lpc18xx_pwm_probe() only ensures clk_rate <= NSEC_PER_SEC, the following
> reasoning is right even under this slightly lesser condition.
> 
> Fixes: 8933d30c5f46 ("pwm: lpc18xx: Fix period handling")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>   drivers/pwm/pwm-lpc18xx-sct.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
> index 763f2e3a146d..378e1df944dc 100644
> --- a/drivers/pwm/pwm-lpc18xx-sct.c
> +++ b/drivers/pwm/pwm-lpc18xx-sct.c
> @@ -175,7 +175,7 @@ static void lpc18xx_pwm_config_duty(struct pwm_chip *chip,
>   	u32 val;
>   
>   	/*
> -	 * With clk_rate < NSEC_PER_SEC this cannot overflow.
> +	 * With clk_rate <= NSEC_PER_SEC this cannot overflow.
>   	 * With duty_ns <= period_ns < max_period_ns this also fits into an u32.
>   	 */
>   	val = mul_u64_u64_div_u64(duty_ns, lpc18xx_pwm->clk_rate, NSEC_PER_SEC);

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

--
Best wishes,
Vladimir
