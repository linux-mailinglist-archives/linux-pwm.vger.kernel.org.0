Return-Path: <linux-pwm+bounces-6964-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3E5B1C174
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Aug 2025 09:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA821185FF8
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Aug 2025 07:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A3F220F21;
	Wed,  6 Aug 2025 07:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MUoVmE9e"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF45821CC64
	for <linux-pwm@vger.kernel.org>; Wed,  6 Aug 2025 07:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754466180; cv=none; b=shvCh4IpzzvDNlFKz2f1NRa7YM5PbbSwc9VoHwadETidtWALqsAY4jhtfoPYhqMcMdudKrlTI3BaTQaw7ELkaX9heAmp94reZjamkiyVZBZZA7tFt3AR5LiSFEnX2OxfiidcyD4oFr62PQbLeUZnOiKPiT35fsDEqB3hWBZeWjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754466180; c=relaxed/simple;
	bh=Bf++Tk4Smui0X8z0ITbnBD9R17nW5Z+92o6CLzUiu3s=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=K7zbRt+2SCECCW3QXdCpkjQhGD8FWEb4AaKsSEui/wxCgsN/4QFUYGnK/UdOmPztnmrWhMbjEtRNgLKc4niuVbwfq2p9dcCQtCtwTyxoHxjAbq/XQI4QqAt6BB+wbxdhYOsMsPytB1E9HL67K+z5Lz17F1nU3NQUhAZHxyEJfME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=MUoVmE9e; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250806074255euoutp028b0bbb1a6d4550eaa0bbf95fd0a96c67~ZHbDwlhAj1207212072euoutp029
	for <linux-pwm@vger.kernel.org>; Wed,  6 Aug 2025 07:42:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250806074255euoutp028b0bbb1a6d4550eaa0bbf95fd0a96c67~ZHbDwlhAj1207212072euoutp029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754466175;
	bh=iv4jgVkzTcxHfA5JElSRQIQxNL+DVmJ6UZogOj5755o=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=MUoVmE9etZJVf2YZ7eotJvLdaxMDQ/BUjfu2dXpSe/ctvuHasMRHhT5PvWofuvSmJ
	 Krn97b1vnCAujgbskPj0CDJy4G67GWyAsXbQFTVfdX3yJq7YIeAHIThScvKl1DKv+s
	 b9awjSy4KcCdJVWhpY+XSNyDIKHfZH6uvMjobJmY=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250806074255eucas1p2e52051576638bb074c251fe824c34d3d~ZHbDQbjJF0454904549eucas1p2j;
	Wed,  6 Aug 2025 07:42:55 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250806074253eusmtip29774019c53f377eae9809e1404415c23~ZHbB6d7tx1844718447eusmtip2n;
	Wed,  6 Aug 2025 07:42:53 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Wed, 06 Aug 2025 09:42:47 +0200
Subject: [PATCH v13 2/7] rust: pwm: Add Kconfig and basic data structures
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20250806-rust-next-pwm-working-fan-for-sending-v13-2-690b669295b6@samsung.com>
In-Reply-To: <20250806-rust-next-pwm-working-fan-for-sending-v13-0-690b669295b6@samsung.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,  Miguel Ojeda
	<ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,  Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,  Andreas
	Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,  Trevor
	Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,  Michal
	Wilczynski <m.wilczynski@samsung.com>, Guo Ren <guoren@kernel.org>,  Fu Wei
	<wefu@redhat.com>, Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
	<krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Paul Walmsley
	<paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>,  Alexandre Ghiti <alex@ghiti.fr>,  Marek Szyprowski
	<m.szyprowski@samsung.com>,  Benno Lossin <lossin@kernel.org>,  Michael
	Turquette <mturquette@baylibre.com>,  Drew Fustini <fustini@kernel.org>,
	Benno Lossin <lossin@kernel.org>,  Drew Fustini <fustini@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20250806074255eucas1p2e52051576638bb074c251fe824c34d3d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250806074255eucas1p2e52051576638bb074c251fe824c34d3d
X-EPHeader: CA
X-CMS-RootMailID: 20250806074255eucas1p2e52051576638bb074c251fe824c34d3d
References: <20250806-rust-next-pwm-working-fan-for-sending-v13-0-690b669295b6@samsung.com>
	<CGME20250806074255eucas1p2e52051576638bb074c251fe824c34d3d@eucas1p2.samsung.com>

Introduce the foundational support for PWM abstractions in Rust.

This commit adds the `RUST_PWM_ABSTRACTIONS` Kconfig option to enable
the feature, along with the necessary build-system support and C
helpers.

