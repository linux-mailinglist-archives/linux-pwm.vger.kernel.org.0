Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BEF686F76
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Feb 2023 21:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjBAUCO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 1 Feb 2023 15:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjBAUCO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 1 Feb 2023 15:02:14 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFF06EBC;
        Wed,  1 Feb 2023 12:02:13 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id me3so54774958ejb.7;
        Wed, 01 Feb 2023 12:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qSroPy2WHgGfW4fqnkho5f90ztpMpK7y6tuzoTj/kVc=;
        b=D8BtHxYRruMEAMT6AyhMVE0cV2GFDa2AjI0UQXoZmCEw5ipyVKHWcEH5fZxqOOexUW
         vcWG5KdD71WyezR2Mse/Ezb2aYo+HV9x4VnG5uFkKh6vsh6lhIVy0Bt8QptGnqgPuKaQ
         fnZJhJvEwy2f2LaAs2p46SACCdt/6aow4kEIhN6/jpgJGlRCxDSxR2x0IWauFsBF9j31
         wYmEx9pcAvblNsWa0NRRV6Rzfcc0RmaeQ6mV56uhUrJNOM1kNRyBsnaZ7vBYHLQLZO6G
         EdEO6OIuvfxXftC5kRrLJC+Dl48aUQbFK87zNwB0gIs5VRc7yzUTOEgRr261EnJr3was
         jMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qSroPy2WHgGfW4fqnkho5f90ztpMpK7y6tuzoTj/kVc=;
        b=EbJ93auvApJAQvH3OQ/16hFqolTsVNlDTpeHDKufWCtINdQo1gS8nXEr/2dJVrJepV
         GYCCiPlr3OCELpcMyESelBMmvZonQv/kJVljpLXpYJTIT6SIRbeYXzXZZflcU11gUYPC
         6JFu1Ii821FOlxfL5kAnvDa2WZkB/RxgqePMtdJ/Dz9ysaWUG5zh2BGFMdMaSdS6rBW9
         7ZiEE7RYlOEuZfZ4/eAttWtpoBC4yjImATH4VAZyrFsNB2Yxls2b+xuWl2/404B7gy+r
         Ql34JThk2YjwXLYPUC/nywpN1swmuBdjbMfT4XZ88m/dmGKQr3vv88aMQsDHRTJAsF9D
         wiuQ==
X-Gm-Message-State: AO0yUKVIOkdtvN+U58ZrDtentSr0QxyZ9aYhemlAjbpTj8HZ4VLcxLJo
        mPZg4bpF3xKiq2DjAbNGlZg=
X-Google-Smtp-Source: AK7set83/MjcdNvgrsa/LwVxwaTVpq4xOQwjEfak/z3lA6Jw+klDakt5Xb2m+6JuYulQhsFfPPrrNA==
X-Received: by 2002:a17:907:8745:b0:882:82b3:58bc with SMTP id qo5-20020a170907874500b0088282b358bcmr4233828ejc.65.1675281731737;
        Wed, 01 Feb 2023 12:02:11 -0800 (PST)
Received: from ?IPV6:2a01:c23:b912:d400:3963:7bc4:12b:ddb3? (dynamic-2a01-0c23-b912-d400-3963-7bc4-012b-ddb3.c23.pool.telefonica.de. [2a01:c23:b912:d400:3963:7bc4:12b:ddb3])
        by smtp.googlemail.com with ESMTPSA id d27-20020a170906041b00b00887f6c39ac0sm5660738eja.98.2023.02.01.12.02.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 12:02:11 -0800 (PST)
Message-ID: <1ce888df-6096-73de-a98a-354d086428d4@gmail.com>
Date:   Wed, 1 Feb 2023 20:59:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: [PATCH 2/4] arm64: dts: meson: adjust order of some compatibles
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, linux-pwm@vger.kernel.org
References: <8df4ceec-663c-dc68-d775-5caeb02c0cca@gmail.com>
In-Reply-To: <8df4ceec-663c-dc68-d775-5caeb02c0cca@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

During review of a new yaml binding, affecting these dts, it turned out
that some compatibles aren't ordered as they should be. Order should be
most specific to least specific.

Suggested-by: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 923d2d8bb..12ef6e81c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -300,8 +300,8 @@ &ethmac {
 };
 
 &gpio_intc {
-	compatible = "amlogic,meson-gpio-intc",
-		     "amlogic,meson-gxbb-gpio-intc";
+	compatible = "amlogic,meson-gxbb-gpio-intc",
+		     "amlogic,meson-gpio-intc";
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 04e9d0f1b..af912f698 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -312,8 +312,8 @@ &clkc_AO {
 };
 
 &gpio_intc {
-	compatible = "amlogic,meson-gpio-intc",
-		     "amlogic,meson-gxl-gpio-intc";
+	compatible = "amlogic,meson-gxl-gpio-intc",
+		     "amlogic,meson-gpio-intc";
 	status = "okay";
 };
 
-- 
2.39.1


