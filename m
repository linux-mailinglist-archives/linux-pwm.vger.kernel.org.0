Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB8E6835CA
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Jan 2023 19:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjAaS4H (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 31 Jan 2023 13:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbjAaS4A (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 31 Jan 2023 13:56:00 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D863B589BE
        for <linux-pwm@vger.kernel.org>; Tue, 31 Jan 2023 10:55:53 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id h16so15131514wrz.12
        for <linux-pwm@vger.kernel.org>; Tue, 31 Jan 2023 10:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gUdQKI9zSyMIeEoq6H+c/WUp2I2udqEnEyxmZgbVp5Q=;
        b=tzwztSI4Ew+lg2Gk/EXcGwAD4lbsP4+H7hKnbQvDLJA7gJHvsRN1GR066pofydEg42
         bOq237mhDGGheQTLB25Vk2C2x7mMZ1aXRYi2xIn7or3L5eLRCeeMEZhZehmzlKC6ucCQ
         EDGTNmc4OYEcQ5nnofovYDIpzdsuVIepZRTXpmO0tluFmuaBodL9JAYyIMi66OEGwFI2
         J5F45hUR0YGaqdWR4LeUU/R2Na5KHU9izzTVqvXjI4G6a0W0udee19nkc0ft9Ob/zoW9
         jifans04Gni+sb9PGVaybURH0QXCe6TqKulvJnMrpG++RDJHkJgrW/jK7CALBWr2VHl/
         80TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gUdQKI9zSyMIeEoq6H+c/WUp2I2udqEnEyxmZgbVp5Q=;
        b=11GJQOlQPWMqAIQbCKlRvAsrXN4sVEQ03P+iXEujGSSwVHFxZ3I+TgSF3rdDtRkfsH
         Gg+GddhGIY+PktjHQTAWbWjO7FRaPlBonUjYxko0fb7EMBXTbiAGcbMBZ3CJuxhaFs6S
         DvwkBpj6CgjB56w1hgcWqrD0juJH0szY2beb5NBIGSYgh9hi66r4cYmoopR1dLVVLlj1
         I+fhyIApG42CbZHPlt2ayE566yS7XWkRiTlhR/9bqueh9TFh8B35Kyd4UcXNwWPn8a+8
         nGjJ30jfRXNKs0mpsiGj0/rBiLSOj5gxWzGCr5048TSfYBSD1tOXCz7UuYqq+rdckZN2
         zYzQ==
X-Gm-Message-State: AO0yUKUT4GerlcO0v0tJv0gWoJS7K3CKf8OxMCTIEHf+1/jp5u6yZCVK
        RfYhWxmR200sNj8JRJZtpkrt4Q==
X-Google-Smtp-Source: AK7set9VWwr5WXjreYO02wP5uP45RtNxfAGqe/Of4W45cB4xzEpTpH4alVk9kztN3VigQmtf6qB6Bg==
X-Received: by 2002:a05:6000:1c2:b0:2be:1f34:507f with SMTP id t2-20020a05600001c200b002be1f34507fmr5106wrx.68.1675191352439;
        Tue, 31 Jan 2023 10:55:52 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id v14-20020adfe4ce000000b002bfafadb22asm15942156wrm.87.2023.01.31.10.55.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 10:55:52 -0800 (PST)
Message-ID: <99de0305-7519-5c21-d1fc-0886f594ce99@linaro.org>
Date:   Tue, 31 Jan 2023 19:55:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/1] dt-bindings: pwm: imx: add i.MX8QXP compatible
Content-Language: en-US
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230131143720.3250427-1-alexander.stein@ew.tq-group.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230131143720.3250427-1-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 31/01/2023 15:37, Alexander Stein wrote:
> i.MX8QXP compatible is missing in the list, add it.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  Documentation/devicetree/bindings/pwm/imx-pwm.yaml | 1 +

Where is the user of this compatible?

Best regards,
Krzysztof

