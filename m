Return-Path: <linux-pwm+bounces-7538-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9B2C2052C
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 14:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4CE03A3D23
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 13:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C6E211499;
	Thu, 30 Oct 2025 13:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Z1fdwUFI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E07194A65;
	Thu, 30 Oct 2025 13:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761831958; cv=none; b=ZX1bHdq/bCnxodtmPUBsZgvdgWxkkkIvjvIocAPtGyBveXJ9LRFtrb+2ys/IrKMMfrNn0Lo1U6JcoIwOTTlIUZTfvMDgPgRlQrr5GsfaXe9ydCanSDThkKWOM9rn5hRce924hGWXfwJd86iv2yMWDfM9dzX1nTZLq92shuuGMFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761831958; c=relaxed/simple;
	bh=GKFw6gcF7KqqDED2EZ270pxSZAxcOCs0QnhgIKxD0iM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ta9Y6ox1yzVYzGUD1ZwL1HmvnqjHHlOnDB8qoXSAvvjNg29sHQhiqinsNJzvIfs7A3fsVYDJojf0EiOfdTvZ476hBhmTgQL5KMaJL2HQWXwpxCBfadzZkWlhYxZd8Ol4sCWQ/K44ldQNBMcNAr+auy4XYphKwxnWPKSgTnZNON8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Z1fdwUFI; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: be4fe2a8b59611f0b33aeb1e7f16c2b6-20251030
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=rVkGPwv3C6XlbO/gf5Nflh6DXGZXVeoBCqb2ZnxWmhE=;
	b=Z1fdwUFIEI4qxPAPp5IRK5/roTAYaNuUlTWvH6P52CTSNKiZagTWKC5kgyOF2ibqjeb4ZdjuJwtGctf+X3pdU1ZF62mOc8fwJKvkIrbJ8pd/X5gMQRiQV6KPhKe1h10NW/nfG0S91t1ZlXClxJByFJr8u5lxRwSuTR/IV/r59Vs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:645ddbcc-937c-4e43-8e47-e15695cefa3a,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:a9d874c,CLOUDID:5ca16e26-cfd6-4a1d-a1a8-72ac3fdb69c4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: be4fe2a8b59611f0b33aeb1e7f16c2b6-20251030
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <jh.hsu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 990640684; Thu, 30 Oct 2025 21:45:49 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 30 Oct 2025 21:45:47 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Thu, 30 Oct 2025 21:45:47 +0800
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
Subject: [PATCH v6 00/11] Add mt8189 dts evaluation board and Makefile
Date: Thu, 30 Oct 2025 21:44:32 +0800
Message-ID: <20251030134541.784011-1-jh.hsu@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

In this patch series, 
we add Mediatek MT8189 evaluation board dts, dtsi and Makefile,
and also related dt-binding documents.

based on tag: next-20251029

Note:
This patch series depends on following dt-binding headers and yamls
1.dt-binding headers
  1. mt8189-pinfunc.h
       https://patchwork.kernel.org/project/linux-mediatek/patch/20250919020525.7904-1-ot_cathy.xu@mediatek.com/
  2. mt8189_gce.h 
       https://patchwork.kernel.org/project/linux-mediatek/patch/20250820093831.23437-3-xiandong.wang@mediatek.com/ 
  
