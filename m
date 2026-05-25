Return-Path: <linux-pwm+bounces-9126-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OI/rCy+xFGrRPQcAu9opvQ
	(envelope-from <linux-pwm+bounces-9126-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 22:29:35 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 955675CE60D
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 22:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1FE8330185AF
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 20:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734C5396D2C;
	Mon, 25 May 2026 20:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSJY/fX1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CE53947AE;
	Mon, 25 May 2026 20:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779740972; cv=none; b=Zj77CwfjcfJ26FUq3cPxfmzfHL59o6IihOmZAdeHlC7nj3gECGp7dd/0JSYUx/FPvxKoew58YMAXCdLkV1QWZtbSMLiYgB0UGcjDp2ObGG44gh1z/I/xelHcDsT1EwxBWCxcNvtk0DU8JjVDrb+xGN37yZS+yImFezcuiUZolFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779740972; c=relaxed/simple;
	bh=5qWN36ryVO875bRpm9upQBvh6AdLmlbQstO7sKOANT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XKBV2/Ue4j4pqMVV04COl/gMllnbHW1R4kS6qqO4219Fha6dH8gXbeoZMRmgU6XeAsnqutfDUy2f0CXfw6hou7Afk2CMhZJsYNJTAv1mBVKvphz9TinMVonAx3FFVqPNHd+LhLgJFjLFrzDymUXhjgGnMgpgmzfiwl0Hti20yio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSJY/fX1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F261F000E9;
	Mon, 25 May 2026 20:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779740970;
	bh=hbKm+QMbi0bxLA16ZUxC2wBcszGlYqRN0cc16jNNxWw=;
	h=From:To:Cc:Subject:Date;
	b=eSJY/fX11QSv/mXbgRvvzhJ0rwCmYj90qowizR2IUdbct3zFV8G3sVmX5Tw9hNXzi
	 /cTjojCnKZV362Eb445Z+XD3DtrrNylsWbXEqCSzzgAwFv1/Dp6SS/MjzCgldzBzgX
	 UfHx4Mn+/YAFy1wfwHaU5NElk7EXb47nUsoNz4CE7vpNBcMKDXc9Uxhx8xseduKpzj
	 0s+dfDNc+1mYd8oXXkxulD6TvD9okbZ8D63hKsRNgBFiy6YOd/J6DuSL055udyTAdi
	 FuUFogRAdxWIhlVbP8TaUok/23CAvhzJ+6zJsxH6p/ow/AZm+AmFnmcSXUfLHJ69RP
	 jOnky1gjzeh9A==
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
	daniel.almeida@collabora.com,
	pcolberg@redhat.com
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-pm@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v5 00/24] rust: device: Higher-Ranked Lifetime Types for device drivers
Date: Mon, 25 May 2026 22:20:47 +0200
Message-ID: <20260525202921.124698-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9126-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[34];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 955675CE60D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

Bus driver traits use a Generic Associated Type (GAT) type Data<'bound> to
introduce the lifetime on the private data, rather than parameterizing the
Driver trait itself. This avoids a driver trait global lifetime and avoids the
need for ForLt for bus device private data, making the bus implementations much
simpler. ForLt is only needed for auxiliary registration data, where the
lifetime is not introduced by a trait callback but must be threaded through
Registration.

With HRT, driver structs carry a lifetime parameter tied to the device binding
scope -- the interval of a bus device being bound to a driver. Device resources
like pci::Bar<'bound> and IoMem<'bound> are handed out with this lifetime, so
the compiler enforces at build time that they do not escape the binding scope.

Before:

	struct MyDriver {
	    pdev: ARef<pci::Device>,
	    bar: Devres<pci::Bar<BAR_SIZE>>,
	}

	let io = self.bar.access(dev)?;
	io.read32(OFFSET);

After:

	struct MyDriver<'bound> {
	    pdev: &'bound pci::Device,
	    bar: pci::Bar<'bound, BAR_SIZE>,
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

Thanks to Gary for coming up with the ForLt implementation; thanks to Alice for
the early discussions around lifetime-parameterized private data that helped
shape the direction of this work.

Changes in v5:
  - Fix Bar name parameter to &'static CStr
  - ForLt: handle macro_rules! invocations in covariance/WF checks by
    conservatively assuming they may contain lifetimes; fix typos in commit
    message and doc comments
  - Update stale SAFETY comments from T::Data to T::Data<'_> in bus
    driver callbacks
  - Fix USB commit message: unbind() -> disconnect()
  - Clarify Bar commit message on why Devres is no longer needed
  - Drop REF patches (nova-core, tyr); will be revisited and sent separately to
    be routed through drm-rust

