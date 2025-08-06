Return-Path: <linux-pwm+bounces-6962-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA43B1C16F
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Aug 2025 09:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC21018C0A88
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Aug 2025 07:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D8921B9DA;
	Wed,  6 Aug 2025 07:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UPmu5qmF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714CD54654
	for <linux-pwm@vger.kernel.org>; Wed,  6 Aug 2025 07:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754466177; cv=none; b=gRmLSO23+9SVaiMFS0IGTIur4L1KDJV5QFV4vSKgNTs6uxq29Lr7gjZQhHPWB5x1BE/o7mpQDUJE6xseBqp1O3+ftdsZQ+XvIT/4pJPUEJ/tkH51SAy/FQZ2QDXjR70dtkRBtLK2iuqujmMxSH70tkvIiK8Vhnvc/sWXjr2/kP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754466177; c=relaxed/simple;
	bh=vbk/1ya0s+23u3l8tqgTy+9vEFiT8Zx3cbDlSmRjE6M=;
	h=From:Subject:Date:Message-Id:MIME-Version:To:Cc:Content-Type:
	 References; b=F0gosuR8UWjatj6+oyfz/ZP9JCNBJF2tkGaiUzy78381Q6NK53+ASFe55dHgQTrAJXKZvWann7B88CLwG4bBGURf0bCrPam7DTnSN0aneLyIKoDPOFoGTtwprvXd8Z3o7y9EM6EE2y4NCNnrPwQRuYHytMZjM6YBz7PYonwyCnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=UPmu5qmF; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250806074252euoutp02e4ee8b331ba1f75c0899141aa1dd2a39~ZHbBOmY3Z1207212072euoutp025
	for <linux-pwm@vger.kernel.org>; Wed,  6 Aug 2025 07:42:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250806074252euoutp02e4ee8b331ba1f75c0899141aa1dd2a39~ZHbBOmY3Z1207212072euoutp025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754466172;
	bh=sFlBOWp8PPR4NWlarWjxkWyh95PaOKBaxJz7SB8ymGc=;
	h=From:Subject:Date:To:Cc:References:From;
	b=UPmu5qmFpSr21OYU57XHKNTc1/3/BSyr0CX8EDBWRl2TENz1PZ05yAaaQQGlZzESD
	 3hMwxKmXWAj4nh3VVsMQBu8X5/+eAtiZ69LLp5EYY/CT8VqjvDuPjTQ45icWZeABxX
	 IiyO8BLlvvSzTVPnxQTAeePMnS4rzmr7PkNGHhuI=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250806074252eucas1p1ce94c3149ad49acf50d96fba9ca6b67c~ZHbAvGyV11469114691eucas1p12;
	Wed,  6 Aug 2025 07:42:52 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250806074251eusmtip22b18587d911cb7c312589256fae93fcd~ZHa-llNeF1964419644eusmtip2D;
	Wed,  6 Aug 2025 07:42:51 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Subject: [PATCH v13 0/7] Rust Abstractions for PWM subsystem with TH1520 PWM
 driver
Date: Wed, 06 Aug 2025 09:42:45 +0200
Message-Id: <20250806-rust-next-pwm-working-fan-for-sending-v13-0-690b669295b6@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHUHk2gC/5XUTW7cMAwF4KsEXkcFSf1ZXfUeRRayJE6MYOzUn
	pkkCObupZMAEepZqEtq8T0tHvnerWUZy9r9vHvvlnIZ13GeZEB9f9elxzgdihqzPHQEZMGSUct
	5PampvJ7U88tRvczL0zgdFMdJ8byotUx5m62lmCnjgEF3Yj0vhcfXj6DfDzI/jutpXt4+ci+4v
	f5vwgUVqCFLiIVgmP2vNR7X83T4keZjt2Vc6Nt1CK0uieutLhSsZUTYu7p2faurxcWUYm98chx
	475ra7VtdI250kXqmweU+7l1buaRbXSsupEjay4dJl73rvl0P2Oo6cckjBE3s2A1719cutbpeX
	OcL68CMmcLe7Wu3uWe9uMFisaanFDjv3VC7rtUN4hoabEyEgOlGfxFquLloUnVQGZJNrA0BmBt
	ytXK+fTVw27mgezIRpcIl3ZCpltv/vG2dAfY6F44F/pGvnydkKX/OcqJOX3fkev0L8JkwV8AEA
	AA=
