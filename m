Return-Path: <linux-pwm+bounces-4176-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D86FB9DFA8E
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Dec 2024 07:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9734A281888
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Dec 2024 06:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B856F1D63FB;
	Mon,  2 Dec 2024 06:02:14 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C768D28399;
	Mon,  2 Dec 2024 06:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733119334; cv=none; b=YfysPYL5Rf62tA8OvetUPHzZUZb2vqNttPrSu7Z3Osprhn1IlS1LcvHc6oc/Dao/FH7fCeKOtakbbH7UWq+wo48zJw9rUpQEy0iFwZhyj5YiHiv4wDevyK3wsm+spYqYS5sSxrHxz4cS0DwKq/JQkz/+p7yTndZ6pvmeXmiZJFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733119334; c=relaxed/simple;
	bh=gDnYUZc4CxPpid2Lh5V3qbouyziOywv81EIwU/y/PZk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y5pGDOe97wCmIcP0Mnl9SM/GWOxShFYmXPOzTVlx9VR7UrV5ILnJQBZF/koPx38ZtdNCjSZdJqZ/IOfEssRopOLf4eZGWyWZtKPLeRwRRkU5iVwgejgyhBIqL6GiRSPvb538MZLKpjBiii6XkZDLKDXbvaQhteeaMWewBQRaDfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 4B261nKe017800
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Dec 2024 14:01:49 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server id 14.3.498.0; Mon, 2 Dec 2024
 14:01:48 +0800
From: Ben Zong-You Xie <ben717@andestech.com>
To: <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <ukleinek@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, Ben Zong-You Xie <ben717@andestech.com>
Subject: [PATCH v2 0/2] pwm: add PWM driver for atcpit100
Date: Mon, 2 Dec 2024 14:01:45 +0800
Message-ID: <20241202060147.1271264-1-ben717@andestech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 4B261nKe017800

The ATCPIT100 Programmable Interval Timer (PIT) is a set of compact
multi-function timers, which can be used as pulse width
modulators (PWM) as well as simple timers. ATCPIT100 supports up to 4
PIT channels, and each PIT channel may be a simple timer or PWM, or a
combination of the timer and the PWM.

This patch series includes DT-bindings(1/2) and PWM driver(2/2).

---

Changes in v2:
(1/2):
 - change "title" in the yaml file.
 - remove vendor-specific property, and add clocks property.
(2/2):
 - add a description for hardware limitations.
 - instead of statically configuring the clock source in the dtb,
   switch the clock parent depending on the requested setting.
 - have some minor changes according to Uwe's suggestion.
Link to v1: https://lore.kernel.org/linux-pwm/20241028102721.1961289-1-ben717@andestech.com/T/#t
 
---
Ben Zong-You Xie (2):
  dt-bindings: pwm: add atcpit100-pwm
  pwm: atcpit100: add Andes PWM driver support

 .../bindings/pwm/andestech,atcpit100-pwm.yaml |  51 +++
 MAINTAINERS                                   |   6 +
 drivers/pwm/Kconfig                           |  17 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-atcpit100.c                   | 290 ++++++++++++++++++
 5 files changed, 365 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/andestech,atcpit100-pwm.yaml
 create mode 100644 drivers/pwm/pwm-atcpit100.c

-- 
2.34.1


