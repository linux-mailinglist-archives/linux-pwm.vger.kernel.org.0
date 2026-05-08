Return-Path: <linux-pwm+bounces-8849-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id xC+5CZgv/mnjngAAu9opvQ
	(envelope-from <linux-pwm+bounces-8849-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 08 May 2026 20:46:48 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5E44FAC11
	for <lists+linux-pwm@lfdr.de>; Fri, 08 May 2026 20:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B04CA301E6F1
	for <lists+linux-pwm@lfdr.de>; Fri,  8 May 2026 18:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B12F3644BD;
	Fri,  8 May 2026 18:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpqEHIwi"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDB633B6F9
	for <linux-pwm@vger.kernel.org>; Fri,  8 May 2026 18:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778266005; cv=none; b=PGQbj1JKCwzBly3J5nugcR5MP2jvi6oLI+QtZoheIMc5e7bbFQP1KPdjOrdmGLMrxHtx+JVYjbq9qpMLJioIhm+1HV46qUBbEoaytnsaQc2BgoLIRgKfguzIByyVXTRFIY03p2M0Ordx9fStQ2DZW2pMrtdbQruTjanu5YK7X1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778266005; c=relaxed/simple;
	bh=dgL1CIuswNSdc4LrmMhh0E3H607UoGQppq1RIGzbSWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sZrbRy4umNS2CNB7QaWQCpU0zbE78ojwqvZQnQuxBMvm0LfpeIRrictHkDueChX98xc9kTJDAtk2tOV6BLBl9lLlXDIAjz1Vjgq+awhAjYwa00vnz96RhtienVt6+7aNB5WRl8kA4oYLAEwEvMpFLzyEVnPqanPR58ciwapnRAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpqEHIwi; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c8016d642b2so1609306a12.0
        for <linux-pwm@vger.kernel.org>; Fri, 08 May 2026 11:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778266003; x=1778870803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8T4V1KOUS/zQQGD3wOEYFO7WBlAjbkL/PMKx62SumA=;
        b=ZpqEHIwipDBeRa+sVoaMMA9f5SOglXglel/ZgPHfuf7MR5C0p25OTX0Byu4kUWGaSV
         wTjm/AHoz7w7q83XwZGaoTPHBNDISzT3EQjunp12QlekYCvzIbhfuxejlQg53jcVBErC
         W2lM4nPU2mWuo+ZcmZSFquXmvzVxCWQBAxGaNUl4DYahaJSas06hd+5dnyOYsnczDfd3
         8RbwB+0zrlvO73t2DbEQOYX+mwJiNRoKgYjuLvS27Ms0LGyK4iugOXY9kYDt12Yzzz0l
         qoxZCr2puQC8jrPL7SQPOUrLKlNUxuksENvIdv3WkbI5zp0tT+4MBf5y6ZhsykWLK42w
         VLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778266003; x=1778870803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8T4V1KOUS/zQQGD3wOEYFO7WBlAjbkL/PMKx62SumA=;
        b=iecKC94nFXCSUQ2Rv+EVR/4pBJlcX1eFmZV+O7FJC9C9UJtLDfEx8aPPtKYFD7M8q0
         ivBuF+P70Cfb+uVK17SvHnznO2/uKMYxDQ3Co2PE1cZuxko4D+qsp2pUB2N28XAIi6bE
         vv46zdyaVMOvBDlewo6P/Gavpd9/k/utbkuL5iChK6DjhQysjrLutsFt2a/ufNY6vvbj
         3epBFVu17ZKagJTfhqBu6rrYL2sDcupTrCaUUb6PLMdw7ZBHcNohkjQ8gtoaPuGI6TR/
         i6ymbJIbbODG1YvDUIsa5SaXKtkGEmpSAobk+2yv+nFSMJY5Ahli2KGatlwmTIZV2kQi
         NSew==
X-Forwarded-Encrypted: i=1; AFNElJ9K7DBOKAwAzFDFRMNSGn8/suaFOK3AvZMewTM9JYF4R081VC8q5HNqnZpWb6VNbYsPtF0ZqS1KMnw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+h9pf/0eld4aM/9eUXrDT8vIS5zLLaPVXu7kLct49eBORJl5l
	mMbUA1xBZDv3oefNBonSex3gfBms0Nr3AxSkcNDxo/fFh1puXgBqJRTj
X-Gm-Gg: Acq92OEo9JfXIyjpfPgYV8bvMvCE2zpCBa/jFse8DzkSgjloThNVOUj8URX6wH5Ad0k
	DqhP0mkcnHbOqZ6piOEuylL9IZWxNBD/veBIbqoff3FE7WcmH1oQ9jqUs71GIxzCLwrQroo/p6Q
	+V6pylW+Nb3UwZxxvodylAbuQN+NztBskoC1Yx0X0HjxIBns/eSsZ9un8Q5kp1vlBgncFiQeVic
	RCsd9Xc5fMyFkL0uv/VzLHibSfZwY1wbPhKdkec4/+SFU/vrFQvcDdu+EGKbdtR+SAVSNhksG3g
	ll+9cmcglAngVbVNvnRRfIZ+4TKyNftHU/YCJnFbOMzEL2foT8LIv0RuKhc+a+Oqhxu2mmvhIqb
	T+3d5pY8F52JyzbW/WXZPbILvHvmB6FuK5+JERjtMiDPFMOjSfrbzl6/kfZGVuIWe+z6hQz51EO
	cDx4zHBi50D80D9ihwoxJ2H7NA1uvj6+popy1B3IYH+UI6peXpMCVJf6FnV9gWN7MU1aU=
X-Received: by 2002:a17:903:2f46:b0:2b9:6cde:c345 with SMTP id d9443c01a7336-2babd4a4742mr76227935ad.18.1778266003085;
        Fri, 08 May 2026 11:46:43 -0700 (PDT)
Received: from Ubuntu.. ([49.37.171.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e89d43sm30926035ad.63.2026.05.08.11.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 11:46:42 -0700 (PDT)
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
Subject: [PATCH v2] dt-bindings: pwm: stmpe: drop legacy binding
Date: Fri,  8 May 2026 18:46:26 +0000
Message-ID: <20260508184626.15938-1-manishbaing2789@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6E5E44FAC11
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
	TAGGED_FROM(0.00)[bounces-8849-lists,linux-pwm=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[manishbaing2789@gmail.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The st,stmpe-pwm binding is already covered by the MFD schema
Documentation/devicetree/bindings/mfd/st,stmpe.yaml. Remove the
obsolete and redundant text binding file.

Signed-off-by: Manish Baing <manishbaing2789@gmail.com>
---
Changes in v2:
- Drop the TXT file instead of converting to YAML, as the
  functionality is already covered by st,stmpe.yaml.
- Update the commit subject and description to reflect the drop.

 .../devicetree/bindings/pwm/st,stmpe-pwm.txt   | 18 ------------------
 1 file changed, 18 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/st,stmpe-pwm.txt

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


