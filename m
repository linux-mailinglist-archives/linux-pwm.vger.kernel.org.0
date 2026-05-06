Return-Path: <linux-pwm+bounces-8794-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAMOLUa4+2k0DwAAu9opvQ
	(envelope-from <linux-pwm+bounces-8794-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 06 May 2026 23:53:10 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F184E0D10
	for <lists+linux-pwm@lfdr.de>; Wed, 06 May 2026 23:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3441B3016C9B
	for <lists+linux-pwm@lfdr.de>; Wed,  6 May 2026 21:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45673B2FE7;
	Wed,  6 May 2026 21:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKYsJ/XU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D486322B6D;
	Wed,  6 May 2026 21:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778104282; cv=none; b=lYgp8ELvU+QrwvnIVULnp/A4uQlYyr8SIjEFK2GH+JwLSXAsAhd8mFDslr9Oip8cj/LJj3I1Xs1+Gg9s/lc7OVTOWAWmcbrHBd2Y4FO+Z6AgvqTNSUh2aA/TvfC9N0UfIaAHydHEf/UwzQuL0ebDOgbz86qCcoObutN/+nuNPpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778104282; c=relaxed/simple;
	bh=eK+42iwer4stlgq5uFasabGEzh4LF2MsdeKvgd9ivO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QoHd0Z6jqDQrLfq4hKluljXItTp0qQ2PdhIB8hqYPm1UW7KjFdFRX5X8U8EqN65/qk7S3jSUHs44EPZ8oaEhCcw1hZKrTIp10eZ1Zua46spNUGbfUMtQ4LkUDvZq7idAurRQnA8EdgF1P38p860eS6YP0RsYRGfH5XpWwo0WKS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKYsJ/XU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4BFC2BCB0;
	Wed,  6 May 2026 21:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778104282;
	bh=eK+42iwer4stlgq5uFasabGEzh4LF2MsdeKvgd9ivO0=;
	h=From:To:Cc:Subject:Date:From;
	b=DKYsJ/XUxdPgaV3ZRzmV2hX0vsCs1rLlPTMS0wLRNL2J3LHQOZkt7FNA1vNmMWwvh
	 kVBE9Z9+UDkhd996+krBlBmEeitBNDcatEWn8Ior+Dw1bBPmaLNmKQtZGCFF43AEJS
	 O0Pl5fk4VDnilFtVw0/nJbH4rVNzg3v+XjjOCIfGGSOoVsalipViPL/KIHJuvwrLzK
	 0uL92zUuCuj1G80CxIlikg3im7NobgvpulaTbd4QHLUL7zi13td7CUuW9k/o6ULrzu
	 4EAKNeie9ilk78QCjjEvxqgp/pB4fLM2xSDU+1ZpwjiMdVTj59hC/ugiu5hPwXSw6E
	 7pyEEy25QgZtA==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	acourbot@nvidia.com,
	aliceryhl@google.com,
	david.m.ertman@intel.com,
	ira.weiny@intel.com,
	leon@kernel.org,
	viresh.kumar@linaro.org,
	m.wilczynski@samsung.com,
	ukleinek@kernel.org,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	abdiel.janulgue@gmail.com,
	robin.murphy@arm.com,
	markus.probst@posteo.de,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	igor.korotin@linux.dev,
	daniel.almeida@collabora.com
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-pm@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 00/25] rust: device: Higher-Ranked Lifetime Types for device drivers
Date: Wed,  6 May 2026 23:50:36 +0200
Message-ID: <20260506215113.851360-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 44F184E0D10
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8794-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Currently, Rust device drivers access device resources such as PCI BAR mappings
and I/O memory regions through Devres<T>.

Devres::access() provides zero-overhead access by taking a &Device<Bound>
reference as proof that the device is still bound. Since a &Device<Bound> is
available in almost all contexts by design, Devres is mostly a type-system level
proof that the resource is valid, but it can also be used from scopes without
this guarantee through its try_access() accessor.

