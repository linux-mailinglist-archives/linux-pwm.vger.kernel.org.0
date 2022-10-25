Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCCE60CA28
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Oct 2022 12:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiJYKdF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Oct 2022 06:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbiJYKdD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Oct 2022 06:33:03 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC98166554
        for <linux-pwm@vger.kernel.org>; Tue, 25 Oct 2022 03:33:02 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id l14so12798500wrw.2
        for <linux-pwm@vger.kernel.org>; Tue, 25 Oct 2022 03:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=66cLoBSJDG8wtROQKHHj/HCiSoIoqGjskOnA1JjrMs4=;
        b=EsinVv7lY4mFWF9zAXFWNSq/PlLiuThvfBA6FIs32bxAt9cSRCW6CoNQM46JXHHV00
         vbLofaGo4uftSErfd0CaUJAloTKfyuSgpenM4aWYIWlmNidUQ1qRPc+UU+EGYbAqgAz6
         PqQmeRQYPLBp0Rse3uGTazS/bUI+GX6LajygaB7oIht8nxsCdzHZR2AFknUZRi7BxWbE
         /jCzdM3/l1sDgX9znlR7Jldhb1QOCPr6Jz0gL/EldC4VJUMQW4BIf4jy6cO43QbvRCzJ
         yPWc1jqcSsGtC8ugXBy+FcUm4iFjlibG2YPEOu572xmbZBPefBi8vI9oODVY3GCrThvQ
         5wrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=66cLoBSJDG8wtROQKHHj/HCiSoIoqGjskOnA1JjrMs4=;
        b=BYjIptM8sv89RrrMUDeJ1XO0tBBu2CGknFsTdHuECsZGdsVpKIe4f+SjijnwDwROus
         /e34/yDpdoSKrciIZVfKIvt397Ypw7HJfdWf10zCiQSQxiD1InZsHdgEkZ/9lk/pYzGt
         MmuU3xLrkJsV+Fct1jP7a619h7dpi0SPUOuCs6FTixDOYKtRcBXUL+1dYqKWS9BAi3Wg
         aQPaOmWJS5syaxRbFh6Toh/zUKp8eIp6j+vmIUoCNRJvtKlhCKdOzeUyojUir1g1pggQ
         RnrutJinVcd6OqB6wzjvFfB3etnMCG5MhgH7YGUCBo3kBiQgLUH8wT5trhOWqxv1jUuQ
         qxuQ==
X-Gm-Message-State: ACrzQf07S8EapTBt4ePitMyftE+TXFUae4QJHdgsiiznSlh2fWELjrAM
        N4yYMZYAU1x4+iJ9CPCYfnT2xQ==
X-Google-Smtp-Source: AMsMyM6M6qlAQjBljmmzOXjq4u3AucmyE7qU1ZqU4aZWRcPhut5obO/D02H6dN7TRWeW0zBEY3oB6w==
X-Received: by 2002:adf:dbc5:0:b0:22c:c605:3b81 with SMTP id e5-20020adfdbc5000000b0022cc6053b81mr24510392wrj.218.1666693980884;
        Tue, 25 Oct 2022 03:33:00 -0700 (PDT)
Received: from [192.168.1.115] ([185.126.107.38])
        by smtp.gmail.com with ESMTPSA id g42-20020a05600c4caa00b003a84375d0d1sm10021817wmp.44.2022.10.25.03.32.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 03:33:00 -0700 (PDT)
Message-ID: <714a3bba-611a-fc78-cb62-f12be9a7e356@linaro.org>
Date:   Tue, 25 Oct 2022 12:32:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: [PATCH 4/5] pwm: jz4740: Depend on MACH_INGENIC instead of MIPS
Content-Language: en-US
To:     Paul Cercueil <paul@crapouillou.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     od@opendingux.net, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
References: <20221024205213.327001-1-paul@crapouillou.net>
 <20221024205213.327001-5-paul@crapouillou.net>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20221024205213.327001-5-paul@crapouillou.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 24/10/22 22:52, Paul Cercueil wrote:
> The MACH_INGENIC Kconfig option will be selected when building a kernel
> targeting Ingenic SoCs, but also when compiling a generic MIPS kernel
> that happens to support Ingenic SoCs.
> 
> Therefore, if MACH_INGENIC is not set, we know that we're not even
> trying to build a generic kernel that supports these SoCs, and we can
> hide the options to compile the SoC-specific drivers.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>   drivers/pwm/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

