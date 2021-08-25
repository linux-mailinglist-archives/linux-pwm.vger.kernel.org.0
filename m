Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE3C3F723B
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Aug 2021 11:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239664AbhHYJtV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 25 Aug 2021 05:49:21 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:43541 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236638AbhHYJtU (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 25 Aug 2021 05:49:20 -0400
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 361BF440E17;
        Wed, 25 Aug 2021 12:48:25 +0300 (IDT)
From:   Baruch Siach <baruch@tkos.co.il>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>
Cc:     Baruch Siach <baruch@tkos.co.il>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Kathiravan T <kathirav@codeaurora.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 1/4] dt-bindings: mfd: qcom,tcsr: document ipq6018 compatible
Date:   Wed, 25 Aug 2021 12:48:24 +0300
Message-Id: <3b70f9e757e018d3cd91a882282040c4c0589a93.1629884907.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 Documentation/devicetree/bindings/mfd/qcom,tcsr.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,tcsr.txt b/Documentation/devicetree/bindings/mfd/qcom,tcsr.txt
index e90519d566a3..c5f4f0ddfcc3 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,tcsr.txt
+++ b/Documentation/devicetree/bindings/mfd/qcom,tcsr.txt
@@ -6,6 +6,7 @@ registers via syscon.
 
 Required properties:
 - compatible:	Should contain:
+		"qcom,tcsr-ipq6018", "syscon", "simple-mfd" for IPQ6018
 		"qcom,tcsr-ipq8064", "syscon" for IPQ8064
 		"qcom,tcsr-apq8064", "syscon" for APQ8064
 		"qcom,tcsr-msm8660", "syscon" for MSM8660
-- 
2.32.0

