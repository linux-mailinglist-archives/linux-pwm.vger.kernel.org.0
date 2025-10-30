Return-Path: <linux-pwm+bounces-7543-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D712C205CE
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 14:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AD5C1892C4D
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 13:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F373C25EF9C;
	Thu, 30 Oct 2025 13:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ibZ2iwJL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D9423AB8E;
	Thu, 30 Oct 2025 13:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761832064; cv=none; b=TUp3uUBLWfgwJm8nrRWSzPIJe1b/VfYgTWfjmoSzZiqBm2NHMkIKcVcKd7VGO7LOJBTwBfTgRpA6kpqwqUQiVibnx8SSdXw2oDu+yh8MitJjcbHg0NzwIVmRwm/j8uoRVY3rnw4yXw7NCLBUBXPLa8dkoIWclKcNY6WvSu2N6+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761832064; c=relaxed/simple;
	bh=NZg/oxKn7fW7jMI/h+J3YFo/XNwx85iF/PDTQmCtJcA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pRABirLjEe9yMeLQUUcwpGCuxiu0rcWu7f3dD6ZJhblQdIMY0BDnSEatWutNA4+iu5YyXKNUE3oeLl/0C5aSqCw6O6WIrFrLSth08ZKItg6y9jQx8WvP8TOwgjEogIP9/pTE4jsqcNhu3n4mv6qOGlFTGU0duFMTskbTNtNyS98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ibZ2iwJL; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: fbf03bdab59611f0b33aeb1e7f16c2b6-20251030
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=+I5W8kSXBIH2OskTzYbpCFMTm8Tfj4NAhf2p2c9a7XQ=;
	b=ibZ2iwJLZrRgy3sOHfYk/fWicFSAjFeIAmC6k9QoOtTKj+vafeiFURz+fKmn1YUYczFQunT+V/dxGx3ZSYhJ0e8pMjMXg6RSuO6z6oq+usm+MBUUeKhv4I0ziaoigtAJWDYvFgpeRmzhhvlXtxhY4odztsafmtUyA42ihPW9weo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:42673499-5e55-4be3-a72c-3a32cca34b0e,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:73c8db6a-d4bd-4ab9-8221-0049857cc502,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: fbf03bdab59611f0b33aeb1e7f16c2b6-20251030
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <jh.hsu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1997488647; Thu, 30 Oct 2025 21:47:32 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 30 Oct 2025 21:47:30 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Thu, 30 Oct 2025 21:47:30 +0800
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
Subject: [PATCH v6 04/11] dt-bindings: pwm: Support MediaTek MT8189 evb board disp-pwm
Date: Thu, 30 Oct 2025 21:44:36 +0800
Message-ID: <20251030134541.784011-5-jh.hsu@mediatek.com>
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

add compatible string for mt8189 evb board dts node of disp-pwm

Signed-off-by: Jack Hsu <jh.hsu@mediatek.com>
---
 Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
index 68ef30414325..22712769518b 100644
--- a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
+++ b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
@@ -30,6 +30,7 @@ properties:
               - mediatek,mt6893-disp-pwm
               - mediatek,mt8186-disp-pwm
               - mediatek,mt8188-disp-pwm
+              - mediatek,mt8189-disp-pwm
               - mediatek,mt8192-disp-pwm
               - mediatek,mt8195-disp-pwm
               - mediatek,mt8365-disp-pwm
-- 
2.45.2


