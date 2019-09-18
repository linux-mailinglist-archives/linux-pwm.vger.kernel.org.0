Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAB5B5B42
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Sep 2019 07:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfIRFvt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Sep 2019 01:51:49 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:28302 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728423AbfIRFvZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Sep 2019 01:51:25 -0400
X-UUID: fbfbc4118a93484a9ee9196d55fd3b0d-20190918
X-UUID: fbfbc4118a93484a9ee9196d55fd3b0d-20190918
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1801908594; Wed, 18 Sep 2019 13:51:17 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 18 Sep 2019 13:51:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 18 Sep 2019 13:51:13 +0800
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
Subject: [RESEND, PATCH v7 09/11] arm: dts: mt7623: add a property "num-pwms" for PWM
Date:   Wed, 18 Sep 2019 13:50:09 +0800
Message-ID: <1568785811-9577-10-git-send-email-sam.shih@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1568785811-9577-1-git-send-email-sam.shih@mediatek.com>
References: <1568785811-9577-1-git-send-email-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 7BD3B40C46195B1E5378B1399F24716D82DAF94D95961D616AE0DDCD5CA5503C2000:8
X-MTK:  N
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Ryder Lee <ryder.lee@mediatek.com>

This adds a property "num-pwms" for PWM controller.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Sam Shih <sam.shih@mediatek.com>
---
 arch/arm/boot/dts/mt7623.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index a79f0b6c3429..208e0d19a575 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -452,6 +452,7 @@
 			 <&pericfg CLK_PERI_PWM5>;
 		clock-names = "top", "main", "pwm1", "pwm2",
 			      "pwm3", "pwm4", "pwm5";
+		num-pwms = <5>;
 		status = "disabled";
 	};
 
-- 
2.17.1

