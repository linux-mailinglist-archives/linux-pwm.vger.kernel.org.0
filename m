Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFD529535D
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Oct 2020 22:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505144AbgJUULx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 21 Oct 2020 16:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505140AbgJUULw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 21 Oct 2020 16:11:52 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD57C0613D4
        for <linux-pwm@vger.kernel.org>; Wed, 21 Oct 2020 13:11:52 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id j7so3410133oie.12
        for <linux-pwm@vger.kernel.org>; Wed, 21 Oct 2020 13:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CTQjXkyBU+AXR4n3+CD+/Udf1tnLCv+grrFndIKi/I8=;
        b=rpbvkLyJKFEWhkI0bl3iRJ+6Poue7ZjikFm+j1wMw19BQi6vVa2w+6A7TGM4i5AvyJ
         FLoZ+56T1NEJM6CnMG5xvbV4BZ3aTwgZlOpE4elptBwWTWUTiwXEYciyvTWCF9mgW5kO
         nHLnEdd7zEnzst/FkZ1nUrX+w01wrlpCzhQpiMj5TjFp9YR/p8z01F8O/OdyiuvL5dAN
         8+cxJbZJW5I6nERd6vGo3ztfMoIi7HTdSi18LDcBVYaMiMpJxUbXhbjCskQin9kGq5M8
         wKylvPzXTkMyZGExbYQZaHjA/jcY96t7sXYPv4LDgvAF8IyCntAftflBr8R6so9a1/j6
         LJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CTQjXkyBU+AXR4n3+CD+/Udf1tnLCv+grrFndIKi/I8=;
        b=S2ZkFgEN9pH9ogQCB3dYws4IGhDAiQ0Wgp47GIIYpug2w8UI2jCDAgfqozSx3me9Cg
         c4bSNZNnrwPhXBoHQ1nHCgVPtHmHOlxB3Abk1pDH1LGyZY19DPMczoDElgTY28LpfHpY
         H+iwAXMEn3QCx+agnISJslPPLmdf279DT5lr6uqJLvLymjLRMG9/4GSA92EK36QmBPp7
         u3UptxlHx2b/neu36HSZ1ealZ9Rq5ACdLE1UBf95Xj5YaZG70zu9LLr7trNCmlfPJAqY
         P8YNAeEDFovdj6gzxAdYlRHVprkVZ1VeZa5klE+p3JwI3h1SUT41yY0KbzDDw9QihUyr
         HrdA==
X-Gm-Message-State: AOAM530GxsqZsAb2FbYZOI3dOy76YOXynE17jqSsTjowR5qstYl9mss/
        fMV3Y8hQJ1hOwDrJCoQOx2yhZg==
X-Google-Smtp-Source: ABdhPJxVvM2KS6NoTYQZqhWxtTSGGTGaDlEmqecZLtPRRYaUhla2A0ek/tTe7tHT+zFDTkG92bLCOA==
X-Received: by 2002:aca:4c0d:: with SMTP id z13mr3207502oia.78.1603311111876;
        Wed, 21 Oct 2020 13:11:51 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t5sm838166otl.22.2020.10.21.13.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 13:11:51 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Martin Botka <martin.botka1@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: [PATCH v6 3/4] arm64: dts: qcom: pm(i)8994: Add mpp and lpg blocks
Date:   Wed, 21 Oct 2020 13:12:23 -0700
Message-Id: <20201021201224.3430546-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021201224.3430546-1-bjorn.andersson@linaro.org>
References: <20201021201224.3430546-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The pm8994 contains a 6 LPG channels and the pmi8994 contains 4 MPP
channels and a 4 channel LPG, with TRILED and LUT blocks.

Add nodes for these blocks.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v5:
- None

 arch/arm64/boot/dts/qcom/pm8994.dtsi  |  9 +++++++++
 arch/arm64/boot/dts/qcom/pmi8994.dtsi | 20 ++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8994.dtsi b/arch/arm64/boot/dts/qcom/pm8994.dtsi
index 7e4f777746cb..b5bef687aa3c 100644
--- a/arch/arm64/boot/dts/qcom/pm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8994.dtsi
@@ -86,6 +86,15 @@ pmic@1 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pm8994_lpg: lpg {
+			compatible = "qcom,pm8994-lpg";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disabled";
+		};
+
 		pm8994_spmi_regulators: regulators {
 			compatible = "qcom,pm8994-regulators";
 		};
diff --git a/arch/arm64/boot/dts/qcom/pmi8994.dtsi b/arch/arm64/boot/dts/qcom/pmi8994.dtsi
index e5ed28ab9b2d..23f41328d191 100644
--- a/arch/arm64/boot/dts/qcom/pmi8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8994.dtsi
@@ -19,6 +19,17 @@ pmi8994_gpios: gpios@c000 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
 		};
+
+		pmi8994_mpps: mpps@a000 {
+			compatible = "qcom,pm8994-mpp";
+			reg = <0xa000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupts = <0 0xa0 0 IRQ_TYPE_NONE>,
+				     <0 0xa1 0 IRQ_TYPE_NONE>,
+				     <0 0xa2 0 IRQ_TYPE_NONE>,
+				     <0 0xa3 0 IRQ_TYPE_NONE>;
+		};
 	};
 
 	pmic@3 {
@@ -27,6 +38,15 @@ pmic@3 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pmi8994_lpg: lpg@b100 {
+			compatible = "qcom,pmi8994-lpg";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disabled";
+		};
+
 		pmi8994_spmi_regulators: regulators {
 			compatible = "qcom,pmi8994-regulators";
 			#address-cells = <1>;
-- 
2.28.0

