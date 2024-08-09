Return-Path: <linux-pwm+bounces-2987-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 153AE94CBD7
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Aug 2024 10:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C39AA1F21D89
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Aug 2024 08:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C34176226;
	Fri,  9 Aug 2024 08:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZMaLTIPC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B94C8D1;
	Fri,  9 Aug 2024 08:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723190743; cv=none; b=M20Ga9PlA23Y1PQj2I4sUVoenAw9tZ3EHcwQr0sQG1RthpkwtH6IIOGZncw6js2CZwB+OI6kalxEfV1+DrsMxN6m3hWVroKbYOPH+ZIHU9VSl9HQtcDXrWYLq/Dzz8jKP/PeT/fWaCW8XuG+sTYJlgorSSMJSqt+fI/EfdLMW6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723190743; c=relaxed/simple;
	bh=PV2/IPy3/F9H9IEkab5gV/JXvBjk34SNXEZw8Og8RPg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gxfZotTF4QTBPt66aQlkGf22Tg/I33JMj4GlfAL0QvlGjxorJo38QF/syU0cWnZA24YmuoHVGArmc7VnXTxUtbevoYhfWFW55wDO6N6LdcsAiiWAmKC5Nrpjj6A4MXpcSbRd03Q1tRMLQh7pjMIMD1qF0DtlmFh5b1A4haqFE+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZMaLTIPC; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723190732; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=NwcqZgI6fC9qkkzgxcvY/VNJ+r0cNe7XQ8n4c/eG3Ig=;
	b=ZMaLTIPCIT4368EG4Fe3wMD5MzjekcCE00FWGMWwb0jNsSKGrYC99h61n8vSWhM8GWAMgV8T8Ycwr9UOrtfMXQWzxnSJfu6yLauGaHmhSnFfLoa4K8YekFo4h1GsbT01L7k2IdU2PbAmOJXNDqTF+s9MXr9ny5BZKS/z6OrZq8I=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0WCPEg4x_1723190725;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WCPEg4x_1723190725)
          by smtp.aliyun-inc.com;
          Fri, 09 Aug 2024 16:05:31 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: ukleinek@kernel.org
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] pwm: lp3943: Fix an incorrect type in lp3943_pwm_parse_dt()
Date: Fri,  9 Aug 2024 16:05:23 +0800
Message-Id: <20240809080523.32717-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The return value from the call to of_property_count_u32_elems() is int.
However, the return value is being assigned to an u32 variable
'num_outputs', so making 'num_outputs' an int.

./drivers/pwm/pwm-lp3943.c:238:6-17: WARNING: Unsigned expression compared with zero: num_outputs <= 0.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9710
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/pwm/pwm-lp3943.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-lp3943.c b/drivers/pwm/pwm-lp3943.c
index f0e94c9e5956..90b0733c00c1 100644
--- a/drivers/pwm/pwm-lp3943.c
+++ b/drivers/pwm/pwm-lp3943.c
@@ -218,8 +218,7 @@ static int lp3943_pwm_parse_dt(struct device *dev,
 	struct lp3943_platform_data *pdata;
 	struct lp3943_pwm_map *pwm_map;
 	enum lp3943_pwm_output *output;
-	int i, err, count = 0;
-	u32 num_outputs;
+	int i, err, num_outputs, count = 0;
 
 	if (!node)
 		return -EINVAL;
-- 
2.32.0.3.g01195cf9f