It also introduces the first set of safe wrappers for the PWM
subsystem, covering the basic data carrying C structs and enums:
- `Polarity`: A safe wrapper for `enum pwm_polarity`.
- `Waveform`: A wrapper for `struct pwm_waveform`.
- `Args`: A wrapper for `struct pwm_args`.
- `State`: A wrapper for `struct pwm_state`.

These types provide memory safe, idiomatic Rust representations of the
core PWM data structures and form the building blocks for the
abstractions that will follow.

Tested-by: Drew Fustini <fustini@kernel.org>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 MAINTAINERS                     |   8 +++
 drivers/pwm/Kconfig             |  13 +++++
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/pwm.c              |  20 +++++++
 rust/kernel/lib.rs              |   2 +
 rust/kernel/pwm.rs              | 123 ++++++++++++++++++++++++++++++++++++++++
 7 files changed, 168 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d780a6fcd163b49232bd51c4ecb845530048f61e..af85c50afbf785acc6f8dffdfaf3163e555b8b7e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20371,6 +20371,14 @@ F:	include/linux/pwm.h
 F:	include/linux/pwm_backlight.h
 K:	pwm_(config|apply_might_sleep|apply_atomic|ops)
 
+PWM SUBSYSTEM BINDINGS [RUST]
+M:	Michal Wilczynski <m.wilczynski@samsung.com>
+L:	linux-pwm@vger.kernel.org
+L:	rust-for-linux@vger.kernel.org
+S:	Maintained
+F:	rust/helpers/pwm.c
+F:	rust/kernel/pwm.rs
+
 PXA GPIO DRIVER
 M:	Robert Jarzmik <robert.jarzmik@free.fr>
 L:	linux-gpio@vger.kernel.org
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index f00ce973dddf651287168b44228574f4d5c28dc0..2b608f4378138775ee3ba4d53f682952e1914118 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -800,4 +800,17 @@ config PWM_XILINX
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-xilinx.
 
+ config RUST_PWM_ABSTRACTIONS
+	bool "Rust PWM abstractions support"
+	depends on RUST
+	depends on PWM=y
+	help
+	  This option enables the safe Rust abstraction layer for the PWM
+	  subsystem. It provides idiomatic wrappers and traits necessary for
+	  writing PWM controller drivers in Rust.
+
+	  The abstractions handle resource management (like memory and reference
+	  counting) and provide safe interfaces to the underlying C core,
+	  allowing driver logic to be written in safe Rust.
+
 endif
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 84d60635e8a9baef1f1a1b2752dc0fa044f8542f..7a06ee5781eadc9f21ccd456b574a9cb152cd58c 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -66,6 +66,7 @@
 #include <linux/pm_opp.h>
 #include <linux/poll.h>
 #include <linux/property.h>
+#include <linux/pwm.h>
 #include <linux/refcount.h>
 #include <linux/regulator/consumer.h>
 #include <linux/sched.h>
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 2bb13285825b7769f818ab675fa9b979b458c076..0d1df4298dffe1e493af7ea6861e6c55b799a059 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -35,6 +35,7 @@
 #include "pid_namespace.c"
 #include "poll.c"
 #include "property.c"
+#include "pwm.c"
 #include "rbtree.c"
 #include "regulator.c"
 #include "rcu.c"
