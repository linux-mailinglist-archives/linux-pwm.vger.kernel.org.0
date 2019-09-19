Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23AB9B87BD
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Sep 2019 00:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406405AbfISWvG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 19 Sep 2019 18:51:06 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:36261 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2406262AbfISWvF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 19 Sep 2019 18:51:05 -0400
X-UUID: a600f8cbd91f45619bb794e56bce1dc9-20190920
X-UUID: a600f8cbd91f45619bb794e56bce1dc9-20190920
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1422154027; Fri, 20 Sep 2019 06:50:59 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 20 Sep 2019 06:50:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 20 Sep 2019 06:50:54 +0800
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
Subject: [PATCH v9 10/11] dt-bindings: pwm: update bindings for MT7629 SoC
Date:   Fri, 20 Sep 2019 06:49:10 +0800
Message-ID: <1568933351-8584-11-git-send-email-sam.shih@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1568933351-8584-1-git-send-email-sam.shih@mediatek.com>
References: <1568933351-8584-1-git-send-email-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 0E0BD68C5B0239AD628993A1099FE5B3FA385D5F42D3D191052146B1EF60F2402000:8
X-MTK:  N
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Ryder Lee <ryder.lee@mediatek.com>

This updates bindings for MT7629 pwm controller.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Sam Shih <sam.shih@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
---
Changes since v7:
- add a missed Reviewed-by tag back from v1:
https://patchwork.kernel.org/patch/10769381/
Changes since v1:
- add a Reviewed-by tag

---
 Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
index ea95b490a913..c7bd5633d1eb 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
@@ -6,6 +6,7 @@ Required properties:
    - "mediatek,mt7622-pwm": found on mt7622 SoC.
    - "mediatek,mt7623-pwm": found on mt7623 SoC.
    - "mediatek,mt7628-pwm": found on mt7628 SoC.
+   - "mediatek,mt7629-pwm", "mediatek,mt7622-pwm": found on mt7629 SoC.
  - reg: physical base address and length of the controller's registers.
  - #pwm-cells: must be 2. See pwm.txt in this directory for a description of
    the cell format.
-- 
2.17.1

