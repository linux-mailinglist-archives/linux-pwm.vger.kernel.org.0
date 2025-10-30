Return-Path: <linux-pwm+bounces-7544-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D4DC205DD
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 14:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4F331897A2D
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 13:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44061267AF2;
	Thu, 30 Oct 2025 13:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="c7jbqvkV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F30423EA82;
	Thu, 30 Oct 2025 13:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761832065; cv=none; b=iriSHeCKFp5aaFw6zh8R7+DQmL1ae7KSNy0uv2A4Ek7H6ROYQIgFf3WAdVic6y5bZVwgF9xXHI5wf5Elxc+arKaQ0GPlKG0CQq+bvJ5XVZrGwqakSICbpjp6hRVYI/JsUSIqYyTmypQz1aBebfdxE29+2O/dgzylheDJsWe1Z6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761832065; c=relaxed/simple;
	bh=/IYpckoeprK7JXJq7SBcaTqieMQ8YCExuAE7jIG/VbU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NTDGcDzhHF46Y3JEN2cnAwuwtxGpkqzt894PwTvYuPiDvpwtQ5Mm67ItNgjv8vOyW2GLdTT4v/fHc5F07k6xfuIRNwUr3grXz12QPVRbuIOT9v+DOL9XNw/nnfV266KScXPBZZCE0Zl5fuW1dcHQM7KN556araZWoTcPpufdLtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=c7jbqvkV; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: fcab9330b59611f0b33aeb1e7f16c2b6-20251030
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Y5xYksDJSoM3FsK+l+zIqMequ4QeSt0WoTpN/qOQ7Jk=;
	b=c7jbqvkVOxKoOGArFramxkDhB0ox3st+ZBEt4+qahh+1pA9rGY4M6PRZUEvRKY6v14ENsAs0oeiH8o1rO1kHDM4zaeVz+huOdWkKGoXALJTigj7q5knk0B/WVifzbkOwh/+YUg4obkCwIUuMx4qWhWOcv/88Gib20+AmhC5EaY0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:d56f06a8-8c36-4375-b958-273128d82bbc,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:a9d874c,CLOUDID:75c8db6a-d4bd-4ab9-8221-0049857cc502,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: fcab9330b59611f0b33aeb1e7f16c2b6-20251030
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <jh.hsu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 392333532; Thu, 30 Oct 2025 21:47:33 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
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
Subject: [PATCH v6 10/11] arm64: dts: mediatek: add properties for MT6359
Date: Thu, 30 Oct 2025 21:44:42 +0800
Message-ID: <20251030134541.784011-11-jh.hsu@mediatek.com>
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

Add properties of rtc fg (Fuel Gauge), external crystal
and auxadc definition for mt6359 pmic.

Signed-off-by: Jack Hsu <jh.hsu@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt6359.dtsi | 20 ++++++++++
 include/dt-bindings/iio/mt635x-auxadc.h  | 50 ++++++++++++++++++++++++
 2 files changed, 70 insertions(+)
 create mode 100644 include/dt-bindings/iio/mt635x-auxadc.h

diff --git a/arch/arm64/boot/dts/mediatek/mt6359.dtsi b/arch/arm64/boot/dts/mediatek/mt6359.dtsi
index 467d8a4c2aa7..cc7053bdd292 100644
--- a/arch/arm64/boot/dts/mediatek/mt6359.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6359.dtsi
@@ -3,6 +3,8 @@
  * Copyright (C) 2022 MediaTek Inc.
  */
 
+#include <dt-bindings/iio/mt635x-auxadc.h>
+
 &pwrap {
 	pmic: pmic {
 		compatible = "mediatek,mt6359";
@@ -302,6 +304,24 @@ mt6359_vsram_others_sshub_ldo: ldo_vsram_others_sshub {
 
 		mt6359rtc: rtc {
 			compatible = "mediatek,mt6358-rtc";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+
+			fginit: fginit {
+				reg = <0 0x1>;
+				bits = <0 8>;
+			};
+
+			fgsoc: fgsoc {
+				reg = <1 0x1>;
+				bits = <0 8>;
+			};
+
+			ext32k: ext32k {
+				reg = <2 0x1>;
+				bits = <6 1>;
+			};
 		};
 	};
 };
diff --git a/include/dt-bindings/iio/mt635x-auxadc.h b/include/dt-bindings/iio/mt635x-auxadc.h
new file mode 100644
index 000000000000..69ba13a7b9ec
--- /dev/null
+++ b/include/dt-bindings/iio/mt635x-auxadc.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Copyright (c) 2020 MediaTek Inc.
+ */
+
+#ifndef _DT_BINDINGS_MT635X_AUXADC_H
+#define _DT_BINDINGS_MT635X_AUXADC_H
+
+/* PMIC MT635x AUXADC channels */
+#define AUXADC_BATADC				0x00
+#define AUXADC_ISENSE				0x01
+#define AUXADC_VCDT	    			0x02
+#define AUXADC_BAT_TEMP				0x03
+#define AUXADC_BATID				0x04
+#define AUXADC_CHIP_TEMP			0x05
+#define AUXADC_VCORE_TEMP			0x06
+#define AUXADC_VPROC_TEMP			0x07
+#define AUXADC_VGPU_TEMP			0x08
+#define AUXADC_ACCDET				0x09
+#define AUXADC_VDCXO				0x0a
+#define AUXADC_TSX_TEMP				0x0b
+#define AUXADC_HPOFS_CAL			0x0c
+#define AUXADC_DCXO_TEMP			0x0d
+#define AUXADC_VBIF		    		0x0e
+#define AUXADC_IMP			    	0x0f
+#define AUXADC_IMIX_R				0x10
+#define AUXADC_VTREF				0x11
+#define AUXADC_VSYSSNS				0x12
+#define AUXADC_VIN1				    0x13
+#define AUXADC_VIN2			    	0x14
+#define AUXADC_VIN3			    	0x15
+#define AUXADC_VIN4			    	0x16
+#define AUXADC_VIN5			    	0x17
+#define AUXADC_VIN6			    	0x18
+#define AUXADC_VIN7		            0x19
+
+#define AUXADC_CHAN_MIN				AUXADC_BATADC
+#define AUXADC_CHAN_MAX				AUXADC_VIN7
+
+#define ADC_PURES_100K				(0)
+#define ADC_PURES_30K				(1)
+#define ADC_PURES_400K				(2)
+#define ADC_PURES_OPEN				(3)
+
+#define ADC_PURES_100K_MASK			(ADC_PURES_100K << 8)
+#define ADC_PURES_30K_MASK			(ADC_PURES_30K << 8)
+#define ADC_PURES_400K_MASK			(ADC_PURES_400K << 8)
+#define ADC_PURES_OPEN_MASK			(ADC_PURES_OPEN << 8)
+
+#endif /* _DT_BINDINGS_MT635X_AUXADC_H */
-- 
2.45.2


