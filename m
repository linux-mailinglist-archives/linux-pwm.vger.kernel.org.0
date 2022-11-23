Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04AC56352C3
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Nov 2022 09:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236142AbiKWId2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Nov 2022 03:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236558AbiKWIdZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Nov 2022 03:33:25 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC85BB9739
        for <linux-pwm@vger.kernel.org>; Wed, 23 Nov 2022 00:33:22 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id j4so27166976lfk.0
        for <linux-pwm@vger.kernel.org>; Wed, 23 Nov 2022 00:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r24+kxiwoCSvm2ayWOZArpjPKCuE4SnymqyJAd3zIYM=;
        b=IOlJksGNdbJbrBpJA3cBm5xy486N/lEda8ByQPM70Vn2iN6r40/7a8iMKvXvbONgot
         dTJRLBkxGogODzjpQHPXfCuRt0SxPUiYwNZapRMJItO9VYrAvduz/YyTAXv81YAGLexT
         BFXU2sSbdjP7kWM4wiENR6YE1J09HxsVAPfm5mVtOFdnoXMfhBEHeKPqxDSEVrHKgs06
         Q5P8Hp3iHER6Nx4H3p/ZqW6tkLcflP9UhrVqKv4SL3Vad5jdoQCfbGdxWx3TvLi+fDFp
         0JGDldMXrOOiYsbT9fBpEjMbS5rABl99l6YBfO3Z5sFcYXGW0oqpuIAr/yptdQpUhNSL
         cG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r24+kxiwoCSvm2ayWOZArpjPKCuE4SnymqyJAd3zIYM=;
        b=kWoirKLNnecPozWVCk4l69RYeQPk2ytO+RuI5zFwDurGcsEEb7722Dz6LKjcWBlbVg
         DS7aTGY0DckQqjJY/Vsqu7p9LFlxPX34e1+UUZ5u5/IlY72eRYuqdYXCJlPY+nDWP2SU
         ChwXwTkvkk2eJ3lpHwnvosb3eut86juo6TeW/b3YaVNcQpj4r0Cf9g3QlGlvVYbPBI4T
         GuupZESiuLjg8y6a25pqsn1pzpnAhBmcgivy32cILp1uuRJblS+De7BBXNdW5aKJjUDQ
         zn0j7TJEbIhrXcbKXw+0lbnsg3+fECK5jKK9zDcki3wTfm6qqhS8BxXIbXlPs/E4mhqb
         G+cw==
X-Gm-Message-State: ANoB5pkUc7upFycSgwchvbgrjAsKhxLfuAqXxdaYIdIlDl96+jzHwnrQ
        C6EQbPmBd1cU0MTKx9dqCNYAqw==
X-Google-Smtp-Source: AA0mqf67rrmrBfbzQZgJMP0M0a0H3ooRG18aVbjknpNHm5vqSTPAfytlNHVUmddpFWSVh4iqF+jDXg==
X-Received: by 2002:ac2:47fc:0:b0:4a2:2f31:12bf with SMTP id b28-20020ac247fc000000b004a22f3112bfmr9699219lfp.550.1669192400912;
        Wed, 23 Nov 2022 00:33:20 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id j8-20020ac24548000000b00499fe9ce5f2sm2834949lfm.175.2022.11.23.00.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 00:33:20 -0800 (PST)
Message-ID: <d7538ba3-c326-ffcb-afe0-5abb7f0deff1@linaro.org>
Date:   Wed, 23 Nov 2022 09:33:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [v4 3/5] dt-bindings: hwmon: Add bindings for aspeed tach
 controller
Content-Language: en-US
To:     Billy Tsai <billy_tsai@aspeedtech.com>, jdelvare@suse.com,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        lee@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, corbet@lwn.net,
        p.zabel@pengutronix.de, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org
References: <20221123061635.32025-1-billy_tsai@aspeedtech.com>
 <20221123061635.32025-4-billy_tsai@aspeedtech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221123061635.32025-4-billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 23/11/2022 07:16, Billy Tsai wrote:
> Add the aspeed tach device bindings which should be the child-node of
> pwm-tach mfd.

Subject: drop second, redundant "bindings".

> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../bindings/hwmon/aspeed,ast2600-tach.yaml   | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
> new file mode 100644
> index 000000000000..f42114f8e3c2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
> @@ -0,0 +1,36 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2021 Aspeed, Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/aspeed,ast2600-tach.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Aspeed Ast2600 Tach controller
> +
> +maintainers:
> +  - Billy Tsai <billy_tsai@aspeedtech.com>
> +
> +description: |
> +  The Aspeed Tach controller can support upto 16 fan input.

Same comments as before. When you receive feedback about something,
please correct it everywhere, not only in one place.

> +  This module is part of the ast2600-pwm-tach multi-function device. For more
> +  details see ../mfd/aspeed,ast2600-pwm-tach.yaml.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2600-tach


Missing blank line.

> +patternProperties:
> +  "^fan@[a-z0-9]+$":
> +    type: object

Missing description. But more important - why do you have such child
nodes? Your example does not have them. What's the point? Do you expect
different number of fans per one device (one compatible)?

> +    properties:
> +      reg:
> +        description:
> +          The tach channel used for this node.
> +        maxItems: 1

Missing blank line.

> +    required:
> +      - reg
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false

Best regards,
Krzysztof

