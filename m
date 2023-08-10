Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B21777386
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Aug 2023 10:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjHJI57 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 10 Aug 2023 04:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjHJI56 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 10 Aug 2023 04:57:58 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8AE10E7
        for <linux-pwm@vger.kernel.org>; Thu, 10 Aug 2023 01:57:58 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fe501e0b4cso5827495e9.1
        for <linux-pwm@vger.kernel.org>; Thu, 10 Aug 2023 01:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691657876; x=1692262676;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hvj5LFo8WJEabdqR2+suuL+LQnCOEoGV9qAU5Niom54=;
        b=DGf0PBlXmdAXci/VxmocUA85dcBi8H5M/KTQ7KyAx7fDMI7A1DMCXM3sJs39rF0aoc
         SCBvTCpciz865tzKaSZUISoG9/eRXNtBATFDIQg5grTkDdWDmtyrSnyE4XKSt5CQ4lN0
         XaoxHW5tmwtgX38y112cr1o0gUGsk4bvn+4360UXusdv0PEZFcxpF7cbAphPdMRtJVpo
         QcYqvv0x1NkDUB8ZjLtpw9qUVHQFopUBI3EZ3WdRmhmha/sbcFel4ppNA03WgQO6O03K
         WRX1LHRDD+qLZMI6DiCVQaY7OPXMF4D0d2GpFy0tvEM56hmPuzzZ+GIEo80lWHtQzlee
         iabA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691657876; x=1692262676;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hvj5LFo8WJEabdqR2+suuL+LQnCOEoGV9qAU5Niom54=;
        b=KyNu5u3AmqUhF11obhL5WMJix2cte+GsTGRSEfu0wqAa446wCbSwBb7su3x1n4YkYM
         FMgVCYobX3im9BpdfTmFaX7/kuWXXjojBDUGh158U90VA9rE4QK3u5JsnZ9r9yrCpDOd
         SeiLaSWFZ/pe0g09HLP3Drgt98DoBfSQ3bRbbFpl4wcQKUh5hW6vMIIp0KMZAy0uPyMT
         ap4g8ifevorMyT3oM5CtncM2RLiLbuxylTwCbVB0gxQU/6kx2M3xkgiRElq32z+9qWM3
         n6vQqEpqGZPNRj7CHtAUrZ2tqlVpG8JxF4If7+rJS1NE8a31/MmNRSJm8QB9MWvd5lwy
         jWNw==
X-Gm-Message-State: AOJu0YxpVf0Rp8BJlWDj8XKndONzpmdRjg8Pb1qKMqZ0Z6o1DrsBQ8q8
        msclYM2P7UfukaYa8k4RCUSpTw==
X-Google-Smtp-Source: AGHT+IEWuF1/AFoXuZSqEd5AEIVM1YFV/ik3a2AlnWVjBZ1+PDSrW/dEtP1ImYJP9SS/5WqwKymJmg==
X-Received: by 2002:a05:600c:600f:b0:3fe:1923:2c3 with SMTP id az15-20020a05600c600f00b003fe192302c3mr1293442wmb.30.1691657876507;
        Thu, 10 Aug 2023 01:57:56 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.158.65])
        by smtp.gmail.com with ESMTPSA id i9-20020a05600c290900b003fe539b83f2sm4344565wmd.42.2023.08.10.01.57.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 01:57:56 -0700 (PDT)
Message-ID: <7725bc47-c557-5874-e7e0-3d746febbe86@linaro.org>
Date:   Thu, 10 Aug 2023 10:57:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] pwm: jz4740: Consistently name driver data "jz"
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
References: <20230808062608.897710-1-u.kleine-koenig@pengutronix.de>
Content-Language: en-US
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230808062608.897710-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 8/8/23 08:26, Uwe Kleine-König wrote:
> Most but not all pointers to driver data are already called "jz":
> 
> 	$ git grep 'struct jz4740_pwm_chip \*' v6.5-rc1 -- drivers/pwm/pwm-jz4740.c
> 	v6.5-rc1:drivers/pwm/pwm-jz4740.c:static inline struct jz4740_pwm_chip *to_jz4740(struct pwm_chip *chip)
> 	v6.5-rc1:drivers/pwm/pwm-jz4740.c:static bool jz4740_pwm_can_use_chn(struct jz4740_pwm_chip *jz,
> 	v6.5-rc1:drivers/pwm/pwm-jz4740.c:      struct jz4740_pwm_chip *jz = to_jz4740(chip);
> 	v6.5-rc1:drivers/pwm/pwm-jz4740.c:      struct jz4740_pwm_chip *jz = to_jz4740(chip);
> 	v6.5-rc1:drivers/pwm/pwm-jz4740.c:      struct jz4740_pwm_chip *jz = to_jz4740(chip);
> 	v6.5-rc1:drivers/pwm/pwm-jz4740.c:      struct jz4740_pwm_chip *jz4740 = to_jz4740(pwm->chip);
> 	v6.5-rc1:drivers/pwm/pwm-jz4740.c:      struct jz4740_pwm_chip *jz4740;
> 
> Adapt the two variables called "jz4740" to use the same name for
> consistency.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>   drivers/pwm/pwm-jz4740.c | 36 ++++++++++++++++++------------------
>   1 file changed, 18 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

