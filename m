Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23C67B5B4A
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Sep 2019 07:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfIRFvS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Sep 2019 01:51:18 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:18579 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726676AbfIRFvS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Sep 2019 01:51:18 -0400
X-UUID: 824bc8d3d4d544e5a0306e3b8456b8b3-20190918
X-UUID: 824bc8d3d4d544e5a0306e3b8456b8b3-20190918
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 522187; Wed, 18 Sep 2019 13:51:15 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 18 Sep 2019 13:51:11 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 18 Sep 2019 13:51:11 +0800
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
Subject: [RESEND, PATCH v7 07/11] dt-bindings: pwm: pwm-mediatek: add a property "num-pwms"
Date:   Wed, 18 Sep 2019 13:50:07 +0800
Message-ID: <1568785811-9577-8-git-send-email-sam.shih@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1568785811-9577-1-git-send-email-sam.shih@mediatek.com>
References: <1568785811-9577-1-git-send-email-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-TM-SNTS-SMTP: 6C682525EDF0C75DE16D32A41A4065D87FB6982C24E11A1BEE1DED76BDDE98922000:8
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
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Changes since v6:
Follow reviewers's comments:
- The subject should indicate this is for Mediatek

Changes since v5:
- Add an Acked-by tag
- This file is original v4 patch 5/10
(https://patchwork.kernel.org/patch/11102577/)

---
 Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
index 991728cb46cb..ea95b490a913 100644
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
2.17.1

