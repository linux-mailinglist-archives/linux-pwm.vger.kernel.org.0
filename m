Return-Path: <linux-pwm+bounces-6413-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D035ADCF7B
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 16:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71F8240390A
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 14:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530DB2ED171;
	Tue, 17 Jun 2025 14:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tOKD0EZ+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE61E2EB5A2
	for <linux-pwm@vger.kernel.org>; Tue, 17 Jun 2025 14:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169330; cv=none; b=VGKLJNOj+z0bDaI+6GTEXep7ZUQ/mVU4GC1Xkurb1hY9PT6wKknMnYcLDgAF3QXBsWbqiYt4gcf1aqF1xS+oYvmHyCKo1vgsPfSa3ek7PEvpx8jFhus/8x/lLW+Msn5zDD56xzKQYFaNvdclPKOlC6CvWXkddoq3JYrpHuzHz+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169330; c=relaxed/simple;
	bh=G3Rcxmg/8RGJT9WdkJVO9/yG6cY6SHgkWJ+0LoMKMUY=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=G3MgULFchkdND3C95wdZ0SLanLRPsMVRriA2Y2ou0DGFstHPpqWeapzQmkXD3v5ppFLpwji4RVxYWiahiKPFBhszcccX7IVeag/E1BJ0Qc7HxU6sRSdpdV1Dwg3TZz4ixiTx4L44Oys55JRht0LpQ1P62QjHKfE1s9oSRYqzeNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tOKD0EZ+; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250617140844euoutp01e741be48584c9205aad4dba0f23a0c8b~J2bpN-qxg2798127981euoutp01f
	for <linux-pwm@vger.kernel.org>; Tue, 17 Jun 2025 14:08:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250617140844euoutp01e741be48584c9205aad4dba0f23a0c8b~J2bpN-qxg2798127981euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750169324;
	bh=tb9Nm7oCBfF8pKU9GqtVQRGVuCwKCYbxFHqowy9m/jM=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=tOKD0EZ+VyFAjmM5b0FA3+ylHu0+d4JzdbkihoIILWjUkL2/7g7dCK0PFN9Rg30i1
	 XfDvnlgF6bzyMjcKuSfOGd9pnOMVYgKqFeh06s6D2i9FR9GwizvMRr4LW5eDjfDVRx
	 lLngSlqz1azpMTegIN7p8Szs1XDvgQZWGWWNg0tU=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250617140843eucas1p21824efa35dec7b9169ed3114f9e92df9~J2bosQUTc1724917249eucas1p2k;
	Tue, 17 Jun 2025 14:08:43 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250617140842eusmtip14bbca11e5f3b918117cdc84a60ed2e51~J2bnTA_hH2540625406eusmtip1N;
	Tue, 17 Jun 2025 14:08:42 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Tue, 17 Jun 2025 16:07:30 +0200
Subject: [PATCH v3 7/9] riscv: dts: thead: Add PWM controller node
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-rust-next-pwm-working-fan-for-sending-v3-7-1cca847c6f9f@samsung.com>
In-Reply-To: <20250617-rust-next-pwm-working-fan-for-sending-v3-0-1cca847c6f9f@samsung.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,  Miguel Ojeda
	<ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,  Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,  Andreas
	Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,  Trevor
	Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,  Michal
	Wilczynski <m.wilczynski@samsung.com>, Drew Fustini <drew@pdp7.com>,  Guo
	Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,  Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
	<conor+dt@kernel.org>,  Paul Walmsley <paul.walmsley@sifive.com>,  Palmer
	Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,  Alexandre
	Ghiti <alex@ghiti.fr>,  Marek Szyprowski <m.szyprowski@samsung.com>,  Benno
	Lossin <lossin@kernel.org>,  Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20250617140843eucas1p21824efa35dec7b9169ed3114f9e92df9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250617140843eucas1p21824efa35dec7b9169ed3114f9e92df9
X-EPHeader: CA
X-CMS-RootMailID: 20250617140843eucas1p21824efa35dec7b9169ed3114f9e92df9
References: <20250617-rust-next-pwm-working-fan-for-sending-v3-0-1cca847c6f9f@samsung.com>
	<CGME20250617140843eucas1p21824efa35dec7b9169ed3114f9e92df9@eucas1p2.samsung.com>

Add the Device Tree node for the T-HEAD TH1520 SoC's PWM controller.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index 1db0054c4e093400e9dbebcee5fcfa5b5cae6e32..26996422e1efe5d2dde68819c2cec1c3fa782a23 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -490,6 +490,13 @@ uart2: serial@ffec010000 {
 			status = "disabled";
 		};
 
+		pwm: pwm@ffec01c000 {
+			compatible = "thead,th1520-pwm";
+			reg = <0xff 0xec01c000 0x0 0x4000>;
+			clocks = <&clk CLK_PWM>;
+			#pwm-cells = <3>;
+		};
+
 		clk: clock-controller@ffef010000 {
 			compatible = "thead,th1520-clk-ap";
 			reg = <0xff 0xef010000 0x0 0x1000>;

-- 
2.34.1


