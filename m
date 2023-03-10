Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB736B3887
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Mar 2023 09:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjCJI0a (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 10 Mar 2023 03:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjCJI02 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 10 Mar 2023 03:26:28 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A970A1070EC
        for <linux-pwm@vger.kernel.org>; Fri, 10 Mar 2023 00:26:26 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id ec29so17273451edb.6
        for <linux-pwm@vger.kernel.org>; Fri, 10 Mar 2023 00:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678436785;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gOKNGZG0x2BIsC/5CftnnrxuLbXbpdy0LX8bxWaSAVU=;
        b=UCKEXum4m6mhbU0y2hfd5gRlpkWmkywyX6s/hGJKD+RgZ7Zrqyt8CZlCP51o1lalIs
         p8bihyAvtfm0vA2ObxyqHJmD2G8GIMNiYR3S570uylOz45p7s3HEOn9ryQ9b+bONdil6
         jtIq9Q/dXdH5yFDlP63PQJG6LONAChRboU3hDg62zRx+CMC8aghAUV4cy9X82Q/2Z03L
         bJ8G71pu40fewu8ZJtSj7kMcFJAW+7TJ6bvYBpjUKlpha5wvhzMBN2gyNXx2WLs+h/Vc
         +3HMgfr4KgOXqbO43UkPtOMSorO5YAR/AIH4WBt3FXEGH9f7jAY+Oe2xF2a/0Zp7BOXz
         2uIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678436785;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gOKNGZG0x2BIsC/5CftnnrxuLbXbpdy0LX8bxWaSAVU=;
        b=iZ2XNBRxwjp1ELV+tpOqyIvdP94pwvTtoSm3NpEbi0hnD46gFKK6EXLtLy/gWbMICP
         sQF3pwcnBz3DxWWfcY/aFed9zTk4efx22hITDS5+b9qRLAmipnzzs2eG9GYQ+ju9nj6D
         xYLdpMbdf7NeSVFEkJSIZnhCGKhZkGBJ9jbdx08RRjUI5s3ZDZZcmNDedrWlzx3Hhhfl
         WzDNU9oV3MvA4Sr3KSfNHCMh2vWgod3YT+XD8BDTN0YfiVJ/AAryf1ZKZ1MFi6mLNorX
         2qjknFsKuCVvpfVbZLcftlDedTxjlaBJGcah0MRjIT3LSTCwvqL1VEqHcqKormo949rf
         oqxA==
X-Gm-Message-State: AO0yUKWYsr7Eyv91LTU/WxYr8kXDn+i+AdEGI96/HetFLKvEfSsD2GWQ
        Tx2ZKJS1YJlhtVTig/9eXM0ezg==
X-Google-Smtp-Source: AK7set8ABKS7JbAcneG8iYh20ou85gWAGqUNTg0LRchqU9xjGRT4vtjfOFqdJbjXxi/awgvijdCmEQ==
X-Received: by 2002:a17:907:d24:b0:8a9:e330:3a23 with SMTP id gn36-20020a1709070d2400b008a9e3303a23mr32101268ejc.26.1678436785198;
        Fri, 10 Mar 2023 00:26:25 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:2a59:841a:ebc:7974? ([2a02:810d:15c0:828:2a59:841a:ebc:7974])
        by smtp.gmail.com with ESMTPSA id sd13-20020a170906ce2d00b008eb89a435c9sm649327ejb.164.2023.03.10.00.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 00:26:24 -0800 (PST)
Message-ID: <f02e072c-a963-669c-95b7-e093a0073bde@linaro.org>
Date:   Fri, 10 Mar 2023 09:26:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/2] dt-bindings: PWM: Add StarFive PWM module
Content-Language: en-US
To:     William Qiu <william.qiu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Hal Feng <hal.feng@starfivetech.com>
References: <20230310074503.155131-1-william.qiu@starfivetech.com>
 <20230310074503.155131-2-william.qiu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230310074503.155131-2-william.qiu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 10/03/2023 08:45, William Qiu wrote:
> Add documentation to describe StarFive Pulse Width Modulation
> controller driver.
> 
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>

(...)

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pwm@120d0000 {
> +        compatible = "starfive,jh7110-pwm";
> +        reg = <0x120d0000 0x10000>;
> +        clocks = <&syscrg 121>;
> +        resets = <&syscrg 108>;
> +        #pwm-cells=<3>;

Missing spaces around =

With above:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