X-Change-ID: 20250524-rust-next-pwm-working-fan-for-sending-552ad2d1b193
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
	devicetree@vger.kernel.org, Daniel Almeida <daniel.almeida@collabora.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20250806074252eucas1p1ce94c3149ad49acf50d96fba9ca6b67c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250806074252eucas1p1ce94c3149ad49acf50d96fba9ca6b67c
X-EPHeader: CA
X-CMS-RootMailID: 20250806074252eucas1p1ce94c3149ad49acf50d96fba9ca6b67c
References: <CGME20250806074252eucas1p1ce94c3149ad49acf50d96fba9ca6b67c@eucas1p1.samsung.com>

This patch series introduces Rust support for the T-HEAD TH1520 PWM
controller and demonstrates its use for fan control on the Sipeed Lichee
Pi 4A board.

The primary goal of this patch series is to introduce a basic set of
Rust abstractions for the Linux PWM subsystem. As a first user and
practical demonstration of these abstractions, the series also provides
a functional PWM driver for the T-HEAD TH1520 SoC. This allows control
of its PWM channels and ultimately enables temperature controlled fan
support for the Lichee Pi 4A board. This work aims to explore the use of
Rust for PWM drivers and lay a foundation for potential future Rust
based PWM drivers.

The core of this series is a new rust/kernel/pwm.rs module that provides
abstractions for writing PWM chip provider drivers in Rust. This has
been significantly reworked from v1 based on extensive feedback. The key
features of the new abstraction layer include:

 - Ownership and Lifetime Management: The pwm::Chip wrapper is managed
   by ARef, correctly tying its lifetime to its embedded struct device
   reference counter. Chip registration is handled by a pwm::Registration
   RAII guard, which guarantees that pwmchip_add is always paired with
   pwmchip_remove, preventing resource leaks.

 - Modern and Safe API: The PwmOps trait is now based on the modern
   waveform API (round_waveform_tohw, write_waveform, etc.) as recommended
   by the subsystem maintainer. It is generic over a driver's
   hardware specific data structure, moving all unsafe serialization logic
   into the abstraction layer and allowing drivers to be written in 100%
   safe Rust.

 - Ergonomics: The API provides safe, idiomatic wrappers for other PWM
   types (State, Args, Device, etc.) and uses standard kernel error
   handling patterns.

The series is structured as follows:
 - Expose static function pwmchip_release.
 - Rust PWM Abstractions: The new safe abstraction layer.
 - TH1520 PWM Driver: A new Rust driver for the TH1520 SoC, built on
   top of the new abstractions.
 - Device Tree Bindings & Nodes: The remaining patches add the necessary
   DT bindings and nodes for the TH1520 PWM controller, and the PWM fan
   configuration for the Lichee Pi 4A board.

Testing:
Tested on the TH1520 SoC. The fan works correctly. The duty/period
calculations are correct. Fan starts slow when the chip is not hot and
gradually increases the speed when PVT reports higher temperatures.

The patches doesn't contain any dependencies that are not currently in
the mainline kernel anymore.

---
Changes in v13:
- Re-add the T-HEAD TH1520 PWM driver and its device tree bindings, as
  Iomem series got merged into mainline kernel.
- Fix Args struct to be consistent with State - no Opaque needed for
  copies.
- Replace tuple retur type in the PwmOps trait with dedicated struct
  for improved clarity.
- Use build_assert for WfHw size, as it doesn't have to be runtime
  check.
- Various cosmetic changes.
- Link to v12: https://lore.kernel.org/r/20250717-rust-next-pwm-working-fan-for-sending-v12-0-40f73defae0c@samsung.com

Changes in v12:
 - Reworked the PWM abstractions to use the subclassing pattern as
   suggested by reviewers.
 - pwm::Chip and its driver data are now allocated in a single, contiguous
   memory block via pwmchip_alloc() sizeof_priv argument.
 - Chip::new() now uses the pin init API to construct the driver data
   in place, removing the need for a separate allocation.
 - The  PwmOps trait is now implemented directly by the driver data struct
   itself, removing the DrvData associated type and the ForeignOwnable
   trait.
 - The custom release handler has been updated to call drop_in_place on the driver
   data, ensuring destructors are run correctly before the underlying
   memory is freed.
 - Moved the pwmchip_release prototype in the C header to a separate
   section to clarify it is for FFI use only, as requested.
 - Added a Prerequisite-patch-id trailer to the cover letter to declare
   the dependency on the PWM_WFHWSIZE patch.