This works well in general, but has a few limitations:

  - Every access to a device resource goes through Devres::access(), which
    despite zero cost, adds boilerplate to every access site.

  - Destructors do not receive a &Device<Bound>, so they must use try_access(),
    which can fail. In practice the access succeeds if teardown ordering is
    correct, but the type system can't express this, forcing drivers to handle a
    failure path that should never be taken.

  - Sharing a resource across components (e.g. passing a BAR to a sub-component)
    requires Arc<Devres<T>>.

  - Device references must be stored as ARef<Device> rather than plain &Device
    borrows.

These limitations stem from the driver's bus device private data being 'static
-- the driver struct cannot borrow from the device reference it receives in
probe(), even though it structurally cannot outlive the device binding.

This series introduces Higher-Ranked Lifetime Types (HRT) for Rust device
drivers. An HRT is a type that is generic over a lifetime -- it does not have a
fixed lifetime, but can be instantiated with any lifetime chosen by the caller.

Rust does not directly support types that are generic over a lifetime as type
parameters; the ForLt trait (contributed by Gary Guo) encodes this internally.

The module_*_driver! macros handle the wrapping, so driver authors just write
struct MyDriver<'a> and impl Driver<'a>.

With HRT, driver structs carry a lifetime parameter tied to the device binding
scope -- the interval of a bus device being bound to a driver. Device resources
like pci::Bar<'a> and IoMem<'a> are handed out with this lifetime, so the
compiler enforces at build time that they do not escape the binding scope.

Before:

	struct MyDriver {
	    pdev: ARef<pci::Device>,
	    bar: Devres<pci::Bar<BAR_SIZE>>,
	}

	let io = self.bar.access(dev)?;
	io.read32(OFFSET);

After:

	struct MyDriver<'a> {
	    pdev: &'a pci::Device,
	    bar: pci::Bar<'a, BAR_SIZE>,
	}

	self.bar.read32(OFFSET);

Lifetime-parameterized device resources can be put into a Devres at any point
via Bar::into_devres() / IoMem::into_devres(), providing the exact same
semantics as before. This is useful for resources shared across subsystem
boundaries where revocation is needed.

This also synergizes with the upcoming self-referential initialization support
in pin-init, which allows one field of the driver struct to borrow another
during initialization without unsafe code.

The same pattern is applied to auxiliary device registration data as a first
example beyond bus device private data. Registration<F: ForLt> can hold
lifetime-parameterized data tied to the parent driver's binding scope. Since the
auxiliary bus guarantees that the parent remains bound while the auxiliary
device is registered, the registration data can safely borrow the parent's
device resources.

More generally, binding resource lifetimes to a registration scope applies to
every registration that is scoped to a driver binding -- auxiliary devices,
class devices, IRQ handlers, workqueues.

A follow-up series extends this to class device registrations, starting with
DRM, so that class device callbacks (IOCTLs, etc.) can safely access device
resources through the separate registration data bound to the registration's
lifetime without Devres indirection.

The series contains a few driver patches for reference, indicated by the REF
suffix.

Thanks to Gary for coming up with the ForLt implementation; thanks to Alice for
the early discussions around lifetime-parameterized private data that helped
shape the direction of this work.

This series depends on [1].

[1] https://lore.kernel.org/driver-core/20260505152400.3905096-1-dakr@kernel.org/

Changes in v2:
  - Add 'a bound to ForLt::Of<'a> and WithLt::Of, making the lifetime bound
    inherent to the trait; remove all F::Of<'static>: 'static where clauses
  - Drop "rust: devres: add ForLt support to Devres"; Devres itself stays
    unchanged -- ForLt-aware access is introduced later through DevresLt in a
    separate series
  - Use 'bound instead of 'a; add patches to consistently use 'bound for
    pre-existing 'a

