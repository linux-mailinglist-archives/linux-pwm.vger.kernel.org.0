Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0382C611E2B
	for <lists+linux-pwm@lfdr.de>; Sat, 29 Oct 2022 01:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiJ1Xdl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Oct 2022 19:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJ1Xdj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Oct 2022 19:33:39 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B8818DD40
        for <linux-pwm@vger.kernel.org>; Fri, 28 Oct 2022 16:33:37 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id ay12so3805554qtb.12
        for <linux-pwm@vger.kernel.org>; Fri, 28 Oct 2022 16:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cdgQWivqc/wtv7MeOYBq5nbthM38lmIcxzkv6fflFzw=;
        b=D8Vq1fnMiuhXplh54X3Q37MnOKLI+FdU0o8Z3MD9PJ0KmCEeqpcT8yHPI82qFwqv1j
         +CkB+VxBrE0oM4j781atvz6/I4wmoxMW/49idjbiqXYZEJwNNT2J6sjajkJWwdmEqgVR
         +/dgAHieTJ/vc8b7+L4WlTb5g5c8PWuEh5cPeC82JMncqdDYu8eYGZTQG8zLi5WVd8Ny
         AyNRojL8vbbDboq3yvHplt3Zh5A4Vf3kF1blj73wP3rcYbipOq0zsnU8Fe4KXaIJXOy2
         ljWBYU8JMWV5M4OGyssimTFhu+eCy7qAow9xLtw3HPdHPcQc4ja1XaQ3/M5upf6+JwWC
         m3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cdgQWivqc/wtv7MeOYBq5nbthM38lmIcxzkv6fflFzw=;
        b=lL7KBtYhoAf7XJvDMA6WxysWpU4JjJNA5h3PFDDvsQLiEEBcZWO84ifVRFNA0Bq+Sv
         EREufDKo767SYoe2eTNFaKLBTEyabz8KfGFoUFLimKBWKoGjZRPMbgOGYt2lHUbc3F3F
         AOxg3KVdnBt/iKPuUgVTGfITon7kSQLYkwAvVy8KJ10Jv/WLqQcJSH4BjAYJHXS8tBTs
         OS1eOFZJ4jY6YxEGWnurSOV/dh6o/qiL15zCK3z7lRFbfGeIJlDL3OwGcR5iLc8g0LaB
         eKdsvXbFsh6dsUS5DwbTT41Ly7HjCVDntfFJmsCmLbK5JoQneZqvAzEkS73pd7pejyer
         d2ag==
X-Gm-Message-State: ACrzQf0w8IjjaeUOW5S9SL/abzy9+25T5zH8cVlPj5jUpmS2sa6j9b0i
        PlTr4LQrknlncKezxkO8HBRMnQ==
X-Google-Smtp-Source: AMsMyM7revH3T4kZO5bhmDCcRcQKi0hDm3vR9OSiNEl9087Ty/6RpunyVzF/p1hSEwBgJ2wyqU1kEA==
X-Received: by 2002:a05:622a:307:b0:39c:ddcf:f563 with SMTP id q7-20020a05622a030700b0039cddcff563mr1695305qtw.563.1667000016976;
        Fri, 28 Oct 2022 16:33:36 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id 17-20020a05620a071100b006fa11a057f4sm11262qkc.68.2022.10.28.16.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 16:33:36 -0700 (PDT)
Message-ID: <79b817ec-90bd-b5f5-0d66-d6f9f9ceb37b@linaro.org>
Date:   Fri, 28 Oct 2022 19:33:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 1/5] dt-bindings: pwm: Add Mstar MSC313e PWM devicetree
 bindings documentation
Content-Language: en-US
To:     Romain Perier <romain.perier@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220907131241.31941-1-romain.perier@gmail.com>
 <20220907131241.31941-2-romain.perier@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220907131241.31941-2-romain.perier@gmail.com>
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

On 07/09/2022 09:12, Romain Perier wrote:
> This adds the documentation for the devicetree bindings of the Mstar
> MSC313e PWM driver, it includes MSC313e SoCs and SSD20xd.
> 
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> ---
>  .../bindings/pwm/mstar,msc313e-pwm.yaml       | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/mstar,msc313e-pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/mstar,msc313e-pwm.yaml b/Documentation/devicetree/bindings/pwm/mstar,msc313e-pwm.yaml
> new file mode 100644
> index 000000000000..07f3f576f21b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/mstar,msc313e-pwm.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/mstar,msc313e-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mstar MSC313e PWM controller
> +
> +allOf:
> +  - $ref: "pwm.yaml#"
> +
> +maintainers:
> +  - Daniel Palmer <daniel@0x0f.com>
> +  - Romain Perier <romain.perier@gmail.com>
> +
> +properties:
> +  compatible:
> +    items:

Drop items, you have only one item.

Would be nice if you used Linux tools for getting list of people to Cc...

Best regards,
Krzysztof

