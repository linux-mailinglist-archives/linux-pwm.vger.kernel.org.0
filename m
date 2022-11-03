Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87B5617F11
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Nov 2022 15:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiKCOOT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 3 Nov 2022 10:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiKCOOH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 3 Nov 2022 10:14:07 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D4911C38
        for <linux-pwm@vger.kernel.org>; Thu,  3 Nov 2022 07:14:06 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id w4so1304749qts.0
        for <linux-pwm@vger.kernel.org>; Thu, 03 Nov 2022 07:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gYQGyQS8DP53gudD2LS5QIdA9P5CghjE18cB5YGbwNo=;
        b=YPDKiBDhL3GTpZFC90CenZCcTm0lE7QqO55q9u1umahiJTGoPAQLmtFarcCsEC9GZm
         t0CEAHuLk/CEY6FBw0kT1KXS9kk9QOLfCvn+33jtBVakvMMvkhMKrBeexfM0UvVHqTtj
         XCjhtlDs/6cE9RBRWSpX7lhwg+ZeGlFdKCfFw16lTGQ+p2TggKvQKgl1ahgTHVR0ggke
         jcfcmuMQyRA/ZPoOAVQETCm/ni4tG6SDPWa67ZNbXaVGHdkKYHCebIbYB+dM8FDMxFtz
         Ch5pRimZDh/fOgYp3eiSyMl4H3w3syxlw/qPcs5N3jTS8wf9UKpLQMJngWgEHrOJILNv
         SR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gYQGyQS8DP53gudD2LS5QIdA9P5CghjE18cB5YGbwNo=;
        b=CM80cifdu4ycqvsQ5/Q7pzmh0+DBByTyOQ6isOP+HhXo2zBdFdVTsrZvCfrViRGNCi
         5lJE1gHmL/YZbinIePvleAJR5F5qEXQPCCLxxfPnUz/6ck9WL5lxccLadpVt6jCbEX9v
         NuXOKho+CxOkwmgnuX3r5adWNWfXn3vYeKL5IK6yIG3vqP5xkYbKF0oEnfJ7M3vLN/o1
         ZVMoS359oOgRShiKbNUJlvuwu3ubXYidJ9FYB0liZbOqDmXPflpwImfabKxrxasqbNk+
         94lellqGLc/oOmncmBAowRtrI86EWfIRZmjdsKzTwLooJCblxHAa6n9mSQh9rvTWa2MG
         CAMA==
X-Gm-Message-State: ACrzQf0l3ZJ6R5QpKDhB05P+4uHyyo3fTaEJHjwwUrHG3itooIGCzrJR
        7uTnYyaRZ5hBoa9TRqzNMVpQfW1z/F2GgQ==
X-Google-Smtp-Source: AMsMyM4DvdwTxW9AjaVe1eLPMpQG5yb5nGRTwsLMR0Kn6Zlxx66//tEHqZs8S0U7aS/vvhsbS4CKNQ==
X-Received: by 2002:a05:622a:114b:b0:3a5:4b2e:41e2 with SMTP id f11-20020a05622a114b00b003a54b2e41e2mr5982956qty.255.1667484845775;
        Thu, 03 Nov 2022 07:14:05 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:a35d:9f85:e3f7:d9fb? ([2601:586:5000:570:a35d:9f85:e3f7:d9fb])
        by smtp.gmail.com with ESMTPSA id e2-20020ac84902000000b0039cb5c9dbacsm596518qtq.22.2022.11.03.07.14.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 07:14:05 -0700 (PDT)
