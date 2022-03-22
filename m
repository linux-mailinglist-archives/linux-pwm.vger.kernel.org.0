Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074624E3589
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Mar 2022 01:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbiCVAd1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Mar 2022 20:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbiCVAcm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Mar 2022 20:32:42 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D6D38D762
        for <linux-pwm@vger.kernel.org>; Mon, 21 Mar 2022 17:31:14 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id s42so16962841pfg.0
        for <linux-pwm@vger.kernel.org>; Mon, 21 Mar 2022 17:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=XM+TgxL8NHgpPQL8bNe7xChjlBYLCqdsfBPXoOydz/4=;
        b=s0Fu9HWt/+zWpGu6X8LA5mlRPC2raz0O4wG31dfI7nUvlDL2JyI/6eG2SfoilMIQeP
         lIt+3IRsR7pVtUmx4lATqbzn2hxjETQo3aHqxVfmbngEo/nEHMLfbhL3zEk/MS59fuyx
         iNf5UU8g4GEL9+4zTuIjJk6sJLKPsR2hmCKFBsjbmWtSv23OOInMbj1tfjN/Y9cSD6vl
         ewtGEB6JK6D4eWQOgHc5GI4ANOdgFiLWQ6w4uKssd7XSNcal1uz8qb2ywUgvxkFXTXRi
         AhZUG7/LE82C1zlMGtoQkoWedXeMKAGXd5wTBgmQACiG7XvTixbV4b/tNffzdkNVfRch
         2RAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=XM+TgxL8NHgpPQL8bNe7xChjlBYLCqdsfBPXoOydz/4=;
        b=qQ1uRPlsKC4JWz1v3P1seti8Xz7D0aRgGzmHyyuCLGar+G6SAswpU6I+CmT1MfkdqZ
         1bzUxHAcM3269QbF/i+Ph1sInw8qfEOKY5JJXSLcxlnFzm3tdwevr0tiT/YC/pRnxhDJ
         sI1LPCWe1IboBQoyKECgAjKANQBAzUgP/Tj+5zC/ZQ6UpfqnrzCVvl59g0HxRbeZuQPJ
         fiYKkZ0peV847yJpF/YioKy1aGFCVIDvSCa6z7ODTAzm7uH3J5KdZjfsBxGw/wOickXK
         2wJJqYG61b9nZkg7A3DZSYtBItCwBERvd4vKawXI0T6vbNuo4X+jank0fBt0dhoSaoEh
         Xj3g==
X-Gm-Message-State: AOAM530WwBaFzsf4xL3QQ3FLmAU5c7tW4CJSzDWa6xrWVn8Y007z93jH
        9P53oRzMGLI8+NKWpn9ZcTGstg==
X-Google-Smtp-Source: ABdhPJxf8rrrAYGNrfInbsQntDvoeDQOh3KjS8VS/BtItwV2lILWmyam/HWUReGDbcNmSPGzvmDCwA==
X-Received: by 2002:a63:1248:0:b0:381:54c9:1a1a with SMTP id 8-20020a631248000000b0038154c91a1amr19652958pgs.185.1647909074036;
        Mon, 21 Mar 2022 17:31:14 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id lp4-20020a17090b4a8400b001bedba2df04sm535823pjb.30.2022.03.21.17.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 17:31:13 -0700 (PDT)
Date:   Mon, 21 Mar 2022 17:31:13 -0700 (PDT)
X-Google-Original-Date: Mon, 21 Mar 2022 17:31:11 PDT (-0700)
Subject:     Re: [PATCH] MAINTAINERS: sifive: drop Yash Shah
In-Reply-To: <ef965982-0c21-9cc7-1e5a-69726671ba1f@canonical.com>
CC:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, aou@eecs.berkeley.edu,
        p.zabel@pengutronix.de, sagar.kadam@sifive.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     krzysztof.kozlowski@canonical.com
