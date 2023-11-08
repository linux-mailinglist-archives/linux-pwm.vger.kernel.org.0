Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267E77E53FC
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Nov 2023 11:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344576AbjKHKpH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 8 Nov 2023 05:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344586AbjKHKoo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 8 Nov 2023 05:44:44 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D2D1FFA
        for <linux-pwm@vger.kernel.org>; Wed,  8 Nov 2023 02:44:19 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40859c466efso48582365e9.3
        for <linux-pwm@vger.kernel.org>; Wed, 08 Nov 2023 02:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699440258; x=1700045058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TGrUPXldQQyi7i1y6HTuSgGxtg81Z3Wiq2G+ebaMhpQ=;
        b=RRyZ2DsumWDob59sxIhP4NZ0+PB9uqb9zZOUEOANQYdG++ZFy2VRMKtljHlKQz2N/b
         FWyNXAM90moRZUT9eT6+Uv5TbS7CPe9q7c3KOcLjxxzOBrfyWbaAqMDtmXsDpoRHWolZ
         nNHIs3XfkQeqER0jUAusgARPrNPvSZ/cIxQT0M4y9KHtLyq8xxD2j4XSRCPRHVhLgkDT
         fUZhaESpUcxCaH3amqo7JEmuqdlsvW/u71otvwXtUgpq/xDNfHn69aF7IovJ39IZgWy+
         /UUa+J1L1aoAxKISj9Ttf0SEkrQTTFoRgxfETPWH1CVy5Tys9WnF6BKIBEH3NY2qfdRo
         IwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699440258; x=1700045058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TGrUPXldQQyi7i1y6HTuSgGxtg81Z3Wiq2G+ebaMhpQ=;
        b=ku6qLLLPrmIRcl0/bLsv0oeU8h8+Nj4PHAc1PibVxxKWK55CYrWNB9VGESYJxvXc9f
         I41IKpo3Ur1TE76xD3mpSnZ+0SyHpuUvgqF5R9I/zO2BzlZJ+4pyH+LVI/rQzW5OrjjE
         sWSWzpjyHIn+vhpSQj05Hew8Gog1n7ClwFfXM2Mla6x2F+UtM93tizY/Etfohozexr/3
         oxhML27OCNsVC1QWGfWXGiaDQ5b8lqMyfZGG9x0bC7I5ipBMLxYHOLJK4K0vPY/MsoHw
         lWcqBGzxFL9yf+HwIK3REe0IcPxu6g771euSA9LDBdgRfnmtVSQC7TQHeTOFpbScR7ko
         EtUg==
X-Gm-Message-State: AOJu0YxOWlaa6ztctwoP62GOyhoDC41kql5P0D9OCgrsN2+PtkXC6Osb
        J4MyPZs3fyvA4hO9t+8j1Sy78w==
X-Google-Smtp-Source: AGHT+IGzkWzdSSfC10gvMcrdr+HWpovdFD2tWKhVyooAAzLg7iLljfH0hHjLNTv+Bpu3NP726JCxaA==
X-Received: by 2002:a05:600c:3553:b0:406:c6de:2bea with SMTP id i19-20020a05600c355300b00406c6de2beamr1367091wmq.17.1699440257975;
        Wed, 08 Nov 2023 02:44:17 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id fj12-20020a05600c0c8c00b004094c5d92bdsm19377377wmb.31.2023.11.08.02.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 02:44:17 -0800 (PST)
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
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
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
        alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 06/17] dt-bindings: rtc: s3c-rtc: add specific compatibles for existing SoC
Date:   Wed,  8 Nov 2023 11:43:32 +0100
Message-Id: <20231108104343.24192-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231108104343.24192-1-krzysztof.kozlowski@linaro.org>
References: <20231108104343.24192-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Samsung Exynos SoC reuses several devices from older designs, thus
historically we kept the old (block's) compatible only.  This works fine
and there is no bug here, however guidelines expressed in
Documentation/devicetree/bindings/writing-bindings.rst state that:
1. Compatibles should be specific.
2. We should add new compatibles in case of bugs or features.

Add compatibles specific to each SoC in front of all old-SoC-like
compatibles.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

I propose to take the patch through Samsung SoC (me). See cover letter
for explanation.
---
 Documentation/devicetree/bindings/rtc/s3c-rtc.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/s3c-rtc.yaml b/Documentation/devicetree/bindings/rtc/s3c-rtc.yaml
index d51b236939bf..bf4e11d6dffb 100644
--- a/Documentation/devicetree/bindings/rtc/s3c-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/s3c-rtc.yaml
@@ -17,6 +17,11 @@ properties:
           - samsung,s3c2416-rtc
           - samsung,s3c2443-rtc
           - samsung,s3c6410-rtc
+      - items:
+          - enum:
+              - samsung,exynos7-rtc
+              - samsung,exynos850-rtc
+          - const: samsung,s3c6410-rtc
       - const: samsung,exynos3250-rtc
         deprecated: true
 
-- 
2.34.1

