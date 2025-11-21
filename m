Return-Path: <linux-pwm+bounces-7661-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A30CEC7AC48
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Nov 2025 17:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F9344E99E5
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Nov 2025 16:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FF13538A0;
	Fri, 21 Nov 2025 16:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYpu23TB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A93B34DB55
	for <linux-pwm@vger.kernel.org>; Fri, 21 Nov 2025 16:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763741344; cv=none; b=gqxcvomJI0mPpr6Gf57H35571uO8CA0tR9gz854mVzI+JC2cqxLVVObk7BVpIDoUo4AUVfLdg0ynn2/M8ffKBu0JmYXzu9cA7M3yKLnsUBu/Q1pQpVu7tix/ZIgaSubMrjcj/tOutd0PdVOlkwBSFTpbaqmIp/gwxqNgJRJs3TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763741344; c=relaxed/simple;
	bh=A0Ss2FjsUCOJF7j5tDObMG5r/Eb7H5jpKMO+13IpeQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjSags1vwMmIHi5meM0rg7xXwtFQ0kpuN0MQkwA5tcNFCVcj4q1yn+y3hGYURPoShbCIF02aAihr2W7Y5RqdsEeXkeet2GGGxKzPEYt+9iQLQM+L+cHYmE/rewxjJhcKTy0diKgnmD5G54n+sswhQ1zGCFuMrAjRC2pqKMzKdlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYpu23TB; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so21137875e9.2
        for <linux-pwm@vger.kernel.org>; Fri, 21 Nov 2025 08:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763741335; x=1764346135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+pSoQWtQTSE8J9RasiAG9yE97LqZssvT14IYVKYS4U=;
        b=AYpu23TBKaPJd29lbkS1a9JJuK5I8bnYNrXI2ApB/yny1Xs0V2qVEY8V/SM44oJ587
         WC/ckuwblsPR5bKbDZff1Q6c275DDF8BhjQ2+K2VN3vjYgfMLF4fs9+2MG0ZxzwKy05C
         6x5AEZTjqd15bGCSWtgTF5BJZ9PsBP0Csy+YW3KpivzZdDzKGBPfrH8uxQ9/bv+et66E
         av4sRdft1bO35ERXs5AUd8GSxRQr3Si2Gf+N09NfdHwbfDB6brLZE9AicKpN8djJWxwN
         RaI8Vce5afxrU/tdKjb3XoOkwpYu5beKiDX7cltcmvvzD7X9g4fvyjzUXzPz/2dJCWV7
         LbXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763741335; x=1764346135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m+pSoQWtQTSE8J9RasiAG9yE97LqZssvT14IYVKYS4U=;
        b=WgfXtd66IHNE0i3rgWPAPA8EuvRRR8TJBOAfozb7O2Mdt9TGQ7VgeTwIAuZcciW/ti
         +mvBerWl06Mrnkb+OhxYZVXQjSJc8qEdqklvjr27zrqol835KngNXvNstvb9C7FArdoN
         AeVtNNj+q+np5dqKyJWp4ru0hgbknlDhI2UkY1Qy6t65cV/vQ3G8on3facf0xwTUg7P0
         U6yKQRjT+Fl0epXWlGfr0+UK0/Ydqpjt7USPPPWHOihsrjZwnd5gle4it7ig2249qyF1
         bP+RayF9PDPgdQ8tN/UfNtDPYrW7Z76foXkNKxpn5xYhR4UGfoxio9fBOiBH4r8sthWm
         ZKXA==
X-Forwarded-Encrypted: i=1; AJvYcCXu8WrFVi4VChjCW0RrM/xvOZY1tIfGRYmJ9ufGqfRArm6X0uanrdpXONleVWs66vpxaCuFF2Fq+GI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBN2IMflvx5jDD1uFUH9eBQgB93P35f7aZFkR5gK1TDAbPxRP6
	41Twm4D7rRWLjB3Tjkbx8uMdFbHPP4b+Mv5oeztH3vo7UoQ/Dj64Qsz6
X-Gm-Gg: ASbGncsFwr0nS8PdDJmSkqDzogQZ0lxPDC6WK0qmRDbp5K73F2yXG+q2994nnl2IN8S
	VFDQIyqWtY0DjiLXNlqFm55/NE23JetCMrxCI74nPoM+XBcTasWib15JnT1d9yjiLK8YCG34Zst
	eHzLDjn6Ar3mvrT5i3WSmPq1hWky2iVhTUvdWqkNe0QN+aJR1qgTDTzPYmjMwCMiSLpGkC/mWO/
	yP5rwCfhdF6nHhDhky5gEfvx2TJDPTZANfQuocDASspQSuBUjb/Ra3LDX2tvhW4B1qUly8UR7Pr
	c7F9k8475KMhm443tGmsRzIM3dwbR0Xa8Jy8X5F2re3UCvqjgLIdiy0OlzCyJ5eiI/CN69msl05
	Bv6e+XnHdjZVjDKGiep5nDHPEQ13Yd08DuRB9Hlzz2FLi5fVilOmpmekGdrhd1BfCQF70XLHF4J
	vos527QwRdYZHRnbtskRcGyUmDqfIouTDpDW5eWrvgbF0WeP6qn29Ozi+bL+ZifoW7pbFb8HY=
