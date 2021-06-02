Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29604399626
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Jun 2021 01:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhFBXHw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Jun 2021 19:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhFBXHw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Jun 2021 19:07:52 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF3DC06174A
        for <linux-pwm@vger.kernel.org>; Wed,  2 Jun 2021 16:05:55 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id v19-20020a0568301413b0290304f00e3d88so4003329otp.4
        for <linux-pwm@vger.kernel.org>; Wed, 02 Jun 2021 16:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=01Hagr0rlb03xkE9a3oTGw76oR0aQexaO5aG/02aCB4=;
        b=Wab2V42HgyG6YvnYjDfObRMTpUq54/FpFMvvpT+0wP6ICyDk4x+cQIfhRBklOga6wc
         ZL0R67ZCLhERbhyuwTzYg3c5pTIjZYhS8c+SVvNUVQr9sgmTphZnOrWci2bmdI29YgUL
         QxLkjuCn9Dqr2RC8ie0c9Ou9nmmxGLKZtfLfAYHJdOsHNIEMzPyw3Hold94dCxvU1I4f
         hkTn9Lv1rQl645l9hSEpP0ocnhED/xBz/LeQc1qlY+ARoZjZyHgcSuEaaH+5L//Bsr5Y
         o71B/XPIjwbh8dCXUlSyzJTH6yHXVNiR9k2wA8C/SKAOy1wQnZCLi7r2vPjLc7iWAA2c
         4xcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=01Hagr0rlb03xkE9a3oTGw76oR0aQexaO5aG/02aCB4=;
        b=J38I4M8wnv1Kdv9chGpgOf8dFjVd+3N2x+vX5Asy5WIXeIZLJqhhQyDDmD9IlNzDsx
         kuqMRj4nmWOemN1U1z2SldbbMoodJfcqczd8PGIxmufNzrShMlmbRKWj+2mVXGnWlV2Q
         QBrZh9oUbbRaRHLrlSG26nHLKg0/emO9vlnWDe4AbMoQAgWeIyHZkrHLSxesXuQloYAU
         8ksZu6kN7h7G52OQdIzBLwFNaCkn0eo1K8uslsbBEJBL+uVddYzVht/c5dWl4TVJ9oaW
         o65MzWEpex0OBFkG+UNeOrAz+I51BwtQfhW545DDAku0AbfhKCxQO74oiKnME5MJxKdY
         JHfg==
X-Gm-Message-State: AOAM531DcPo0GIyMcyQiYVQOGqNkurM6Uq6dl0PunrYqW4ZLVVk1B46o
        Lf2hrCVJc6HSDYaQD16dWrVQqw==
X-Google-Smtp-Source: ABdhPJwkXDuDdU2nXIPKkgGdIzDgav85nX1ZhJns9Ee4N2N7+7xTNnkPC3zCqg/aC3h88B1WaWtj8Q==
X-Received: by 2002:a05:6830:1d0:: with SMTP id r16mr3470023ota.116.1622675155259;
        Wed, 02 Jun 2021 16:05:55 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id n11sm286681ooo.12.2021.06.02.16.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 16:05:54 -0700 (PDT)
Date:   Wed, 2 Jun 2021 18:05:52 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Baruch Siach <baruch@tkos.co.il>, Rob Herring <robh+dt@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Robert Marko <robert.marko@sartura.hr>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] dt-bindings: pwm: add IPQ6018 binding
Message-ID: <YLgO0Aj1d4w9EcPv@yoga>
References: <ea071bbcab92d4a296c7aee5d72de0427676847a.1621851644.git.baruch@tkos.co.il>
 <249bddc521b15e992d0846edf1813aeb577458b9.1621851644.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <249bddc521b15e992d0846edf1813aeb577458b9.1621851644.git.baruch@tkos.co.il>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon 24 May 05:20 CDT 2021, Baruch Siach wrote:

> DT binding for the PWM block in Qualcomm IPQ6018 SoC.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> v2: Make #pwm-cells const (Rob Herring)
> ---
>  .../devicetree/bindings/pwm/ipq-pwm.yaml      | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/ipq-pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/ipq-pwm.yaml b/Documentation/devicetree/bindings/pwm/ipq-pwm.yaml
> new file mode 100644
> index 000000000000..f85ce808a14e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/ipq-pwm.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/ipq-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm IPQ6018 PWM controller
> +
> +maintainers:
> +  - Baruch Siach <baruch@tkos.co.il>
> +
> +properties:
> +  "#pwm-cells":
> +    const: 2
> +
> +  compatible:
> +    const: qcom,pwm-ipq6018
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: core
> +
> +required:
> +  - "#pwm-cells"
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,gcc-ipq6018.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pwm@1941010 {
> +            #pwm-cells = <2>;
> +            compatible = "qcom,pwm-ipq6018";
> +            reg = <0x0 0x1941010 0x0 0x20>;

These 32 bytes are in the middle of the TCSR block, which is already
partially described by the &tcsr_q6 node, which is described as only
compatible = "syscon" - something no longer accepted by the DT
maintainers.

As such, I think we should adjust the &tcsr_q6 definition to cover the
entire TCSR: 0x01937000 of size 0x21000.


@Rob, should we represent the entire tcsr as a simple-mfd and then have
the pwm and q6 region as children of that? Or can we make the whole
thing as a simple-mfd and a syscon and only describe the pwm as a child?

Regards,
Bjorn

> +            clocks = <&gcc GCC_ADSS_PWM_CLK>;
> +            clock-names = "core";
> +        };
> +    };
> -- 
> 2.30.2
> 
