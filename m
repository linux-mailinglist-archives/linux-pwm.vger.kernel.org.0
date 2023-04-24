Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1AA6EC9DB
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Apr 2023 12:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjDXKKO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Apr 2023 06:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjDXKKN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Apr 2023 06:10:13 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AE6EA
        for <linux-pwm@vger.kernel.org>; Mon, 24 Apr 2023 03:10:12 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-94a342f7c4cso753843366b.0
        for <linux-pwm@vger.kernel.org>; Mon, 24 Apr 2023 03:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682331011; x=1684923011;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hap29hkMONIqb3a65KU2SJPeBl9j6CavN0wd4ZM0vK4=;
        b=PFMQKFCgKWFKkU/a73gHiv4ThGQPZ0MqyDAg9KjjjnMXyRlOmr6PhjM9Feu3T+k/cM
         wCHxhysc5i4E3GgqwxIfiHWJCmaTv+HVr0oFxnDhlr51iqbEbM7EQx/hI+mAq853WJwm
         gm+LmYJE80Lv6fDR5RDnCBWRUd6+o7JQg1pWaZiaPhYr+3fREJFA0APApxtV0BukJifh
         T4P7ydWmdM8oPP/I2eI+VeujlgAtIEMWJurKLIZ+7EPS3CC7zHsXhgwLIz3x3ZlDqmon
         74hg7VVaOw/wuj0SdkpJI9H4cRyDoSCrPjvy9rJDJWM43uMeiAAZUoRGTJ3rtgB1Bdjx
         UTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682331011; x=1684923011;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hap29hkMONIqb3a65KU2SJPeBl9j6CavN0wd4ZM0vK4=;
        b=lamTX319fDNFY1O2EiGN8QaLRIoTn1zVS2cdt5xcAyb1vD3jxOFLNrsG5sd1qejJVq
         xWGowdLCuN+iikfcseOIfy4NYG9YJvhXzc4x5+Ou5n6W1GPrtPUNf47B5L1rhDe2oX2o
         C0Xk8/ZJ+VWe+3p4yOxeFZuq6zRM1aQck11kmxSGnq6Ld9v4D7QWoK25/+Fljtq5uwrg
         c0qTJaStBmI57ruRMVwFI9bHpP7e6FnD2p2kfeac/hPvlsp1F5D2U+40xmdfmL/dondp
         ZeMPKpOFvgzDNND/TNgSxHmYdVZUipkJL+4eFmE460z6WYLVnN7NHOjOiBjJKZ+pGYQT
         jN2w==
X-Gm-Message-State: AAQBX9dNI5o/U2YWMYRP4nsLEzyJXEFJVxMTf7If4h8Qx9Gg7p1ctBfH
        fw7LTwN9aJCmIlpHOwS45S4Tcw==
X-Google-Smtp-Source: AKy350bsLAuDChz19AU7KnYjVEvlNj8p4PtnXZy6kxfLAXdtasx8pPWo+9mjZxN0wDVGE4kAmxCrWw==
X-Received: by 2002:a17:907:90c4:b0:94e:ff23:992a with SMTP id gk4-20020a17090790c400b0094eff23992amr8355110ejb.59.1682331010798;
        Mon, 24 Apr 2023 03:10:10 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:fcdb:bf53:d053:3a52? ([2a02:810d:15c0:828:fcdb:bf53:d053:3a52])
        by smtp.gmail.com with ESMTPSA id q26-20020a170906941a00b0094f01aa9567sm5297581ejx.20.2023.04.24.03.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 03:10:10 -0700 (PDT)
Message-ID: <4e0685cc-c9fc-feba-c523-5161b68dfaf7@linaro.org>
Date:   Mon, 24 Apr 2023 12:10:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: imx: add i.MX8QXP compatible
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
References: <20230424082108.26512-1-alexander.stein@ew.tq-group.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230424082108.26512-1-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 24/04/2023 10:21, Alexander Stein wrote:
> i.MX8QXP compatible is missing in the list, add it.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> Changes in v2:
> * Add power-domains property


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

