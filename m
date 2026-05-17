Return-Path: <linux-pwm+bounces-8899-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDIFJ4IFCWq6FQQAu9opvQ
	(envelope-from <linux-pwm+bounces-8899-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 02:02:10 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7D955E5C6
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 02:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22A65300E275
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 00:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344C01862A;
	Sun, 17 May 2026 00:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WzynblCj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A45D10F2;
	Sun, 17 May 2026 00:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778976125; cv=none; b=GkjGKaTjTL3aKzJTmLCXxiKnzB4uvY391sTkKhc1tWgNYdHvFfOVq8wCPTqijVUp8GSmIbKVPMeaAZKTywxAqCbFqY0QqBj/ZyB6Hk4dEWJCLEWrENnASTgdrm/AGCW7fJJgQNDW/8x0GuKSN6zrJxLyxNlTBoQ34xFzJcRR9fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778976125; c=relaxed/simple;
	bh=FueW5XHGsrTI0/bBHXpSoGIK5l+aDF+K76K15915R0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gjzPdsC94mZo9nAVR+4cwf00CmuVBJhNr+wqIM3b7PweojFFON7ZQ/pEwR+pN8qEjttvWE4tLD/JvI0Aph/j0hMfN3F9xRmD/OrwxdIT7wac54bIpwa29ynOsg8YboTEctLWAAgCJQqiEu43jLI/kIDc+GOeTSzsc2uHDYqEC2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WzynblCj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340A4C19425;
	Sun, 17 May 2026 00:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778976124;
	bh=FueW5XHGsrTI0/bBHXpSoGIK5l+aDF+K76K15915R0E=;
	h=From:To:Cc:Subject:Date:From;
	b=WzynblCj7QPOl3VxEzVVM+iO3ZBB7X97GhpUHW9bls4qUvzqHncXrOmdcLCmyYpK4
	 gEqbvT4xZ09FHIZHdnzqJv/kM7IFBAfbpCKMa8z5XNU3IY3mmfCAfdp3nsk60qtdam
	 U6/SrR0XdVac1kymIl07WPmLMa0JiLRCK3CVAMLV38eF0d8HmXVUQ6ZdgBYNNfnL9H
	 gWHVUrCvd4dQcvpkKqD663DYdzqhDnjGJ+QJuCYIMFMZ8PXqBft2llxytWhK7mhMAo
	 2ggJ6eK8LUNCEV6EpLdLl1ior3PaSjuHBzeHypI679XaiwZuthituZ/68Q83yO6Z5O
	 WtfEFquCH1hXg==
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
Subject: [PATCH v3 00/27] rust: device: Higher-Ranked Lifetime Types for device drivers
Date: Sun, 17 May 2026 02:00:48 +0200
Message-ID: <20260517000149.3226762-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BA7D955E5C6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8899-lists,linux-pwm=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
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

The series contains a few driver patches for reference, indicated by the REF
suffix.

Thanks to Gary for coming up with the ForLt implementation; thanks to Alice for
the early discussions around lifetime-parameterized private data that helped
shape the direction of this work.

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

Danilo Krummrich (24):
  rust: driver: decouple driver private data from driver type
  rust: driver core: drop drvdata before devres release
  rust: pci: implement Sync for Device<Bound>
  rust: platform: implement Sync for Device<Bound>
  rust: auxiliary: implement Sync for Device<Bound>
  rust: usb: implement Sync for Device<Bound>
  rust: device: implement Sync for Device<Bound>
  rust: pci: make Driver trait lifetime-parameterized
  rust: platform: make Driver trait lifetime-parameterized
  rust: auxiliary: make Driver trait lifetime-parameterized
  rust: usb: make Driver trait lifetime-parameterized
  rust: i2c: make Driver trait lifetime-parameterized
  rust: driver: update module documentation for GAT-based Data type
  rust: auxiliary: generalize Registration over ForLt
  samples: rust: rust_driver_auxiliary: showcase lifetime-bound
    registration data
  rust: pci: make Bar lifetime-parameterized
  rust: io: make IoMem and ExclusiveIoMem lifetime-parameterized
  samples: rust: rust_driver_pci: use HRT lifetime for Bar
  rust: driver-core: rename 'a lifetime to 'bound
  gpu: nova-core: rename 'a lifetime to 'bound
  gpu: nova-core: use lifetime for Bar
  gpu: nova-core: unregister sysmem flush page from Drop
  gpu: nova-core: replace ARef<Device> with &'bound Device in
    SysmemFlush
  gpu: drm: tyr: use lifetime for IoMem

Gary Guo (3):
  rust: alloc: remove `'static` bound on `ForeignOwnable`
  rust: driver: move 'static bounds to constructor
  rust: types: add `ForLt` trait for higher-ranked lifetime support

 drivers/base/dd.c                        |   2 +-
 drivers/cpufreq/rcpufreq_dt.rs           |   9 +-
 drivers/gpu/drm/nova/driver.rs           |   6 +-
 drivers/gpu/drm/tyr/driver.rs            |  23 ++-
 drivers/gpu/drm/tyr/gpu.rs               |  62 +++---
 drivers/gpu/drm/tyr/regs.rs              |  21 +-
 drivers/gpu/nova-core/driver.rs          |  51 ++---
 drivers/gpu/nova-core/fb.rs              |  31 ++-
 drivers/gpu/nova-core/firmware/gsp.rs    |   8 +-
 drivers/gpu/nova-core/gpu.rs             |  38 ++--
 drivers/gpu/nova-core/gsp/commands.rs    |  10 +-
 drivers/gpu/nova-core/gsp/fw/commands.rs |   4 +-
 drivers/gpu/nova-core/nova_core.rs       |   2 +-
 drivers/pwm/pwm_th1520.rs                |  13 +-
 include/linux/device/driver.h            |   4 +-
 rust/Makefile                            |   1 +
 rust/kernel/alloc/kbox.rs                |  24 ++-
 rust/kernel/auxiliary.rs                 |  98 +++++----
 rust/kernel/cpufreq.rs                   |   9 +-
 rust/kernel/device.rs                    |  12 +-
 rust/kernel/devres.rs                    |  16 +-
 rust/kernel/driver.rs                    |  37 ++--
 rust/kernel/i2c.rs                       |  62 +++---
 rust/kernel/io/mem.rs                    | 133 +++++++------
 rust/kernel/pci.rs                       |  39 ++--
 rust/kernel/pci/io.rs                    |  68 ++++---
 rust/kernel/pci/irq.rs                   |  38 ++--
 rust/kernel/platform.rs                  |  62 +++---
 rust/kernel/types.rs                     |  12 +-
 rust/kernel/types/for_lt.rs              | 117 +++++++++++
 rust/kernel/usb.rs                       |  53 +++--
 rust/macros/for_lt.rs                    | 242 +++++++++++++++++++++++
 rust/macros/lib.rs                       |  12 ++
 samples/rust/rust_debugfs.rs             |   9 +-
 samples/rust/rust_dma.rs                 |   6 +-
 samples/rust/rust_driver_auxiliary.rs    |  41 ++--
 samples/rust/rust_driver_i2c.rs          |  13 +-
 samples/rust/rust_driver_pci.rs          |  90 ++++-----
 samples/rust/rust_driver_platform.rs     |   9 +-
 samples/rust/rust_driver_usb.rs          |  13 +-
 samples/rust/rust_i2c_client.rs          |  14 +-
 samples/rust/rust_soc.rs                 |   9 +-
 42 files changed, 1011 insertions(+), 512 deletions(-)
 create mode 100644 rust/kernel/types/for_lt.rs
 create mode 100644 rust/macros/for_lt.rs


base-commit: 8d3bea93f483cb8f92b9f85d1528268a6469af28
-- 
2.54.0


