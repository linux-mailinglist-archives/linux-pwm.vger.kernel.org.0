Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B95D611B30
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Oct 2022 21:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiJ1TuC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Oct 2022 15:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiJ1Ttx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Oct 2022 15:49:53 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024DD3718E
        for <linux-pwm@vger.kernel.org>; Fri, 28 Oct 2022 12:49:47 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id l28so4153190qtv.4
        for <linux-pwm@vger.kernel.org>; Fri, 28 Oct 2022 12:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CrrbK6WiWXkWTKLU/KfAO4hvX9jlvOUQaHzqnu/h4mc=;
        b=OjL/nt1Dp1/VP/e3v0ZKs5p2qQeXHV5NgNI3Rd1KnjbGfaOka7Px+PjzCXyw6sMhOb
         Znl96YHjoXR8U+pjzIeYs6DN8AKLlo6cvi0dTe2+LgJHGHv3LCpVIH1MQeDhtmEPsvm6
         /krya6K6d/PsZkEPdGrIWhzgi7h8uQjIE6pbs1Koqkmn/39Qmz7YD9WgOEQVSYw8VMyX
         AAaGUef+kLxg1y8D0YWjgvGdW6wu/CiwHy1MTxa9tpyD3+nHHZIr3lZYYWp95WCFY9bX
         AAHAMVwPs173OC4AjQzRzIF2lNkV/5P0OtNQ7mSTACrf1vEa7jpFW32+MzcYWQFWn4nu
         MxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CrrbK6WiWXkWTKLU/KfAO4hvX9jlvOUQaHzqnu/h4mc=;
        b=bsDRWlLjcfz3uuQd/pDo9Iq1kNjN1JpupmnDCCxtItRb8BrKRSNKDsM2R8fdUhzE1s
         bT7NeIHEVGXv7xJeEJv4ojG9BhJvfma7CpLwWAe/CdjV1ANrn7aQQWpy58yhzBgGLuXl
         VKv7DscsZJks8n4CPZ5r1HME+ZwGd0J1HW+pL2/qFlmcQ0eiXKnZOxqjCFV5SZMq4726
         TTZgDpXF/kV5w2D7hGqrze+4LXUqNpq5gr5X7lt7ptouzRBb27v70jAlkUfON+K1ZQ5H
         YKA5/GNethY9lHlIQ1npcaEG8Vp3M16YscWHBpDTJcz1HsvPmyDEIJrDwYybKMDExKea
         35Yw==
X-Gm-Message-State: ACrzQf3WdBBxG6R6OSDfongzbJpydtdOcoJF4MyKmEwuU52o8DJq55fw
        7vZRtRAoz+kUlJePVoCb9ob9Gg==
X-Google-Smtp-Source: AMsMyM7nMFuwEm0OvAIGlJiOgSag125RW6TO1KxEjVBRpjyHvfL07vawyBpzddMrC11skIJGMBMAig==
X-Received: by 2002:ac8:5ac5:0:b0:39c:f8f5:c432 with SMTP id d5-20020ac85ac5000000b0039cf8f5c432mr1022780qtd.33.1666986585310;
        Fri, 28 Oct 2022 12:49:45 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id t1-20020a05620a450100b006ee7e223bb8sm3622607qkp.39.2022.10.28.12.49.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 12:49:44 -0700 (PDT)
Message-ID: <3b8441da-31af-2414-1362-0efb05cbf8c0@linaro.org>
Date:   Fri, 28 Oct 2022 15:49:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 2/4] pwm: Add Apple PWM controller
Content-Language: en-US
To:     Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, marcan@marcan.st,
        sven@svenpeter.dev, alyssa@rosenzweig.io, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221028165215.43662-1-fnkl.kernel@gmail.com>
 <20221028165215.43662-3-fnkl.kernel@gmail.com>
 <02523fe5-bf99-9891-d00c-347893d5dabe@linaro.org>
 <CAMT+MTTE84XDf8c0D3MLxZ92HiDP6DhXfpHVyQZ7hfYMUkL7dg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMT+MTTE84XDf8c0D3MLxZ92HiDP6DhXfpHVyQZ7hfYMUkL7dg@mail.gmail.com>
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

On 28/10/2022 14:51, Sasha Finkelstein wrote:
> On Fri, 28 Oct 2022 at 20:54, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 28/10/2022 12:52, Sasha Finkelstein wrote:
>>> +config PWM_APPLE
>>> +     tristate "Apple SoC PWM support"
>>> +     depends on ARCH_APPLE || (COMPILE_TEST && 64BIT)
>>
>> Why this code cannot be build on 32-bit?
> It uses 64-bit divisions, which causes it to fail to build on 32-bit
> mips. It should not be a
> problem, since this hardware is only present on 64-bit SoCs.

Does not matter, code should be portable and buildable on 32-bit. If it
does not build then your code is not correct.

You need to investigate the failure. Maybe using do_div would solve (or
other macros from div64.h)

Best regards,
Krzysztof

