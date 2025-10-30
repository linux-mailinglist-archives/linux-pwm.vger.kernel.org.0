Return-Path: <linux-pwm+bounces-7548-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E380C20655
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 14:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B02B21A67BCB
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 13:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CE128152D;
	Thu, 30 Oct 2025 13:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qWSvqxXS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9C526F296;
	Thu, 30 Oct 2025 13:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761832068; cv=none; b=gWDMy26Lfkq7JDKTgLgM8Vy4bDNb2yoRDzKGal2zurg3lYBtmeoKQsBcIu60TPQadRsy0dehc7gOuvabwQ4KnEY511+pOvoLHpHvc5nsbrrvfKQ/BE2/VBrVE25iI1MJsfjxkW0Chd64WulPFql2lkeUHTwT0JAP+yrjPOQG4QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761832068; c=relaxed/simple;
	bh=rWFa89BJYj2OiUfGOT/n9ZC74mtX2mBO/z/0KjqnnkY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G/IEj8ULzWvsse5mkF8k7e9zBdwBLbWVBqTa9Oi/t+W+KRf3jlyn/n9e7RMTORa5RAeBGdv5ARcfXq88qFFL92V/bS9u9mQoVaF3TPFCwthp8XXVx1/LK55wJ9ISF4pvEjV+fYRV2yPOjygmUvMNApZomo6eJT9+P7NPJaIY5IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=qWSvqxXS; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: fc7a90e6b59611f0ae1e63ff8927bad3-20251030
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=W58v+e8siGwxrS7/1FaAvhhPBfKw7gKGeCnuKRMKrJo=;
	b=qWSvqxXSmy8buHk5+g8hBOwQpq8yZA1b8VGQXEHMAH7v3QlwYO+ddiQgZXL/6d5dSn032gZollXgEPtVZcEaXzPpwU1XoSy9HJA3BUDrq/qqM0gRezCjNLg9BLxvEkZu0Z4LLbpIkORMLKtgm5rJYG5/KrawEzd/lLg2tRZ1rFM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:9c34c45d-893e-4ade-bcab-b7798f0fdc84,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:0ca46e26-cfd6-4a1d-a1a8-72ac3fdb69c4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: fc7a90e6b59611f0ae1e63ff8927bad3-20251030
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <jh.hsu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 766265684; Thu, 30 Oct 2025 21:47:33 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 30 Oct 2025 21:47:31 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Thu, 30 Oct 2025 21:47:31 +0800
From: Jack Hsu <jh.hsu@mediatek.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<andy@kernel.org>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <srini@kernel.org>,
	<ukleinek@kernel.org>, <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
	<daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
	<chunfeng.yun@mediatek.com>, <wim@linux-watchdog.org>, <linux@roeck-us.net>,
	<sean.wang@mediatek.com>, <zhiyong.tao@mediatek.com>,
	<andrew-ct.chen@mediatek.com>, <lala.lin@mediatek.com>,
	<jitao.shi@mediatek.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <linux-pwm@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<linux-watchdog@vger.kernel.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Jack Hsu
	<jh.hsu@mediatek.com>
Subject: [PATCH v6 09/11] arm64: dts: mediatek: Add MT6319 PMIC Support
Date: Thu, 30 Oct 2025 21:44:41 +0800
Message-ID: <20251030134541.784011-10-jh.hsu@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251030134541.784011-1-jh.hsu@mediatek.com>
References: <20251030134541.784011-1-jh.hsu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Add support for MediaTek MT6319 PMIC IC

Signed-off-by: Jack Hsu <jh.hsu@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt6319.dtsi | 66 ++++++++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6319.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/mt6319.dtsi b/arch/arm64/boot/dts/mediatek/mt6319.dtsi
new file mode 100644
index 000000000000..8b2386547508
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt6319.dtsi
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ */
+#include <dt-bindings/spmi/spmi.h>
+
+&spmi {
+	mt6319_7: mt6319@7 {
+		compatible = "mediatek,mt6315-regulator";
+		buck1-modeset-mask = <0x3>;
+		reg = <0x7 SPMI_USID>;
+
+		regulators {
+			mt6319_7_vbuck1: vbuck1 {
+				regulator-name = "vbuck1";
+				regulator-allowed-modes = <0 1 2>;
+				regulator-always-on;
+			};
+			mt6319_7_vbuck2: vbuck2 {
+				regulator-name = "vbuck2";
+				regulator-allowed-modes = <0 1 2>;
+				regulator-always-on;
+			};
+			mt6319_7_vbuck3: vbuck3 {
+				regulator-name = "vbuck3";
+				regulator-allowed-modes = <0 1 2>;
+				regulator-always-on;
+			};
+			mt6319_7_vbuck4: vbuck4 {
+				regulator-name = "vbuck4";
+				regulator-allowed-modes = <0 1 2>;
+				regulator-always-on;
+			};
+		};
+	};
+
+	mt6319_8: mt6319@8 {
+		compatible = "mediatek,mt6315-regulator";
+		buck1-modeset-mask = <0xb>;
+		reg = <0x8 SPMI_USID>;
+
+		regulators {
+			mt6319_8_vbuck1: vbuck1 {
+				regulator-name = "vbuck1";
+				regulator-allowed-modes = <0 1 2>;
+				regulator-always-on;
+			};
+			mt6319_8_vbuck2: vbuck2 {
+				regulator-name = "vbuck2";
+				regulator-allowed-modes = <0 1 2>;
+				regulator-always-on;
+			};
+			mt6319_8_vbuck3: vbuck3 {
+				regulator-name = "vbuck3";
+				regulator-allowed-modes = <0 1 2>;
+				regulator-always-on;
+			};
+			mt6319_8_vbuck4: vbuck4 {
+				regulator-name = "vbuck4";
+				regulator-allowed-modes = <0 1 2>;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
-- 
2.45.2


