Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D36686D6B
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Feb 2023 18:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjBARw7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 1 Feb 2023 12:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjBARw5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 1 Feb 2023 12:52:57 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3729410407
        for <linux-pwm@vger.kernel.org>; Wed,  1 Feb 2023 09:52:55 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id a3so11391874wrt.6
        for <linux-pwm@vger.kernel.org>; Wed, 01 Feb 2023 09:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QqkRimUZCUkO1JuqK4G89C8Sdk2yfsCOyvpc+ZSm4mg=;
        b=H0W1lUqnxB8/wskxUt1FFcmuqYCIOLPNldjoHoDmTbdE6BtzUzRCZFD98AgsfPdSkS
         FPuN6OK/n1yprufrd80BrmT3//ufhCV0jPNOY3cInwmN8E7aKjcgTmT+Qhr3djzSK0+W
         Hb1qlflGY4u9EECirx3+o9RqU/EsB5gwj4sBOplzdFx/LcJYGF384qsPTajwWHDkvP8a
         8MkR0PVCLMjPM64EuuTMDLnvpMJPh86oGRpFmQ1/53vAFFanSb7vtnyh2jbQHXTGDAhN
         Mk97DrqFXHXPS7W5igf8ysW4ZUnIheJcavgZfZMSI+nlibvreRQG/D6mWFIAsjhOg8St
         nVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QqkRimUZCUkO1JuqK4G89C8Sdk2yfsCOyvpc+ZSm4mg=;
        b=V4tbOPQ5ClgWyefPuhSrxpDJu/12cGblRCGSs6Cz5YlpLwNay4UVeULXF0PjOltrEQ
         mQtR2ecMcwSpi0Oq2+Z1uh2d7HcseileT29W+T59C44xNZa9NH+6Imq3rGSDQVUdq/ww
         pNu5lSNWVFQWroHJA+0XSaYwLfqNup16Kqh5uqlnAtawPMEnf8bDNEWB0Hwp3VDja4hC
         unzi9Q2N8eGbzx+pzk4SRK5dMcgSqKnXIcjzehBEfFCNrRlQ2UR/wXYCLwqXPBgQJpBt
         aIb8Rg2VjPtzWYoHDQ+RzpOSo8fcJWzx+OJj5Tkimn506s/vbDUkWtlvPytB3H77sisH
         gYYA==
X-Gm-Message-State: AO0yUKW2FVuKA2CeNkJ5V3PQ1uPzQjZUg4QIEaHirANahtE8tK2HaTk3
        LU0m0zDLAe6n/2towbg9HHQULQ==
X-Google-Smtp-Source: AK7set8cPJaRXAp/5k01V3nK45aC2Of7dJlRJ58sJqQVi0YxYfJYz9YfogtTs1yQGcDM7DY2vEurmw==
X-Received: by 2002:adf:e650:0:b0:2bf:ed09:abf1 with SMTP id b16-20020adfe650000000b002bfed09abf1mr3048310wrn.21.1675273973811;
        Wed, 01 Feb 2023 09:52:53 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m15-20020a056000024f00b002bfae16ee2fsm18583946wrz.111.2023.02.01.09.52.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 09:52:53 -0800 (PST)
Message-ID: <26703ea7-bfd1-7c47-f0de-1ae8ea3778c8@linaro.org>
Date:   Wed, 1 Feb 2023 18:52:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4] dt-bindings: pwm: Convert Amlogic Meson PWM binding
Content-Language: en-US
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     linux-pwm@vger.kernel.org,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <aaa73903-1837-d9c8-8c45-54b4473fd548@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <aaa73903-1837-d9c8-8c45-54b4473fd548@gmail.com>
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

On 01/02/2023 18:45, Heiner Kallweit wrote:
> Convert Amlogic Meson PWM binding to yaml.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v2:
> - fix clocks and clock-names
> - consider that more than one compatible may be set
> v3:
> - remove minItem/maxItem properties for compatible
> v4:
> - remove not needed "items" before "enum"

You got here a tag and my comment was about minor issue, so please keep
that tag.

Best regards,
Krzysztof

