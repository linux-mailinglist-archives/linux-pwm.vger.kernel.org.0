Return-Path: <linux-pwm+bounces-7615-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A38C4C04D
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Nov 2025 08:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C1F24F76D6
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Nov 2025 07:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A3C350D7D;
	Tue, 11 Nov 2025 07:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OA0jv1a2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EACB34EEF3;
	Tue, 11 Nov 2025 07:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762844565; cv=none; b=IlTDjoX6RrP2oZkDuEERHIb5sRlIo6zaEYhStKYq0Tqtp/VAoQSSL+BWOHNH7zIBePrZxg+55qIsTbaK+lBoRJOC7kVaXvmnlrKIEFZ8KS54jjS/SJcuZGdgDr4ADHysAYzg0T8Yi4ELUwYkrND57sToZ8d+f2E34ECDiZ0d+lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762844565; c=relaxed/simple;
	bh=AMBRpVBqPwon3x84ff34xAAeCB3px48dtWV2ju+HFnM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ms/3aa99/1VnOdb+oUnu9L4ZfNe7vFj4FRY43rUYwQilPXlW7HikvVID9CW3rD5S1ZFzwpsQF8Vj9dNItFWpSTPDAFmjV230DMqA4S0ai9NSvvS3vA0pTlmZaDIaGRW+RIzfvgth9ZkKeHFpKUoxEAjFkm54J8S2NEba14X3cJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=OA0jv1a2; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 64d22fe4becc11f08ac0a938fc7cd336-20251111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=XJEnXUEG6vZWLXTM9F/rXFXxzsyh5CEun4xXmQa9mXM=;
	b=OA0jv1a2Ok3rC+nHEqeT/0rGGhjkY4OWMM2U1Yd0N3juY/katVC86YxQ5AEm886Ea79c1lr6d/L047J42xQ6EIZGbmgTZABRB8obYnx84N4QRgktrvhCFFKBKIV64cRZRNQ4L3OzNM67PWLybwLUZIgaAIjk/rObC7pv/DBl8lQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:f50009c3-061a-4350-9843-fc4a56cdf9f5,IP:0,UR
	L:0,TC:0,Content:54,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:54
X-CID-META: VersionHash:a9d874c,CLOUDID:fa8ec357-17e4-43d2-bf73-55337eed999a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	3|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 64d22fe4becc11f08ac0a938fc7cd336-20251111
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <jh.hsu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 156860285; Tue, 11 Nov 2025 15:02:32 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
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
	<jh.hsu@mediatek.com>, Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v7 4/9] dt-bindings: timer: Support MediaTek MT8189 timer
Date: Tue, 11 Nov 2025 14:59:18 +0800
Message-ID: <20251111070031.305281-5-jh.hsu@mediatek.com>
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

add compatible string for mt8189 dts node of timer

Signed-off-by: Jack Hsu <jh.hsu@mediatek.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>

---
Changs in v7:
 - update dt-bindings commit msg
   (use "mt8189" instead of "mt8189 evb board")
   
---
 Documentation/devicetree/bindings/timer/mediatek,timer.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/mediatek,timer.yaml b/Documentation/devicetree/bindings/timer/mediatek,timer.yaml
index 337580dc77d8..8e705fe58dc5 100644
--- a/Documentation/devicetree/bindings/timer/mediatek,timer.yaml
+++ b/Documentation/devicetree/bindings/timer/mediatek,timer.yaml
@@ -44,6 +44,7 @@ properties:
               - mediatek,mt8183-timer
               - mediatek,mt8186-timer
               - mediatek,mt8188-timer
+              - mediatek,mt8189-timer
               - mediatek,mt8192-timer
               - mediatek,mt8195-timer
               - mediatek,mt8196-timer
-- 
2.45.2


