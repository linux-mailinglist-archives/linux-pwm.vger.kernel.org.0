Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 501E9478EC8
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Dec 2021 16:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbhLQPAB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 17 Dec 2021 10:00:01 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:57068
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237749AbhLQO76 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 17 Dec 2021 09:59:58 -0500
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 089693F048
        for <linux-pwm@vger.kernel.org>; Fri, 17 Dec 2021 14:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639753198;
        bh=MelU3SMHwWCoWgQGcng8T0F8tu5Ji7Wc6RArgT+BeXI=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=d+LZ0SzYA44zZAevQh5Qp4Ai8hLhEB6LILsea7n73iWqYo9pK2aQukJxnoE3PiNVA
         trIR+lgEODLxIVBBDfWBlFaCFzyeL8+fJdla0T6G8GGNN2gWEOs3KtPMZmfBcPbkeS
         TgaSkHlEs/Ai9D7XZsPEmsFbmdoRB7L0YGdfNl0lGNXpqOADEd/Sk5IXtfvMqdWegs
         xz1MBbG1wXSUZfw5X7cVmeHiFH94U52L+rxSTIMSP+lJTS+1+7J/u/xR7JBRhZv7gg
         LyVtPFZmbXVIRjsguw0aTEJERSQiP/L6RT3YKJWoNeug23nuCIbtrz6l00EcKzYTDQ
         esbVMpFqPRWOg==
Received: by mail-lj1-f200.google.com with SMTP id o15-20020a2e90cf000000b00218dfebebdeso768700ljg.13
        for <linux-pwm@vger.kernel.org>; Fri, 17 Dec 2021 06:59:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MelU3SMHwWCoWgQGcng8T0F8tu5Ji7Wc6RArgT+BeXI=;
        b=hhdlZZ2yX3YYLpNA3emZEb0xpTpyAww0aog4ohMg4+kDPM4WL+ZynxWQ7sGddK+BW6
         OUlwwZri5CLHkdJE7ikE+clCQrakwEA4xIXZHMQLVX6H+gxRfPKJvlUOi4aw6NEmpCbL
         7Q5cO4oRfInsnJBgAQyEtFIkWIqSeOz659mycwE7MWt97Eos7bCCgD9BdsPS4EbMDLLy
         vzb5Yyu7+ZM7CaAnriNDT79Y9HS3U3HQm1txXoMx0CXFxbJoPHOtwdCkL/uzicLMg3la
         WPKbHn6OkRbbA8qM+lpNxyxAYMgjerRW5XbCi2zoidL6EH7xbTKs3S2vDI8YZls83Tcg
         j5nw==
X-Gm-Message-State: AOAM532AEwl1tN5bcZxnwpftfyuwPwg5hZz3eKgPAjoEWcXLkSRnVfzf
        E87htHJH6Q/7fCnBHD+B+wK22OoJp5RrcQEle9mRwpykGjOtk1ZLK2MAelTMlYGspepSB61JsZJ
        oocHF4/W/eSekBjq9FQITRPGpUpVvBEDuQ0HIrQ==
X-Received: by 2002:a05:6512:1151:: with SMTP id m17mr3312061lfg.414.1639753184825;
        Fri, 17 Dec 2021 06:59:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwX3iHx/NQRikos1eLTnz73uw8eLg8t6q9e2UaRo1h3MxDjjO6FmRhNO4HZayVZ1aVIIc+2tQ==
X-Received: by 2002:a05:6512:1151:: with SMTP id m17mr3312038lfg.414.1639753184651;
        Fri, 17 Dec 2021 06:59:44 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id bn17sm1751216ljb.22.2021.12.17.06.59.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 06:59:44 -0800 (PST)
Message-ID: <d5c996b7-9ac3-d7a9-4c21-307068afb84e@canonical.com>
Date:   Fri, 17 Dec 2021 15:59:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 14/17] riscv: dts: microchip: add fpga fabric section
 to icicle kit
Content-Language: en-US
To:     conor.dooley@microchip.com, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, robh+dt@kernel.org,
        jassisinghbrar@gmail.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     geert@linux-m68k.org, bin.meng@windriver.com, heiko@sntech.de,
        lewis.hanly@microchip.com, daire.mcnamara@microchip.com,
        ivan.griffin@microchip.com, atish.patra@wdc.com
References: <20211217093325.30612-1-conor.dooley@microchip.com>
 <20211217093325.30612-15-conor.dooley@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211217093325.30612-15-conor.dooley@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 17/12/2021 10:33, conor.dooley@microchip.com wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Split the device tree for the Microchip MPFS into two sections by adding
> microchip-mpfs-fabric.dtsi, which contains peripherals contained in the
> FPGA fabric.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../boot/dts/microchip/microchip-mpfs-fabric.dtsi   | 13 +++++++++++++
>  .../dts/microchip/microchip-mpfs-icicle-kit.dts     |  4 ++++
>  arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi   |  1 +
>  3 files changed, 18 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/microchip/microchip-mpfs-fabric.dtsi
> 
> diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs-fabric.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs-fabric.dtsi
> new file mode 100644
> index 000000000000..234c1f9bea40
> --- /dev/null
> +++ b/arch/riscv/boot/dts/microchip/microchip-mpfs-fabric.dtsi
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/* Copyright (c) 2020-2021 Microchip Technology Inc */
> +
> +/ {
> +	corePWM0: pwm@41000000 {

Lowercase labels please, so could be "core_pwm0".


Best regards,
Krzysztof
