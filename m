Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D498755B14
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Jul 2023 08:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjGQGAr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 17 Jul 2023 02:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjGQGAp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 17 Jul 2023 02:00:45 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495D5E64
        for <linux-pwm@vger.kernel.org>; Sun, 16 Jul 2023 23:00:43 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fbf1f6c771so6492009e87.1
        for <linux-pwm@vger.kernel.org>; Sun, 16 Jul 2023 23:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689573641; x=1692165641;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1EAEq9EYfLiHz07Q1JLn+kabYfXHc9a64epSts6zTJE=;
        b=uhUXLthHHoB8O71J+1sXRRl4eDV9hOW7gwQNDNxwcn+PEFFTxYIr2u22XsDFCPq41W
         NQYZsQfb+qIVRNa3hlCryh6n3blIItExfhIl3gouoKOd6eLaw/tMe5sOYmAqnTaahsKS
         PqMG9YNb09o5G+kpbBsN4/xmAXU3xq0s44A7sBNSJkKSVhyaFXMO+C1382GoRCqoBtGf
         Tp8zqapKM82sFSlDoRzlZbhInPbBq0nVM6aPHqG/woSR1WWdgSyX+AxeBtqM7UJ98T67
         XN1tz/opYzYciF7UtEJg6ZALqri37jsn7xfSuy15lS/RZQz9WA8xi0ng1kInesEuA6uR
         YPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689573641; x=1692165641;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1EAEq9EYfLiHz07Q1JLn+kabYfXHc9a64epSts6zTJE=;
        b=eGgQDnZjONjCQHbC/UzG+W+fRhbj+Tci8DdB5HlS5OVrlKvNFYj8q1GvpDs5YvPmKn
         d2kRQwXfOsz1PBK8vurtP4elYMr3j9rQbevcXQNy5FpZQCc/qSQd9rhJyRCawUxnwhKS
         JbvuuT/+w+03K+irpHnr4X8pcoRXpBw1Zy1cEGaXZLF3Zprnu12e1p8NPD4svUOtv79U
         8XYhnx+Y3mZohwD+8Hr9+y6C11pLZfx9B9VTK9D+EOiPj3UHUUuaLitPQkBGNLHF1aar
         IHBC8/Vt8xVo6JjQlnQfM+HCn9zMSq/8qLLWg9PKl25Sodog8eopid0/aDeD4PTv88p2
         P2yw==
X-Gm-Message-State: ABy/qLbzObT/Sb0jMJZ4tbuJCXtyLVMGUMrR41HE42ojpRgwu1xDPWSD
        APnhydc4oiR0vv7Uj7xUw4982Q==
X-Google-Smtp-Source: APBJJlE3eWcYfh3FAyK8DWXar9G/0y/7PYTZYtQUJ85PhOV/Kn8ydUYaWil/51EbkL/CiKOPVYIN3A==
X-Received: by 2002:a05:6512:3f10:b0:4fb:8bad:1cdf with SMTP id y16-20020a0565123f1000b004fb8bad1cdfmr7294469lfa.42.1689573641445;
        Sun, 16 Jul 2023 23:00:41 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id b7-20020aa7c6c7000000b00521713ac50asm3550858eds.34.2023.07.16.23.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jul 2023 23:00:41 -0700 (PDT)
Message-ID: <47519060-7a1e-d0e7-8c7f-06260da5149a@linaro.org>
Date:   Mon, 17 Jul 2023 08:00:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/3] pwm: samsung: Add compatible for ExynosAutov9 SoC
Content-Language: en-US
To:     Jaewon Kim <jaewon02.kim@samsung.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>
References: <20230714100929.94563-1-jaewon02.kim@samsung.com>
 <CGME20230714101434epcas2p3e2475698c527ca72dee797225d3dad37@epcas2p3.samsung.com>
 <20230714100929.94563-3-jaewon02.kim@samsung.com>
 <20230715072203.ecz7wg4novvhpyuj@pengutronix.de>
 <ef5341dc-3539-ef20-84bb-b32c0b76be2b@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ef5341dc-3539-ef20-84bb-b32c0b76be2b@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 17/07/2023 06:44, Jaewon Kim wrote:
> Hello,
> 
> 
> On 23. 7. 15. 16:22, Uwe Kleine-König wrote:
>> Hello,
>>
>> On Fri, Jul 14, 2023 at 07:09:28PM +0900, Jaewon Kim wrote:
>>> Add new compatible string to support ExynosAutov9 SoC.
>>>
>>> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
>> Looks good to me:
>>
>> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>>
>> What are the merge plans here? The whole series via pwm or a samsung
>> tree? Or a mixture?
> 
> It would be nice to be merged whole series in the samsung tree.
> 
> Krzysztof could you apply all patch after your review?

Patch needs fixes - it is really different than we talked about.

Anyway, both PWM patches - bindings and driver - should go via PWM tree.
I will take the DTS, once proper version is sent.

Best regards,
Krzysztof

