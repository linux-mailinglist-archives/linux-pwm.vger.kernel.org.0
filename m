Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6337573BAB1
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Jun 2023 16:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjFWOv7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 23 Jun 2023 10:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbjFWOvy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 23 Jun 2023 10:51:54 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8061D2
        for <linux-pwm@vger.kernel.org>; Fri, 23 Jun 2023 07:51:53 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f9002a1a39so8173955e9.2
        for <linux-pwm@vger.kernel.org>; Fri, 23 Jun 2023 07:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687531912; x=1690123912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ViquPjhH1N3je1UsslpC1YcsHiBgdV94QpP/Uq4EN6c=;
        b=VeOIvv1VwHaZZ7rz8gSvtHIrD3X83U1HPXSZG4BYORVUG9R6zCqv+K5EPd+LyHsTvp
         zug8rDJvuoMupQF3HAAVnTtdI/UOlJ3PIjjoMGJ39N11NlfjerD+zaCic0CrLuAEcT4f
         n+bU1sstAwtKwlYaqfNpuPCmurFC/yM3yi1PNwGeFGrky1TvPSo+IE5fQ/DLn1PCbhc4
         qmLvUaGzajRNcSbBRsGPvfE550FLpvspDSh057b3kBBv7twpxwSgCYPdeA4+vODx86sk
         G2lF9PPzkodf0x9QbV81CZRI7+rCxboubERmEpgy+LZphAR/j6c5tz4co54cD/OLpAeR
         fwpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687531912; x=1690123912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ViquPjhH1N3je1UsslpC1YcsHiBgdV94QpP/Uq4EN6c=;
        b=jcSkMZxVXTAxlQqK+cjJHPERdkis+5sp4rJUTG+AGfGPxJDCahZsHVLztUXg1vAbvT
         9WP7P3a1yon5qt8pmrewKXNLiKhlNblMGX4QaApOC9VdEIwbCeC2cyGdJ9uJYchvvMKt
         ezG4WfbiUKssANvKpiKdvYLcWvBJjTkpZQS0fbyBSfcgMYgUwiqsV3OnthQYEMcjrRt+
         S2MdYNUa9D3DXpwUpgYiVNF2e+SY09ASkYdiuk41Tg7tcb5KxSCffxfI+w2a17/pwtcK
         xY5THJ6ePOCG30cpG+D628YTeW2HOxI+lHDEFWejqb4b57UeEnMmY1mxvrMY82KSMfq2
         hjow==
X-Gm-Message-State: AC+VfDxiWvki38kPByf3fL7vtM9YXW/w/lLk9I1h/YTqZRGXcadeT+tu
        MvpV6iPZ5JA259yXRpmdOc4=
X-Google-Smtp-Source: ACHHUZ6f+5xuDTZEg0/tJxV9Y848iMRoZYg1E35qIhp671SIzvA/yhVHgpmJdLO8t73zzy/hxs6Auw==
X-Received: by 2002:a1c:f718:0:b0:3f5:1728:bde9 with SMTP id v24-20020a1cf718000000b003f51728bde9mr4357732wmh.2.1687531912115;
        Fri, 23 Jun 2023 07:51:52 -0700 (PDT)
Received: from localhost (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id m21-20020a7bca55000000b003f4248dcfcbsm2552540wml.30.2023.06.23.07.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:51:51 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-pwm@vger.kernel.org,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: Re: [PATCH v5 0/6] pwm: meson: make full use of common clock framework
Date:   Fri, 23 Jun 2023 16:51:35 +0200
Message-ID: <168753171964.1191890.9331410157279790777.b4-ty@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <aa498590-261c-4ada-63ff-8d7aaeec0932@gmail.com>
References: <aa498590-261c-4ada-63ff-8d7aaeec0932@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


On Wed, 24 May 2023 21:45:55 +0200, Heiner Kallweit wrote:
> Newer versions of the PWM block use a core clock with external mux,
> divider, and gate. These components either don't exist any longer in
> the PWM block, or they are bypassed.
> To minimize needed changes for supporting the new version, the internal
> divider and gate should be handled by CCF too.
> 
> I didn't see a good way to split the patch, therefore it's somewhat
> bigger. What it does:
> 
> [...]

Applied, thanks!

[1/6] pwm: meson: modify and simplify calculation in meson_pwm_get_state
      commit: 6b9352f3f8a1a35faf0efc1ad1807ee303467796
[2/6] pwm: meson: fix handling of period/duty if greater than UINT_MAX
      commit: 87a2cbf02d7701255f9fcca7e5bd864a7bb397cf
[3/6] pwm: meson: remove not needed check in meson_pwm_calc
      commit: bafa23b6c07caac63a9637e83a605c26771b43ee
[4/6] pwm: meson: switch to using struct clk_parent_data for mux parents
      commit: ed73300326ec67d2a0c35fb7f911314cc6d7d918
[5/6] pwm: meson: don't use hdmi/video clock as mux parent
      commit: 3bddf73285d578a1798189e0eed2e7f82ebf0e11
[6/6] pwm: meson: make full use of common clock framework
      commit: 329db102a26da0ba876974dbe04308d08acfad94

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