Message-ID: <18d66cce-64ae-aeaa-e9cf-9426c5d214f5@linaro.org>
Date:   Thu, 3 Nov 2022 10:14:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] dt-bindings: pwm: tegra: Convert to json-schema
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20221103120137.1467905-1-thierry.reding@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221103120137.1467905-1-thierry.reding@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 03/11/2022 08:01, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Convert the Tegra PWFM bindings from the free-form text format to
> json-schema.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../bindings/pwm/nvidia,tegra20-pwm.txt       |  77 ----------
>  .../bindings/pwm/nvidia,tegra20-pwm.yaml      | 144 ++++++++++++++++++
>  2 files changed, 144 insertions(+), 77 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
> deleted file mode 100644
> index 74c41e34c3b6..000000000000
> --- a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
> +++ /dev/null
> @@ -1,77 +0,0 @@
> -Tegra SoC PWFM controller
> -
> -Required properties:
> -- compatible: Must be:
> -  - "nvidia,tegra20-pwm": for Tegra20
> -  - "nvidia,tegra30-pwm", "nvidia,tegra20-pwm": for Tegra30
> -  - "nvidia,tegra114-pwm", "nvidia,tegra20-pwm": for Tegra114
> -  - "nvidia,tegra124-pwm", "nvidia,tegra20-pwm": for Tegra124
> -  - "nvidia,tegra132-pwm", "nvidia,tegra20-pwm": for Tegra132
> -  - "nvidia,tegra210-pwm", "nvidia,tegra20-pwm": for Tegra210
> -  - "nvidia,tegra186-pwm": for Tegra186
> -  - "nvidia,tegra194-pwm": for Tegra194
> -- reg: physical base address and length of the controller's registers
> -- #pwm-cells: should be 2. See pwm.yaml in this directory for a description of
> -  the cells format.
> -- clocks: Must contain one entry, for the module clock.
> -  See ../clocks/clock-bindings.txt for details.
> -- resets: Must contain an entry for each entry in reset-names.
> -  See ../reset/reset.txt for details.
> -- reset-names: Must include the following entries:
> -  - pwm
> -
> -Optional properties:
> -============================
> -In some of the interface like PWM based regulator device, it is required
> -to configure the pins differently in different states, especially in suspend
> -state of the system. The configuration of pin is provided via the pinctrl
> -DT node as detailed in the pinctrl DT binding document
> -	Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
> -
> -The PWM node will have following optional properties.
> -pinctrl-names:	Pin state names. Must be "default" and "sleep".
> -pinctrl-0:	phandle for the default/active state of pin configurations.
> -pinctrl-1:	phandle for the sleep state of pin configurations.
> -
> -Example:
> -
> -	pwm: pwm@7000a000 {
> -		compatible = "nvidia,tegra20-pwm";
> -		reg = <0x7000a000 0x100>;
> -		#pwm-cells = <2>;
> -		clocks = <&tegra_car 17>;
> -		resets = <&tegra_car 17>;
> -		reset-names = "pwm";
> -	};
> -
> -
> -Example with the pin configuration for suspend and resume:
> -=========================================================
> -Suppose pin PE7 (On Tegra210) interfaced with the regulator device and
> -it requires PWM output to be tristated when system enters suspend.
> -Following will be DT binding to achieve this:
> -
> -#include <dt-bindings/pinctrl/pinctrl-tegra.h>
> -
> -	pinmux@700008d4 {
> -		pwm_active_state: pwm_active_state {
> -                        pe7 {
> -                                nvidia,pins = "pe7";
> -                                nvidia,tristate = <TEGRA_PIN_DISABLE>;
> -			};
> -		};
> -
> -		pwm_sleep_state: pwm_sleep_state {
> -                        pe7 {
> -                                nvidia,pins = "pe7";
> -                                nvidia,tristate = <TEGRA_PIN_ENABLE>;
> -			};
> -		};
> -	};
> -
> -	pwm@7000a000 {
> -		/* Mandatory PWM properties */
> -		pinctrl-names = "default", "sleep";
> -		pinctrl-0 = <&pwm_active_state>;
> -		pinctrl-1 = <&pwm_sleep_state>;
> -	};
> diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml
> new file mode 100644
> index 000000000000..9c73e78ff434
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml
> @@ -0,0 +1,144 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/nvidia,tegra20-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NVIDIA Tegra PWFM controller
> +
> +maintainers:
> +  - Thierry Reding <thierry.reding@gmail.com>
> +  - Jon Hunter <jonathanh@nvidia.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: nvidia,tegra20-pwm
> +
> +      - items:
> +          - enum:
> +              - nvidia,tegra30-pwm
> +              - nvidia,tegra114-pwm
> +              - nvidia,tegra124-pwm
> +              - nvidia,tegra132-pwm
> +              - nvidia,tegra210-pwm
> +          - enum:
> +              - nvidia,tegra20-pwm
> +
> +      - items:
> +          - const: nvidia,tegra186-pwm

I guess you wanted to keep some order between nvidia,tegra20-pwm and
nvidia,tegra186-pwm, but this creates impression you will have here more
items, which of course cannot happen. So either keep this one with
tegra20 as one enum or drop "items".

> +
> +      - items:
> +          - const: nvidia,tegra194-pwm
> +          - const: nvidia,tegra186-pwm
> +
> +      - items:
> +          - const: nvidia,tegra234-pwm
> +          - const: nvidia,tegra194-pwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: module clock

Just maxItems: 1, because description is not really helping.

> +
> +  clock-names:
> +    items:
> +      - const: pwm

This wasn't in original binding and does not look needed. Mention
changes from pure conversion.

> +
> +  resets:
> +    items:
> +      - description: module reset
> +
> +  reset-names:
> +    items:
> +      - const: pwm
> +
> +  "#pwm-cells":
> +    const: 2
> +
> +  pinctrl-names:
> +    items:
> +      - const: default
> +      - const: sleep
> +
> +  pinctrl-0:
> +    description: configuration for the default/active state
> +
> +  pinctrl-1:
> +    description: configuration for the sleep state
> +
> +  operating-points-v2:
> +    $ref: "/schemas/types.yaml#/definitions/phandle"

Drop quotes. We should actually define it in some common schema.

> +
> +  power-domains:
> +    items:
> +      - description: phandle to the core power domain
> +
> +allOf:
> +  - $ref: pwm.yaml
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - resets
> +  - reset-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/tegra20-car.h>
> +
> +    pwm: pwm@7000a000 {
> +        compatible = "nvidia,tegra20-pwm";
> +        reg = <0x7000a000 0x100>;
> +        #pwm-cells = <2>;
> +        clocks = <&tegra_car TEGRA20_CLK_PWM>;
> +        resets = <&tegra_car 17>;
> +        reset-names = "pwm";
> +    };
> +
> +  # Example with the pin configuration for suspend and resume:
> +  # ==========================================================
> +  # Suppose pin PE7 (On Tegra210) interfaced with the regulator device and it requires PWM output
> +  # to be tristated when system enters suspend.
> +  - |
> +    #include <dt-bindings/clock/tegra210-car.h>
> +    #include <dt-bindings/pinctrl/pinctrl-tegra.h>
> +
> +    pinmux@700008d4 {
> +        compatible = "nvidia,tegra210-pinmux";
> +        reg = <0x700008d4 0x29c>, /* Pad control registers */
> +              <0x70003000 0x294>; /* Mux registers */
> +
> +        pwm_active_state: pwm_active_state {

No underscores in node names.


Best regards,
Krzysztof

