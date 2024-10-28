Return-Path: <linux-pwm+bounces-3937-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F27DC9B2D1F
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Oct 2024 11:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E7741F22AEE
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Oct 2024 10:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30CB1D61A1;
	Mon, 28 Oct 2024 10:43:35 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655AF1D5AC2;
	Mon, 28 Oct 2024 10:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112215; cv=none; b=n4JNq9NThj4joxA1qIAk/saupmxMUA33c+4XY1Oailu72DIktRWZmDzpKhoiGRhP9hpDcPV0wkIXuFbTlv03dtWUEaSTvtbkTrK3MIpPl9/JUZJEAJKz6WKcsOXEi0EjdfuNh58+qfziKXFpI+PKUE6PD57qwxVmk3YgrgahZf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112215; c=relaxed/simple;
	bh=cKMEkLjrq/paUDIDfO+RCm116jTTbWgc89b7+gEmez0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cnJ9SLZWX0bH3YccYtYFMaJ8v7e4T3PxqVGOs2MODvSwQxp63EgUaK+AoEiujeYwpjTdpnfxUgoJrVU4aR+SAGADv3y/bFfcGYGbzlDoZQfQGPT5UiC1MTjO5/uoU57RzagHld26t8hPavb6gdLNDB9G4g+mbBrWABlgcqRzkk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
	by Atcsqr.andestech.com with ESMTP id 49SARmGu076961;
	Mon, 28 Oct 2024 18:27:48 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 49SARQdR076692
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 18:27:26 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server id 14.3.498.0; Mon, 28 Oct 2024
 18:27:27 +0800
From: Ben Zong-You Xie <ben717@andestech.com>
To: <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <ukleinek@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, Ben Zong-You Xie <ben717@andestech.com>
Subject: [PATCH 0/2] pwm: add PWM driver for atcpit100
Date: Mon, 28 Oct 2024 18:27:19 +0800
Message-ID: <20241028102721.1961289-1-ben717@andestech.com>
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
X-MAIL:Atcsqr.andestech.com 49SARmGu076961

The ATCPIT100 Programmable Interval Timer (PIT) is a set of compact
multi-function timers, which can be used as pulse width
modulators (PWM) as well as simple timers. ATCPIT100 supports up to 4
PIT channels, and each PIT channel may be a simple timer or PWM, or a
combination of the timer and the PWM.

This patch series includes DT-bindings(1/2) and PWM driver(2/2).

Ben Zong-You Xie (2):
  dt-bindings: pwm: add atcpit100-pwm
  pwm: atcpit100: add Andes PWM driver support

 .../bindings/pwm/andestech,atcpit100-pwm.yaml |  52 ++++
 MAINTAINERS                                   |   6 +
 drivers/pwm/Kconfig                           |  17 ++
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-atcpit100.c                   | 240 ++++++++++++++++++
 5 files changed, 316 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/andestech,atcpit100-pwm.yaml
 create mode 100644 drivers/pwm/pwm-atcpit100.c

-- 
2.34.1


