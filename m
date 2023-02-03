Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACC4689199
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Feb 2023 09:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbjBCIHy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Feb 2023 03:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbjBCIHU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Feb 2023 03:07:20 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCF746168
        for <linux-pwm@vger.kernel.org>; Fri,  3 Feb 2023 00:05:39 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id a2so3605524wrd.6
        for <linux-pwm@vger.kernel.org>; Fri, 03 Feb 2023 00:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Mv17eaJFCI/w5Z3xek3QoJZ92Bm1fO3+e35K6LedY2Y=;
        b=jq4WMr89+a3LJs6QVU01tpxjfScM//lo2OEWbtPxzvN2uv2MGVaLwCrfjvRmaMHS1F
         /54JqjyzVFWlhc/0mnNfsNSLHqLOs2EO5bq+VxhiZ8/OgfDwxlRm5JFc5uEAHlbn6CBc
         GuWa+ZJUDbFSKTUBHCnjOmYkk/c/Gpraq6QsD7uBPKXlytiSib5OHMW7jV2X6ROd6Ld4
         YTVgcfUJE2jGT9MtT0PeZ5aiIZOdYkNesNx5Px5e8JiST0ACi1ld5GLuWT7oQm/4qMlX
         V/eOjBw/nKRnlbEYTJExB6+cxZv34u1S+0Bct76h979ZgPWxzpLuZDY/AN12/TjSe3Rs
         KRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mv17eaJFCI/w5Z3xek3QoJZ92Bm1fO3+e35K6LedY2Y=;
        b=RbJETxN5m3TRLCmeGVLZh73knZgBKuALYlC2XRdSD72EmqKGTw7+XXvYOhapuFsmTs
         HMgCr82d67yAZaMcXSv+jiGn+qPI+lJyluNehF6GVkxNEZlj9atwGgHRKgwPZpqHE4sD
         cf5jQQ6Fs8eABcBTpgNb5FqwM2sktAYf0/L1UlaNEz4h6VPvuguIuC0FajSh2IXVeA5o
         iGFUtn6FeEwreXOBpL7eFXrSLOYJp1AZz9YGLtwPfbg1ixr3O3vKn/3N5zgfvDN0cpqC
         CRTTvQbQcmTHbbS5DxQYBJAAYZGrHzcl7dClyoVZiqe6tj8dfgbfSpw4zlGNuhtVKJWF
         wAAw==
X-Gm-Message-State: AO0yUKWX2HHgxx9M1qA5vtuSZ+xw2yuaQAUsNWWAWn+TEFpVq9tr3QOW
        cm5V9D2CtEkcVHSsXlVg2ODXPQ==
X-Google-Smtp-Source: AK7set/TiiQhfEWBSxtDxQuC1mikiRX+6Zo9nA6ypZA5geunkb+DGH0j7NUGqgG82UrhrwUXLJb7Nw==
X-Received: by 2002:a5d:4e02:0:b0:2bf:e1f8:c4b6 with SMTP id p2-20020a5d4e02000000b002bfe1f8c4b6mr7969162wrt.52.1675411537589;
        Fri, 03 Feb 2023 00:05:37 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:7407:d8b9:ec7a:537? ([2a01:e0a:982:cbb0:7407:d8b9:ec7a:537])
        by smtp.gmail.com with ESMTPSA id l2-20020a05600002a200b002bfd687a96dsm1467430wry.16.2023.02.03.00.05.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 00:05:36 -0800 (PST)
Message-ID: <204f71e1-d98d-9aa7-4848-663e22332c69@linaro.org>
Date:   Fri, 3 Feb 2023 09:05:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/4] arm: dts: meson: adjust order of some compatibles
Content-Language: en-US
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, linux-pwm@vger.kernel.org
References: <8df4ceec-663c-dc68-d775-5caeb02c0cca@gmail.com>
 <66f77c32-2678-3e31-fb00-1294ccaa6045@gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <66f77c32-2678-3e31-fb00-1294ccaa6045@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 01/02/2023 20:58, Heiner Kallweit wrote:
> During review of a new yaml binding, affecting these dts, it turned out
> that some compatibles aren't ordered as they should be. Order should be
> most specific to least specific.
> 
> Suggested-by: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>   arch/arm/boot/dts/meson8b.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
> index d5a3fe21e..5979209fe 100644
> --- a/arch/arm/boot/dts/meson8b.dtsi
> +++ b/arch/arm/boot/dts/meson8b.dtsi
> @@ -580,8 +580,8 @@ &ethmac {
>   };
>   
>   &gpio_intc {
> -	compatible = "amlogic,meson-gpio-intc",
> -		     "amlogic,meson8b-gpio-intc";
> +	compatible = "amlogic,meson8b-gpio-intc",
> +		     "amlogic,meson-gpio-intc";
>   	status = "okay";
>   };
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
