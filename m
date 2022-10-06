Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB3B5F625B
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Oct 2022 10:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiJFINJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 6 Oct 2022 04:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiJFINI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Oct 2022 04:13:08 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5363BC4A
        for <linux-pwm@vger.kernel.org>; Thu,  6 Oct 2022 01:13:06 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id p5so1303601ljc.13
        for <linux-pwm@vger.kernel.org>; Thu, 06 Oct 2022 01:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=knVgkzHrPTCqB1ZFhjM+hWo7hg4pHaozQe9OPUNBOUo=;
        b=HJQe7+5xV1cJtj5fiZ8I0ZNzlmCbMnzkv+7OpTQqKOHCKAdEyF1ufnvaOLnm9E4kDf
         I6334zEfb8BMVRReTSIuOABziXT8yT6TdS0eC9FrduTsv13s6g/XFCBrRlQtOxwBJnrk
         /QpPdCV59qsuUMsc2ZGydAEuqgKAym3SV072InyRMYE+6V+WdpFjpUPGNrRI3i6nMOcO
         0DS5OjULx7p3C9n/nZIZ6V3qhD8zlPbbylc+lH/HH0vhYNhuKUDUC1VHZ0z+eHImsyaj
         QdzEccpIV+tSCh2q2J/Qsg6ogIBZqrnCglVBD0X/jGzNdVCL/udde0Umf2wuDxcpC+hZ
         DXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=knVgkzHrPTCqB1ZFhjM+hWo7hg4pHaozQe9OPUNBOUo=;
        b=DdZ0KE0xPMIsxZh+L/G8Ka7OiDakOfOQ2Am9ZOh0G8XPiXih2Ki6lRxwR7giRCDw2e
         kP5MvV5XmgtdGZiZU+oQ57CMayOx2pXosBCrA04wWsqzzQo+HywznBytW1wMLHODTLwx
         ZOjoEylt9gzyD9Ze+xybTXv501XxPhhfbq99FfyCO2hHNFx983TO+p+hwrrWk3DIBq52
         6702rXLAmnoI0JVDXNujHhMJsw3qZuu+UeOZ5mCvBxCNsBJmNa1z2TI3zlVhQ8QZXJ+T
         X3nTj34srwS7LoAnu3ISfXgKgDr5pNUZMJsPZ3QCfIS9luVbRlDdC9To/DD832626DVD
         KppQ==
X-Gm-Message-State: ACrzQf2jAimkOnnjsUfo8j28jKnGC6XHLlo1HKz7jkxtNFTm/1rO5l07
        JT5JKMHuN8phgdIKgPV1sgDGEA==
X-Google-Smtp-Source: AMsMyM4zWbqUkeAPPnI+E/LINbSegImIRrqIp4sfOgPhFiovple/lcBRebLD2YelGk8j57cHPygWuw==
X-Received: by 2002:a2e:90d6:0:b0:26b:8a74:6aa0 with SMTP id o22-20020a2e90d6000000b0026b8a746aa0mr1370533ljg.350.1665043985300;
        Thu, 06 Oct 2022 01:13:05 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q3-20020a0565123a8300b00498fc3d4cfdsm2615671lfu.189.2022.10.06.01.13.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 01:13:04 -0700 (PDT)
Message-ID: <52faca2b-b4b4-6af8-6038-8e90bf02748c@linaro.org>
Date:   Thu, 6 Oct 2022 10:13:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v5 01/10] dt-bindings: pwm: Document Synopsys DesignWare
 snps,pwm-dw-apb-timers-pwm2
Content-Language: en-US
To:     Ben Dooks <ben.dooks@sifive.com>, linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
References: <20221005221242.470734-1-ben.dooks@sifive.com>
 <20221005221242.470734-2-ben.dooks@sifive.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221005221242.470734-2-ben.dooks@sifive.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 06/10/2022 00:12, Ben Dooks wrote:
> Add documentation for the bindings for Synopsys' DesignWare PWM block
> as we will be adding DT/platform support to the Linux driver soon.
> 
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> ---
> v5:
>  - fixed order of properties
>  - corrected clock to two items
> v4:
>  - fixed typos, added reg


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

