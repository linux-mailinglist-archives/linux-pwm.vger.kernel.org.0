Return-Path: <linux-pwm+bounces-6287-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34929AD45B2
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Jun 2025 00:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3600189B2AE
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Jun 2025 22:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338F6288C92;
	Tue, 10 Jun 2025 22:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vPBzWXYu";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hZ8rMAWA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844C028853F;
	Tue, 10 Jun 2025 22:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749593339; cv=none; b=M6ERF+bGRK8zSonLr9BAVc7dlBDfrgIJSovcdGU5wDXBFPOcbFO/wE90fpBkh4t/0tg1OsO1UPExMNnZNIM9spWqTbaZXjNi6q0X+9ljJIXRcQfchk+XLfTdjeAGeALZu1WxenUIvRO6+0QnVgoruVSIkRlYPJizWYhGv1OMevY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749593339; c=relaxed/simple;
	bh=TYP/rzBt1tKjqVNXOYGBiVtW5OhMZEirATwhlgpCj6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aRS9orzAGLi9jCDeq5lzRflo2lvAhoQUGbbJAki1Gv+ba7IvPQsmDLZkAAwh4OOkMUeurGGKO9kQs3+7jqd1GiHlS5pU3RXPZc7TaUWXqGI+UhZ1I9KKXc391s7k7hoSB9I6xNWucFDFaOVDhHz7mJyhslxiwF5GRnD2zP7JpCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=vPBzWXYu; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=hZ8rMAWA; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bH2xY5WDYz9t06;
	Wed, 11 Jun 2025 00:08:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1749593329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZhSW18usXf/fa8+m7F4bYpKDM3eRzhBfY1RQeGT2YM=;
	b=vPBzWXYueUM3go92CHzECqG5z9OQNQXgp75fS7gstgn74c3TuiylhcbiYaGR1j6J5idrl/
	DzeI2tQzWfn74wsGUDzW1E2XdTAqHxAbfiOTKeDMCX2wmOVECxI6W7MJTvbSOv8cL5CW5e
	lrj25D1FrJYki2Ee9DswqU8NIR88ofh6u/+4C56T9PWCDwoHxyqPYWfYKzWunBggogbXNw
	YmgPEQhOZAx3TOQX1qZIMJJ90ut785MSdf8mEu42rHXBkrnVRaRm3mXnuOU8zzKgxmgTuj
	Elcb3IjJrvYYVFAXy1O4RxIddrMIfrRKqh0UXIPjsBnBxEW3124x+5g7Ld6W1w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1749593327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZhSW18usXf/fa8+m7F4bYpKDM3eRzhBfY1RQeGT2YM=;
	b=hZ8rMAWAx3Tm6YlJ0LF2xAvbZfb55anrEQ0Ozc8nAylZHrcYuboRIfJ8q0JyG5oZg5mOrT
	hFRuK57Uu2Kyas6uThOs3Slz2VhmmsrTbZbxYmFlc7iVN5gQ2K22rJtSl7MUUUXKHtEd44
	3TY8ZmKSSu1JhhBDPsS07iPrkRS39pWPpxAOxnN2+JAvFFSGsFijJRnzwpEMM02167MSVx
	x3MGR8eUQxRK/gKNps25SK5P9ohR5IKZx0oekFb+Ykc57qTQCWtzLfTDhK2f1Jm/BrWLkV
	1/7evcGPpNU8KAHhKD8Kq37yG95cs7+bok9lYCLRNHBTxuh2kYjd6vuwnIaztQ==
To: linux-pwm@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: trivial-devices: Document Argon40 Fan HAT
Date: Wed, 11 Jun 2025 00:07:26 +0200
Message-ID: <20250610220814.167318-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250610220814.167318-1-marek.vasut+renesas@mailbox.org>
References: <20250610220814.167318-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: h6w61hrk3cof8ntwg3jdwr4u5zth83rc
X-MBO-RS-ID: e1304fc48dd708c65e5

Document trivial PWM on Argon40 Fan HAT, which is a RaspberryPi
blower fan hat which can be controlled over I2C.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Uwe Kleine-König" <ukleinek@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-pwm@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 27930708ccd5..b8f1ee6e63dd 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -45,6 +45,8 @@ properties:
           - adi,lt7182s
             # AMS iAQ-Core VOC Sensor
           - ams,iaq-core
+            # Argon40 Fan HAT PWM controller
+          - argon40,fan-hat
             # Temperature monitoring of Astera Labs PT5161L PCIe retimer
           - asteralabs,pt5161l
             # i2c h/w elliptic curve crypto module
-- 
2.47.2


