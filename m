Return-Path: <linux-pwm+bounces-931-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6B183B798
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 04:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E0BA288B58
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 03:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92DA748D;
	Thu, 25 Jan 2024 03:09:28 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFED5111B1;
	Thu, 25 Jan 2024 03:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706152168; cv=none; b=L0rzycMIAMzbDciGYe+ol4M/kLAEU2Dc5CzIJqHk2jZ9tXKm/VRP71+KGtr8uoS1LX8COxLd691WSWOl7curThmVxpEgI0QhKanD73XcwDM4CwXyRmaKFkvouqt/UhFE5ASiPSv/wWY8R8NUtPA/TK6ECwWiQX+MKQ9kbCVQ0Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706152168; c=relaxed/simple;
	bh=QdoVm85CYjnptAKMSZUac9+Lf2ap7MRXkWP7LpnIxeU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sFmJ5iqVMbs2LxYWk07MjixQojZ2lIFdwg5CckHbNcY4vsHc4RwLmcPuoN9U4dRspV6TXhd6/EbEwmdpuph0RIBjyTkTsLU/zRrPFpcGfNPE/nKN8nIAIwbcjbQ8/YUqYkd0poMWLdNZsUylMoIhR7saBztDuGoXyg3cFwr0nFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 40P38eM7061701;
	Thu, 25 Jan 2024 11:08:40 +0800 (+08)
	(envelope-from Wenhua.Lin@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TL5F76jRwz2Rq2lr;
	Thu, 25 Jan 2024 11:01:15 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx06.spreadtrum.com
 (10.0.1.11) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Thu, 25 Jan
 2024 11:08:39 +0800
From: Wenhua Lin <Wenhua.Lin@unisoc.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Rob
 Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        wenhua lin <wenhua.lin1994@gmail.com>,
        Wenhua
 Lin <Wenhua.Lin@unisoc.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>,
        zhaochen
 su <zhaochen.su29@gmail.com>,
        Zhaochen Su <Zhaochen.Su@unisoc.com>,
        Xiaolong
 Wang <Xiaolong.Wang@unisoc.com>
Subject: [PATCH V2 5/6] pwm: sprd: Add sprd,ums9620-pwm compatible
Date: Thu, 25 Jan 2024 10:55:32 +0800
Message-ID: <20240125025533.10315-6-Wenhua.Lin@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240125025533.10315-1-Wenhua.Lin@unisoc.com>
References: <20240125025533.10315-1-Wenhua.Lin@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx06.spreadtrum.com (10.0.1.11)
X-MAIL:SHSQR01.spreadtrum.com 40P38eM7061701

Add sprd,ums9620-pwm compatible string to binding document.

Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
---
 Documentation/devicetree/bindings/pwm/pwm-sprd.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-sprd.yaml b/Documentation/devicetree/bindings/pwm/pwm-sprd.yaml
index 81c5fd688c3c..02e039fee3b4 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-sprd.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-sprd.yaml
@@ -23,6 +23,7 @@ properties:
     items:
       - enum:
           - sprd,ums512-pwm
+          - sprd,ums9620-pwm
 
   reg:
     maxItems: 1
-- 
2.17.1


