Return-Path: <linux-pwm+bounces-8758-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCWyKk9X9GkCAwIAu9opvQ
	(envelope-from <linux-pwm+bounces-8758-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 01 May 2026 09:33:35 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E19C4AAFCC
	for <lists+linux-pwm@lfdr.de>; Fri, 01 May 2026 09:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C420B30151CA
	for <lists+linux-pwm@lfdr.de>; Fri,  1 May 2026 07:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B4E366DA3;
	Fri,  1 May 2026 07:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jizN4cyk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F05721CC5C
	for <linux-pwm@vger.kernel.org>; Fri,  1 May 2026 07:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777620800; cv=none; b=BWAP3UvaklwQhQZe2MPb+XCadPLas6R3NVhqno6Ak9naaJasrUs79nQ22cx+TgF3Jvmm/NB7rQ/iVMbvy0jq4HJKsFY5v+F8C152HDgDdF810OvQMVuLTvXiVbmR9/AtIJk8tGPKWkh3NfqnzMQINginNI4HO9NTYCUnHJ3jX5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777620800; c=relaxed/simple;
	bh=f4ytoeoPomm5tYmISrt8VX4ssSEEKL+vgSrubij9sWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rZ+09yxKbup3F941T4f7zGEt3BpcFwGSSAZZeiAihFhpYXoF++7jNjY7CvgmxEiisR3BYWvPkTr94P8com3L45Vq2KjuCr0rx9COeTgN1EflQE1XfjJGc409RLE6NZYnVVP7WVZTSbUm5x4Qmw89RSBbE+FTVvgRIGJj+GOabXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jizN4cyk; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-364d72f2986so983569a91.3
        for <linux-pwm@vger.kernel.org>; Fri, 01 May 2026 00:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777620798; x=1778225598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eEGH/Mz9b26kwzXLbg9yiEa8TTkjExptNbsoCdY3tLk=;
        b=jizN4cykeAH2Wb+JNfi6CKYX/WVQuazQ/63O5VzxsV7Onw3n5y4zCzaJ/Sl0zauIKL
         1H7xk30eOWqDGlQ2yI1sdXiGnSpHVZSpAmF2gJY/rxPLiAX944WEZzG04iCK3qiXSeBz
         Q8kskIBUgDc3nYyASDxsoxiSSH2z+c29/xk+rH0HonQ43fJ0HKuMx0LWyoVuZTRkWRKR
         Y2Sl7Y0ClxsXk6h0FRIosGd0nqsg0twBaoR1HYIv7NuJpVTVYdHPGjSOom+2SajB6YF4
         LyMMJ82gZmBSs/ICca3jMs8+7iAl86rE1TaSTg9/5f2Bb9RSH6oGoDkghaG00Y14cZbK
         CH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777620798; x=1778225598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eEGH/Mz9b26kwzXLbg9yiEa8TTkjExptNbsoCdY3tLk=;
        b=svEy//aEPdRm2aBy9IBRaJ7xMaAL5sW369MrB8BWy3xIP+7qJU2ZXx7shfRQyK8FH9
         usp3EoQo9aPxpiHlx+VLePAg18LJ5eRcNLEsv6FYGpaY/VEZtxE7rZeUeCZW+V694dnA
         tdxPkvAJrIj6tedUvuALaVYFlyISi8uSvvDzxzwBHXRlT9ADOXjvqK/ILof69oM84GiK
         Jv58HLFkWbqaZXDL32/dOKhqMVvu5PJjoCnlYxeWIV/Qyqtzhm2kcJg4Kyzi56mu/gro
         iTlTmFyArYPlqTtHFD/PAv+lX2ZZ6azPWcTUKpaJuF0s4yRDpNw2Pq46TDViYnQ2COJ8
         ZaYQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ylj2GIJbogUgnEpLj88zKLhAAlHKYWW0aflpbAXouwNogD1vLFomUCvDXIMJ8WPJnMVFUGEf1wNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnPuuTTCSW8g+XscscdEffIpzJqbwGqRjF/LwFFmNyTNqXEDxb
	V1wdde+umThc9Vjf14nzRr0H1lstlrvyZ01Li5Dj0Izu8ktUaAEL1OuY
X-Gm-Gg: AeBDievX5XfpIMSoUUJGFXTG8TYY8CHQvLpjBP0ZZ0O0rQYamC0vDgl+aopOb02sqGH
	eJFxtt71jzvG08hHMT8Rk8n+6i15sNz1CggJtvdKCZ+7c+Gdr11rvzJ60fVaxJjq+tHXQ3uxI0V
	iIcWbS5+eg3l2ugNeHM3jAMZ3GvCL7KNnLNphIQojx2b5oJOyCc0zZ+tNV3fbyDOR7e8hmtlG+n
	2iYU5MLuEy1qRmHD3d+tGcxPAUszKuQgB4CN3+Y/tmQG7L60BokngP1/gcUFjHn+xkh1X9WDlEB
	Sh1fgLaUnEDQlBYmxl8kBKkq1/1G3s8h2EO0T8775x3mRw3OLgMQsfc6nLSWN0E84UKNO6f0YxR
	YYyJEOW8CKKACYCjkpeF9KcA1flcg2aSVuNu0+QW97XocEoFUF7K4Ue3JfP5B3pd/QfaVu5lJ28
	NzRlmf+umrb1AjilnuROJNfZJiQeUB56bNt9qBUqV13IEZa2Ve+KA2Sdr1LHDdKHkRlo+Jnb+IM
	56Cig==
X-Received: by 2002:a17:90b:55cf:b0:35f:b940:4e81 with SMTP id 98e67ed59e1d1-364ef501f66mr2206239a91.16.1777620797619;
        Fri, 01 May 2026 00:33:17 -0700 (PDT)
Received: from Ubuntu.. ([49.37.171.148])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ebf12bcesm1481466a91.7.2026.05.01.00.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 00:33:17 -0700 (PDT)
From: Manish Baing <manishbaing2789@gmail.com>
To: ukleinek@kernel.org,
	thierry.reding@gmail.com,
	linusw@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	manishbaing2789@gmail.com
Subject: [PATCH] dt-bindings: pwm: stmpe: convert to DT schema
Date: Fri,  1 May 2026 07:33:05 +0000
Message-ID: <20260501073305.5866-1-manishbaing2789@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1E19C4AAFCC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[gmail.com,foss.st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-8758-lists,linux-pwm=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[manishbaing2789@gmail.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_HAM(-0.00)[-0.997];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,devicetree.org:url]

Convert the STMicroelectronics STMPE PWM controller bindings
from text format to YAML schema.

Signed-off-by: Manish Baing <manishbaing2789@gmail.com>
---
 .../devicetree/bindings/pwm/st,stmpe-pwm.txt  | 18 --------
 .../devicetree/bindings/pwm/st,stmpe-pwm.yaml | 41 +++++++++++++++++++
 2 files changed, 41 insertions(+), 18 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/st,stmpe-pwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/st,stmpe-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/st,stmpe-pwm.txt b/Documentation/devicetree/bindings/pwm/st,stmpe-pwm.txt
deleted file mode 100644
index f401316e0248..000000000000
--- a/Documentation/devicetree/bindings/pwm/st,stmpe-pwm.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-== ST STMPE PWM controller ==
-
-This is a PWM block embedded in the ST Microelectronics STMPE
-(ST Multi-Purpose Expander) chips. The PWM is registered as a
-subdevices of the STMPE MFD device.
-
-Required properties:
-- compatible: should be:
-  - "st,stmpe-pwm"
-- #pwm-cells: should be 2. See pwm.yaml in this directory for a description of
-  the cells format.
-
-Example:
-
-pwm0: pwm {
-	compatible = "st,stmpe-pwm";
-	#pwm-cells = <2>;
-};
diff --git a/Documentation/devicetree/bindings/pwm/st,stmpe-pwm.yaml b/Documentation/devicetree/bindings/pwm/st,stmpe-pwm.yaml
new file mode 100644
index 000000000000..4d5b43c9e7fa
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/st,stmpe-pwm.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/st,stmpe-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STMPE PWM controller
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+  - Thierry Reding <thierry.reding@gmail.com>
+
+description:
+  This is a PWM block embedded in the STMicroelectronics STMPE
+  (ST Multi-Purpose Expander) chips. The PWM is registered as a
+  subdevice of the STMPE MFD device.
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: st,stmpe-pwm
+
+  "#pwm-cells":
+    const: 2
+
+required:
+  - compatible
+  - "#pwm-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    stmpe {
+        pwm {
+            compatible = "st,stmpe-pwm";
+            #pwm-cells = <2>;
+        };
+    };
-- 
2.43.0


