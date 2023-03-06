Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D7A6AB991
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Mar 2023 10:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjCFJTy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 6 Mar 2023 04:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjCFJTs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Mar 2023 04:19:48 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36C91E5CF
        for <linux-pwm@vger.kernel.org>; Mon,  6 Mar 2023 01:19:46 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id bx12so8001356wrb.11
        for <linux-pwm@vger.kernel.org>; Mon, 06 Mar 2023 01:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678094385;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTmNLGYu5Mcu9P2jNHBIhC8Wi04M9rJBLk23XMtTHVY=;
        b=CmkBs+vWBlDaCqs84t52YAjZMnusZpu95a2vLlP42QmVjEgTR2gS56anHe4kAmzUxa
         7wfejXFKjA1tstajkNkVzhvJoLwT4xHqmPqazFwbEq6rkWW+R7ZRaHKNNWlJDLc7Qt8u
         9U8wHQybDDyDDj981o37ScOd7XKI/l1cluI1kjMOoGPscG4r6sa+8E++vz1bEcZGd3KE
         nympXTGHNVAbkptz4Z6vU4fiNEgegs1632HCTLz+wD7mH6XGc/Mh3WHDzNGi2vkCl6mL
         Kmq/skKEqbwc+0yTNwlbra0ZophJnPDiuArflOcXqOJC13Ss3GVEo7t0RZqwqSTf0ZvG
         C9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678094385;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTmNLGYu5Mcu9P2jNHBIhC8Wi04M9rJBLk23XMtTHVY=;
        b=SXaT8ivetcXW1cjgJ0Kaev1O3wp0SbPTQyu5VUkY08JpQQSgnMq6m54+OiRLzUL898
         +5aqedLQTCw63oYe8A02eaEu1Yv479WQ+mIIPMDEGKzEx+uK8xWCC1zaTwrClQMYoBZj
         z8IAec9zeInfcW/EE/ECfkUBr07rmcdJl0brt0nJz2uze/z8nUaQXMmwNiddRXCqy9tZ
         YtpYeIHdrinvssNByC6frWJ5a6IqHGIHIgXB1Ht9jmc7YvH8/I6ay+msVKry+jVewUod
         RaugrVa5wRZllEaO3gkdh+ZC1YRa6WW0pZZ3Y3/8GEn8dONeHa6PPEOejTN8QSQrbjcU
         HW2w==
X-Gm-Message-State: AO0yUKUjwUwz8MfPt2NSRZs7i8FaOmhurRJRk9KCvV8DQBM33ICiSj48
        ZUTBbsjh7JIl5zvb62ye9/OICg==
X-Google-Smtp-Source: AK7set8LhmIS/Ewr0ABinGsnVv0gYSTQkOzX04VwMgU2SuXX1uxXZJQqh0ye5JCeOBKU0KFVlm1N+w==
X-Received: by 2002:adf:e908:0:b0:2c3:e0a0:93f with SMTP id f8-20020adfe908000000b002c3e0a0093fmr6170846wrm.8.1678094385375;
        Mon, 06 Mar 2023 01:19:45 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id k11-20020a5d628b000000b002c707b336c9sm9151304wru.36.2023.03.06.01.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 01:19:45 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     devicetree@vger.kernel.org,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org
In-Reply-To: <8df4ceec-663c-dc68-d775-5caeb02c0cca@gmail.com>
References: <8df4ceec-663c-dc68-d775-5caeb02c0cca@gmail.com>
Subject: Re: (subset) [PATCH 0/4] soc: amlogic: switch bindings to yaml and
 adjust some dtbs's
Message-Id: <167809438458.62434.12865612944830154623.b4-ty@linaro.org>
Date:   Mon, 06 Mar 2023 10:19:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On Wed, 01 Feb 2023 20:57:48 +0100, Heiner Kallweit wrote:
> Switch two Amlogic Meson bindings to yaml. As prerequisite adjust the
> order of some compatibles first.
> 
> New versions of the bindings have been submitted as individual
> patches in between. Put it into a series again.
> 
> Heiner Kallweit (4):
>   arm: dts: meson: adjust order of some compatibles
>   arm64: dts: meson: adjust order of some compatibles
>   dt-bindings: pwm: Convert Amlogic Meson PWM binding
>   dt-bindings: interrupt-controller: Convert Amlogic Meson GPIO
>     interrupt controller binding
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.4/arm64-dt)

[2/4] arm64: dts: meson: adjust order of some compatibles
      https://git.kernel.org/amlogic/c/4dcc844c99d3e47820f574911b495b58f7da1d94

These changes has been applied on the intermediate git tree [1].

The v6.4/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
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

