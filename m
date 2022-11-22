Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBFB633CD6
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Nov 2022 13:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbiKVMtS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 22 Nov 2022 07:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbiKVMtM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 22 Nov 2022 07:49:12 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42596606AC
        for <linux-pwm@vger.kernel.org>; Tue, 22 Nov 2022 04:49:11 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id r8so7216474ljn.8
        for <linux-pwm@vger.kernel.org>; Tue, 22 Nov 2022 04:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BKKhKb5Gs5Frt6QdrTXva2XYvf3P1wraxWYylueZjts=;
        b=vROLuRMtSqcLs1vlki0d4Ne+UuwsQbEAY11V9y2sDHUGQI21crDHZJ0tXsuLE9VtKp
         N2Q4+Y6IUjbnBrY500Tf762D8wED2XgZtptJAxv3FDcvzZY/Wunw/aA8FlnzWTLzI2ax
         GEFLAcEKzlSOXMdqVs5jPTh+0TlUc7GCVQ6bG2KJASiozOKfojeO/A3IjuIVGIrVYtL9
         bmmDAQSoJjiRYxMlfYVdXX/BVXZWi+6yAS9h4uSlIB4lhisB4BsIzws0KXXnyrumElRm
         sXM+e+23Hl1PJkhflw3fYIN/lni5xF2hnK4bUyv3j76scCac5Legy7zYPCyyE+3VXZ60
         8/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BKKhKb5Gs5Frt6QdrTXva2XYvf3P1wraxWYylueZjts=;
        b=Q7DZZSTjYKrd9VrOtLkqoW2RryG7vA6UG+OOTpMbMXzMocoQe6dZGVsfLuTYi9M4Vq
         e/h1m/w45QjFzxFaRo1KS1j3ZJRzLbh1yN9xAuiRKHcJMa/5/aT/MMNx3rtuHEznDayS
         V1XRm9SDVtX6RUgOw7/7EySDt1Z3rlp8GW2OUIQM4vVlPjzy/vcRBz3OxRPybVer/5rx
         08FeCs69lfenpySBBCwZ06QmcPIoZ4A3Cez6TD6gcIeM4eO/nv4Ep8n92r4NYj+pTPJb
         ne88T8tJ0BYhwcDl1rY5yUNPqn8bDcgPY92HxsjBsm9yRAOCJe9pXLrRoc/qWMhuG90J
         6Axg==
X-Gm-Message-State: ANoB5pkSLpX1Z/p629f4swhzvwRd0h9dmxovxJ+HF7FbHR6G9KeOCr8Q
        zmKRQ4HoHdyqjgqndw/5ceZQxA==
X-Google-Smtp-Source: AA0mqf5sBXpQ0lraqYbLN3Pt9WJ/0BS7mciGklDZFRVVoBTpC5iowYQuF9T/Uuqg6Tc0kDYLXXQ8fA==
X-Received: by 2002:a2e:2c05:0:b0:277:13ef:53ad with SMTP id s5-20020a2e2c05000000b0027713ef53admr1396802ljs.327.1669121349652;
        Tue, 22 Nov 2022 04:49:09 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id w26-20020a05651c119a00b0027730261350sm1853863ljo.131.2022.11.22.04.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 04:49:09 -0800 (PST)
Message-ID: <bee157b1-e05f-7f64-61bf-8d6796dd1336@linaro.org>
Date:   Tue, 22 Nov 2022 13:49:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 1/2] dt-bindings: pwm: Allow decimal format in addition
 to hex format
To:     Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20221122123225.59106-1-tony@atomide.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221122123225.59106-1-tony@atomide.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 22/11/2022 13:32, Tony Lindgren wrote:
> Let's allow node numbering in decimal format too.
> 
> Simple human-readable increments/IDs are usually decimal, hex is only for
> addresses as noted by Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>.
> 
> Let's use an improved match suggested by Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> and improved a bit by Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de>.
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

