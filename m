Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D45918D10A
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Aug 2019 12:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfHNKpM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Aug 2019 06:45:12 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:29419 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726551AbfHNKpL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Aug 2019 06:45:11 -0400
X-UUID: da896fad1a3f48d6ab0961ca83e2064c-20190814
X-UUID: da896fad1a3f48d6ab0961ca83e2064c-20190814
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 52192520; Wed, 14 Aug 2019 18:45:05 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 14 Aug 2019 18:45:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 14 Aug 2019 18:45:07 +0800
From:   Sam Shih <sam.shih@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Ryder Lee <ryder.lee@mediatek.com>,
        John Crispin <john@phrozen.org>, <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        sam shih <sam.shih@mediatek.com>
Subject: [PATCH v2 9/10] dt-bindings: pwm: update bindings for MT7628 SoC 
Date:   Wed, 14 Aug 2019 18:43:39 +0800
Message-ID: <1565779497-23621-2-git-send-email-sam.shih@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <621e49c01b943edb6ddac9182f34719eb0727f01.1548313019.git.ryder.lee@mediatek.com>
References: <621e49c01b943edb6ddac9182f34719eb0727f01.1548313019.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: sam shih <sam.shih@mediatek.com>

This updates bindings for MT7628 pwm controller.

Signed-off-by: Sam Shih <sam.shih@mediatek.com>
---
 .../devicetree/bindings/pwm/pwm-mediatek.txt       | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
index c7bd5633d1eb..9d2d893a07ff 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
@@ -21,6 +21,8 @@ Required properties:
  - pinctrl-0: One property must exist for each entry in pinctrl-names.
    See pinctrl/pinctrl-bindings.txt for details of the property values.
  - num-pwms: the number of PWM channels.
+ - clock-frequency: fix clock frequency, this is an optional property, only use in MT7628 SoC
+                    for period calculation. This SoC has no complex clock tree.
 
 Example:
 	pwm0: pwm@11006000 {
@@ -40,3 +42,13 @@ Example:
 		pinctrl-0 = <&pwm0_pins>;
 		num-pwms = <5>;
 	};
+MT7628 Example:
+	pwm: pwm@5000 {
+		compatible = "mediatek,mt7628-pwm";
+		reg = <0x5000 0x1000>;
+		#pwm-cells = <2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm0_pins>, <&pwm1_pins>;
+		num-pwms = <4>;
+		clock-frequency = <100000>;
+	};
-- 
2.17.1
