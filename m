Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B596BE03F
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Sep 2019 16:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732601AbfIYOei (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 25 Sep 2019 10:34:38 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:47216 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730669AbfIYOeh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 25 Sep 2019 10:34:37 -0400
X-UUID: 1fed44208310455bbdbc54d2b24f3828-20190925
X-UUID: 1fed44208310455bbdbc54d2b24f3828-20190925
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 300394955; Wed, 25 Sep 2019 22:34:28 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 25 Sep 2019 22:34:27 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 25 Sep 2019 22:34:27 +0800
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
Subject: [PATCH v10 07/12] dt-bindings: pwm: pwm-mediatek: add a property "num-pwms"
Date:   Wed, 25 Sep 2019 22:32:32 +0800
Message-ID: <1569421957-20765-8-git-send-email-sam.shih@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1569421957-20765-1-git-send-email-sam.shih@mediatek.com>
References: <1569421957-20765-1-git-send-email-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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
Changes since v10:
1. Follow reviewers's comments:
- derive the number of PWMs from the specific compatible string
2. Add mt7629 pwm description
3. Add mt7628 fixed-clock description

Changes since v6:
Follow reviewers's comments:
- The subject should indicate this is for Mediatek

Changes since v5:
- Add an Acked-by tag
- This file is original v4 patch 5/10
(https://patchwork.kernel.org/patch/11102577/)

---
 Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
index 991728cb46cb..975d7871830d 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
@@ -9,17 +9,20 @@ Required properties:
  - reg: physical base address and length of the controller's registers.
  - #pwm-cells: must be 2. See pwm.txt in this directory for a description of
    the cell format.
- - clocks: phandle and clock specifier of the PWM reference clock.
- - clock-names: must contain the following, except for MT7628 which
-                has no clocks
+ - clocks: One phandle and clock specifier for each entry in the "clock-names"
+           property, Use fixed-clock as dummy clocks for mt7628
+ - clock-names: must contain the following
    - "top": the top clock generator
    - "main": clock used by the PWM core
    - "pwm1-8": the eight per PWM clocks for mt2712
    - "pwm1-6": the six per PWM clocks for mt7622
    - "pwm1-5": the five per PWM clocks for mt7623
+   - "pwm1-4": the four per PWM clocks for mt7628
+   - "pwm1": the PWM1 clock for mt7629
  - pinctrl-names: Must contain a "default" entry.
  - pinctrl-0: One property must exist for each entry in pinctrl-names.
    See pinctrl/pinctrl-bindings.txt for details of the property values.
+ - num-pwms: the number of PWM channels.
 
 Example:
 	pwm0: pwm@11006000 {
@@ -37,4 +40,5 @@ Example:
 			      "pwm3", "pwm4", "pwm5";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm0_pins>;
+		num-pwms = <5>;
 	};
-- 
2.17.1

