Return-Path: <linux-pwm+bounces-8851-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCX3IYKN/2nV7gAAu9opvQ
	(envelope-from <linux-pwm+bounces-8851-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 09 May 2026 21:39:46 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD215013E9
	for <lists+linux-pwm@lfdr.de>; Sat, 09 May 2026 21:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17212300616B
	for <lists+linux-pwm@lfdr.de>; Sat,  9 May 2026 19:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75583CBE9C;
	Sat,  9 May 2026 19:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gc0Di/VS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA72F3CCA02
	for <linux-pwm@vger.kernel.org>; Sat,  9 May 2026 19:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778355582; cv=none; b=Jh6+H7e/Sou7SSlLQXYkitWj/VvucnVWDfw63wP2vhGSmGugt1p99PlnmeC0XouNlXy/wQXHjwQjQctF/c9wV01rUbJ68e9/QHnsZop2jdyu7b4AWkTZXG9wF0AAutfxfuDgED91kp05aapGBycZ6+vKmcgpfOd+gvdOo3ixFLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778355582; c=relaxed/simple;
	bh=BtlNkM7JtRsr4H1APlBzmmd0+2E3WucFpktmbWjT2nk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a88v649Mn06b6uufAlHdUi3/USHmR0Gpb2Jp9Iw2rHxbtXaRsWynnBgkRR+TFflASWjByYYXil2rVJMAqRCXWHWIuebsCwgbbZAbCRlhvaaNvjwf+wCYT42z/2rPud2Ay5F67xtG06Y0ZYulLJKaeRRdQVL8YKLWy8x4Y9c03Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gc0Di/VS; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3665b67ed66so1006203a91.1
        for <linux-pwm@vger.kernel.org>; Sat, 09 May 2026 12:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778355579; x=1778960379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a5cMbOemj5qCKf6YMBNAikh7EtC1awKMtCwgmYlIPnw=;
        b=Gc0Di/VSstcweSCs5yxkMpmFrjkx/C1uLmKLVodySybSg8ToVCnPo82IZ9Sqn0tpWc
         fcG11j22/I/AP1/j0bc4omBsuGWQRdLIzMmF5AGWnd3rKP5UV9HlYQdbVOiOYLPWjE9+
         1HGU7VrU/d/qUTWdoZuzDm5f+rujr0uhQUUon4GrHwoGJYD6SA2VgLYsA83jG1CYePSh
         YbSjuPQZWgd2fErPcnaT3eoUw3iSv3tsFzWoxKWXjAgu/b0392nJU4vE0ERsGJwrcKvK
         doFyFuX/8yZvMZUO4WMkJs60BVYLpWIizolAFJmpsgQzPj05f17a1sEkf3TuOVJmRSV6
         m3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778355579; x=1778960379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5cMbOemj5qCKf6YMBNAikh7EtC1awKMtCwgmYlIPnw=;
        b=UgN0hA0+fNiJvATXEW9SJqZmDv1O5RmAxpwodLW3BS/tWpDtnXo3EPt+MfcvV/Y06k
         jsNe/IvHwOFSrNJyi+O++Ho87kBVflHV+yePTdVbRCGzmPBv34t33QhGmtSL7+8DjGMT
         peifak+Scmv5uOVcNJIAoxNfrly45VD6AgmDUxZEl2l7VMR9l3s3joNbKF9ERf4s0q+P
         tS8qdIJE6T05V2U0+tnYtSXKXY7OChJCZURuGHGhYLYC1gJI9V1rkofrGdq1FZvWG8T6
         zrVEHN+YI7dahenUiV3VmNukmw7inf6SnP3rjtvkhAN4xF/R9revAQ5BEOkCJWQmsogE
         Ding==
X-Forwarded-Encrypted: i=1; AFNElJ/0H1M94Zp9x2yw/EYkJtaSndm9ByJWvi8iHpJ/z4e7AOnEXJaiDEihhl3ceiqJjtAZgDWAiUvfwjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn3fR/SPqiXRn3+UZTCHCqhmKg6lqyq54gxohWp4srna5xdlrc
	4sEooS5SQKHPhx+UEBRmywYlSO7lVshPLXiKjZILUsMlbwB9Sh74fTJM
X-Gm-Gg: Acq92OGMJkmFBar2iCf3P+EsPfkIHWn/dtf0jZN+Y8pBSbkTg/3FXITjYCPXPoy7tY/
	YrXbDsAdhJCd860yahg3OD8ryDJVt4iwrXRngOM9Ead8D69EKNZXtU+FjizIFFzORrDAtZSJNb3
	aiqWSbdqTsHKE0H1/jIe+kbLKLpqoMwmQURz02pRj0oQccjcn7lVEuqOVJq+2c4lwOnSMQ4YgG/
	s4HpHbSbNpzsd2o0LJf0DKU9kzpD7yBFhOEXTEFuoWGXuRTtlFS0eJMu+552rGGbnoFphrihZeT
	oOPf0NGN5rNMXRNW7e2KZfBgYUFt/1zpA5+i/sRmr+0l+pesj4vOvTyR2hGGyGMtZ52R5QvpJnM
	gVc+8EFkDZTUK0HcXUjfpZjkOZ1Fvkx73+s8ildhx1D+iwAUK/9vmPygcklsI3puKz8Qjc303oE
	NzotM25OidOzfLP91FOofn0HCVxoXrQe3Je7djzyHbQvk8BIpKfboIsXvCjPioPZPmC9zVQMiiM
	e88
X-Received: by 2002:a17:902:e750:b0:2b2:5258:a23d with SMTP id d9443c01a7336-2bc7a9ba9c0mr33335675ad.14.1778355578556;
        Sat, 09 May 2026 12:39:38 -0700 (PDT)
Received: from Ubuntu.. ([49.37.169.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d3fed8sm59690265ad.27.2026.05.09.12.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 12:39:37 -0700 (PDT)
From: Manish Baing <manishbaing2789@gmail.com>
To: lee@kernel.org,
	ukleinek@kernel.org,
	linusw@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	manishbaing2789@gmail.com
Subject: [PATCH v3] dt-bindings: mfd: st,stmpe: fix PWM schema and drop legacy binding
Date: Sat,  9 May 2026 19:39:28 +0000
Message-ID: <20260509193928.19030-1-manishbaing2789@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DBD215013E9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[gmail.com,foss.st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8851-lists,linux-pwm=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manishbaing2789@gmail.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The st,stmpe-pwm binding is already covered by the MFD schema in
Documentation/devicetree/bindings/mfd/st,stmpe.yaml. However, the
PWM subnode was missing a 'required' properties block. This allowed
Device Tree nodes to pass validation even if the 'compatible'
string was omitted. This omission could lead to probe failures
at runtime.

Fix the schema by adding the missing 'required' block and
remove the obsolete and redundant text binding file.

Signed-off-by: Manish Baing <manishbaing2789@gmail.com>
---
Changes in v3:
- Added 'required' properties to the pwm subnode in st,stmpe.yaml
  to close a validation gap identified by the Sashiko.
- Updated commit message and description to reflect MFD subsystem changes.

Changes in v2:
 - Droppped the TXT file instead of converting to YAML, as the
   functionality is already covered by st,stmpe.yaml.
   
 .../devicetree/bindings/mfd/st,stmpe.yaml      |  4 ++++
 .../devicetree/bindings/pwm/st,stmpe-pwm.txt   | 18 ------------------
 2 files changed, 4 insertions(+), 18 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/st,stmpe-pwm.txt

diff --git a/Documentation/devicetree/bindings/mfd/st,stmpe.yaml b/Documentation/devicetree/bindings/mfd/st,stmpe.yaml
index df43878fbe18..4bb05d544901 100644
--- a/Documentation/devicetree/bindings/mfd/st,stmpe.yaml
+++ b/Documentation/devicetree/bindings/mfd/st,stmpe.yaml
@@ -127,6 +127,10 @@ properties:
       "#pwm-cells":
         const: 2
 
+    required:
+      - compatible
+      - "#pwm-cells"
+
   touchscreen:
     type: object
     $ref: /schemas/input/touchscreen/touchscreen.yaml#
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
-- 
2.43.0