2.dt-binding yamls
  1. smi-common.yaml, smi-larb.yaml
        https://patchwork.kernel.org/project/linux-mediatek/patch/20251027121443.16783-2-zhengnan.chen@mediatek.com/
  2. mediatek,gce-mailbox.yaml
        https://patchwork.kernel.org/project/linux-mediatek/patch/20250820093831.23437-2-xiandong.wang@mediatek.com/
  3. mediatek,ufs.yaml
        https://patchwork.kernel.org/project/linux-scsi/patch/20251016-mt8196-ufs-v2-1-c373834c4e7a@collabora.com/
  4. mediatek,iommu.yaml  
        https://lore.kernel.org/linux-mediatek/20251018132625.14428-2-zhengnan.chen@mediatek.com/
  5. gce-mailbox.yaml
        https://patchwork.kernel.org/project/linux-mediatek/patch/20250820093831.23437-2-xiandong.wang@mediatek.com/
  6. disp_isp yamls
        https://lore.kernel.org/linux-mediatek/20251020074211.8942-1-xiandong.wang@mediatek.com/
  7. jpeg yaml
        https://patchwork.kernel.org/project/linux-mediatek/patch/20250528095748.17485-2-jianhua.lin@mediatek.com/  
        https://patchwork.kernel.org/project/linux-mediatek/patch/20250528095748.17485-3-jianhua.lin@mediatek.com/   
  8. vcodec yaml
        https://lore.kernel.org/linux-mediatek/20251016060747.20648-2-kyrie.wu@mediatek.com/      
        https://lore.kernel.org/linux-mediatek/20251016060747.20648-8-kyrie.wu@mediatek.com/ 
  9. mtk-sd.yaml
        https://patchwork.kernel.org/project/linux-mediatek/patch/20250818114855.8637-1-mengqi.zhang@mediatek.com/   
  10. mtk,scp.yaml
        https://patchwork.kernel.org/project/linux-mediatek/patch/20250924084422.4604-2-huayu.zong@mediatek.com/
  11. pwrap/spmi yaml  
        https://patchwork.kernel.org/project/linux-mediatek/patch/20250801070913.3109-2-niklaus.liu@mediatek.com/
  12. mt8189-nau8825.yaml
        https://lore.kernel.org/linux-mediatek/20250905071659.25805-10-Cyril.Chao@mediatek.com/
  13. mt8189-afe-pcm.yaml           
        https://lore.kernel.org/linux-mediatek/20250905071659.25805-8-Cyril.Chao@mediatek.com/
  14. mediatek,ufs.yaml
        https://patchwork.kernel.org/project/linux-scsi/patch/20251016-mt8196-ufs-v2-1-c373834c4e7a@collabora.com/


---
Changs in v6:
 - add/fix dt-bindings for mt8189 dts node
 - add pmic mt63xx dtsi for mt8189 evb board
 - add complete device node of mt8189 evb board
 - Fix previous version review comments
 - Link to v5: https://patchwork.kernel.org/project/linux-mediatek/cover/20250718075630.644870-1-sirius.wang@mediatek.com/

Changs in v5:
 - remove unused cpu-dile-state definition.
 - change memory size in "reg" property which if filled in by bootloader.

Changs in v4:
 - Correct cpu-idle-states.
 - Change the "reg" property name of the "memory" node in the
   device tree source (DTS) to lowercase.

Changs in v3:
 - Move ulposc and ulposc3 before cpu nodes.
 - Refactor cpu-map to a single cluster0.
 - Change cpu nodes name from medium core to big core.
 - Move psci before timer nodes.

Changs in v2:
 - Fix warning issues for make CHECK_DTBS=y.
 - Add mediatek,uart.yaml document.

---

Jack Hsu (11):
  dt-bindings: arm: Add compatible for MediaTek MT8189
  dt-bindings: iio: adc: Support MediaTek MT8189 evb board auxadc
  dt-bindings: nvmem: Support MediaTek MT8189 evb board efuse
  dt-bindings: pwm: Support MediaTek MT8189 evb board disp-pwm
  dt-bindings: serial: Support MediaTek MT8189 evb board uart
  dt-bindings: timer: Support MediaTek MT8189 evb board timer
  dt-bindings: usb: Support MediaTek MT8189 evb board xhci
  dt-bindings: watchdog: Support MediaTek MT8189 evb board wdt
  arm64: dts: mediatek: Add MT6319 PMIC Support
  arm64: dts: mediatek: add properties for MT6359
  arm64: dts: mediatek: Add mt8189 evaluation board dts

 .../devicetree/bindings/arm/mediatek.yaml     |    4 +
 .../iio/adc/mediatek,mt2701-auxadc.yaml       |    1 +
 .../bindings/nvmem/mediatek,efuse.yaml        |    1 +
 .../bindings/pwm/mediatek,pwm-disp.yaml       |    1 +
 .../bindings/serial/mediatek,uart.yaml        |    1 +
 .../bindings/timer/mediatek,timer.yaml        |    1 +
 .../bindings/usb/mediatek,mtk-xhci.yaml       |    7 +-
 .../bindings/watchdog/mediatek,mtk-wdt.yaml   |    1 +
 arch/arm64/boot/dts/mediatek/Makefile         |    1 +
 arch/arm64/boot/dts/mediatek/mt6319.dtsi      |   66 +
 arch/arm64/boot/dts/mediatek/mt6359.dtsi      |   20 +
 arch/arm64/boot/dts/mediatek/mt8189-evb.dts   | 1082 ++++++
 arch/arm64/boot/dts/mediatek/mt8189.dtsi      | 3014 +++++++++++++++++
 include/dt-bindings/iio/mt635x-auxadc.h       |   50 +
 14 files changed, 4249 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6319.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8189-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8189.dtsi
 create mode 100644 include/dt-bindings/iio/mt635x-auxadc.h

-- 
2.45.2


