Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7232E7EB352
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Nov 2023 16:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjKNPUM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Nov 2023 10:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbjKNPUL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Nov 2023 10:20:11 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DEA127
        for <linux-pwm@vger.kernel.org>; Tue, 14 Nov 2023 07:20:07 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-41cbf31da84so32749301cf.0
        for <linux-pwm@vger.kernel.org>; Tue, 14 Nov 2023 07:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699975206; x=1700580006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BA7pnPzeobuo2moOM/02mtG2pcefll8ayuxU3397aJs=;
        b=MgnRI5Ag/42cLoXqHTUyAhohy8qDN/vsVTkTJ5AaNpYwtO2CWBUqG92JT2nPrpAxTJ
         Uxm7GGwaVaQE9sWVp7n6HVtAKQ3MbWk4NoKgwEt9JILoFJoq0dKkt/JL6zRkDbvWDmmj
         yVVDD+f8IQbEfClG3PQWU1muNEWGKEI6VI9u6YCq3M3QT88kJaHJo1uxM3HS5fwW/9Xy
         7Swp9XbB1r9TsLW6YYooGlGZKUxC/9AAHfhyg0N7FMiuYzOekroeuZ4sdUrX17DFmCod
         nd8h3S2U+GhYPr/1al4N2CmhiOmRP9cwgNHyxELN3CGr8d1dbNpw1zVV2E2zEg17M5b/
         RL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699975206; x=1700580006;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BA7pnPzeobuo2moOM/02mtG2pcefll8ayuxU3397aJs=;
        b=Su+OlRzvrtP3od28HMo6WlxkeOKuBg6KWl+pFaW342c51p0sawEeONSzGLi/VfkQAx
         e14iGk2LT7AO5iVYuHqHBlMICoWNrMa+KHValj8o2cIm+NgfsYa0wo/O67MGQ+eVhjWw
         RvT4bCHEts+4I4bM5UgvjtYZAEdpDHzJrUlfUq740SVD+zNhLDE2gjjok+iJVPKSAdgH
         Bklza5yq5Htf36uvROfIodEyIXZEs3b6z9eMnWpJg1C+yPcatthEvl8IMG20BBy5VsUK
         IzoZ3StZST9cgPU7VrKZLasNjmixh823oOxz7HWLfv2iaa5hLy0r/4bSoO1kmLK0S2FC
         37Ww==
X-Gm-Message-State: AOJu0YwsiRTF0qZIM0hHaC2bGQkRn84ruHuo6bc1ULoq5Fx65mTH06kT
        7o8NYFccmHmIlhokEun2923a1Q==
X-Google-Smtp-Source: AGHT+IEadI/6/GH9NIUFNMeCr9T6NLwUprWeQImT3ovdsHFRg8kMWXk2T9gPr4vx6eENhu9WMgNH1g==
X-Received: by 2002:a05:622a:105:b0:41e:19d5:bdf5 with SMTP id u5-20020a05622a010500b0041e19d5bdf5mr2279660qtw.48.1699975206381;
        Tue, 14 Nov 2023 07:20:06 -0800 (PST)
Received: from [127.0.1.1] ([12.186.190.2])
        by smtp.gmail.com with ESMTPSA id l24-20020ac848d8000000b00419732075b4sm2806318qtr.84.2023.11.14.07.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 07:20:05 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lee Jones <lee@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231108104343.24192-1-krzysztof.kozlowski@linaro.org>
References: <20231108104343.24192-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 00/17] dt-bindings: samsung: add specific compatibles
 for existing SoC
Message-Id: <169997520487.6747.17671551558724027958.b4-ty@linaro.org>
Date:   Tue, 14 Nov 2023 16:20:04 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


