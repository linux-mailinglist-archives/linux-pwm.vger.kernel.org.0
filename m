Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAD758CA9F
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Aug 2022 16:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237548AbiHHOjK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 8 Aug 2022 10:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbiHHOjJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 8 Aug 2022 10:39:09 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE4B65F2
        for <linux-pwm@vger.kernel.org>; Mon,  8 Aug 2022 07:39:07 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id h186-20020a1c21c3000000b003a5360f218fso625022wmh.3
        for <linux-pwm@vger.kernel.org>; Mon, 08 Aug 2022 07:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Yfx5Fy5cN2az6kfckQUrUy6w54e1VxWOvlvl3ISd03g=;
        b=Q5+t5E23tFMkREANclol+R/2J00dEzl7xp1vqLnTXJqyhPT0Ww31q42/Nj8fOqdR4V
         UF3r7pDk2u8glTvuxFQLEaDdJaHVZhFoQQuqAnWbhrf3plNUsTAGz0wIfRwCdNgqh3PF
         M0bMWkntpZspeYhlvV0nqwebdHrecI05Iy7kQ2mWLiR5H5rlOe3qLkK1meWaPpPhPLcM
         ADVI6m1HEAHTpM0/VBl/AWOEQD5KRGWgWUWfLU1QNzlYKNnd81xHzhTrHrmQXiU2TIEY
         zoYbBjcTQ6vXmmiM6eAjCaSKB0SBWbYV1y+u3OocCQtDQVnxh+qxZw6WMkhGN/cmYlgk
         DTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Yfx5Fy5cN2az6kfckQUrUy6w54e1VxWOvlvl3ISd03g=;
        b=uxLn2QexLmJPQ3Dvaq0t/FqnJ+qIQ5gGlJLHpVKYOqkBiwwpCs9u7myDT8z1RmtE8z
         QU+6tl9FB8WxmIJuRZLv34Wexo14/iI7Toh/717WS4/q8As/VGGVMRviPpi09OoXiX0A
         gjL8pObdZmDIOE6HyKNrssk2f/ynbkBg5ycepd0+MvLVhimtqLUHvZgIH0wHyVpY7ifB
         LtsT7xYaXw2tKKXfKIaFyCJDPO+Cp/Na0L7qThOTE8vbZz7WFdk00LcBwwYgNZFttXvT
         MSCGN41Z7afrFWMmquzHPDSHqBnzVFCvazIl7ggsakcr7xLJ1OpPKC9RtEhDPVErrb+Q
         AV+Q==
X-Gm-Message-State: ACgBeo3V5vg7Y3sttEqmzlVA8WInud8/T02G0nmvqwOrzxeBcPyuPBR0
        t9JMo2weUDv499d5JN9OGlCbUw==
X-Google-Smtp-Source: AA6agR7RvpVhiXGrYtB1bDOmUDufwnqtBPQ8VPj5QpuYPU/1sM0dIFpoxORAGlWHx0c3DJkah3hDZg==
X-Received: by 2002:a05:600c:a18e:b0:3a3:10ef:672a with SMTP id id14-20020a05600ca18e00b003a310ef672amr17000351wmb.14.1659969545936;
        Mon, 08 Aug 2022 07:39:05 -0700 (PDT)
Received: from [10.35.5.6] ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id u13-20020a5d434d000000b0021e74ef5ae8sm11519900wrr.21.2022.08.08.07.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 07:39:05 -0700 (PDT)
Message-ID: <b73e8514-ad73-c207-ccef-1b156a796689@sifive.com>
Date:   Mon, 8 Aug 2022 15:39:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 4/8] pwm: dwc: add of/platform support
Content-Language: en-GB
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha --subject-prefix=PATCH v3 
        <jude.onyenegecha@sifive.com>
References: <20220805165033.140958-1-ben.dooks@sifive.com>
 <20220805165033.140958-5-ben.dooks@sifive.com>
 <6ecdfca0-61fc-ad75-67d0-e49efc7b3f6d@linux.intel.com>
From:   Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <6ecdfca0-61fc-ad75-67d0-e49efc7b3f6d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 08/08/2022 15:36, Jarkko Nikula wrote:
> Hi
> 
> On 8/5/22 19:50, Ben Dooks wrote:
>> The dwc pwm controller can be used in non-PCI systems, so allow
>> either platform or OF based probing.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
>> ---
>> v3:
>>   - changed compatible name
>> ---
>>   drivers/pwm/Kconfig   |  5 ++--
>>   drivers/pwm/pwm-dwc.c | 53 +++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 56 insertions(+), 2 deletions(-)
>>
> ...
> 
>> @@ -319,6 +320,58 @@ static struct pci_driver dwc_pwm_driver = {
>>   module_pci_driver(dwc_pwm_driver);
> ...
>> +module_platform_driver(dwc_pwm_plat_driver);
>> +
> 
> These module_X_driver() macros cannot coexist in the same module and 
> ideally the same kernel built should support probing both PCI and OF 
> based systems in runtime, i.e. putting those macros under #ifdef is not 
> ideal.
> 
> Usually this is solved either by common code has the platform device 
> probing (with or without the OF support) and the PCI part is in another 
> module which adds the platform device(s) or both platform and PCI device 
> code are in own modules and call common code.

Yeah, just realised that.

I'm not sure it is worth splitting the driver as most of the probe code
is pretty small so it might be worth just having one init function that
adds both the pcie and the of drivers.

-- 
Ben