- Link to v11: https://lore.kernel.org/r/20250710-rust-next-pwm-working-fan-for-sending-v11-0-93824a16f9ec@samsung.com

Changes in v11:
- Dropped driver and DT commits, as they don't compile based on publicly
  known commit.
- Re-based on top of pwm/for-next.
- Reverted back to devres::Devres::new_foreign_owned, as pwm/for-next
  doesn't contain 'register' re-factor, which is present in linux-next,
  queued for the next merge window. The conflict is trivial, simply
  change 'new_foreign_owned' -> 'register'.
- Added list to MAINTAINERS entry as requested.
- Link to v10: https://lore.kernel.org/r/20250707-rust-next-pwm-working-fan-for-sending-v10-0-d0c5cf342004@samsung.com

Changes in v10:
 - Exported the C pwmchip_release function and called it from the custom
   Rust release_callback to fix a memory leak of the pwm_chip struct.
 - Removed the PwmOps::free callback, as it is not needed for idiomatic
   Rust resource management.
 - Removed the redundant is_null check for drvdata in the release handler,
   as the Rust API guarantees a valid pointer is always provided.

- Link to v9: https://lore.kernel.org/r/20250706-rust-next-pwm-working-fan-for-sending-v9-0-42b5ac2101c7@samsung.com

Changes in v9:
 - Encapsulated vtable setup in Chip::new(): The Chip::new() function is
   now generic over the PwmOps implementation. This allows it to create and
   assign the vtable internally, which simplifies the public API by
   removing the ops_vtable parameter from Registration::register().
 - Fixed memory leak with a release handler: A custom release_callback is
   now assigned to the embedded struct device's release hook. This
   guarantees that driver specific data is always freed when the chip is
   destroyed, even if registration fails.
 - The PwmOpsVTable is now defined as a const associated item to ensure
   it has a 'static lifetime.
 - Combined introductory commits: The Device, Chip, and PwmOps abstractions
   are now introduced in a single commit. This was necessary to resolve the
   circular dependencies between them and present a clean, compilable unit
   for review.

- Link to v8: https://lore.kernel.org/r/20250704-rust-next-pwm-working-fan-for-sending-v8-0-951e5482c9fd@samsung.com

Changes in v8:
 - Dropped already accepted commit, re-based on top of linux-next
 - Reworked the Chip and PwmOps APIs to address the drvdata() type-safety
   comment. Chip is now generic, and PwmOps uses an associated type
   to provide compile-time guarantees.
 - Added a parent device sanity check to Registration::register().
 - Updated drvdata() to return the idiomatic T::Borrowed<'_>.
 - added temporary unsafe blocks in the driver, as the current
   abstraction for Clk is neiter Safe nor Sync. I think eventually
   proper abstraction for Clk will be added as in a current state it's
   not very useful.

- Link to v7: https://lore.kernel.org/r/20250702-rust-next-pwm-working-fan-for-sending-v7-0-67ef39ff1d29@samsung.com

Changes in v7:
- Made parent_device function private and moved casts to Device<Bound>
  there as well.
- Link to v6: https://lore.kernel.org/r/20250701-rust-next-pwm-working-fan-for-sending-v6-0-2710932f6f6b@samsung.com

Changes in v6:
 - Re-based on top of linux-next, dropped two already accepted commits.
 - After re-basing the IoMem dependent patchset stopped working,
   reworked it to use similar API like the PCI subsystem (I think it
   will end up the same). Re-worked the driver for it as well.
 - Remove the apply and get_state callbacks, and most of the State as
   well, as the old way of implementing drivers should not be possible
   in Rust. Left only enabled(), since it's useful for my driver.
 - Removed the public set_drvdata() method from pwm::Chip
 - Moved WFHWSIZE to the public include/linux/pwm.h header and renamed it
   to PWM_WFHWSIZE, allowing bindgen to create safe FFI bindings.
 - Corrected the ns_to_cycles integer calculation in the TH1520 driver to
   handle overflow correctly.
 - Updated the Kconfig entry for the TH1520 driver to select the Rust
   abstractions for a better user experience.

