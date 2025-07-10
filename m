Return-Path: <linux-pwm+bounces-6820-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C69B00BB4
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Jul 2025 20:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DA9F5C0C3E
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Jul 2025 18:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C472FD5AC;
	Thu, 10 Jul 2025 18:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="u2zap5jo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC6E2FD581
	for <linux-pwm@vger.kernel.org>; Thu, 10 Jul 2025 18:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752173685; cv=none; b=CGUmf1r3GG2REVPFv6I9Iktx6lxuU6uBrA9KpgJEkDYhZiTiwA7oy8EzsbIe+t+SjrOLAnxZKOZEhQczkc+xWtBrwf6It90MNvJ71mNE/qUrYidqbrp7msChV1wZofDhKJlldNeSG4SHnxN6N4MqxKkr3ntfGyJckgs/t5hEkxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752173685; c=relaxed/simple;
	bh=/OtKJxxr+rsqjTLS7hAiA2D1ufkvpJWSTweL2w50xAQ=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=a+Jvf70SXKriEKj6s/EZ88JnnpJnAUchNPszDmV4pvueAQ3ypYPXJD0coSu3Dj30bLzCIZli+YgR9x49TutdzK1MPdLW3m5WJw/9/tPQgTHSs7M0ScvRmRq6Bcmo/CLNG6V9K3wsgroasgQoZXGmBkkee/Q6PPAUvDK8S9lmjow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=u2zap5jo; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250710185442euoutp01e959128b7e8337dec77faa1506bebc41~Q_K43cDVX1557715577euoutp01R
	for <linux-pwm@vger.kernel.org>; Thu, 10 Jul 2025 18:54:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250710185442euoutp01e959128b7e8337dec77faa1506bebc41~Q_K43cDVX1557715577euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1752173682;
	bh=7z6+Dkh6UkCFrLttXWWt6W6hTmLBHMizcToymQJAPX8=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=u2zap5jonqHKjxqmf2NjG9JlVsL2t2ZDD/XxRtQ6h4xZOXJY3wKYzs123+YCVLY9D
	 8sIcZyz1cS58RaoYfQd9BkTkFOHvGa0JzbU6+APIh3JV8giRL7SbYcrIfN4xarSMvE
	 8fM/nxDHPSNjgR3a53kIRGvzjuxNFSgeHcrDu8nk=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250710185440eucas1p2ea282a7bae97733fd010e69ff8003013~Q_K3U4EP83113931139eucas1p2j;
	Thu, 10 Jul 2025 18:54:40 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250710185439eusmtip1242ee7fd11c164ea28e3284250d5bd91~Q_K2N4Ycw2401224012eusmtip1i;
	Thu, 10 Jul 2025 18:54:39 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Thu, 10 Jul 2025 20:54:29 +0200
Subject: [PATCH v11 2/3] rust: pwm: Add Kconfig and basic data structures
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20250710-rust-next-pwm-working-fan-for-sending-v11-2-93824a16f9ec@samsung.com>
In-Reply-To: <20250710-rust-next-pwm-working-fan-for-sending-v11-0-93824a16f9ec@samsung.com>
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
	Drew Fustini <fustini@kernel.org>, Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20250710185440eucas1p2ea282a7bae97733fd010e69ff8003013
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250710185440eucas1p2ea282a7bae97733fd010e69ff8003013
X-EPHeader: CA
X-CMS-RootMailID: 20250710185440eucas1p2ea282a7bae97733fd010e69ff8003013
References: <20250710-rust-next-pwm-working-fan-for-sending-v11-0-93824a16f9ec@samsung.com>
	<CGME20250710185440eucas1p2ea282a7bae97733fd010e69ff8003013@eucas1p2.samsung.com>

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
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 MAINTAINERS                     |   8 +++
 drivers/pwm/Kconfig             |  13 ++++
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/pwm.c              |  20 ++++++
 rust/kernel/lib.rs              |   2 +
 rust/kernel/pwm.rs              | 137 ++++++++++++++++++++++++++++++++++++++++
 7 files changed, 182 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0c1d245bf7b84f8a78b811e0c9c5a3edc09edc22..ca490a8a196c5db2870459084168c5483eb57b06 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20073,6 +20073,14 @@ F:	include/linux/pwm.h
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
index 3ef1757502ebd92b30584cd10611311a0fbfc03b..c32655566d6ab9eff9d10f29e469f9aef89cecfa 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -799,4 +799,17 @@ config PWM_XILINX
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
index bc494745f67b82e7a3a6f53055ece0fc3acf6e0d..e794dada5537c53f8aeae425d181ec339c10f9d0 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -63,6 +63,7 @@
 #include <linux/pm_opp.h>
 #include <linux/poll.h>
 #include <linux/property.h>
+#include <linux/pwm.h>
 #include <linux/refcount.h>
 #include <linux/sched.h>
 #include <linux/security.h>
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 16fa9bca5949b85e8d4cdcfe8e6886124f72d8d8..60879e6d794ce0f87e39caafc5495bf5e8acf8f0 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -31,6 +31,7 @@
 #include "platform.c"
 #include "pci.c"
 #include "pid_namespace.c"
+#include "pwm.c"
 #include "rbtree.c"
 #include "rcu.c"
 #include "refcount.c"
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
index 6b4774b2b1c37f4da1866e993be6230bc6715841..ce1d08b14e456905dbe7b625bbb8ca8b08deae2a 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -105,6 +105,8 @@
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
index 0000000000000000000000000000000000000000..3fad101406eac728d9b12083fad7abf7b7f89b25
--- /dev/null
+++ b/rust/kernel/pwm.rs
@@ -0,0 +1,137 @@
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
+pub struct Args(Opaque<bindings::pwm_args>);
+
+impl Args {
+    /// Creates an `Args` wrapper from a C struct pointer.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `c_args_ptr` is a valid, non-null pointer
+    /// to `bindings::pwm_args` and that the pointed-to data is valid
+    /// for the duration of this function call (as data is copied).
+    unsafe fn from_c_ptr(c_args_ptr: *const bindings::pwm_args) -> Self {
+        // SAFETY: Caller guarantees `c_args_ptr` is valid. We dereference it to copy.
+        Args(Opaque::new(unsafe { *c_args_ptr }))
+    }
+
+    /// Returns the period of the PWM signal in nanoseconds.
+    pub fn period(&self) -> u64 {
+        // SAFETY: `self.0.get()` returns a pointer to the `bindings::pwm_args`
+        // managed by the `Opaque` wrapper. This pointer is guaranteed to be
+        // valid and aligned for the lifetime of `self` because `Opaque` owns a copy.
+        unsafe { (*self.0.get()).period }
+    }
+
+    /// Returns the polarity of the PWM signal.
+    pub fn polarity(&self) -> Result<Polarity, Error> {
+        // SAFETY: `self.0.get()` returns a pointer to the `bindings::pwm_args`
+        // managed by the `Opaque` wrapper. This pointer is guaranteed to be
+        // valid and aligned for the lifetime of `self`.
+        let raw_polarity = unsafe { (*self.0.get()).polarity };
+        Polarity::try_from(raw_polarity)
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