diff --git a/rust/helpers/pwm.c b/rust/helpers/pwm.c
new file mode 100644
index 0000000000000000000000000000000000000000..d75c588863685d3990b525bb1b84aa4bc35ac397
--- /dev/null
+++ b/rust/helpers/pwm.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2025 Samsung Electronics Co., Ltd.
+// Author: Michal Wilczynski <m.wilczynski@samsung.com>
+
+#include <linux/pwm.h>
+
+struct device *rust_helper_pwmchip_parent(const struct pwm_chip *chip)
+{
+	return pwmchip_parent(chip);
+}
+
+void *rust_helper_pwmchip_get_drvdata(struct pwm_chip *chip)
+{
+	return pwmchip_get_drvdata(chip);
+}
+
+void rust_helper_pwmchip_set_drvdata(struct pwm_chip *chip, void *data)
+{
+	pwmchip_set_drvdata(chip, data);
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index c2d1b93752050743e232f040ec1d3137b5e39aa4..9c3605cff348b274e9ab6f4857a7e010e9ef5ccc 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -114,6 +114,8 @@
 pub mod seq_file;
 pub mod sizes;
 mod static_assert;
+#[cfg(CONFIG_RUST_PWM_ABSTRACTIONS)]
+pub mod pwm;
 #[doc(hidden)]
 pub mod std_vendor;
 pub mod str;
diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
new file mode 100644
index 0000000000000000000000000000000000000000..57675a3dfca12033355670deb210ca66f8469334
--- /dev/null
+++ b/rust/kernel/pwm.rs
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2025 Samsung Electronics Co., Ltd.
+// Author: Michal Wilczynski <m.wilczynski@samsung.com>
+
+//! PWM subsystem abstractions.
+//!
+//! C header: [`include/linux/pwm.h`](srctree/include/linux/pwm.h).
+
+use crate::{
+    bindings,
+    prelude::*,
+    types::Opaque,
+};
+use core::convert::TryFrom;
+
+/// PWM polarity. Mirrors [`enum pwm_polarity`](srctree/include/linux/pwm.h).
+#[derive(Copy, Clone, Debug, PartialEq, Eq)]
+pub enum Polarity {
+    /// Normal polarity (duty cycle defines the high period of the signal).
+    Normal,
+
+    /// Inversed polarity (duty cycle defines the low period of the signal).
+    Inversed,
+}
+
+impl TryFrom<bindings::pwm_polarity> for Polarity {
+    type Error = Error;
+
+    fn try_from(polarity: bindings::pwm_polarity) -> Result<Self, Error> {
+        match polarity {
+            bindings::pwm_polarity_PWM_POLARITY_NORMAL => Ok(Polarity::Normal),
+            bindings::pwm_polarity_PWM_POLARITY_INVERSED => Ok(Polarity::Inversed),
+            _ => Err(EINVAL),
+        }
+    }
+}
+
+impl From<Polarity> for bindings::pwm_polarity {
+    fn from(polarity: Polarity) -> Self {
+        match polarity {
+            Polarity::Normal => bindings::pwm_polarity_PWM_POLARITY_NORMAL,
+            Polarity::Inversed => bindings::pwm_polarity_PWM_POLARITY_INVERSED,
+        }
+    }
+}
+
+/// Represents a PWM waveform configuration.
+/// Mirrors struct [`struct pwm_waveform`](srctree/include/linux/pwm.h).
+#[derive(Copy, Clone, Debug, Default, PartialEq, Eq)]
+pub struct Waveform {
+    /// Total duration of one complete PWM cycle, in nanoseconds.
+    pub period_length_ns: u64,
+
+    /// Duty-cycle active time, in nanoseconds.
+    ///
+    /// For a typical normal polarity configuration (active-high) this is the
+    /// high time of the signal.
+    pub duty_length_ns: u64,
+
+    /// Duty-cycle start offset, in nanoseconds.
+    ///
+    /// Delay from the beginning of the period to the first active edge.
+    /// In most simple PWM setups this is `0`, so the duty cycle starts
+    /// immediately at each period’s start.
+    pub duty_offset_ns: u64,
+}
+
+impl From<bindings::pwm_waveform> for Waveform {
+    fn from(wf: bindings::pwm_waveform) -> Self {
+        Waveform {
+            period_length_ns: wf.period_length_ns,
+            duty_length_ns: wf.duty_length_ns,
+            duty_offset_ns: wf.duty_offset_ns,
+        }
+    }
+}
+
+impl From<Waveform> for bindings::pwm_waveform {
+    fn from(wf: Waveform) -> Self {
+        bindings::pwm_waveform {
+            period_length_ns: wf.period_length_ns,
+            duty_length_ns: wf.duty_length_ns,
+            duty_offset_ns: wf.duty_offset_ns,
+        }
+    }
+}
+
+/// Wrapper for board-dependent PWM arguments [`struct pwm_args`](srctree/include/linux/pwm.h).
+#[repr(transparent)]
+pub struct Args(bindings::pwm_args);
+
+impl Args {
+    /// Creates a `Args` wrapper by taking ownership of a C `pwm_args` value.
+    pub(crate) fn from_c(c_args: bindings::pwm_args) -> Self {
+        Args(c_args)
+    }
+
+    /// Returns the period of the PWM signal in nanoseconds.
+    pub fn period(&self) -> u64 {
+        self.0.period
+    }
+
+    /// Returns the polarity of the PWM signal.
+    pub fn polarity(&self) -> Result<Polarity, Error> {
+        Polarity::try_from(self.0.polarity)
+    }
+}
+
+/// Wrapper for PWM state [`struct pwm_state`](srctree/include/linux/pwm.h).
+#[repr(transparent)]
+pub struct State(bindings::pwm_state);
+
+impl State {
+    /// Creates a `State` wrapper by taking ownership of a C `pwm_state` value.
+    pub(crate) fn from_c(c_state: bindings::pwm_state) -> Self {
+        State(c_state)
+    }
+
+    /// Returns `true` if the PWM signal is enabled.
+    pub fn enabled(&self) -> bool {
+        self.0.enabled
+    }
+}

-- 
2.34.1