Message-ID: <mhng-9e915473-a905-42ef-908d-2d84b08a3023@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 10 Mar 2022 23:33:54 PST (-0800), krzysztof.kozlowski@canonical.com wrote:
> On 11/03/2022 04:14, Palmer Dabbelt wrote:
>> On Mon, 14 Feb 2022 00:23:49 PST (-0800), krzysztof.kozlowski@canonical.com wrote:
>>> Emails to Yash Shah bounce with "The email account that you tried to
>>> reach does not exist.", so drop him from all maintainer entries.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>> ---
>>>  Documentation/devicetree/bindings/gpio/sifive,gpio.yaml     | 1 -
>>>  Documentation/devicetree/bindings/pwm/pwm-sifive.yaml       | 1 -
>>>  .../devicetree/bindings/riscv/sifive-l2-cache.yaml          | 1 -
>>>  MAINTAINERS                                                 | 6 ------
>>>  4 files changed, 9 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml b/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml
>>> index e04349567eeb..427c5873f96a 100644
>>> --- a/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml
>>> +++ b/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml
>>> @@ -7,7 +7,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>>>  title: SiFive GPIO controller
>>>
>>>  maintainers:
>>> -  - Yash Shah <yash.shah@sifive.com>
>>>    - Paul Walmsley <paul.walmsley@sifive.com>
>>>
>>>  properties:
>>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.yaml b/Documentation/devicetree/bindings/pwm/pwm-sifive.yaml
>>> index 676b2160bada..605c1766dba8 100644
>>> --- a/Documentation/devicetree/bindings/pwm/pwm-sifive.yaml
>>> +++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.yaml
>>> @@ -8,7 +8,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>>>  title: SiFive PWM controller
>>>
>>>  maintainers:
>>> -  - Yash Shah <yash.shah@sifive.com>
>>>    - Sagar Kadam <sagar.kadam@sifive.com>
>>>    - Paul Walmsley <paul.walmsley@sifive.com>
>>>
>>> diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
>>> index 2b1f91603897..e2d330bd4608 100644
>>> --- a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
>>> +++ b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
>>> @@ -9,7 +9,6 @@ title: SiFive L2 Cache Controller
>>>
>>>  maintainers:
>>>    - Sagar Kadam <sagar.kadam@sifive.com>
>>> -  - Yash Shah <yash.shah@sifive.com>
>>>    - Paul Walmsley  <paul.walmsley@sifive.com>
>>>
>>>  description:
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index ebf7a75a6bec..87eeac970ca2 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -7090,12 +7090,6 @@ L:	linux-edac@vger.kernel.org
>>>  S:	Maintained
>>>  F:	drivers/edac/sb_edac.c
>>>
>>> -EDAC-SIFIVE
>>> -M:	Yash Shah <yash.shah@sifive.com>
>>> -L:	linux-edac@vger.kernel.org
>>> -S:	Supported
>>> -F:	drivers/edac/sifive_edac.c
>>
>> Looks like that leaves this unmaintained?  I'm happy to volunteer, I've
>> got the boards lying around somewhere and sort of feel on the hook to
>> keep this stuff alive given that whatever's in there is partially my
>> fault.  That said, I'm happy to stay out of it so if it's OK to have
>> otherwise unmaintained EDAC drivers that works for me so
>>
>> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>
> The patch was already merged. EDAC SiFive is now covered by generic EDAC
> and SIFIVE entries. Feel free to restore the entry with yourself.

Sorry for being vague there, I'd seen it get merged.

If having it covered via some generic MAINTAINERS entries is OK for the 
EDAC folks then that's fine with me, I just don't want to get into a 
spot where this driver is going to get removed because nobody's more 
explicitly maintaining it.  These SiFive boards are still the only ones 
that run a normal-smelling upstream Linux (at least until we can get the 
D1 issues sorted out, which is hopefully soon) and I'd hate to start 
dropping stuff if we don't need to.

So if it's fine for the EDAC forks to have things in the state the are 
after this patch was merged, that's great for me.

> Best regards,
> Krzysztof
