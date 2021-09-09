Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A8B405A13
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Sep 2021 17:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236866AbhIIPT3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Sep 2021 11:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbhIIPT2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Sep 2021 11:19:28 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CB5C061575
        for <linux-pwm@vger.kernel.org>; Thu,  9 Sep 2021 08:18:19 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id k23-20020a17090a591700b001976d2db364so1692638pji.2
        for <linux-pwm@vger.kernel.org>; Thu, 09 Sep 2021 08:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VWNh9d2tUZKG8idZXByBeqTa3/M4oXQ5jM0T9ftLR/I=;
        b=DnigeVP4cZBoGJUJUi88ziXn1T3CRIWIFPRKrJ3LPoiqoQGG3OigRZ/Nw3AdIecPYQ
         JnFT/1lTu2E9E04ZwY9ZgZbYhJuhV7JPIB++wzcygMO8hvR2L+50c1wMFfxlYt0hVrYb
         C/YN8jBK0j7lymZLZEXbML9qB5S5JUq017qmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VWNh9d2tUZKG8idZXByBeqTa3/M4oXQ5jM0T9ftLR/I=;
        b=qOoGMF15bnbpxoFBQIzm5ZL2meX1tqFL9a0rLmWrJBVir1YlEBLdjv4gg0YeSTWsiy
         ujYG+5Tlz3dZbCaafvo2Siuku7a3RD1DOg6vfzLBEXIJ2ngQCgknAom1wWvhu7r4TO9R
         WKsk12pwnfuVRcea6jH4kv7HpDyDJotT5vmbAItS9StaBdjix5LSXD5n0pg3KDJT0zPJ
         7yjNShBB7hzU2z3cFAZA8mGDZNCDTHYr//bcNMjs7UbUNvYNfsasSj6YuXudrhI7J0RY
         rKAmtIhEre6AorLtDH4wSqHAH1Itp0r4m3mN9rKagFWxOEl1S1YK67XIv2GzDxZP0e+D
         X2Lg==
X-Gm-Message-State: AOAM533ippZVYTmgf8I5OzTqVT8WSfbApc/xWwMX61YfHD/q78cpvPWj
        r6o5EmvyU3zl8WwhVuDpmpx8EA==
X-Google-Smtp-Source: ABdhPJwOc/+AcPWbSFMHLSdY7Q78w3vlSzQ1LUqYnbXZ/HaAWI8X35xZ6GWLqwIRUxSL36sRhM136Q==
X-Received: by 2002:a17:90a:2ecb:: with SMTP id h11mr4165144pjs.196.1631200698756;
        Thu, 09 Sep 2021 08:18:18 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:27cc:a1d4:ed44:e1de])
        by smtp.gmail.com with UTF8SMTPSA id q3sm3032653pgf.18.2021.09.09.08.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 08:18:18 -0700 (PDT)
Date:   Thu, 9 Sep 2021 08:18:16 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>
Subject: Re: [PATCH v9 1/2] dt-bindings: leds: Add Qualcomm Light Pulse
 Generator binding
Message-ID: <YToluIBXlNJEFhcb@google.com>
References: <20210623035039.772660-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210623035039.772660-1-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Jun 22, 2021 at 08:50:38PM -0700, Bjorn Andersson wrote:
> This adds the binding document describing the three hardware blocks
> related to the Light Pulse Generator found in a wide range of Qualcomm
> PMICs.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v8:
> - None
> 
> Changes since v7:
> - Added qcom,pmc8180c-lpg
> - Defined constraints for qcom,power-source
> - Changes qcom,dtest to matrix and added constraints
> - Changed example from LED_COLOR_ID_MULTI to LED_COLOR_ID_RGB
> 
>  .../bindings/leds/leds-qcom-lpg.yaml          | 164 ++++++++++++++++++
>  1 file changed, 164 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
> new file mode 100644
> index 000000000000..10aee61a7ffc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
> @@ -0,0 +1,164 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/leds-qcom-lpg.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Light Pulse Generator
> +
> +maintainers:
> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> +
> +description: >
> +  The Qualcomm Light Pulse Generator consists of three different hardware blocks;
> +  a ramp generator with lookup table, the light pulse generator and a three
> +  channel current sink. These blocks are found in a wide range of Qualcomm PMICs.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,pm8150b-lpg
> +      - qcom,pm8150l-lpg
> +      - qcom,pm8916-pwm
> +      - qcom,pm8941-lpg
> +      - qcom,pm8994-lpg
> +      - qcom,pmc8180c-lpg
> +      - qcom,pmi8994-lpg
> +      - qcom,pmi8998-lpg
> +
> +  "#pwm-cells":
> +    const: 2
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  qcom,power-source:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      power-source used to drive the output, as defined in the datasheet.
> +      Should be specified if the TRILED block is present
> +    enum: [0, 1, 3]
> +
> +  qcom,dtest:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    description: >
> +      A list of integer pairs, where each pair represent the dtest line the
> +      particular channel should be connected to and the flags denoting how the
> +      value should be outputed, as defined in the datasheet. The number of
> +      pairs should be the same as the number of channels.
> +    items:
> +      items:
> +        - description: dtest line to attach
> +        - description: flags for the attachment
> +
> +  multi-led:
> +    type: object
> +    $ref: leds-class-multicolor.yaml#
> +    properties:
> +      "#address-cells":
> +        const: 1
> +
> +      "#size-cells":
> +        const: 0
> +
> +      "^led@[0-9a-f]$":
> +        type: object
> +        $ref: common.yaml#
> +
> +patternProperties:
> +  "^led@[0-9a-f]$":
> +    type: object
> +    $ref: common.yaml#
> +
> +    properties:
> +      reg: true
> +
> +    required:
> +      - reg
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/leds/common.h>
> +
> +    lpg {
> +      compatible = "qcom,pmi8994-lpg";
> +
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      qcom,power-source = <1>;
> +
> +      qcom,dtest = <0 0>,
> +                   <0 0>,
> +                   <0 0>,
> +                   <4 1>;
> +
> +      led@1 {
> +        reg = <1>;
> +        label = "green:user1";
> +      };
> +
> +      led@2 {
> +        reg = <2>;
> +        label = "green:user0";
> +        default-state = "on";
> +      };
> +
> +      led@3 {
> +        reg = <3>;
> +        label = "green:user2";
> +      };
> +
> +      led@4 {
> +        reg = <4>;
> +        label = "green:user3";
> +      };
> +    };
> +  - |
> +    #include <dt-bindings/leds/common.h>
> +
> +    lpg {
> +      compatible = "qcom,pmi8994-lpg";
> +
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      qcom,power-source = <1>;
> +
> +      multi-led {
> +        color = <LED_COLOR_ID_RGB>;
> +        function = LED_FUNCTION_STATUS;
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        led@1 {
> +          reg = <1>;
> +          color = <LED_COLOR_ID_RED>;
> +        };
> +
> +        led@2 {
> +          reg = <2>;
> +          color = <LED_COLOR_ID_GREEN>;
> +        };
> +
> +        led@3 {
> +          reg = <3>;
> +          color = <LED_COLOR_ID_BLUE>;
> +        };
> +      };
> +    };
> +  - |
> +    lpg {

nit: should the node be named 'lpg-pwm'?

IIUC a PMIC .dtsi could have both a 'lpg' and a 'lpg-pwm' node, even though
only one of them can be enabled at any time.

> +      compatible = "qcom,pm8916-pwm";
> +      #pwm-cells = <2>;
> +    };
