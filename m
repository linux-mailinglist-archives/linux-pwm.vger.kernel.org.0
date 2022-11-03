Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C490461802C
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Nov 2022 15:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbiKCOx5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 3 Nov 2022 10:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbiKCOxj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 3 Nov 2022 10:53:39 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB6A186DC
        for <linux-pwm@vger.kernel.org>; Thu,  3 Nov 2022 07:53:36 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id n18so1253175qvt.11
        for <linux-pwm@vger.kernel.org>; Thu, 03 Nov 2022 07:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jrYaAHvMcvAgON2HJIoIE2IBvbz54WPBWq/9VlMTUN8=;
        b=xcBA91hGHInB4KTtVPZW2NQt5yB4tHUi+auIQ6aJYlat/DX9nRYEWLG9Ju6DkX7E2K
         9K7S29pUk6u7a8H9r7lF/QBisDa55jpu6giSceDXlOJF/9E+QYs4tAUglvDUaot0WRCM
         m/BmMgMBcveJe63QYdIu3qRKbj+vqqfT6C7c7iLuulV/Q4QCWSANGqOhqinFzqDXS82c
         0pmIhZRPXfhk3x3v1x2Mc/6FM+5r8Y9gqyeoDYjkibFZgqJCl9ZCDNiN1LDyNZOoTqCn
         06ISmv0xruPzl9gWKgb6/6yqcHJ7wcUsHRIR85oVIA20GiSO+hRapVkziB2ab/mNIOEi
         NKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jrYaAHvMcvAgON2HJIoIE2IBvbz54WPBWq/9VlMTUN8=;
        b=3uqJkxH4MhSTcbU6sumZniy5PX1QqRTXehOvwowp2ovARGILpBttybD8zY6qodgzcq
         t36rRNCnB87eD1ZKL2JTOaFKMjKXTx6XiB4vg2BjizuCtmV6FxyuopJTFTQfB/CsxTJ3
         bN5cFiTgCJLO3BYZPS4gqP9xSKz3uQ5tLezL4Ffn77OiLvDc8Vl1QGvDsPljmxmfvZ+K
         8bhs3jWogyCpPNv3gNJvKIzlelxhcDUyyY334hOCFFKnyG1B+Wap5GkEDPazJmOW09c4
         DWUk4FxDmH/yUPWYDxB8t/FYzOoREayVLZfh7dWFBZ0ciCHVBip/cVAmd0BLQKwzqn0P
         9CCw==
X-Gm-Message-State: ACrzQf0gysxfTZSKC/bru9yu43WulNfUVdm5UoEd53l12WJ7gQ4RRzCB
        3lVGQsyY7nE2sfPqJTSkHNeV4Q==
X-Google-Smtp-Source: AMsMyM4G+1DZEOjki9fpIe4QcPidcY8eOdH1TWlR9Lt+Oie2mvIlCmefsBFT1cU8J35Ccx3tvnphJw==
X-Received: by 2002:a05:6214:258b:b0:4bc:246c:dd01 with SMTP id fq11-20020a056214258b00b004bc246cdd01mr7632303qvb.64.1667487215489;
        Thu, 03 Nov 2022 07:53:35 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:a35d:9f85:e3f7:d9fb? ([2601:586:5000:570:a35d:9f85:e3f7:d9fb])
        by smtp.gmail.com with ESMTPSA id y12-20020a37f60c000000b006cfaee39ccesm833591qkj.114.2022.11.03.07.53.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 07:53:34 -0700 (PDT)
Message-ID: <26249f27-dbea-c30e-a2ea-df5cb4290b3e@linaro.org>
Date:   Thu, 3 Nov 2022 10:53:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] dt-bindings: pwm: tegra: Convert to json-schema
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20221103120137.1467905-1-thierry.reding@gmail.com>
 <18d66cce-64ae-aeaa-e9cf-9426c5d214f5@linaro.org> <Y2PSgwfqZ9BfXSFw@orome>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y2PSgwfqZ9BfXSFw@orome>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 03/11/2022 10:38, Thierry Reding wrote:

>>> +
>>> +  clock-names:
>>> +    items:
>>> +      - const: pwm
>>
>> This wasn't in original binding and does not look needed. Mention
>> changes from pure conversion.
> 
> At some point (looks like with the switch to 64-bit ARM) we started
> adding these for consistency because we were noticing that sometimes
> either we were missing clock entries or newer SoC generations gained
> additional clocks. Whenever that happened it would become somewhat
> cumbersome to describe this in device tree bindings and/or driver
> code, so consistently adding a clock-names property preventively
> even if only a single clock was used in the first iteration seemed a
> prudent thing to do.

Adding undocumented properties "preventively" is not the correct
approach. Either you document them, or you do not add them.

The property with one item and name matching the function is not really
a good approach, not helpful. Drop it.

> 
> So these are not technically necessary, but many device tree files will
> have these entries, so this is here for those to pass validation.

Drop it from DTS then.

> 
> Note that the property doesn't show up along the "clocks" property in
> "required:" below.
> 
>>
Best regards,
Krzysztof

