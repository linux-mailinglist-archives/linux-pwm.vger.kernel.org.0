Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5DC61E0A8
	for <lists+linux-pwm@lfdr.de>; Sun,  6 Nov 2022 08:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiKFH4f (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 6 Nov 2022 02:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKFH4e (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 6 Nov 2022 02:56:34 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F4B6246;
        Sun,  6 Nov 2022 00:56:32 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id f7so13196194edc.6;
        Sun, 06 Nov 2022 00:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gkzrt0tLXNTRfLm2uFzAkX1Avhsv5RXjjNb/2WJUlik=;
        b=DzrsiMeD6vgcQ6q/Fpth37UDork/jbuMdZxdFqi/9C+/66NmeFCXM19niKP92lHRck
         LhiBjSj8zFFV0sGQk7oVq1MTzhbRaZYJACRyTF0EfQxVZvfjndJYAF/FtkCAUC3X4ols
         DGI0+Z/BCOp1q0K00/Ps75MnolbSCs2QBYY9MDOLQcoUWyY7mavUCtVQP2BXMIh+9fIJ
         E+F4nx2VwRRNvqCsUySYmsikfkkRK1//HhaFLtIP411hu2CsI9q180fm7/Uq2qfW+TSQ
         K4mmflomiQTLnwrbO2uDDevf24nxsftByKhnmLFbzGwVsDXYNFgoye4vxXNYJ26aHdwo
         NZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gkzrt0tLXNTRfLm2uFzAkX1Avhsv5RXjjNb/2WJUlik=;
        b=3sKVyNymTXNKynSctwzr4V3J4JfhbwlS9zXkfJOQQJ/kJ5qkC0ImW9tmtYqhP89Xp4
         78umcFCBN1KOUixK0JVRj6mqe9v0oRmvn4/WeTmMmURNmopjAzPui222CG0xZPvr33NA
         hTaoMfG3Lxa4kpuToUQNDjRNqz9B2Gue5MTU0G+d1eKpGOvko+AOgSP59x2hVZz7n1a2
         h42ZwPULfZLfzvQe8RcfQaUhrA8VVb+9h1w4qOmraJtC64IkcpyYwkkWwm4sfRK4ArNi
         EmutGC74SDNrDgUbqj1+MoGjnFOiYI3G2zWxx1u8HiotXjJyoArXM9lsKnrx5F+inwdT
         IbvQ==
X-Gm-Message-State: ACrzQf0Lc5ojukdgpKh5Cn432u9tRg9lhlCExes4/0VmDzgvmsZVEXgj
        FZcw8BEoawaLrgnhevT5mg0=
X-Google-Smtp-Source: AMsMyM7ak3tVRHLrcWvyw7Y3Cy7kh+ed4+8e2QUjoi4nw9UBbYSQ8Whe88vZGzla2/4KcXfkgTYFVQ==
X-Received: by 2002:aa7:dcd5:0:b0:461:5fad:4215 with SMTP id w21-20020aa7dcd5000000b004615fad4215mr45981851edu.332.1667721391260;
        Sun, 06 Nov 2022 00:56:31 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id s8-20020a056402164800b004642b35f89esm2301685edx.9.2022.11.06.00.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 00:56:30 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Icenowy Zheng <uwu@icenowy.me>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 2/9] ARM: dts: suniv: f1c100s: add PWM node
Date:   Sun, 06 Nov 2022 08:56:29 +0100
Message-ID: <8176089.NyiUUSuA9g@jernej-laptop>
In-Reply-To: <20221101141658.3631342-3-andre.przywara@arm.com>
References: <20221101141658.3631342-1-andre.przywara@arm.com> <20221101141658.3631342-3-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Dne torek, 01. november 2022 ob 15:16:51 CET je Andre Przywara napisal(a):
> The Allwinner F1C100s family of SoCs contain a PWM controller compatible
> to the one used in the A20 chip.
> Add the DT node so that any users can simply enable it in their board
> DT.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm/boot/dts/suniv-f1c100s.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/suniv-f1c100s.dtsi
> b/arch/arm/boot/dts/suniv-f1c100s.dtsi index 0edc1724407b3..d5a6324e76465
> 100644
> --- a/arch/arm/boot/dts/suniv-f1c100s.dtsi
> +++ b/arch/arm/boot/dts/suniv-f1c100s.dtsi
> @@ -192,6 +192,15 @@ wdt: watchdog@1c20ca0 {
>  			clocks = <&osc32k>;
>  		};
> 
> +		pwm: pwm@1c21000 {
> +			compatible = "allwinner,suniv-f1c100s-pwm",
> +				     "allwinner,sun7i-a20-pwm";
> +			reg = <0x01c21000 0xc>;

According to documentation, size is 0x400.

Best regards,
Jernej

> +			clocks = <&osc24M>;
> +			#pwm-cells = <3>;
> +			status = "disabled";
> +		};
> +
>  		uart0: serial@1c25000 {
>  			compatible = "snps,dw-apb-uart";
>  			reg = <0x01c25000 0x400>;




