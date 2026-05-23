Return-Path: <linux-pwm+bounces-9091-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EC9tOtXkEWrirgYAu9opvQ
	(envelope-from <linux-pwm+bounces-9091-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 23 May 2026 19:33:09 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 543CF5C0098
	for <lists+linux-pwm@lfdr.de>; Sat, 23 May 2026 19:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E8003013878
	for <lists+linux-pwm@lfdr.de>; Sat, 23 May 2026 17:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E424E320A14;
	Sat, 23 May 2026 17:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jyt/ZugT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F2E18D658
	for <linux-pwm@vger.kernel.org>; Sat, 23 May 2026 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779557585; cv=none; b=gHFBaNwf+fcZe9ZxNCkt338t+TQ1myxqOfso/Kxx+KyEJv9M4OObLOxkkh65PX0kpXcHgs1hSY8F2STjtqTUdSj71grxrcgEGMgNDwBNJHmDmTOcaxx4zUBb6cbdOm3mC5i9SJ5EmlZ6+rZkEd15amxVD+sP0/unzEuiWqdtmEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779557585; c=relaxed/simple;
	bh=pIPczO+JdxqZe45yY1lXO5wH/7QRu5a76UN/e6ceYaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SCXIDTfN3/RDJFjMR1xcdYFT5BlQbNt4aLm1jXZhIeFbT5jZmBfm5qOJhX5Gyfr2Juh/Rgfs1lMOjQe1Uk6TRI1TIZ+ySQp0XS4prJBr36AztDMprzzhH/r+0xAYJTmfPxHMNHWpx8kEPYe78pX9kCIH9YVZOiq+nRd9ANjH5Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jyt/ZugT; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-83d31ac4017so4155967b3a.3
        for <linux-pwm@vger.kernel.org>; Sat, 23 May 2026 10:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779557583; x=1780162383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HjZOf7bVbm6B+eRTHEBmeDXi1tZwk3zjXWzPdrWiVjQ=;
        b=Jyt/ZugTBQp8ad+M4jRgl4Zr6Ygsn9DhzvNUPgLW1+Go6Xy/KgECMCVUOTFTlJi5sa
         XYjyJN9UXNgoylybAzesZIZZEHnWVe06yUU1o3Rmk8Aaw36ROzdkIV7TvQG9/o5nw5JF
         aqeixJDr84qYXpfxl+/tZsdhQ/bVYltW2WRRCf9px6ckQDppHWYiww0+U7TUyl4yX+NO
         nA9xt7AaowUT7ijYE1j/AIkpMQmkVDoxp2mhUK9N6DM9w3NxB36i1yQzLGDsmdWRDPCp
         ST23Kc7oXXl6aEyBeSV9uaZcCugdcVhLz8fgisywAggFghN3ifXVi8+9NFcpSnOGcHWI
         PAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779557583; x=1780162383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjZOf7bVbm6B+eRTHEBmeDXi1tZwk3zjXWzPdrWiVjQ=;
        b=e+8x1F5pWDxy68+7pZ6trM6h02LpWe5isa+T1kiusU22z00zbaIuvJJiO7D6ToUoih
         WJGnxSgruCEXfFGGsNZoACUiMxuR1XdJzhzx3qnrDZF8U3hx89hLPIo3fSlSYAZRZcnS
         cNcfk16TOZLG6tmqHanEdBJ/FqoOFtUUFhAECAcuqxFpr9raidlKH9MAdAB4rOfrLX2Y
         vMcO5v6RrOCZSWyHRSdykpbIZAhYl2abOAsop/ABjtUc/Xs1YKpm28mxUKtxS3lWI7Iz
         ILRsh4bIZzlNcY4/waUqMqiciYb5CTJRq4AFBhhd/CCZo8dWd0BkHMeHXehcLkmVk8FS
         8ZyA==
X-Gm-Message-State: AOJu0YxJnwqo64d23SXJiu+UuGAgUv9omldEy6YrjrSP/6E77D+ksN3p
	yrE817pTwN7obDU7C6oZIhGZqEgyn44PTrftqPw7vDuX8s63hSHk4GP6
X-Gm-Gg: Acq92OHF/RY7aZHJGuv6kAh0nztTarTx5wEPCXpQE6C423wzJ3Ac1wjSRm/sXUAOOm4
	4PWJd8TVW1uyAHW9utMs/D6wEDMhYsFJmasmJKlgWh5PM8gU52usiGC85jCovXqSJu82LDFih30
	5UliizYbr2gx9Lr/2AbJBttiSiUc7NWpj4IdKgaibOFJslrf+/D7pq6xhqUB84Rptq95jfvqyoB
	6dJeDJekmlPuA6rymNapSzjKBJC33AiqBDySy9tRsuacFG7x9QF8MDXbpXxMjt2DqLWjf11n/St
	7Lwyz94M7A+j0VNuqbmLu4XAplCJDk4j8MCZfbZY9SwnweazvBo7ke3A+FozNspEqhqXaPgStEj
	YTcySHOZ3ynk9Lw08bV0PxZsX1wfL81e5FA3AJ2vY4OzNCYPuLvSLAaguZbl+gsDj8FXbWr5TYb
	RmTPMTaPhVB9TKx2w/cwwuNu1QmQYcMOVNuBo06DflrvXzCNVtzCEuWJXW5xm2FxztzQ==
X-Received: by 2002:a05:6a00:a383:b0:82f:21ee:270e with SMTP id d2e1a72fcca58-8415f6d0bb4mr8246436b3a.42.1779557582864;
        Sat, 23 May 2026 10:33:02 -0700 (PDT)
Received: from Ubuntu.. ([49.37.171.12])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164fc646bsm5162945b3a.46.2026.05.23.10.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 10:33:02 -0700 (PDT)
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
	manishbaing2789@gmail.com
Subject: [PATCH v4 0/2] dt-bindings: mfd/pwm: Split st,stmpe cleanup into separate patches
Date: Sat, 23 May 2026 17:32:49 +0000
Message-ID: <20260523173251.72540-1-manishbaing2789@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9091-lists,linux-pwm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,foss.st.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manishbaing2789@gmail.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 543CF5C0098
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

This series splits the previous single patch into two distinct changes
to avoid cross-subsystem merge coordination, as requested by Uwe.

The first patch addresses a validation gap in the MFD YAML schema,
and the second patch drops the redundant legacy PWM text binding.

Changes in v4:
- Split single patch into a 2-patch series based on feedback from Uwe
  Kleine-König to prevent cross-subsystem merge conflicts.

Changes in v3:
- Added 'required' properties to the pwm subnode in st,stmpe.yaml
  to close a validation gap identified by the Sashiko.
- Updated commit message and description to reflect MFD subsystem changes

Changes in v2:
- Drop the TXT file instead of converting to YAML, as the
  functionality is already covered by st,stmpe.yaml.
- Update the commit subject and description to reflect the drop.

Manish Baing (2):
  dt-bindings: mfd: st,stmpe: Add missing properties for PWM subnode
  dt-bindings: pwm: stmpe: drop legacy binding

 .../devicetree/bindings/mfd/st,stmpe.yaml      |  4 ++++
 .../devicetree/bindings/pwm/st,stmpe-pwm.txt   | 18 ------------------
 2 files changed, 4 insertions(+), 18 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/st,stmpe-pwm.txt

-- 
2.43.0


