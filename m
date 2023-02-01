Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93965686F74
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Feb 2023 21:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjBAUCN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 1 Feb 2023 15:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjBAUCM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 1 Feb 2023 15:02:12 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09736EBC;
        Wed,  1 Feb 2023 12:02:11 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id mc11so32261777ejb.10;
        Wed, 01 Feb 2023 12:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZUwxNJxFlwiJY3LE0c9a6Ul2PZq/gNO1u4vk0lo6jnI=;
        b=IVLey1eKZEphphuNftYbmy7S1jjoJUqk4PgJK0jUbbm3gYEPerkSIQdBo2Ny1fXClI
         8neWXXxDRn28q63pPFRneXPzJESFwzBwlzruwVrq1YUdsb5eUKUKSf57XNWn1ZHqzSpw
         +jkd0YvzOOSX0mkuh0zlp+GSB5ynYsvE/fg2804Dpdr0nbEiGLNdDYEAXlLOyN0tlztr
         RS6KDUeR33/bPOMblHolVz2eEaLWKVx0BWlpYa79LKGh0nIQfkxG4k8uvaLgfG9TCaJ6
         Nmt495Lta0Vj6MHnKSU0yntoSFGhW5EyM5JuWpBLtKzy+4g667VYsilKsR9DNSDGAGN3
         WSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUwxNJxFlwiJY3LE0c9a6Ul2PZq/gNO1u4vk0lo6jnI=;
        b=bCQZ5IgT9ZDGAdl3KxeNkP/+eYiHlh+S0Q54k+/NAtd8suhmpG8mzzbwlDK56EVn0t
         Dnq159ZjdhFTc+/0voiY0TDGH9ns9I64w3RqgPKVjDYkbMEO+num/KJ20MX01zcVwyFM
         OAVGcpWS9gKdH7Y5IYYZUD8EM0J08ROgn+H3NCMBijC2BiT9nTp8K4auMs4RZIvcmkvY
         cfMx7ALJmfHT9nUOabxOzaDx66oEmp34eZE7oFg6FZm1OUQZ2swDx3sZ4UAKkQ8/nFYy
         f1EAJETpMNoOvo41cVlJIqvkSUEAnsAJWNfLtIL+iJM9sJ4VUTRDRxaFCd/vFwuybcPC
         h3FQ==
X-Gm-Message-State: AO0yUKVDMjtYRVKXQEsZaXplwlV7cirTDqJn0joMmq3bVHt7vkINYIhf
        mYv4EKJgBiRkFL3UEVXD4fk=
X-Google-Smtp-Source: AK7set8h0j6vw0PIPChjn+OwS6+zd1oGxPsJJFo8VoSYCJEhnxWEj0LExbaxskt85Q397EyTALNABw==
X-Received: by 2002:a17:907:1607:b0:87b:6aa1:c87f with SMTP id hb7-20020a170907160700b0087b6aa1c87fmr4814168ejc.26.1675281730131;
        Wed, 01 Feb 2023 12:02:10 -0800 (PST)
Received: from ?IPV6:2a01:c23:b912:d400:3963:7bc4:12b:ddb3? (dynamic-2a01-0c23-b912-d400-3963-7bc4-012b-ddb3.c23.pool.telefonica.de. [2a01:c23:b912:d400:3963:7bc4:12b:ddb3])
        by smtp.googlemail.com with ESMTPSA id se11-20020a170906ce4b00b0087f68a2681bsm8264924ejb.96.2023.02.01.12.02.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 12:02:09 -0800 (PST)
Message-ID: <66f77c32-2678-3e31-fb00-1294ccaa6045@gmail.com>
Date:   Wed, 1 Feb 2023 20:58:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: [PATCH 1/4] arm: dts: meson: adjust order of some compatibles
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
 arch/arm/boot/dts/meson8b.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index d5a3fe21e..5979209fe 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -580,8 +580,8 @@ &ethmac {
 };
 
 &gpio_intc {
-	compatible = "amlogic,meson-gpio-intc",
-		     "amlogic,meson8b-gpio-intc";
+	compatible = "amlogic,meson8b-gpio-intc",
+		     "amlogic,meson-gpio-intc";
 	status = "okay";
 };
 
-- 
2.39.1