On Wed, 08 Nov 2023 11:43:26 +0100, Krzysztof Kozlowski wrote:
> Merging
> =======
> I propose to take entire patchset through my tree (Samsung SoC), because:
> 1. Next cycle two new SoCs will be coming (Google GS101 and ExynosAutov920), so
>    they will touch the same lines in some of the DT bindings (not all, though).
>    It is reasonable for me to take the bindings for the new SoCs, to have clean
>    `make dtbs_check` on the new DTS.
> 2. Having it together helps me to have clean `make dtbs_check` within my tree
>    on the existing DTS.
> 3. No drivers are affected by this change.
> 4. I plan to do the same for Tesla FSD and Exynos ARM32 SoCs, thus expect
>    follow up patchsets.
> 
> [...]

Applied, thanks!

[01/17] dt-bindings: hwinfo: samsung,exynos-chipid: add specific compatibles for existing SoC
        https://git.kernel.org/krzk/linux/c/4be756fd983a0d91c258196b3206e9131e63d62d
[02/17] dt-bindings: i2c: exynos5: add specific compatibles for existing SoC
        https://git.kernel.org/krzk/linux/c/9da80ed69eb150617e8c72aeb7fdb9bfc7b97fba
[03/17] dt-bindings: i2c: samsung,s3c2410-i2c: add specific compatibles for existing SoC
        https://git.kernel.org/krzk/linux/c/c45860f6ee9b52b2e2f9b9255d93b9875e416cb0
[04/17] dt-bindings: mmc: samsung,exynos-dw-mshc: add specific compatibles for existing SoC
        https://git.kernel.org/krzk/linux/c/5faf7e3d35b819cfa8de971f7e8ed84552c3a676
[05/17] dt-bindings: pinctrl: samsung: add specific compatibles for existing SoC
        https://git.kernel.org/krzk/linux/c/3e17c66d1aa322db1d68e842089bd639a88a88bf
[06/17] dt-bindings: rtc: s3c-rtc: add specific compatibles for existing SoC
        https://git.kernel.org/krzk/linux/c/b8029fbe90351d1fdd54dceb39b21c4062c94ce1
[07/17] dt-bindings: serial: samsung: add specific compatibles for existing SoC
        https://git.kernel.org/krzk/linux/c/6f52f8b78d319ba63ce7fae950d9395d376bb6bf
[08/17] dt-bindings: samsung: exynos-pmu: add specific compatibles for existing SoC
        https://git.kernel.org/krzk/linux/c/ed856d66b8c679ec1260c3151b2f4f3202aa213b
[09/17] dt-bindings: gpu: arm,mali-midgard: add specific compatibles for existing Exynos SoC
        https://git.kernel.org/krzk/linux/c/e47d571301460a214c6253c15ff79db20ea50389
[10/17] dt-bindings: iio: samsung,exynos-adc: add specific compatibles for existing SoC
        https://git.kernel.org/krzk/linux/c/bbe4d4bbacd7f11b601a0c912f3f6270558899d8
[11/17] ASoC: dt-bindings: samsung-i2s: add specific compatibles for existing SoC
        https://git.kernel.org/krzk/linux/c/4a559c3db839afea05dc0f471823d4401b4444fc
[12/17] dt-bindings: pwm: samsung: add specific compatibles for existing SoC
        https://git.kernel.org/krzk/linux/c/0b549b3f74e39f7b0e787f8ffdfd2cf67c0fdc4b
[13/17] arm64: dts: exynos5433: add specific compatibles to several blocks
        https://git.kernel.org/krzk/linux/c/e9a72a20acf7b620e48cd4e268d7c7a4d45e1930
[14/17] arm64: dts: exynos7: add specific compatibles to several blocks
        https://git.kernel.org/krzk/linux/c/a1c0d44441d35063b79f38120105b5f92ca40445
[15/17] arm64: dts: exynos7885: add specific compatibles to several blocks
        https://git.kernel.org/krzk/linux/c/050e7f7217e4d4d73dfcebfbc35b3eafbc36272a
[16/17] arm64: dts: exynos850: add specific compatibles to several blocks
        https://git.kernel.org/krzk/linux/c/bd3623def8a93cea94a8689514e557fd4522dd53
[17/17] arm64: dts: exynosautov9: add specific compatibles to several blocks
        https://git.kernel.org/krzk/linux/c/2a8ff4d56ef6cb4a7b2b4025ea4366178e4e8eaf

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

