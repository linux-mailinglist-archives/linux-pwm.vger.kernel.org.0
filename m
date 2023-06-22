Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95937398BD
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Jun 2023 09:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjFVH6e (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 22 Jun 2023 03:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjFVH6a (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 22 Jun 2023 03:58:30 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEAF19AB
        for <linux-pwm@vger.kernel.org>; Thu, 22 Jun 2023 00:58:04 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fa23c3e618so7848165e9.0
        for <linux-pwm@vger.kernel.org>; Thu, 22 Jun 2023 00:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687420678; x=1690012678;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qwq75zYUHkn/9Dpk4owisZ27y9W8ALSN2XNSG1RSGjs=;
        b=dXKEfAn4lDYZ779o1lNXaamSP08+9Qa/N283WOsK/wu7YL/LF/JbQ4T7kg63lKab11
         Qs1pt41rnvonUrKzgEGX9eeETVIE21h0zLRAxuP5aDcwg9qIeqQIeZCsPpV3HqO1oaP0
         9TkYNYWSiQ1xh0mhMqnIVs2Hht+p1bG10rA6xribKVc9yV1wdbipjPzYJlJzjy7AzwVe
         +6Si5u5Vxcn1yTNuM6JzjEI6V5uwN5dsirdeR/5TTIKkzy1j+mCv9np3/blvDMz9q+3s
         N6U2u7hltkPIec0fJzSVT4+T14DTJjfGtmvihpa5DM8iMfuZwZcmoHo0DmcwfsKJdDos
         eK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687420678; x=1690012678;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qwq75zYUHkn/9Dpk4owisZ27y9W8ALSN2XNSG1RSGjs=;
        b=bDqP+F3CrzMKYs6qGo3Bu3bXSQC1RxW1T74CwXzACzBgDs8LtCwIttBjqvhkoGcj3l
         dBCujzBbSI5ULHS5vbS0BxRubOGsIJCJCfha8RSC48nA+J/73Ost/cm8uBfvo8v3mzon
         iyLNqlHmg6aBjux/cjEXw535SW4ROavJ2i8tH7Yji2MExbOcZwPqKndWSBzeZrj32zzE
         L9SCeWlrpZ/klqnUUDOcrZPmuFaTI7Brx9EzewvfcW7abzg2j6YHXWF2HD0wfD1uMgSk
         8a1Bo3ysnm5Dec5V5onlhVwYOko/klyrKHgaOxh0Z4NOPbRwVwDhB166HRAAnbFq3zAX
         AkwQ==
X-Gm-Message-State: AC+VfDwCiJSxph6GodMiLOuwnUyhb/Wkftg6CUh9DyOy2Dlep1GeVLv4
        9EtV9+yZnWxBM9XF5pCx+xXFlw==
X-Google-Smtp-Source: ACHHUZ6VU14QJ9KVoogL68Wvs38IfYUvRR09TALogE5vv0xpIYmSyrfNEHbmbTNWSy5LmsqiEO6hIw==
X-Received: by 2002:a7b:c4cc:0:b0:3f8:fed0:1c56 with SMTP id g12-20020a7bc4cc000000b003f8fed01c56mr13170797wmk.23.1687420678124;
        Thu, 22 Jun 2023 00:57:58 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id u23-20020a05600c00d700b003f78fd2cf5esm7000683wmm.40.2023.06.22.00.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 00:57:57 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-pwm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-gpio@vger.kernel.org
In-Reply-To: <cb62dfc0-cb3d-beba-6d0b-8db18583dda0@gmail.com>
References: <cb62dfc0-cb3d-beba-6d0b-8db18583dda0@gmail.com>
Subject: Re: [PATCH 0/8] soc: amlogic: switch bindings to yaml and adjust
 some dtbs's
Message-Id: <168742067695.2178283.8048572430137764480.b4-ty@linaro.org>
Date:   Thu, 22 Jun 2023 09:57:56 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On Mon, 23 Jan 2023 22:22:15 +0100, Heiner Kallweit wrote:
> At first adjust some existing dtbs's so that they pass dtbs_check
> after switching bindings to yaml.
> 
> Then switch further Amlogic Meson bindings to yaml.
> Tested with make targets dt_binding_check and dtbs_check.
> 
> Heiner Kallweit (8):
>   arm64: dts: meson-gx: Remove invalid pwm compatible
>   arm64: dts: amlogic: Fix non-compliant SD/SDIO node names
>   arm64: dts: meson-gx: Set only one compatible string for mmc
>   arm64: dts: amlogic: Remove invalid compatible string
>     amlogic,meson-gpio-intc
>   dt-bindings: rtc: Add Amlogic Meson vrtc controller binding
>   dt-bindings: pwm: Add Amlogic Meson PWM binding
>   dt-bindings: interrupt-controller: Add Amlogic Meson GPIO interrupt
>     controller binding
>   dt-bindings: pinctrl: Add Amlogic Meson pinctrl binding
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.5/drivers)

[1/1] dt-bindings: interrupt-controller: Convert Amlogic Meson GPIO interrupt controller binding
      https://git.kernel.org/amlogic/c/6b0139b372d40bd5dafc140b6618b57d13211168

These changes has been applied on the intermediate git tree [1].

The v6.5/drivers branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil

