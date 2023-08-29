Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E4578C1A1
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Aug 2023 11:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbjH2Jjb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 29 Aug 2023 05:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234838AbjH2JjJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 29 Aug 2023 05:39:09 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25F91A1
        for <linux-pwm@vger.kernel.org>; Tue, 29 Aug 2023 02:39:05 -0700 (PDT)
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 11E053F0D2
        for <linux-pwm@vger.kernel.org>; Tue, 29 Aug 2023 09:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1693301944;
        bh=gTippXVpSNNz9qzwb3ZwRyGCLyetmmexG2eFM+R4Cws=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=SF7/n0sxplvyQpmrXTUei+QllTXsQE9PGCuShKz0OGYR5i45MYKcPIx2SlPB6lpIa
         o+hbytNmaMxi82jv9PgjwwztH5NjUkvhgZihg38E1koCdCiMgKOdZj40y1xjVrXUe8
         Xd8fFfWSZdFNnJmcXcLv4iMnFdTRpulQ+vA1CLR8lRZLlNPWhioKbV10IRARVt1uQC
         OO2VFrfv1G44kDk1eP37NsaZmgxEFkO+tciAY+3k2aWa3QkHkTsYDnhPN98yXbmTe0
         5e6EJpEa6PpgOv6+Z4TrLctMwg2po501KOn8jPn5MtQ9jWBge8ysG8ZZs5aefsx42/
         N6+3y5Qhq8FJA==
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-410f0988ea6so47406211cf.3
        for <linux-pwm@vger.kernel.org>; Tue, 29 Aug 2023 02:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693301943; x=1693906743;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gTippXVpSNNz9qzwb3ZwRyGCLyetmmexG2eFM+R4Cws=;
        b=LSnWeUjRIxBC/vG94u+kVNk3IP9hKFhKYrriF4mwFNq4XxrpYp9T1JrZuWxjBbMmNs
         X3khiZGNxCOXl0e6MFutUoHFZtaoSYbDr4rgT48+gydGSfT48beuo3U+yVg839odTLFe
         RK2gWINALdLPOQWDnbr2AoTHnA1wNHBUaB+DlynHKoDpkLKfqREN24kjVfBxcv9OOKBp
         +k6gc8VIfo3FNOAsdPFssI7s2MaCSom7FyRYcwYElEh/xJ5CF2zlIKYIl7ytM4Q/2TC/
         TyA1CFUzE4rWmFqjNwVHtVvKVNMiCXQrWlAmzhf86QBoiCxF2X6BLsPmJCQ04BfhIQvU
         TWVg==
X-Gm-Message-State: AOJu0Ywr3npXfIvHCJyZSzu1rTbDvzFj9RIJBR6chIwlwvU09OzWjysv
        b8wZmYQ6Xy7vb99zAuVadoca/hoUroh7RlIyHmBi556C1/mVeKH78U4NIbNf6FtIojgx3DQiHaV
        2zjndEzTsPnBIAJfqYKLztenL4qL+J1o2lftMjCUYrr7XBHVt2Ni0PQ==
X-Received: by 2002:a05:622a:143:b0:412:2f80:abe4 with SMTP id v3-20020a05622a014300b004122f80abe4mr4205704qtw.46.1693301943118;
        Tue, 29 Aug 2023 02:39:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLWz7iEHHsdF1zihnHlrPh2AIw2E72KlWSpDq4tWYiTK1S3tWsZy7Ux1KU97H/VDehpWQvp6k93Yxn7RuCS70=
X-Received: by 2002:a05:622a:143:b0:412:2f80:abe4 with SMTP id
 v3-20020a05622a014300b004122f80abe4mr4205688qtw.46.1693301942895; Tue, 29 Aug
 2023 02:39:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230825081328.204442-1-william.qiu@starfivetech.com> <20230825081328.204442-5-william.qiu@starfivetech.com>
In-Reply-To: <20230825081328.204442-5-william.qiu@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Tue, 29 Aug 2023 11:38:47 +0200
Message-ID: <CAJM55Z-Ab1DAQyQC9TRFFBidus6wCRns9RQjx-iyYyNK1e-e6A@mail.gmail.com>
Subject: Re: [RFC v4 4/4] riscv: dts: starfive: jh7100: Add PWM node and pins configuration
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, 25 Aug 2023 at 10:16, William Qiu <william.qiu@starfivetech.com> wrote:
> Add StarFive JH7100 PWM controller node and add PWM pins configuration
> on VisionFive 2 board.

Hi William,

This is the VisionFive V1 board right?

/Emil

> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  .../boot/dts/starfive/jh7100-common.dtsi      | 24 +++++++++++++++++++
>  arch/riscv/boot/dts/starfive/jh7100.dtsi      |  9 +++++++
>  2 files changed, 33 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
> index b93ce351a90f..746867b882b0 100644
> --- a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
> @@ -84,6 +84,24 @@ GPO_I2C2_PAD_SDA_OEN,
>                 };
>         };
>
> +       pwm_pins: pwm-0 {
> +               pwm-pins {
> +                       pinmux = <GPIOMUX(7,
> +                                 GPO_PWM_PAD_OUT_BIT0,
> +                                 GPO_PWM_PAD_OE_N_BIT0,
> +                                 GPI_NONE)>,
> +                                <GPIOMUX(5,
> +                                 GPO_PWM_PAD_OUT_BIT1,
> +                                 GPO_PWM_PAD_OE_N_BIT1,
> +                                 GPI_NONE)>;
> +                       bias-disable;
> +                       drive-strength = <35>;
> +                       input-disable;
> +                       input-schmitt-disable;
> +                       slew-rate = <0>;
> +               };
> +       };
> +
>         uart3_pins: uart3-0 {
>                 rx-pins {
>                         pinmux = <GPIOMUX(13, GPO_LOW, GPO_DISABLE,
> @@ -154,6 +172,12 @@ &osc_aud {
>         clock-frequency = <27000000>;
>  };
>
> +&ptc {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pwm_pins>;
> +       status = "okay";
> +};
> +
>  &uart3 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&uart3_pins>;
> diff --git a/arch/riscv/boot/dts/starfive/jh7100.dtsi b/arch/riscv/boot/dts/starfive/jh7100.dtsi
> index 4218621ea3b9..7f5bb19e636e 100644
> --- a/arch/riscv/boot/dts/starfive/jh7100.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7100.dtsi
> @@ -248,5 +248,14 @@ watchdog@12480000 {
>                         resets = <&rstgen JH7100_RSTN_WDTIMER_APB>,
>                                  <&rstgen JH7100_RSTN_WDT>;
>                 };
> +
> +               ptc: pwm@12490000 {
> +                       compatible = "starfive,jh7100-pwm";
> +                       reg = <0x0 0x12490000 0x0 0x10000>;
> +                       clocks = <&clkgen JH7100_CLK_PWM_APB>;
> +                       resets = <&rstgen JH7100_RSTN_PWM_APB>;
> +                       #pwm-cells = <3>;
> +                       status = "disabled";
> +               };
>         };
>  };
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