Changes in v4:
  - Use 'bound only for lifetimes that represent the full duration of a device
    being bound to a driver
  - Make Core and CoreInternal lifetime-parameterized
  - Split auxiliary::Registration constructor into unsafe fn new_with_lt
    (borrowed data) and safe fn new ('static data) to close mem::forget()
    soundness hole
  - Use TypeId::of::<F>() instead of TypeId::of::<F::Of<'static>>() in auxiliary
    registration_data()
  - Handle Type::Macro in ForLt! covariance and WF checks; proc macros cannot
    expand macro_rules invocations, so use WithLt trait projection for lifetime
    substitution
  - Fix missing Send bound in type Data: Send

Changes in v3:
  - Rework all bus "make Driver trait lifetime-parameterized" patches to use a
    GAT (type Data<'bound>); in the context of adding a 'bound lifetime, this
    avoids a driver trait global lifetime and avoids ForLt for bus device
    private data making the bus implementations much simpler

Changes in v2:
  - Add 'a bound to ForLt::Of<'a> and WithLt::Of, making the lifetime bound
    inherent to the trait; remove all F::Of<'static>: 'static where clauses
  - Drop "rust: devres: add ForLt support to Devres"; Devres itself stays
    unchanged -- ForLt-aware access is introduced later through DevresLt in a
    separate series
  - Use 'bound instead of 'a; add patches to consistently use 'bound for
    pre-existing 'a

Danilo Krummrich (21):
  rust: pci: use 'static lifetime for PCI BAR resource names
  rust: driver: decouple driver private data from driver type
  rust: driver core: drop drvdata before devres release
  rust: pci: implement Sync for Device<Bound>
  rust: platform: implement Sync for Device<Bound>
  rust: auxiliary: implement Sync for Device<Bound>
  rust: usb: implement Sync for Device<Bound>
  rust: device: implement Sync for Device<Bound>
  rust: device: make Core and CoreInternal lifetime-parameterized
  rust: pci: make Driver trait lifetime-parameterized
  rust: platform: make Driver trait lifetime-parameterized
  rust: auxiliary: make Driver trait lifetime-parameterized
  rust: usb: make Driver trait lifetime-parameterized
  rust: i2c: make Driver trait lifetime-parameterized
  rust: driver: update module documentation for GAT-based Data type
  rust: pci: make Bar lifetime-parameterized
  rust: io: make IoMem and ExclusiveIoMem lifetime-parameterized
  samples: rust: rust_driver_pci: use HRT lifetime for Bar
  gpu: nova-core: separate driver type from driver data
  rust: auxiliary: generalize Registration over ForLt
  samples: rust: rust_driver_auxiliary: showcase lifetime-bound
    registration data

Gary Guo (3):
  rust: alloc: remove `'static` bound on `ForeignOwnable`
  rust: driver: move 'static bounds to constructor
  rust: types: add `ForLt` trait for higher-ranked lifetime support

 drivers/base/dd.c                     |   2 +-
 drivers/cpufreq/rcpufreq_dt.rs        |   9 +-
 drivers/gpu/drm/nova/driver.rs        |   6 +-
 drivers/gpu/drm/tyr/driver.rs         |  13 +-
 drivers/gpu/nova-core/driver.rs       |  30 ++--
 drivers/gpu/nova-core/gpu.rs          |   2 +-
 drivers/gpu/nova-core/nova_core.rs    |   2 +-
 drivers/pwm/pwm_th1520.rs             |  13 +-
 include/linux/device/driver.h         |   4 +-
 rust/Makefile                         |   1 +
 rust/kernel/alloc/kbox.rs             |  24 ++-
 rust/kernel/auxiliary.rs              | 142 ++++++++++-----
 rust/kernel/cpufreq.rs                |   9 +-
 rust/kernel/device.rs                 |  61 +++++--
 rust/kernel/devres.rs                 |   2 +-
 rust/kernel/dma.rs                    |   2 +-
 rust/kernel/driver.rs                 |  41 +++--
 rust/kernel/i2c.rs                    |  61 ++++---
 rust/kernel/io/mem.rs                 | 121 +++++++------
 rust/kernel/pci.rs                    |  51 +++---
 rust/kernel/pci/id.rs                 |   2 +-
 rust/kernel/pci/io.rs                 |  54 +++---
 rust/kernel/platform.rs               |  52 +++---
 rust/kernel/types.rs                  |  12 +-
 rust/kernel/types/for_lt.rs           | 117 ++++++++++++
 rust/kernel/usb.rs                    |  57 +++---
 rust/macros/for_lt.rs                 | 248 ++++++++++++++++++++++++++
 rust/macros/lib.rs                    |  12 ++
 samples/rust/rust_debugfs.rs          |  11 +-
 samples/rust/rust_dma.rs              |   6 +-
 samples/rust/rust_driver_auxiliary.rs |  79 +++++---
 samples/rust/rust_driver_i2c.rs       |  13 +-
 samples/rust/rust_driver_pci.rs       |  90 +++++-----
 samples/rust/rust_driver_platform.rs  |   9 +-
 samples/rust/rust_driver_usb.rs       |  15 +-
 samples/rust/rust_i2c_client.rs       |  14 +-
 samples/rust/rust_soc.rs              |   9 +-
 37 files changed, 998 insertions(+), 398 deletions(-)
 create mode 100644 rust/kernel/types/for_lt.rs
 create mode 100644 rust/macros/for_lt.rs


base-commit: 95ade775c4ab9b9b3d7cfa2d45283e93fbfa4e7a
-- 
2.54.0


