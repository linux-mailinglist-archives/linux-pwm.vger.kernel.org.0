Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8FF08D0FA
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Aug 2019 12:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfHNKo6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Aug 2019 06:44:58 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:5802 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726551AbfHNKo6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Aug 2019 06:44:58 -0400
X-UUID: 20eb46e758b0455b9f25295df721bdbd-20190814
X-UUID: 20eb46e758b0455b9f25295df721bdbd-20190814
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 867862673; Wed, 14 Aug 2019 18:44:47 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 14 Aug 2019 18:44:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 14 Aug 2019 18:44:50 +0800
From:   Sam Shih <sam.shih@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Ryder Lee <ryder.lee@mediatek.com>,
        John Crispin <john@phrozen.org>, <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Sam Shih <sam.shih@mediatek.com>
Subject: [PATCH v2 4/10] dt-bindings: pwm: add a property "num-pwms"
Date:   Wed, 14 Aug 2019 18:43:34 +0800
Message-ID: <4107497fa8564032cac49e70680a9aa7bbb312eb.1548313019.git.ryder.lee@mediatek.com>
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

From: Ryder Lee <ryder.lee@mediatek.com>

This adds a property "num-pwms" in example so that we could
specify the number of PWM channels via device tree.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Sam Shih <sam.shih@mediatek.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
---
Changes since v2:
- use num-pwms instead of mediatek,num-pwms.
- modify the description of clocks to make it simple.

Changes since v1:
- add a Reviewed-by tag.
---
 Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
index 991728c..ea95b49 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
@@ -14,12 +14,12 @@ Required properties:
                 has no clocks
    - "top": the top clock generator
    - "main": clock used by the PWM core
-   - "pwm1-8": the eight per PWM clocks for mt2712
-   - "pwm1-6": the six per PWM clocks for mt7622
-   - "pwm1-5": the five per PWM clocks for mt7623
+   - "pwm1-N": the PWM clocks for each channel
+   where N starting from 1 to the maximum number of PWM channels
  - pinctrl-names: Must contain a "default" entry.
  - pinctrl-0: One property must exist for each entry in pinctrl-names.
    See pinctrl/pinctrl-bindings.txt for details of the property values.
+ - num-pwms: the number of PWM channels.
 
 Example:
 	pwm0: pwm@11006000 {
@@ -37,4 +37,5 @@ Example:
 			      "pwm3", "pwm4", "pwm5";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm0_pins>;
+		num-pwms = <5>;
 	};
-- 
1.9.1

