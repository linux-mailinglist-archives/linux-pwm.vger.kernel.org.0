Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 092328FC33
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Aug 2019 09:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfHPHW7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 16 Aug 2019 03:22:59 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:46014 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727025AbfHPHWv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 16 Aug 2019 03:22:51 -0400
X-UUID: 986e9a7c64a6416eaea88be0867cf5d9-20190816
X-UUID: 986e9a7c64a6416eaea88be0867cf5d9-20190816
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 1785444964; Fri, 16 Aug 2019 15:22:42 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 16 Aug 2019 15:22:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 16 Aug 2019 15:22:46 +0800
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
Subject: [PATCH v3 9/10] dt-bindings: pwm: update bindings for MT7628 SoC
Date:   Fri, 16 Aug 2019 15:21:27 +0800
Message-ID: <1565940088-845-10-git-send-email-sam.shih@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1565940088-845-1-git-send-email-sam.shih@mediatek.com>
References: <1565940088-845-1-git-send-email-sam.shih@mediatek.com>
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
 Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
index c7bd5633d1eb..bfdc438ae4d3 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
@@ -21,6 +21,9 @@ Required properties:
  - pinctrl-0: One property must exist for each entry in pinctrl-names.
    See pinctrl/pinctrl-bindings.txt for details of the property values.
  - num-pwms: the number of PWM channels.
+ Optional properties:
+ - clock-frequency: fix clock frequency, this is only used in MT7628 SoC
+                    for period calculation. This SoC has no complex clock tree.
 
 Example:
 	pwm0: pwm@11006000 {
-- 
2.17.1