Danilo Krummrich (24):
  rust: driver core: drop drvdata before devres release
  rust: device: generalize drvdata methods over ForLt
  rust: driver: make Adapter trait lifetime-parameterized
  rust: pci: implement Sync for Device<Bound>
  rust: platform: implement Sync for Device<Bound>
  rust: auxiliary: implement Sync for Device<Bound>
  rust: usb: implement Sync for Device<Bound>
  rust: device: implement Sync for Device<Bound>
  rust: pci: make Driver trait lifetime-parameterized
  rust: platform: make Driver trait lifetime-parameterized
  rust: auxiliary: make Driver trait lifetime-parameterized
  rust: auxiliary: generalize Registration over ForLt
  samples: rust: rust_driver_auxiliary: showcase lifetime-bound
    registration data
  rust: usb: make Driver trait lifetime-parameterized
  rust: i2c: make Driver trait lifetime-parameterized
  rust: pci: make Bar lifetime-parameterized
  rust: io: make IoMem and ExclusiveIoMem lifetime-parameterized
  samples: rust: rust_driver_pci: use HRT lifetime for Bar
  rust: driver-core: rename 'a lifetime to 'bound
  gpu: nova-core: rename 'a lifetime to 'bound
  gpu: nova-core: use HRT lifetime for Bar
  gpu: nova-core: unregister sysmem flush page from Drop
  gpu: nova-core: replace ARef<Device> with &'bound Device in
    SysmemFlush
  gpu: drm: tyr: use HRT lifetime for IoMem

Gary Guo (1):
  rust: types: add `ForLt` trait for higher-ranked lifetime support

 drivers/base/dd.c                        |   2 +-
 drivers/cpufreq/rcpufreq_dt.rs           |  10 +-
 drivers/gpu/drm/nova/driver.rs           |   9 +-
 drivers/gpu/drm/tyr/driver.rs            |  24 ++-
 drivers/gpu/drm/tyr/gpu.rs               |  62 +++---
 drivers/gpu/drm/tyr/regs.rs              |  21 +-
 drivers/gpu/nova-core/driver.rs          |  48 ++---
 drivers/gpu/nova-core/fb.rs              |  31 ++-
 drivers/gpu/nova-core/firmware/gsp.rs    |   8 +-
 drivers/gpu/nova-core/gpu.rs             |  38 ++--
 drivers/gpu/nova-core/gsp/commands.rs    |  10 +-
 drivers/gpu/nova-core/gsp/fw/commands.rs |   4 +-
 drivers/gpu/nova-core/nova_core.rs       |   4 +-
 drivers/pwm/pwm_th1520.rs                |  14 +-
 include/linux/device/driver.h            |   4 +-
 rust/Makefile                            |   1 +
 rust/kernel/auxiliary.rs                 | 132 +++++++++----
 rust/kernel/cpufreq.rs                   |   8 +-
 rust/kernel/device.rs                    |  79 +++++---
 rust/kernel/devres.rs                    |  16 +-
 rust/kernel/driver.rs                    |  44 +++--
 rust/kernel/i2c.rs                       | 130 +++++++-----
 rust/kernel/io/mem.rs                    | 131 ++++++------
 rust/kernel/pci.rs                       |  89 ++++++---
 rust/kernel/pci/io.rs                    |  68 ++++---
 rust/kernel/pci/irq.rs                   |  38 ++--
 rust/kernel/platform.rs                  | 120 +++++++----
 rust/kernel/types.rs                     |   4 +
 rust/kernel/types/for_lt.rs              | 117 +++++++++++
 rust/kernel/usb.rs                       |  94 +++++----
 rust/macros/for_lt.rs                    | 242 +++++++++++++++++++++++
 rust/macros/lib.rs                       |  12 ++
 samples/rust/rust_debugfs.rs             |  10 +-
 samples/rust/rust_dma.rs                 |   9 +-
 samples/rust/rust_driver_auxiliary.rs    |  53 +++--
 samples/rust/rust_driver_i2c.rs          |  18 +-
 samples/rust/rust_driver_pci.rs          |  93 ++++-----
 samples/rust/rust_driver_platform.rs     |  12 +-
 samples/rust/rust_driver_usb.rs          |  14 +-
 samples/rust/rust_i2c_client.rs          |  12 +-
 samples/rust/rust_soc.rs                 |  12 +-
 41 files changed, 1220 insertions(+), 627 deletions(-)
 create mode 100644 rust/kernel/types/for_lt.rs
 create mode 100644 rust/macros/for_lt.rs

-- 
2.54.0


