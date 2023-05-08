Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0636FA371
	for <lists+linux-pwm@lfdr.de>; Mon,  8 May 2023 11:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbjEHJgj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 8 May 2023 05:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbjEHJgg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 8 May 2023 05:36:36 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2454223486
        for <linux-pwm@vger.kernel.org>; Mon,  8 May 2023 02:36:33 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-959a3e2dd27so759244566b.3
        for <linux-pwm@vger.kernel.org>; Mon, 08 May 2023 02:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683538591; x=1686130591;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+gQynKHq/j0rouitkQ61mRMZDG5anZgmqsztbwdlNZc=;
        b=DymGYpSMNyruICBmlBVGENxrUAxCQg/9cXLgCRaamSdE/dEF2PWDcI2NMgDIRJyj0k
         AiDSeiLGwe73bHrNxQwjuoRCedlA2Yal3AQs/a4zdKuNhJDj6FOpRSWRybzpa3q9yppa
         +6MwAuSI8a26ybP1A3zGDXHJ/8ehNfai1ak7usI0MarlRYSoOOKoX3CP++uMCQHkckTB
         6/TfU7klsLFfkBTZylAh3wU4x8ZIoNloePBOYGxoc8QRhqNcfEvKc14v8pEagcyo6SJG
         voc7He/24Y+xohlSkDq2rH+Bz57fvqz51ITqXFlyKTsYLwLADR1wROlLMbTlnGJu1Q2V
         2bzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683538591; x=1686130591;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+gQynKHq/j0rouitkQ61mRMZDG5anZgmqsztbwdlNZc=;
        b=U8k6POvrIDpL1zmlcIO8FImUvheZnA/Mm5zuitzR7z3ImXbpMVLXWkQ/D83wWvBiWf
         9rGksFJ5HrxpXQYG7K7ssNaZWMmvf4X4+dIdymrGOC4t0mEprYlDTwwtvbkYBI2XvZ6V
         AnDntziVwrgXuoSXXknLehZ+QRS0dGH+qbpQXU1Y+m4HnrLTBfTDGXlMmjndDm/ZdtWI
         SYahdrJ6ysgT2gGGqWfvH3hGkbYRwV/WNAIlCwJBofhuaoPZgsfVEF3TRVX1ip5M3fnI
         bn33tjIDIot6bEtZG3ZrS6qFglyY/waDnS/dfw48TWv7yvMYfCytez3BgWgeXRtppJZF
         4Otg==
X-Gm-Message-State: AC+VfDwv985d3N35l9tnDs6/48O83sx/RQN2tJ/5KJtesTO0fnNwJqEw
        6q4N3sU8XyKkPTDUpZc5FxCokw==
X-Google-Smtp-Source: ACHHUZ5UdACRM4IQ+9A7GHj+UIVY449LpLW4cKn7SLTKxOHi6oMQ6t5zDTtgkejS5Yu2tSpaPeYsQQ==
X-Received: by 2002:a17:906:fe07:b0:953:8249:1834 with SMTP id wy7-20020a170906fe0700b0095382491834mr7734490ejb.16.1683538591535;
        Mon, 08 May 2023 02:36:31 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:50e0:ebdf:b755:b300? ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id f12-20020a05640214cc00b005068fe6f3d8sm5921749edx.87.2023.05.08.02.36.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 02:36:30 -0700 (PDT)
Message-ID: <7fcdfc56-3dc6-b103-afd5-21984940c495@linaro.org>
Date:   Mon, 8 May 2023 11:36:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RESEND v9 5/5] MAINTAINERS: Add entries for Apple PWM
 driver
Content-Language: en-US
To:     fnkl.kernel@gmail.com, Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        - <asahi@lists.linux.dev>, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230214-fpwm-v9-0-f3094107b16b@gmail.com>
 <20230214-fpwm-v9-5-f3094107b16b@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230214-fpwm-v9-5-f3094107b16b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 03/04/2023 16:19, Sasha Finkelstein via B4 Relay wrote:
> From: Sasha Finkelstein <fnkl.kernel@gmail.com>
> 
> Add the MAINTAINERS entries for the driver
> 
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> Acked-by: Sven Peter <sven@svenpeter.dev>

Sasha,

You got here report of warning:
https://lore.kernel.org/all/202304041117.YfOAPGQc-lkp@intel.com/

Don't ignore it, but send a new version which fixes it. Since Thierry
was not Cced on docs build failure, he applied entire patch. In such
case it is expected that you will do something about it, not just skip it.

I'll apply the fix from Lukas.

Best regards,
Krzysztof

