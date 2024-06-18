Return-Path: <linux-pwm+bounces-2496-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F2890C682
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 12:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 076F01F21A14
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 10:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A8113DB8A;
	Tue, 18 Jun 2024 07:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="N5n41eLn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EE613B2BC;
	Tue, 18 Jun 2024 07:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718697187; cv=none; b=oj+OSk4jf/xgZZPminYHBWxx983KMjfFT1DK+t7Uo5JbsMO3F0qV3DNm3YvQHboGmGLtu9IZt27MU7l3zOVIh/eNRSt/QnZD0MzzMK88MH0g20LOgwZ6XQw9kBXlGHqZLUtVLxAscH1K/z723bOlSIeP+TqXrAs26qKiaJCj/Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718697187; c=relaxed/simple;
	bh=osx21kvGnJyFh64uNZnS8oKIVt1xVrKC8xd4UBtlcoY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LxGCdu+HiMdBnqyE2WbmzC/kQkmgCIp0/0XNXxNysEmWCniXaVP+4u2bhXDFzZCMkVv12ME9a9/MxG70C/uJdmH4N880OVxOKkqd1GumRL7t4eVdBT3Oyw5l6UKi9gBKDfb1iAzTdkzuSLgxB7igHSKWAFOE8sCPqW5nIYW7qgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=N5n41eLn; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718697177; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Gz6wNGfvdFsPXfysZrj4qUzWvbWP+zk6QsQzAnDA9JM=;
	b=N5n41eLn1vd0rVnvPxN1x3qvSFOqwfC3txKJWu3Ex4YmpLqqbo4on097FV0UQ7aMonU6i8TRGR7fKrkFYijIf42xIqItLGAOWnEq8VLUYLlLzHm22boTXSrm12nUTyhQAqUjnKu3FshsQ3WEssmPennbwzFHRvEdFjQFMSq6zaM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W8jR6-i_1718697170;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W8jR6-i_1718697170)
          by smtp.aliyun-inc.com;
          Tue, 18 Jun 2024 15:52:57 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: ukleinek@kernel.org
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] pwm: core: Use str_plural() in pwm_seq_show()
Date: Tue, 18 Jun 2024 15:52:48 +0800
Message-Id: <20240618075248.1325-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use existing str_plural() function rather than duplicating its
implementation.

./drivers/pwm/core.c:1690:6-16: opportunity for str_plural(chip->npwm).

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9352
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/pwm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 5c1d20985148..141c5003b216 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -1687,7 +1687,7 @@ static int pwm_seq_show(struct seq_file *s, void *v)
 		   (char *)s->private, chip->id,
 		   pwmchip_parent(chip)->bus ? pwmchip_parent(chip)->bus->name : "no-bus",
 		   dev_name(pwmchip_parent(chip)), chip->npwm,
-		   (chip->npwm != 1) ? "s" : "");
+		   str_plural(chip->npwm));
 
 	pwm_dbg_show(chip, s);
 
-- 
2.20.1.7.g153144c


