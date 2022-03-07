Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405FB4D042B
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Mar 2022 17:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239207AbiCGQa5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Mar 2022 11:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244200AbiCGQa4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Mar 2022 11:30:56 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6B16E543
        for <linux-pwm@vger.kernel.org>; Mon,  7 Mar 2022 08:30:02 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 275703F605
        for <linux-pwm@vger.kernel.org>; Mon,  7 Mar 2022 16:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646670601;
        bh=lYugkCjRW/OhfdxdR0LUXG4Uici1AcMBOSNAUfInjq4=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=wOmVZkfMuWL1iY4g3iTPppUsCa2Pq57QUAIAYRIqN2waEG7YVELm5+XEM7X8D47SA
         CYrUI3T2Y4V+Um4Bgy4z6jOSqv0NKSTc+ZTXkghVXcwdU0i0jIrBume03CrXainxRW
         S/C+Dz3VmNTP0NarC1cPmAiH4NhKkMRLh9UXD1XLaHhYIpehRLGTffNJb0UYAPROfc
         qZJYMCuw4D/NV1Q6cyQb0W2ZttbxBJnUiZLsBwO0O/H4ulLZx2o8kO/9W7oEd6RmA/
         6D/bc4Ul2WrlWi5Raj4u4ieFJ2WnzDd5zJRwqZqo7cCB9kFBqTmSHyowFKq/KT19ZX
         95NkTdcWQvwoA==
Received: by mail-ed1-f71.google.com with SMTP id l14-20020aa7cace000000b003f7f8e1cbbdso8907634edt.20
        for <linux-pwm@vger.kernel.org>; Mon, 07 Mar 2022 08:30:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lYugkCjRW/OhfdxdR0LUXG4Uici1AcMBOSNAUfInjq4=;
        b=cySf+TMF0ExXw3ydKXCt8fbAHRyComt5FQGLbjdb533blH3wXQYzOTk2g+PY5By/rw
         foWFFn2MEHG2JKzMcsS0x7dEX2DIG+KXs/qrjrPx5bqL6zBppypCsIwsRVh5vSKr3+vE
         gu4Bm73p0DNzNQRZq8dd+x73ZvzWUp8mHNpjAnauZ5VlKMCzt1gR2DejhMZOnbgJvOS1
         /pODyiPBxPGpUtluebxUiYURIbtU1enoDtRhCKyC0mBy4yJSRBfkTesrBBZAh8oDWV7q
         7wWYkgdkWYJApr9ZTy9qkO/TPYcCC4AU7VP8bOrAd30vN49LsvWIqvldEPNL4VXKNe+z
         p2oA==
X-Gm-Message-State: AOAM532Gnxx1uaKDa/tzvHsjW1L88/j2Isrxr6cQenBFm5hO/MN5Pznn
        fDtyPlFPMGa+Q4rkIQs1pJkv9J8TajAGnrR+SXt8Ir9r/7qozbN+0woZh9tR45uAZV/3884p/J5
        oZnDVtLeSao5cDZ+UYB5zGFi95cxUp5ki73wePw==
X-Received: by 2002:a50:9505:0:b0:416:4496:5ec4 with SMTP id u5-20020a509505000000b0041644965ec4mr6260004eda.309.1646670600298;
        Mon, 07 Mar 2022 08:30:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzgIDIfs4Uv+2hCWR8xkLdqKgfR0rTZ1uyE2m99wgR5h8pk++5/Mn+yekJDhNMAqpMU4JEJbA==
X-Received: by 2002:a50:9505:0:b0:416:4496:5ec4 with SMTP id u5-20020a509505000000b0041644965ec4mr6259981eda.309.1646670600102;
        Mon, 07 Mar 2022 08:30:00 -0800 (PST)
Received: from [192.168.0.142] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id dz10-20020a0564021d4a00b0041665989a9csm148646edb.41.2022.03.07.08.29.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 08:29:59 -0800 (PST)
Message-ID: <c2d56288-a134-21a4-75f3-d25b050da6a0@canonical.com>
Date:   Mon, 7 Mar 2022 17:29:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/2] dt-bindings: pwm: convert atmel pwm to json-schema
Content-Language: en-US
To:     Sergiu Moga <sergiu.moga@microchip.com>,
        claudiu.beznea@microchip.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        robh+dt@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220307153656.177589-1-sergiu.moga@microchip.com>
 <20220307153656.177589-2-sergiu.moga@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220307153656.177589-2-sergiu.moga@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 07/03/2022 16:36, Sergiu Moga wrote:
> Convert PWM binding for Atmel/Microchip SoCs to Device Tree Schema
> format.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> ---
>  .../bindings/pwm/atmel,at91sam-pwm.yaml       | 42 +++++++++++++++++++
>  .../devicetree/bindings/pwm/atmel-pwm.txt     | 35 ----------------
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 43 insertions(+), 36 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pwm/atmel,at91sam-pwm.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pwm/atmel-pwm.txt
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
