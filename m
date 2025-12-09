Return-Path: <linux-pwm+bounces-7791-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F594CB100B
	for <lists+linux-pwm@lfdr.de>; Tue, 09 Dec 2025 21:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80E6630B8170
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Dec 2025 20:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D9A306486;
	Tue,  9 Dec 2025 20:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="iHnmj+oJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB122F618C
	for <linux-pwm@vger.kernel.org>; Tue,  9 Dec 2025 20:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765310821; cv=none; b=WhscYNYhs2y8T/Od/1A14iNgQ4Xa8CsJKJcXkOUtwbDfqf9eVWac7IYaTkrEf+BOdVAfzu4uCrJQGGLCof7vC+wHaXO1SfFGSuNeLrfEO/ujvoRCLgbnxhpUqVxDoFpxO0rE9Vuc/+YVbsyoRRfzvNgi9q7qsHfKhhk7+O90lQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765310821; c=relaxed/simple;
	bh=X+0CWOqiYAjF7Jn8QKMD0w4mXDhZG3K2v7aJgmYMZpI=;
	h=From:Date:Subject:MIME-Version:Message-Id:To:Cc:Content-Type:
	 References; b=qA9xAcd7muALQTS4MP0xxXdOaoD+wWCzA/BEw5ZU3JfrYUT3syb4ungl5EuvA0rJQKXfjAHZSHeYnTLCugXYTBRaAblqmU/a49Ql+3WryUk/w0ZsjKqZaDPeRBI8GqUUPX9p97+OeTAfxejAnWuBPn3AvFeb96EXzA9uGRVO5PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=iHnmj+oJ; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20251209200657euoutp01f47dacf152e1898190bc6939e1274691~-pNXZanNF1445214452euoutp01f
	for <linux-pwm@vger.kernel.org>; Tue,  9 Dec 2025 20:06:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20251209200657euoutp01f47dacf152e1898190bc6939e1274691~-pNXZanNF1445214452euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1765310817;
	bh=eJfRVdm1pgAhJYONSUY70rFE1uWmFBpfs25dwzkO8rA=;
	h=From:Date:Subject:To:Cc:References:From;
	b=iHnmj+oJuFjN2flqsz8Ttw94iGbbMQCRmycWVfkE2xHk5BkE/a32KXyu03svMlrdJ
	 HH0Q/VPcBM0q0ricta4jqPb2tPRyJnpSzakeVwfon1VgDbVSOJ7XizSsas7XrWlt6y
	 X1kpfidoqEl/zaHlN40EFyoz/tCMIhxsiadFPuNw=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20251209200656eucas1p2849683e0977353b12c35838fef24a344~-pNXAq5Pu0167501675eucas1p2l;
	Tue,  9 Dec 2025 20:06:56 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251209200656eusmtip22d23638fcf94d71fdffbc987ed000257~-pNWvMWPh0701507015eusmtip2R;
	Tue,  9 Dec 2025 20:06:56 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Tue, 09 Dec 2025 21:06:03 +0100
Subject: [PATCH] pwm: th1520: Fix missing Kconfig dependencies
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20251209-fix_deps_pwm-v1-1-f7ed8bd1bd3d@samsung.com>
X-B4-Tracking: v=1; b=H4sIACqBOGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
	vPSU3UzU4B8JSMDI1NDIwNL3bTMiviU1ILi+ILyXN0UY0MzY3NDQ0tDs2QloJaColSgPNi46Nj
	aWgD9g1OLXgAAAA==
X-Change-ID: 20251209-fix_deps_pwm-d3163711916c
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,  Elle Rhumsaa
	<elle@weathered-steel.dev>
Cc: Markus Probst <markus.probst@gmail.com>, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,  Michal
	Wilczynski <m.wilczynski@samsung.com>
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20251209200656eucas1p2849683e0977353b12c35838fef24a344
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251209200656eucas1p2849683e0977353b12c35838fef24a344
X-EPHeader: CA
X-CMS-RootMailID: 20251209200656eucas1p2849683e0977353b12c35838fef24a344
References: <CGME20251209200656eucas1p2849683e0977353b12c35838fef24a344@eucas1p2.samsung.com>

The driver fails to build on configurations lacking COMMON_CLK (missing
clk::Clk) or HAS_IOMEM (incomplete `pwm_chip` struct on UML).

Add dependencies on ARCH_THEAD and HAS_IOMEM, and add COMMON_CLK to
ensure correct compilation and platform targeting.

Reported-by: Markus Probst <markus.probst@gmail.com>
Closes: https://lore.kernel.org/all/a66b337528d700ae92d7940a04c59206e06a8495.camel@posteo.de/
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202512020957.PqnHfe7C-lkp@intel.com/
Fixes: e03724aac758 ("pwm: Add Rust driver for T-HEAD TH1520 SoC")
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/pwm/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index bf2d101f67a1e0ae12a58b5630abd5cfd77ccc99..6f3147518376a04b6e890c4bf31e06e1af04054e 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -760,7 +760,9 @@ config PWM_TEGRA
 
 config PWM_TH1520
 	tristate "TH1520 PWM support"
+	depends on ARCH_THEAD || COMPILE_TEST
 	depends on RUST
+	depends on HAS_IOMEM && COMMON_CLK
 	select RUST_PWM_ABSTRACTIONS
 	help
 	  This option enables the driver for the PWM controller found on the

---
base-commit: cb015814f8b6eebcbb8e46e111d108892c5e6821
change-id: 20251209-fix_deps_pwm-d3163711916c

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>


