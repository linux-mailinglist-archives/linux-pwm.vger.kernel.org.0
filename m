Return-Path: <linux-pwm+bounces-6283-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 240AAAD3867
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Jun 2025 15:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BE569E57D9
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Jun 2025 13:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5EB2E337F;
	Tue, 10 Jun 2025 12:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cIxLsqOl"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6C42DCC0E
	for <linux-pwm@vger.kernel.org>; Tue, 10 Jun 2025 12:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560026; cv=none; b=NZ6TVXtx6rAbeOS0oTZMRXqQcwr9JWkQ9KhrmQCcT0axAuCrxKG26wzbDNPvuWHxu7uJgdZuiodXj42olQdlqbcSECy4Py3NKkWtTSGs/Y3cr8jd5TJjbMR8LvuuX2DQRNDcseF+uIPvLH7sOQcnVA1dZUQ+h8/htJ6xXWULqjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560026; c=relaxed/simple;
	bh=N+2CmuFEvaFrCFvEiZxIZGe87T5yZ+GUUMGzk60ZImg=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=EoqUYwdrvvWpAubLsaKo55fILTYKpWbRbO8blhCF0cqBDiPX+5V3xV4vs68xGXdEEHUVTHkQrHwJxbbLA0UysK2bmzZM7N17T11epeNuaswuN6vVnekElAjKyvjHw1UOtbignj06qUM70II0LEEv/XjR5UkVXvizSc+6BVBSw+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=cIxLsqOl; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250610125339euoutp026563ffbace6d33a766ebfd6d512359ff~Hr5F1Sn922744627446euoutp02J
	for <linux-pwm@vger.kernel.org>; Tue, 10 Jun 2025 12:53:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250610125339euoutp026563ffbace6d33a766ebfd6d512359ff~Hr5F1Sn922744627446euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1749560019;
	bh=ZbpbiGCkq+bc/Hnq9ouJryKcDkGL17+XHPFX3q85en0=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=cIxLsqOlqL5smjQJhKfE0p2NtQhIqk3inVujlXCUMuuhc0FiluKcwfumEnVHq86I9
	 nCB43Po5eSGrmAcUZfDQ+dGL23bpz0ki0WtDNvwCLfm+Prhwrgp32hZxjX8OzppdED
	 uo8TVd1UG4nKIKt+CiXYEE2M0AzZWCHeiPj4IYcY=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250610125338eucas1p2cc606517da2482af0a1cfdfb4b51b1c3~Hr5FQ-k451180711807eucas1p23;
	Tue, 10 Jun 2025 12:53:38 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250610125337eusmtip1d2797a7d750959ffd87abb5b2651733e~Hr5EFEfLP0363103631eusmtip1R;
	Tue, 10 Jun 2025 12:53:37 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Tue, 10 Jun 2025 14:52:54 +0200
Subject: [PATCH v2 6/7] riscv: dts: thead: Add PVT node
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-rust-next-pwm-working-fan-for-sending-v2-6-753e2955f110@samsung.com>
In-Reply-To: <20250610-rust-next-pwm-working-fan-for-sending-v2-0-753e2955f110@samsung.com>
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
X-CMS-MailID: 20250610125338eucas1p2cc606517da2482af0a1cfdfb4b51b1c3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250610125338eucas1p2cc606517da2482af0a1cfdfb4b51b1c3
X-EPHeader: CA
X-CMS-RootMailID: 20250610125338eucas1p2cc606517da2482af0a1cfdfb4b51b1c3
References: <20250610-rust-next-pwm-working-fan-for-sending-v2-0-753e2955f110@samsung.com>
	<CGME20250610125338eucas1p2cc606517da2482af0a1cfdfb4b51b1c3@eucas1p2.samsung.com>

Add PVT DT node for thermal sensor.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index 26996422e1efe5d2dde68819c2cec1c3fa782a23..bef30780034e06b07aa29b27b0225ea891a4b531 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -669,6 +669,17 @@ padctrl_aosys: pinctrl@fffff4a000 {
 			thead,pad-group = <1>;
 		};
 
+		pvt: pvt@fffff4e000 {
+			compatible = "moortec,mr75203";
+			reg = <0xff 0xfff4e000 0x0 0x80>,
+			      <0xff 0xfff4e080 0x0 0x100>,
+			      <0xff 0xfff4e180 0x0 0x680>,
+			      <0xff 0xfff4e800 0x0 0x600>;
+			reg-names = "common", "ts", "pd", "vm";
+			clocks = <&aonsys_clk>;
+			#thermal-sensor-cells = <1>;
+		};
+
 		gpio@fffff52000 {
 			compatible = "snps,dw-apb-gpio";
 			reg = <0xff 0xfff52000 0x0 0x1000>;

-- 
2.34.1


