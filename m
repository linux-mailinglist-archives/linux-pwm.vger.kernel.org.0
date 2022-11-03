Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35E1617EE8
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Nov 2022 15:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiKCOH2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 3 Nov 2022 10:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiKCOHZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 3 Nov 2022 10:07:25 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FC325D7
        for <linux-pwm@vger.kernel.org>; Thu,  3 Nov 2022 07:07:24 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id i9so1142941qki.10
        for <linux-pwm@vger.kernel.org>; Thu, 03 Nov 2022 07:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lSjA5MyrImAN59IjrTQ+qD2HeS9KkgWFH/ZB1XGTgH8=;
        b=C/33wJnHux6pqpHOei/7Xtgnoc6xF3dwHnYxJZK5aS53OINih/hWyam0Yg7keV0TYH
         eDY4kr0gxoiElgzluNIYRftSr2HqS+6U04WHFMDiERiR8KWaTzjAunNzUBgEQz25qtb3
         3fveAvJ2dMrch+OTE2h9N7kg936e/DIWQ0sEGrc5SoZToVQSkBgsUy5vTcjHpIPiXVkt
         mdgzU+FkN2QArPXrJaSPmRA+RfICep3MdQKwfTr+XzqtJGKQm3svcHbNPKkbPW5k7cEF
         Oj41+hby8m8O5oP1F2NHAIp3ggIAWRKjn1twsaxd7IlzJFms9d9mqBh3skRsL8E/ffg6
         PmnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lSjA5MyrImAN59IjrTQ+qD2HeS9KkgWFH/ZB1XGTgH8=;
        b=EEKZ2T3P3StBEFYs7NRc8TMt8qtUEGIuZFXJsqja5L7MllgGIqagc3XoFGg63pi/cC
         ALjLwBZ0IShchUdpZnJK3UlcjHBVo7TxU5etWuX6275QBiKe8yMuBSR4wFRt++8sw2m8
         c1w47MH5tPH1oeh5rV294un7a2sDvt56U5P9cuZTw99UuW5UbLH5q45F2plgneDjZCv7
         srE/mDeoWe2SGPo8YFZGXD1V9ZNjXWB5evEMRK1Pa6MpgeiFDkI+Lb73ZN6fVIy0jDJZ
         4zlKGee+HHqknMG9t21hA1G74ekrksOjXHgnCaZRGtHaZANcMGnyN6bWEyguCOjRwaF2
         JzMQ==
X-Gm-Message-State: ACrzQf3M1bTYVW2ZcF8kEZt3OnRiF3LMSUOs4s6I4bKzfjS+SedQpISk
        9A6O5S1XsNQa4PLIaqM2rftg+Q==
X-Google-Smtp-Source: AMsMyM4vyTM1wTRLMVYVWov0oDy0iEnwlDzjcV7oanvfP5KUnBSgo1D9qdJQXFAVjWbq2jo5i0Dq2g==
X-Received: by 2002:a37:e215:0:b0:6fa:6eef:9de0 with SMTP id g21-20020a37e215000000b006fa6eef9de0mr4249316qki.573.1667484443264;
        Thu, 03 Nov 2022 07:07:23 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:a35d:9f85:e3f7:d9fb? ([2601:586:5000:570:a35d:9f85:e3f7:d9fb])
        by smtp.gmail.com with ESMTPSA id bm39-20020a05620a19a700b006cfc7f9eea0sm781695qkb.122.2022.11.03.07.07.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 07:07:22 -0700 (PDT)
Message-ID: <2c345ba1-41cd-2161-ddc2-84adee1d59b5@linaro.org>
Date:   Thu, 3 Nov 2022 10:07:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] dt-bindings: pwm: tegra: Convert to json-schema
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh@kernel.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20221103120137.1467905-1-thierry.reding@gmail.com>
 <166747792400.2122024.7504112765764946849.robh@kernel.org>
 <Y2PKPeEiliZNyg/a@orome>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y2PKPeEiliZNyg/a@orome>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 03/11/2022 10:03, Thierry Reding wrote:
> On Thu, Nov 03, 2022 at 07:35:43AM -0500, Rob Herring wrote:
>>
>> On Thu, 03 Nov 2022 13:01:37 +0100, Thierry Reding wrote:
>>> From: Thierry Reding <treding@nvidia.com>
>>>
>>> Convert the Tegra PWFM bindings from the free-form text format to
>>> json-schema.
>>>
>>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>>> ---
>>>  .../bindings/pwm/nvidia,tegra20-pwm.txt       |  77 ----------
>>>  .../bindings/pwm/nvidia,tegra20-pwm.yaml      | 144 ++++++++++++++++++
>>>  2 files changed, 144 insertions(+), 77 deletions(-)
>>>  delete mode 100644 Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
>>>  create mode 100644 Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml
>>>
>>
>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>
>> yamllint warnings/errors:
>>
>> dtschema/dtc warnings/errors:
>> Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.example.dtb:0:0: /example-1/pinmux@700008d4: failed to match any schema with compatible: ['nvidia,tegra210-pinmux']
> 
> Still working on the conversion of that one.

Then drop the nodes from example. They are not really needed and example
checks must pass.

Best regards,
Krzysztof

