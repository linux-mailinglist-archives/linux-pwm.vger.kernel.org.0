Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F4B75C91C
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Jul 2023 16:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjGUOIs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 21 Jul 2023 10:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbjGUOIb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 21 Jul 2023 10:08:31 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B44E30F4
        for <linux-pwm@vger.kernel.org>; Fri, 21 Jul 2023 07:08:08 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fb4146e8fcso12644825e9.0
        for <linux-pwm@vger.kernel.org>; Fri, 21 Jul 2023 07:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689948473; x=1690553273;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y2qkUshKHVzVp+c/Y0demp7gaQXxbXWhnsTKXjZPyo0=;
        b=UywUc+C0GWGsJmsnwwyJfmenKpLuppCyVgn7fiVYk6w8oSQSyUPADu9CVzT0lItaIY
         JormQX7Bee7HUdM1Us0r3vshqvTW9dDS77pz9B/D2/ZA9svRp6qlgOzmPqZwXZh6JV1/
         jFAXc0VCSjO1FhzSB/42DbWYEZLCPHvRoJtnZSW/6xd3CWsvpKl50jxs8bWH4bIonPhx
         mfuI8ES1EO+wJ7wjJ7D30ET7A/S3K9wdVKebziw7EOvtZk48W3EgUDtaXZXX93H2sArO
         cOiSlGVXpphHHUVrTWcN6efAAohsXSYhMb2r+xKhHw3ppirNHnquGubX9HEPBDh6NwUV
         LT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689948473; x=1690553273;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y2qkUshKHVzVp+c/Y0demp7gaQXxbXWhnsTKXjZPyo0=;
        b=B3HcvV+SRsulRCxOFiviD/426zlQz9NqmCiKi8FyYzunbxD8aRNHuCOvLlixVncRj7
         2b0fs7FOKY1asiHB4gn01+ORRn0qtGMQ4hwZ2E2R2EX0JWoi6SC0bWfeYxZQHFMwRRDe
         cgEEHdOVFWJOIokUOhADpT6rXEBpv3U5m7tr2m2F+v26gIwUW92QFt1uydrdWsIeOn/9
         EQ0Xxh5gQsZW8TdFSaccCN58u2qD88PB5bqQXOtgbiOSvVSbzbDuPVL7XcGAY713ICh+
         UJqVti4FtRjmGg7TJ0qsNvIIL+Bh51Ri1GjJRRfZ1SX8sfJK5ejcfD0hhhPqlRreFCTB
         JEEg==
X-Gm-Message-State: ABy/qLaoBSkj1mcdJckFV4kI6ga6ArDzZCWOnU4qrY96Ugg6NfQFjgAo
        HXrIi4GGyrNy0Dkzlkzo9JA0og==
X-Google-Smtp-Source: APBJJlHD6QFq7rMNB+KGBdqcP5NQHt4EfBmeBFQNK2CYYyWBzSCftYAyfr7ps7sa61qFYb64TkY4Cg==
X-Received: by 2002:a05:600c:1d1b:b0:3f9:68f:9c1a with SMTP id l27-20020a05600c1d1b00b003f9068f9c1amr7732579wms.15.1689948473091;
        Fri, 21 Jul 2023 07:07:53 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id g9-20020a7bc4c9000000b003fbca05faa9sm3387097wmk.24.2023.07.21.07.07.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 07:07:52 -0700 (PDT)
Message-ID: <3267b625-4597-7658-9faf-800862ca07a5@linaro.org>
Date:   Fri, 21 Jul 2023 16:07:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 10/42] dt-bindings: rtc: Add Cirrus EP93xx
Content-Language: en-US
To:     nikita.shubin@maquefel.me,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Lennert Buytenhek <kernel@wantstofly.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Lukasz Majewski <lukma@denx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
        netdev@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-input@vger.kernel.org, alsa-devel@alsa-project.org
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
 <20230605-ep93xx-v3-10-3d63a5f1103e@maquefel.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230605-ep93xx-v3-10-3d63a5f1103e@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 20/07/2023 13:29, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> This adds device tree bindings for the Cirrus Logic EP93xx
> RTC block used in these SoCs.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  .../devicetree/bindings/rtc/cirrus,ep9301-rtc.yaml | 40 ++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/cirrus,ep9301-rtc.yaml b/Documentation/devicetree/bindings/rtc/cirrus,ep9301-rtc.yaml
> new file mode 100644
> index 000000000000..63572c197e92
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/cirrus,ep9301-rtc.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/cirrus,ep9301-rtc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus EP93xx Real Time Clock controller
> +
> +maintainers:
> +  - Hartley Sweeten <hsweeten@visionengravers.com>
> +  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
> +

allOf: with $ref to rtc.yaml

> +properties:
> +  compatible:
> +    oneOf:
> +      - const: cirrus,ep9301-rtc
> +      - items:
> +          - enum:
> +              - cirrus,ep9302-rtc
> +              - cirrus,ep9307-rtc
> +              - cirrus,ep9312-rtc
> +              - cirrus,ep9315-rtc
> +          - const: cirrus,ep9301-rtc
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false

and then unevaluatedProperties instead.

> +
> +examples:
> +  - |
> +    rtc@80920000 {
> +      compatible = "cirrus,ep9301-rtc";
> +      reg = <0x80920000 0x100>;
> +    };
> +


Each of your file has a trailing blank line.

Best regards,
Krzysztof

