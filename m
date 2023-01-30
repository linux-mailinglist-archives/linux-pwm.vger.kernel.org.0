Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C523768099C
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jan 2023 10:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236243AbjA3Jes (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Jan 2023 04:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236229AbjA3JeQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Jan 2023 04:34:16 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF818A76
        for <linux-pwm@vger.kernel.org>; Mon, 30 Jan 2023 01:32:54 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id o13so10553926pjg.2
        for <linux-pwm@vger.kernel.org>; Mon, 30 Jan 2023 01:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxtYcVhJhYnmw9Kyf/CwQWgviswE64iGZP+l2Z32zUU=;
        b=WfpSpboUezsAyUDDVV9MgUHTxwU1B6vz4v5+gIu7omiVgcRS+MZhIWZsnhesnBobkJ
         FuricfmatL/tBgUO2Ox5jovBrabUbuVFkruA6tDgzTFQg8NdpfM1PA/DXKnbJhaaakHI
         UetQVLgUSxAPkniq7vGNYBLuRL/k9EnltcV5QBnMJgmh+6y3YuHI2HDK2tO2cQFuJKu1
         cy34U3MGwmpRhajU5owIL9mqSuUSM6w1F3wRuOzqU7r+M/Nf66ZWml5iRBZ7ttNvwCBl
         HqdqkfNfe4oBmhzr0Q895sfoVszPUVnwcg2WRU1LSP9N1QpyFifC6WgQ5fm4pizh9PJA
         QCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nxtYcVhJhYnmw9Kyf/CwQWgviswE64iGZP+l2Z32zUU=;
        b=gRf1TnXaXeys5/+Tipi7FOL3d+jG7Wls4nmQTI+H4hMmeSxPyfkuXx/QqsLFTI80WN
         bbZSV+PJ+C/AuC6uPmQFWbDdpSO5qFpIFk5WF1sdDMSEax9xyNkzqAiHswAUNjMZ/YzU
         3mc76ZbwcaCyclhT8Iz3eSuAEAgVQ88GYlrXtfLSzGVrEUAlTczBc5qjxaEAP3XbXAZp
         IQTPRTLTcZOBoPnUl2BZIjMx7KdHmOtSyKuk5TywfA2YHlIsP5pSs69OUi2UQvAaxLQh
         FqT3I6Fpfpo/OIwqfDRuE+l/mW/F0XAbVV8/NCJujpTXMNcoVFdcwGZkd6/wWpMKlP+k
         R7Iw==
X-Gm-Message-State: AO0yUKXb4ipnLRqpa1rmcssSx1yhTorJhV2wnGA9wfa8K9OBcVkkVl0R
        WZr/W0F2OeuSSZ58C+PKFL/DLA==
X-Google-Smtp-Source: AK7set+sqas1TmEZGyot0yhlXSSwa3Kkzex+Yml58yVBreADNUkvzMVeVh4R0UHw2PdTkO1Dvv9mIA==
X-Received: by 2002:a05:6a20:1592:b0:be:9249:236c with SMTP id h18-20020a056a20159200b000be9249236cmr1679774pzj.35.1675071160436;
        Mon, 30 Jan 2023 01:32:40 -0800 (PST)
Received: from hsinchu15.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id t13-20020a6564cd000000b004db2b310f95sm6245704pgv.16.2023.01.30.01.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 01:32:40 -0800 (PST)
From:   Nylon Chen <nylon.chen@sifive.com>
To:     aou@eecs.berkeley.edu, conor@kernel.org,
        emil.renner.berthing@canonical.com, geert+renesas@glider.be,
        heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     nylon.chen@sifive.com, nylon7717@gmail.com, zong.li@sifive.com,
        greentime.hu@sifive.com, vincent.chen@sifive.com
Subject: [PATCH v2 1/2] riscv: dts: sifive: unleashed/unmatched: Remove PWM controlled LED's active-low properties
Date:   Mon, 30 Jan 2023 17:32:28 +0800
Message-Id: <20230130093229.27489-2-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230130093229.27489-1-nylon.chen@sifive.com>
References: <20230130093229.27489-1-nylon.chen@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This removes the active-low properties of the PWM-controlled LEDs in
the HiFive Unmatched device tree.

The reference is hifive-unleashed-a00.pdf[0] and hifive-unmatched-schematics-v3.pdf[1].

[0]: https://sifive.cdn.prismic.io/sifive/c52a8e32-05ce-4aaf-95c8-7bf8453f8698_hifive-unleashed-a00-schematics-1.pdf
[1]: https://sifive.cdn.prismic.io/sifive/6a06d6c0-6e66-49b5-8e9e-e68ce76f4192_hifive-unmatched-schematics-v3.pdf

Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
---
 arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts | 4 ----
 arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
index 900a50526d77..7a9f336a391c 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
@@ -50,7 +50,6 @@ led-controller {
 
 		led-d1 {
 			pwms = <&pwm0 0 7812500 PWM_POLARITY_INVERTED>;
-			active-low;
 			color = <LED_COLOR_ID_GREEN>;
 			max-brightness = <255>;
 			label = "d1";
@@ -58,7 +57,6 @@ led-d1 {
 
 		led-d2 {
 			pwms = <&pwm0 1 7812500 PWM_POLARITY_INVERTED>;
-			active-low;
 			color = <LED_COLOR_ID_GREEN>;
 			max-brightness = <255>;
 			label = "d2";
@@ -66,7 +64,6 @@ led-d2 {
 
 		led-d3 {
 			pwms = <&pwm0 2 7812500 PWM_POLARITY_INVERTED>;
-			active-low;
 			color = <LED_COLOR_ID_GREEN>;
 			max-brightness = <255>;
 			label = "d3";
@@ -74,7 +71,6 @@ led-d3 {
 
 		led-d4 {
 			pwms = <&pwm0 3 7812500 PWM_POLARITY_INVERTED>;
-			active-low;
 			color = <LED_COLOR_ID_GREEN>;
 			max-brightness = <255>;
 			label = "d4";
diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
index 07387f9c135c..11f08a545ee6 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
@@ -52,7 +52,6 @@ led-controller-1 {
 
 		led-d12 {
 			pwms = <&pwm0 0 7812500 PWM_POLARITY_INVERTED>;
-			active-low;
 			color = <LED_COLOR_ID_GREEN>;
 			max-brightness = <255>;
 			label = "d12";
@@ -69,19 +68,16 @@ multi-led {
 
 			led-red {
 				pwms = <&pwm0 2 7812500 PWM_POLARITY_INVERTED>;
-				active-low;
 				color = <LED_COLOR_ID_RED>;
 			};
 
 			led-green {
 				pwms = <&pwm0 1 7812500 PWM_POLARITY_INVERTED>;
-				active-low;
 				color = <LED_COLOR_ID_GREEN>;
 			};
 
 			led-blue {
 				pwms = <&pwm0 3 7812500 PWM_POLARITY_INVERTED>;
-				active-low;
 				color = <LED_COLOR_ID_BLUE>;
 			};
 		};
-- 
2.36.1

