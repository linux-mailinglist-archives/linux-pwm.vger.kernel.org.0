Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0EA55F7B7B
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Oct 2022 18:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiJGQbW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 7 Oct 2022 12:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiJGQbV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 7 Oct 2022 12:31:21 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED369102DFE
        for <linux-pwm@vger.kernel.org>; Fri,  7 Oct 2022 09:31:20 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id p5so6271801ljc.13
        for <linux-pwm@vger.kernel.org>; Fri, 07 Oct 2022 09:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wps2XPzyoQxJCRCgPjDDBxYyJh4/U/3epD9Q85qlSaM=;
        b=u/dIgJCkhb9Qm/TxY8iaZR2y22X0sEjQGESJeGj2HBsbd9TPr/v596xsHL4dHQHQXP
         zx5XGKWaOwKrTV7FNTDUFdj4v/LNAiF+rc7sFZbXiMx5l9aP4LXdVVABbMwD51rI9Juy
         ZUavj9awkwVcTyWkjzDWql+VvrOUligsGYMcY95DXBKi9/vX4wRF2qK+dLqnZSSw953d
         Mg/Npt06gwY2cvAh1QH57O+C5F7KJ6s6hGA9aCsRf+MMuKseOscKO8JkUZCalKkVTQy9
         n83dp9HsyLfr3ceMnp6lDfC6ACOvtS6o36fEob9LkVS4BcLdCwegK74hZSSXdfesiGgL
         z9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wps2XPzyoQxJCRCgPjDDBxYyJh4/U/3epD9Q85qlSaM=;
        b=HrNdUvwSJ4s+45/cFBSAbk01TiBbnLLtpe7Qt0HdIj2UA9S9iFhRGSx7+mQL4lUq3R
         U//sk6hESSKcsWrCGjZYZxv6G6ZTfwF8WOEVBwVHxgDUs3kIfAkad5tYXByOy3oz+IM2
         UvlG1hBjO7DNKc8C+uGSwqwae8ia3zjuXDyJSoGUGveVbmD6hZ+yotjG64GyZ2660feu
         +FZZp6wIbWpsPwSsAVoNIdZNZ5d2KVP4Cse7im1BKSGhzA3R55amfIqQoK/lsMc14/Eg
         II/PFDwJmGEy4//7T5r8djj8gJ5iNqHu+Aqp1rdQXHz+lFqI1Ldw8flpmKFEsCmUUWJJ
         5gmg==
X-Gm-Message-State: ACrzQf1Z2/M/st92/Ywen3BJxrM0Umfs9CRw+2uyOk1b7PHdV7SHfnAa
        fpwb1pTbuCoS4WJC+SG8R3G94g==
X-Google-Smtp-Source: AMsMyM4zXnsg4AQoc9IvgEEFeekUcCkeQIp5LGwqXPDTLlXnb6QUoO1vfL9uexO+KDSsMXdb5ppqkQ==
X-Received: by 2002:a2e:7211:0:b0:26d:fea5:c7e3 with SMTP id n17-20020a2e7211000000b0026dfea5c7e3mr1923621ljc.101.1665160280530;
        Fri, 07 Oct 2022 09:31:20 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id t16-20020a05651c205000b0026de7400f3bsm334161ljo.5.2022.10.07.09.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 09:31:19 -0700 (PDT)
Message-ID: <9e2c95fb-1806-15e6-faca-0140b3c419bd@linaro.org>
Date:   Fri, 7 Oct 2022 18:31:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] dt-bindings: pwm: renesas,pwm-rcar: Add r8a779g0 support
Content-Language: en-US
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <7785f163a5a798574c68495de8b0ca7a02e35f07.1665156318.git.geert+renesas@glider.be>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7785f163a5a798574c68495de8b0ca7a02e35f07.1665156318.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 07/10/2022 17:25, Geert Uytterhoeven wrote:
> Document support for the PWM timers in the Renesas R-Car V4H (R8A779G0)
> SoC.
> 
> Based on a patch in the BSP by CongDang.


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

