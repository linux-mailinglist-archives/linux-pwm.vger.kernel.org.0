Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7973F478EB0
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Dec 2021 15:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237664AbhLQO6t (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 17 Dec 2021 09:58:49 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:56964
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237668AbhLQO6t (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 17 Dec 2021 09:58:49 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 457463F1F0
        for <linux-pwm@vger.kernel.org>; Fri, 17 Dec 2021 14:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639753128;
        bh=Hw35a9zAAra+Bh4MYIJdw1ech8klD8or9kfvHyKDECw=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=bkYtRILlDSq/bvQUhCA+obh3SDSQOe5vgBuc9F4s2NLuGlCp9iriZMNXUgYZf5mmg
         +r4K8cIo5eAZwjyDmuLbAGUnegW1G9DeLndc3jdMN/brD5W8Kbv9ILAdkFajnIlEAR
         OcesneiRBuoWfBvhiU3qx6LhIkYECyGLuorYrXDOmN43RDNqSME1ZnKEMahgbRO0Tl
         PuJMwxGUH4I/uvZsNl/neqBS+b7gBzTUoipKAG1d24/K9D5H19Xh0JL7VvBkVKJbYd
         hu8bigfEIMrSAOaYSnYtMyipiT9/bWcWGkgIfxMdFlFNdMHJJfxLMUZ3NsGaZfPGLT
         nktoIsrjw1vIA==
Received: by mail-ed1-f70.google.com with SMTP id v10-20020aa7d9ca000000b003e7bed57968so2106198eds.23
        for <linux-pwm@vger.kernel.org>; Fri, 17 Dec 2021 06:58:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Hw35a9zAAra+Bh4MYIJdw1ech8klD8or9kfvHyKDECw=;
        b=gBDLveI073WouzaTD/DOO6YP+Rt7pq+1MYT+h1NwTcKBrSZvFyGE4lwjALkAEobXt6
         /VSa22TXxJ3r7Bc0w5htw94uaY7jQEWdubZ8Fl/nOZtzgCKE9hN0uwGGtEymyTJ0kk1j
         NIhBh4V3YzAQUteu/sUYdm10Qr7vM/JrYPc8MKDCtUu668TmIQQKz0krvKQwIILBaTFE
         7ZVyOlIY1Bq0QrRvKugrbtE5p9zKDBWGQuUWlmGN7cBK70++4hf1dgh3lSx/SDUTafGm
         6zbYI5ZZKgvv/rew1LFQy3KQasAG1v66bcgZFmsLgJXG2VUw6e0e4XYqNrv891Lt13hI
         QqYg==
X-Gm-Message-State: AOAM53280YiZE1PJ1nzLVW3IerH2Bj9X29+YK+H1FCDM84mUHncR9tXY
        A38SzpZIUyQWyDpYK8chwdM1G/8Ym3ZUBWgS5n6GYANHmiEUf2rOD1ra9Dsvn1uoEQCS87EFmZV
        cX8v2T8R9rxrAH3AXhnwgi1wbEBKjJR2KEckGWQ==
X-Received: by 2002:a2e:3c16:: with SMTP id j22mr3118033lja.158.1639753117265;
        Fri, 17 Dec 2021 06:58:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyOFUy3T2cRGl82xVn02j230+oyfIezcftFw9B0y5rU/9OtzeUGE1r8DX0H/qzUI3hn4MMlTA==
X-Received: by 2002:a2e:3c16:: with SMTP id j22mr3117988lja.158.1639753116969;
        Fri, 17 Dec 2021 06:58:36 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id b10sm1424506lfj.230.2021.12.17.06.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 06:58:36 -0800 (PST)
Message-ID: <a995a558-6243-e5a1-18f6-fd03054727e7@canonical.com>
Date:   Fri, 17 Dec 2021 15:58:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 12/17] dt-bindings: pwm: add microchip corePWM binding
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
 <20211217093325.30612-13-conor.dooley@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211217093325.30612-13-conor.dooley@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 17/12/2021 10:33, conor.dooley@microchip.com wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Add device tree bindings for the Microchip fpga fabric based "core" PWM controller.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/pwm/microchip,corepwm.yaml       | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/microchip,corepwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/microchip,corepwm.yaml b/Documentation/devicetree/bindings/pwm/microchip,corepwm.yaml
> new file mode 100644
> index 000000000000..ed7d0351adc9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/microchip,corepwm.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/microchip,corepwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip ip core PWM controller bindings
> +
> +maintainers:
> +  - Conor Dooley <conor.dooley@microchip.com>
> +
> +description: |
> +  corePWM is an 16 channel pulse width modulator FPGA IP
> +
> +  https://www.microsemi.com/existing-parts/parts/152118
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: microchip,corepwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  "#pwm-cells":
> +    const: 2
> +
> +  microchip,sync-update:
> +    description: |
> +      In synchronous mode, all channels are updated at the beginning of the PWM period.
> +      Asynchronous mode is relevant to applications such as LED control, where
> +      synchronous updates are not required. Asynchronous mode lowers the area size,
> +      reducing shadow register requirements. This can be set at run time, provided
> +      SHADOW_REG_EN is asserted. SHADOW_REG_EN is set by the FPGA bitstream programmed
> +      to the device.

Please also describe what is the meaning of the values used here. What
does a value "2" mean?

> +
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    default: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - "#pwm-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include "dt-bindings/clock/microchip,mpfs-clock.h"
> +    corePWN1: corePWM@41000000 {

Here and in all patches, please skip the label. It's not helping.

Node name: pwm

> +      compatible = "microchip,corepwm";
> +      microchip,sync-update = /bits/ 8 <1>;
> +      clocks = <&clkcfg CLK_FIC3>;
> +      reg = <0x41000000 0xF0>;
> +      #pwm-cells = <2>;
> +    };
> 


Best regards,
Krzysztof
