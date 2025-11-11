Return-Path: <linux-pwm+bounces-7616-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9A4C4C0CF
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Nov 2025 08:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39E50422CD0
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Nov 2025 07:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C48C351FD6;
	Tue, 11 Nov 2025 07:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="t9/LMxIZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFE034EEF6;
	Tue, 11 Nov 2025 07:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762844567; cv=none; b=Z6HAQlDPBFVDbpbz+MJMVKnGUaRLqEdU0B5bqoix54NF2eFxY6r48dY+PhovMTQwVVJRd0uyxjahWhfQ9HvuSDIrNUT/nuzfNPQMOufpxcZ9xQma29JfIGM0uClq/ZNxhlS9k/V7INV7m4gSa3/k32hjCC+0dHBNooJiY9UrYjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762844567; c=relaxed/simple;
	bh=EbcwKVg3pMqdQtDzmT6mapI1DBY6YO/Pb+qNk8Peqb0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TrCtAFaNL065hj9GUhBaRnJFNKRvGc1r0qaBoca8eNrf6MJERK/56nEVpyPhhMmTnfCLaXSz4SKZJOI+ynK0wHa/18Ac9gH0Xm6zo65nHC0AzldMfFqTLZqLD4tfOE6kk4y5SuKFp/FzJBL9RLogfHnurvih9tFn/Mg+y2w2pBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=t9/LMxIZ; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 64887fe8becc11f08ac0a938fc7cd336-20251111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=r0WChIlV/zxiuVn/aJ6pe5m/YT9YDqgrPizzNby6LIQ=;
	b=t9/LMxIZ1LmnF3zJzXsH91qbEBvRYWwPXvZFIQXl3aoDbX1NevYCb9Tqhb5hGVsDS9qibpS2KgH2YgQT4FQaQh5UcxCq+DB5rxbKkOPGoIloVMlwyUigI8OwkGK1OG6nx0IKvgSbK4Wa84sDkXaCgnAUrVPegfUQAj4Xofazwps=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:f6490cba-c2b0-4b3f-bf47-4c93f773b332,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:1fe18382-b6af-4b29-9981-6bf838f9504d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 64887fe8becc11f08ac0a938fc7cd336-20251111
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <jh.hsu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1349513281; Tue, 11 Nov 2025 15:02:31 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 11 Nov 2025 15:02:30 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Tue, 11 Nov 2025 15:02:30 +0800
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
Subject: [PATCH v7 7/9] arm64: dts: mediatek: Add MT6319 PMIC Support
Date: Tue, 11 Nov 2025 14:59:21 +0800
Message-ID: <20251111070031.305281-8-jh.hsu@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251111070031.305281-1-jh.hsu@mediatek.com>
References: <20251111070031.305281-1-jh.hsu@mediatek.com>
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
Changs in v7:
 - change pmic node name as "pmic@"

---
 arch/arm64/boot/dts/mediatek/mt6319.dtsi | 66 ++++++++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6319.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/mt6319.dtsi b/arch/arm64/boot/dts/mediatek/mt6319.dtsi
new file mode 100644
index 000000000000..6586f0ba5b2f
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
+	mt6319_7: pmic@7 {
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
+	mt6319_8: pmic@8 {
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


