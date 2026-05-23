Return-Path: <linux-pwm+bounces-9092-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILN/KtzkEWrirgYAu9opvQ
	(envelope-from <linux-pwm+bounces-9092-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 23 May 2026 19:33:16 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AEA5C00A8
	for <lists+linux-pwm@lfdr.de>; Sat, 23 May 2026 19:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6ABDD300B3D8
	for <lists+linux-pwm@lfdr.de>; Sat, 23 May 2026 17:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9481A2E62B3;
	Sat, 23 May 2026 17:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfmtIxXF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4908A1D6DB5
	for <linux-pwm@vger.kernel.org>; Sat, 23 May 2026 17:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779557594; cv=none; b=TRCmqHYi8vNpTxCmyuEGI/KzaLN6oQmVNpMqcroyYBRbBOV3+/83w6kn2nUf7h9iLGBPV061qSHkV6A8xBLgiK4pvPpQqrbbzwzgQ+5lQ8AMw+5LYZyCyk356Y64I2Fwwjej6FwE06r4zkMrDKOuJfLzqPm3maw0zbsxGjT0PI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779557594; c=relaxed/simple;
	bh=Saljt8+lEfAQzopPhIMcOHAZd977tUe/WQSEWbNCEBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a3Bv7U0g0NtkV940iI71EFaw3JeBcMPi9ptxKwbL7idxRhnyplI37pT2aJc7ojiQ/l1kE2zNrOUmY526BENF6kHgRHHi1bKTmh0NGXj/grvMuMSh+5sXswIlP/yvLLULYfmO0s3tegxd/CWkqXTz30Pres9NLVhmMbCjuonj8kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KfmtIxXF; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3664df32e91so9594533a91.3
        for <linux-pwm@vger.kernel.org>; Sat, 23 May 2026 10:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779557592; x=1780162392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eCj8+oLwvPOIbmY+qV1+VohiIFMiRIVX9QeRtC1IOt0=;
        b=KfmtIxXFGbV0QbEgYoygEmc+NlXWDQ0TFzvMxTIGo20VyRs/jGIZv6vmQQB+AY33DM
         1FbeBOO8b9lTN+3PJp5b4fYBveojpf7FiXU+ru0xkHbcPdP7pWxpJFqHiYAVaUTxrPJd
         oHdBntqMW7rp8UdFPok8MZM1jhsV8eU0BeTglKAd+07STEYrIiVF1/w2NR8xtYvyvTPH
         F8AkGRL8sgh46yAc/AdK/iVrdrZxUpjWz7mc7Eo3HHtC6d6jXPNaaKNbIjCFqHK8Z4Zr
         t7TO+Xx5FJgdmApm2SardsLvYpCb6+c9ley0BgyFI2QA3bl0TWp/5zzifa1E5QZ8+l8I
         t9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779557592; x=1780162392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eCj8+oLwvPOIbmY+qV1+VohiIFMiRIVX9QeRtC1IOt0=;
        b=Q/LlnjYl7CgFP1M8NI4gsQxr25tVy9Tck45T8uAWJS0Ib2FuhCf4sRlCHwJCJIDQO3
         U137HO+gIknvOj3xKF+8/ua/VOVvmaeUqTRbjLL77iOrXJHBB1XvxXVNCLjdGQAI4+w2
         pTBQTT4bg7QeNSy6u90tPWt+cnUBrGbQ87/DkcFLsaxnn/LXFg+kre5tVLNgIokwjKbF
         l9xmzAphvUjMNE+BMZX7XYrSWoIjXl4Q51sqt9T+dQ2WjVM+GXyYJ5EGUQDR7c1/4T3p
         YMBdlcgIHtMKB3YWEvVM8ELIpoNlbRBPj3bB0qZGGt8oaqrdNJ/+QCDFcLkzLenZ8DAZ
         6e+A==
X-Gm-Message-State: AOJu0YzRf4TPZFTUSGYatlXTCZavMHEYafy0OD2a/btmvdP06VK23FCL
	SO1hhmg23c/QdlsnRnTv9S1SIxYHFT/4RrtGuMmIg7SwQG7fRPh1Y4Jc
X-Gm-Gg: Acq92OFwfM6x5DhPm3Zu1j2KGZ2+YgKGTKqzZsPuFWuN31pisuNC9EO8ANRhXnNDWyQ
	3XVvXfk5ZlXo74NX5ZBG5B8cuuY2NdwHYbl2xRGGvA1Co9WbYuf/7xsF9+T4xLy6jK6qWJvD1B9
	3Q8xdyv3mhM6SxT8rvgVmbE8/Dnc4ZvKVdin5SAIDssHeX548P5Mwxr/UQXqgltFfSXmIVZRCNa
	yXK25zeS22BqfjMrX+W44GsraZdcIdc06urgXVEhLQS3zlS0bvCGVitqt2IHNW5FMZUeZxuppfh
	rgb3b58r3zfKcZEiYFm4gMLfjRGQ7xPEut2rDL1kA0slhOmAThkSZfpKz1BUD436Cxki60rGwIM
	mFhe17P1BBMBKwBUzGsZqF4R5rfPt5uuyedDzUnZ8+FXhJFPVnvXKPrV3sU7SsPiRBgh8Dj46S7
	pD/XQkGe4OR2ph1nrGNr6TWBbxoi5d9jURzfzi281pXAB4Ch/UgnHLeU5eGKUfdKIu2A==
X-Received: by 2002:a05:6a21:594:b0:3a7:1d55:b634 with SMTP id adf61e73a8af0-3b328f562bemr8292242637.38.1779557592547;
        Sat, 23 May 2026 10:33:12 -0700 (PDT)
Received: from Ubuntu.. ([49.37.171.12])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164fc646bsm5162945b3a.46.2026.05.23.10.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 10:33:11 -0700 (PDT)
From: Manish Baing <manishbaing2789@gmail.com>
To: lee@kernel.org,
	ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	linusw@kernel.org
Cc: linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	manishbaing2789@gmail.com,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 1/2] dt-bindings: mfd: st,stmpe: Add missing properties for PWM subnode
Date: Sat, 23 May 2026 17:32:50 +0000
Message-ID: <20260523173251.72540-2-manishbaing2789@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260523173251.72540-1-manishbaing2789@gmail.com>
References: <20260523173251.72540-1-manishbaing2789@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,gmail.com,microchip.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-9092-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,foss.st.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manishbaing2789@gmail.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 63AEA5C00A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The st,stmpe-pwm binding is already covered by the MFD schema in
Documentation/devicetree/bindings/mfd/st,stmpe.yaml. However, the
PWM subnode was missing a 'required' properties block. This allowed
Device Tree nodes to pass validation even if the 'compatible'
string was omitted. This omission could lead to probe failures
at runtime.

Fix the schema by adding the missing 'required' block.

Signed-off-by: Manish Baing <manishbaing2789@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Uwe Kleine-König <ukleinek@kernel.org>
---
 Documentation/devicetree/bindings/mfd/st,stmpe.yaml | 4 ++++
 1 file changed, 4 insertions(+)

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
-- 
2.43.0


