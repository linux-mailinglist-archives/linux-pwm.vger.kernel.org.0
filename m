Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B14662E266
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Nov 2022 18:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235012AbiKQRAD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Nov 2022 12:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240180AbiKQQ7x (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Nov 2022 11:59:53 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C8531226
        for <linux-pwm@vger.kernel.org>; Thu, 17 Nov 2022 08:59:52 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id s24so3460194ljs.11
        for <linux-pwm@vger.kernel.org>; Thu, 17 Nov 2022 08:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6xiNwxzl6a3FLqk1cHzSKAf/wTMMZvGRxsQRMjboQAc=;
        b=ec2Tm8NXWRm0Ewgn0LOGwYlfW4egn/g1bkZ3f6PgKgLau9F9c2Y/GHZgm7Az+7+reI
         xwMcbdRKEimWu7ElM9deIkBLb+1HSw72RNZQ2i8ScIO1kR5/r3tzyyFYPxmrx+2qbUX7
         4Bs7FslKnUqLbuyg5u+ymOlseKdQf8TFh5ELwME3XvadiBRC7TSQUx8GC0u18yJ+FeaO
         TkP4oB0wYwm6vFzyEwKrAfieDKb+vF0jCzGWM3xgxlMvM9wA6/7S7ZYTZG8oyPPmIETt
         sszKtUTXZUFJxD5N0oFWspHCrsZGfceKUZH7gdX7bwbkHntAVpADlGZzr5t32EVzRHf/
         XgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6xiNwxzl6a3FLqk1cHzSKAf/wTMMZvGRxsQRMjboQAc=;
        b=Il7RK5C5kEabwsWFznfKV2tGyUzfLbAVAMSEpkzmKnIFM++S9BzlAQa9VL/s7JtVxc
         Femnjj/FooR+ljoldt3euqsj6tdHG+fyfY2A3FUn4ipx2nOIy8mDteLm2y1u+g4t2wIp
         9gKhpaxknUjp47Qcna/NOd/nkOB/xQ9xkaYhjNwbAqOP65FaJcwPNOK+ROn7Heq1hjtj
         UrnquSS2tOebMsO8Q4n+z8UB6+Mom3FW3HynrOmx2Yf45/86B1LYM85VgnXYZFrhhGH4
         WOe93Gs/tNDAJQjzUgPCqsI5QpPv/KZac8aslMColbxV1qikn1NYMFvH5XW5vigwBlO6
         iB7Q==
X-Gm-Message-State: ANoB5pndinl7QnAC6YJ0V2G5mETW8OplJnkPZVsdyUW0Q7lR5DO3XWRi
        9WadIj2vmMdETc3DMEBWG0iJQA==
X-Google-Smtp-Source: AA0mqf52974ex818Qx2oUR88GJmDRSmA/dU99RAukv1QP6yVE7Ddv9PfGpINQOnSGkwUkXrKQEZU1g==
X-Received: by 2002:a2e:8e2e:0:b0:276:e452:1213 with SMTP id r14-20020a2e8e2e000000b00276e4521213mr1259959ljk.445.1668704390312;
        Thu, 17 Nov 2022 08:59:50 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id f21-20020a2ea0d5000000b002770a7e320esm288684ljm.81.2022.11.17.08.59.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 08:59:49 -0800 (PST)
Message-ID: <9eae8400-b800-3476-2d42-34a89b0b7b50@linaro.org>
Date:   Thu, 17 Nov 2022 17:59:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 1/4] dt-bindings: pwm: Add Apple PWM controller
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc:     thierry.reding@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221111173348.6537-1-fnkl.kernel@gmail.com>
 <20221111173348.6537-2-fnkl.kernel@gmail.com>
 <20221116202044.GA817431-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221116202044.GA817431-robh@kernel.org>
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

On 16/11/2022 21:20, Rob Herring wrote:
> On Fri, Nov 11, 2022 at 08:33:45PM +0300, Sasha Finkelstein wrote:
>> Apple SoCs such as the M1 contain a PWM controller used
>> among other things to control the keyboard backlight.
>>
>> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
>> Reviewed-by: Krzyszstof Kozlowski <krzyszstof.kozlowski@linaro.org>
> 
> I assume you got a bounce on this as you got Krzysztof's name wrong 
> (krzysztof.kozlowski@linaro.org). You should have either resent this or 
> replied pointing out the typo.

Nice...

Please do not type my name. It's pretty impossible to get it right, so
instead copy-paste the tag entirely without changes and addons.

This actually applies to all other tags as well, even with easy-to-type
names.

Please resend.

Best regards,
Krzysztof