- Link to v5: https://lore.kernel.org/r/20250623-rust-next-pwm-working-fan-for-sending-v5-0-0ca23747c23e@samsung.com

Changes in v5:
- Reworked `pwm::Chip` creation to take driver data directly, which
  allowed making the `chip.drvdata()` accessor infallible
- added missing `pwm.c` file lost during the commit split (sorry !)
- Link to v4: https://lore.kernel.org/r/20250618-rust-next-pwm-working-fan-for-sending-v4-0-a6a28f2b6d8a@samsung.com

Changes in v4:
 - Reworked the pwm::Registration API to use the devres framework,
   addressing lifetime issue.
 - Corrected the PwmOps trait and its callbacks to use immutable references
   (&Chip, &Device) for improved safety.
 - Applied various code style and naming cleanups based on feedback

- Link to v3: https://lore.kernel.org/r/20250617-rust-next-pwm-working-fan-for-sending-v3-0-1cca847c6f9f@samsung.com

Changes in v3:
 - Addressed feedback from Uwe by making multiple changes to the TH1520
   driver and the abstraction layer.
 - Split the core PWM abstractions into three focused commits to ease
   review per Benno request.
 - Confirmed the driver now works correctly with CONFIG_PWM_DEBUG enabled
   by implementing the full waveform API, which correctly reads the
   hardware state.
 - Refactored the Rust code to build cleanly with
   CONFIG_RUST_BUILD_ASSERT_ALLOW=n, primarily by using the try_* family of
   functions for IoMem access.
 - Included several cosmetic changes and cleanups to the abstractions
   per Miguel review.

- Link to v2: https://lore.kernel.org/r/20250610-rust-next-pwm-working-fan-for-sending-v2-0-753e2955f110@samsung.com

Changes in v2:
 - Reworked the PWM abstraction layer based on extensive feedback.
 - Replaced initial devm allocation with a proper ARef<Chip> lifetime model
   using AlwaysRefCounted.
 - Implemented a Registration RAII guard to ensure safe chip add/remove.
 - Migrated the PwmOps trait from the legacy .apply callback to the modern
   waveform API.
 - Refactored the TH1520 driver to use the new, safer abstractions.
 - Added a patch to mark essential bus clocks as CLK_IGNORE_UNUSED to fix
   boot hangs when the PWM and thermal sensors are enabled.
- Link to v1: https://lore.kernel.org/r/20250524-rust-next-pwm-working-fan-for-sending-v1-0-bdd2d5094ff7@samsung.com

---
Michal Wilczynski (7):
      pwm: Export `pwmchip_release` for external use
      rust: pwm: Add Kconfig and basic data structures
      rust: pwm: Add complete abstraction layer
      pwm: Add Rust driver for T-HEAD TH1520 SoC
      dt-bindings: pwm: thead: Add T-HEAD TH1520 PWM controller
      riscv: dts: thead: Add PWM controller node
      riscv: dts: thead: Add PWM fan and thermal control

 .../devicetree/bindings/pwm/thead,th1520-pwm.yaml  |  48 ++
 MAINTAINERS                                        |  10 +
 arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts  |  67 ++
 arch/riscv/boot/dts/thead/th1520.dtsi              |   7 +
 drivers/pwm/Kconfig                                |  24 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/core.c                                 |   3 +-
 drivers/pwm/pwm_th1520.rs                          | 355 +++++++++
 include/linux/pwm.h                                |   6 +
 rust/bindings/bindings_helper.h                    |   1 +
 rust/helpers/helpers.c                             |   1 +
 rust/helpers/pwm.c                                 |  20 +
 rust/kernel/lib.rs                                 |   2 +
 rust/kernel/pwm.rs                                 | 790 +++++++++++++++++++++
 14 files changed, 1334 insertions(+), 1 deletion(-)
---
base-commit: eacf91b0c78a7113844830ed65ebf543eb9052c5
change-id: 20250524-rust-next-pwm-working-fan-for-sending-552ad2d1b193

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>