X-Google-Smtp-Source: AGHT+IF2b7f+ZBHK25E9+K489GOtqsYf7pKr0K3jFgK2oZkdroqRS+XqRE/MrqLwRM3wLWl2YED7xA==
X-Received: by 2002:a05:600c:4746:b0:477:9eb8:97d2 with SMTP id 5b1f17b1804b1-477c017d7e8mr26152805e9.8.1763741335414;
        Fri, 21 Nov 2025 08:08:55 -0800 (PST)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9dea7fcsm89496195e9.8.2025.11.21.08.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 08:08:55 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: [DO NOT APPLY PATCH v8 15/15] tools: poeg: Add support for handling GPT output request disable
Date: Fri, 21 Nov 2025 16:08:22 +0000
Message-ID: <20251121160842.371922-16-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121160842.371922-1-biju.das.jz@bp.renesas.com>
References: <20251121160842.371922-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Add support for handling GPT output request disable. When GPT
detects output disable condition, it request POEG and POEG
triggers an interrupt after disabling the output. the clearing
of interrupt happens in GPT. Add support for handling this in
userspace, when POEG triggers interrupt, it sends an event to
user space and user space send clear command to clear the gpt
request for output disable.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 tools/poeg/poeg_app.c | 57 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 47 insertions(+), 10 deletions(-)

diff --git a/tools/poeg/poeg_app.c b/tools/poeg/poeg_app.c
index 4ff8e5c007dc..71f130d5aad2 100644
--- a/tools/poeg/poeg_app.c
+++ b/tools/poeg/poeg_app.c
@@ -20,9 +20,11 @@
 
 int main(int argc, char *argv[])
 {
+	struct poeg_event event_data;
 	struct poeg_cmd cmd;
 	unsigned int val;
 	long cmd_val;
+	int ret, fd;
 	char *p;
 	int i;
 
@@ -36,17 +38,52 @@ int main(int argc, char *argv[])
 	else
 		printf("[POEG]open\n");
 
-	cmd.val = cmd_val;
-	cmd.channel = 4;
-	if (cmd.val == RZG2L_POEG_OUTPUT_DISABLE_USR_ENABLE_CMD)
-		printf("[POEG] user control pin output disable enabled\n");
-	else
-		printf("[POEG] user control pin output disable disabled\n");
+	if (cmd_val == RZG2L_POEG_OUTPUT_DISABLE_USR_ENABLE_CMD ||
+	    cmd_val == RZG2L_POEG_OUTPUT_DISABLE_USR_DISABLE_CMD) {
+		if (cmd_val == RZG2L_POEG_OUTPUT_DISABLE_USR_ENABLE_CMD)
+			printf("[POEG] user control pin output disable enabled\n");
+		else
+			printf("[POEG] user control pin output disable disabled\n");
+
+		cmd.val = cmd_val;
+		cmd.channel = 4;
+		ret = write(fd, &cmd, sizeof(cmd));
+		if (ret == -1) {
+			perror("Failed to write cmd data");
+			return 1;
+		}
+	} else {
+		printf("[POEG] GPT control configure IRQ\n");
+		cmd.val = RZG2L_POEG_GPT_CFG_IRQ_CMD;
+		cmd.channel = 4;
+		ret = write(fd, &cmd, sizeof(cmd));
+		if (ret == -1) {
+			perror("Failed to write cmd data");
+			return 1;
+		}
+
+		for (;;) {
+			ret = read(fd, &event_data, sizeof(event_data));
+			if (ret == -1) {
+				perror("Failed to read event data");
+				return 1;
+			}
 
-	ret = write(fd, &cmd, sizeof(cmd));
-	if (ret == -1) {
-		perror("Failed to write cmd data");
-		return 1;
+			val = event_data.gpt_disable_irq_status;
+			if (val) {
+				/* emulate fault clearing condition by adding delay */
+				sleep(2);
+				for (i = 0; i < 8; i++) {
+					if (val & 7) {
+						printf("gpt ch:%u, irq=%x\n", i, val & 7);
+						cmd.val = RZG2L_POEG_GPT_FAULT_CLR_CMD;
+						cmd.channel = 4;
+						ret = write(fd, &cmd, sizeof(cmd));
+					}
+					val >>= 3;
+				}
+			}
+		}
 	}
 
 	if (close(fd) != 0)
-- 
2.43.0


