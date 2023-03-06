Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C336AB999
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Mar 2023 10:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjCFJV1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 6 Mar 2023 04:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjCFJVY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Mar 2023 04:21:24 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378AA222DA
        for <linux-pwm@vger.kernel.org>; Mon,  6 Mar 2023 01:21:20 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id f11so8025206wrv.8
        for <linux-pwm@vger.kernel.org>; Mon, 06 Mar 2023 01:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678094478;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QTaTg1M82nHPuHpSBS+WU4NCi+YuYDcZym+3+BNoD0=;
        b=hY3zQEkaEFt7L8jf2l7rZVQ3WSnXzuIYX/YnXzeyUdnnkCARe0Ec4S4+mzCPLpmnga
         q1OxpBZ3DldwFuzEN95tjGEbuzVKMOsitKZtGkU3ZU8xSr+LBTGGhazcmsd/c80KJ5c+
         XjYKDAM9Et4UWcA0au7RTZpYuVG7KWUE8LtjsftwbJ/D9fehDjKQEx/W27u5Kv+OP9eB
         Ko2Fofulg2zHSkYhuIAnnfhU8CY87VprzXN9szg0Ni/j+mTWe4sssCc8y7bScULLVaJy
         LFGz5/R77awfacg4KoZIkOFdqkeTzrwAx2lkOuZGbpvqjYRBPpMErMMY9zTNy1sTWh2R
         sGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678094478;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6QTaTg1M82nHPuHpSBS+WU4NCi+YuYDcZym+3+BNoD0=;
        b=xylclSUHkPoNaWyTzJL9ZpCJTjYZ/8cm5AkM9yc2OMFdm8wMxwdktqIL7k7qiAKook
         Fa0LFqBXJRbP0+MVoWC54Ra5TVK803BE1Fy3B37WurorSjWVUMRiVn/koHiM2NTv1ZBM
         X5/GmiJ6uDMkBBefJ4cM+NDS3HXC0lyMIELAYIvlstB4AX54kTrFFgMt0FYf7lnhG4sl
         UcgjMlR286vz2RvOfxuntN4nsC6H4GJ8yDlcrXBLT9vDGsOBL+SEmPpKkspbTPbGJLxf
         oaPhvu22zZDTgR/8/5FClrS/XmCXPY1aSzgIk6rossN44BuHrXRskTToKoaF98WqIx3u
         dqkg==
X-Gm-Message-State: AO0yUKXcS4iuqYbAGgddpz2OeB8GS54Wo4eU6VQtV88bKZb/mX4TCClJ
        8g+aqFkBOjNT4StlGRgiRdNRSQ==
X-Google-Smtp-Source: AK7set9PhQC/LAWuijBZyi1RnO+m0uSLl7osxh+Et8GDOHCxy9UxpG6DiUCb2nJKyQHWzg5n+chgsQ==
X-Received: by 2002:a5d:4a51:0:b0:2c7:778:5da6 with SMTP id v17-20020a5d4a51000000b002c707785da6mr6233079wrs.42.1678094478663;
        Mon, 06 Mar 2023 01:21:18 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id j17-20020adff011000000b002c5a1bd527dsm9235217wro.96.2023.03.06.01.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 01:21:18 -0800 (PST)
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
Message-Id: <167809447788.73638.7893425529034972741.b4-ty@linaro.org>
Date:   Mon, 06 Mar 2023 10:21:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.4/arm-dt)

[1/4] arm: dts: meson: adjust order of some compatibles
      https://git.kernel.org/amlogic/c/0c187cca73291f2c355fae31eed3fc7aa783b2de

These changes has been applied on the intermediate git tree [1].

The v6.4/arm-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
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

