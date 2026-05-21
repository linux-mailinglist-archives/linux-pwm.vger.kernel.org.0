Return-Path: <linux-pwm+bounces-9047-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKG9C62XD2r5NgYAu9opvQ
	(envelope-from <linux-pwm+bounces-9047-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 01:39:25 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E0E5ACDBF
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 01:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3552230054EE
	for <lists+linux-pwm@lfdr.de>; Thu, 21 May 2026 23:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B751348C47;
	Thu, 21 May 2026 23:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uoe2A26T"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EB131F98E;
	Thu, 21 May 2026 23:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779406762; cv=none; b=aWH010HlL+pdMDLPvRMlbBuKAiq+3KNi3jmViWQwxA7TwMreGEN81+qsaowq5UphTGA7zShStnkgFPEBt1FaHOindiJepAoITpjc1ipweNUhoeqsdxuJ8WSx8ZCQwl6gyh+QXZ82Z6h2AXUQ4aIU8CdSuvaneJHJeSsRnP0ghnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779406762; c=relaxed/simple;
	bh=UtyavNy3t/fsQvpHev51O6aS6F/3Gu9YO4jx88jb1Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cGywBq0enO++VeUp3247U2yCeHY3wtmSNGSkqBG8FZnzxc+Z9vP1Wwue0nfruhQmXOEls1Vga7q8auvu9B7V9bRSEKIGf+MBhYgbnLRg9+pi7Gm5io/vFUlPoq6k0H37iFXKPMH3/BMpu2jIy1aKaF3m32+z0uaiBlXlJKUYgfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uoe2A26T; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5080D1F000E9;
	Thu, 21 May 2026 23:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779406759;
	bh=oh6ATn0JwY4+EDxHSfHhWKPTI9yODfpqPfUosl9OAY8=;
	h=From:To:Cc:Subject:Date;
	b=Uoe2A26TNx5SV2ZJaH7ZPogYuwJjOK4C5jLrJPlxJ1nirNVBU+2ELtiPUa2FU+ssm
	 4DcToCl9EApK3h4eyklEy3lOm8M+p0bIhepRDTHV+K/x+ncrzbdlGnlhEYYptJbr2a
	 bYwEe4aNSknanDN/ZGdZqpf1tjbAIIBUzPhf/AAg8QQfQoymApX2NWmS3sJzqtU79b
	 FxRAVpjuXJvC047Xk4+nDj9w+BFE1YQITCYTQ3lqMMB8eHVVQOcUzx6/X/JUSGe+An
	 AlOC9DV6ND2yfBPmeFruSUJzsP7I5oD+wKujuQ4CqnI+F+WQxgVov1kz2bbItetxLM
	 Q4NDCHWjoB1ew==
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
Subject: [PATCH v4 00/27] rust: device: Higher-Ranked Lifetime Types for device drivers
Date: Fri, 22 May 2026 01:34:26 +0200
Message-ID: <20260521233501.1191842-1-dakr@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9047-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C7E0E5ACDBF
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

The series contains a few driver patches for reference, indicated by the REF
suffix.

Thanks to Gary for coming up with the ForLt implementation; thanks to Alice for
the early discussions around lifetime-parameterized private data that helped
shape the direction of this work.

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

Danilo Krummrich (24):
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
  gpu: nova-core: use lifetime for Bar
  gpu: nova-core: unregister sysmem flush page from Drop
  gpu: nova-core: replace ARef<Device> with &'bound Device in
    SysmemFlush
  gpu: drm: tyr: use lifetime for IoMem

Gary Guo (3):
  rust: alloc: remove `'static` bound on `ForeignOwnable`
  rust: driver: move 'static bounds to constructor
  rust: types: add `ForLt` trait for higher-ranked lifetime support

 drivers/base/dd.c                     |   2 +-
 drivers/cpufreq/rcpufreq_dt.rs        |   9 +-
 drivers/gpu/drm/nova/driver.rs        |   6 +-
 drivers/gpu/drm/tyr/driver.rs         |  23 ++-
 drivers/gpu/drm/tyr/gpu.rs            |  62 +++---
 drivers/gpu/drm/tyr/regs.rs           |  21 +-
 drivers/gpu/nova-core/driver.rs       |  52 ++---
 drivers/gpu/nova-core/fb.rs           |  31 ++-
 drivers/gpu/nova-core/gpu.rs          |  38 ++--
 drivers/gpu/nova-core/nova_core.rs    |   2 +-
 drivers/pwm/pwm_th1520.rs             |  13 +-
 include/linux/device/driver.h         |   4 +-
 rust/Makefile                         |   1 +
 rust/kernel/alloc/kbox.rs             |  24 ++-
 rust/kernel/auxiliary.rs              | 142 +++++++++----
 rust/kernel/cpufreq.rs                |   9 +-
 rust/kernel/device.rs                 |  61 ++++--
 rust/kernel/devres.rs                 |   2 +-
 rust/kernel/dma.rs                    |   2 +-
 rust/kernel/driver.rs                 |  41 ++--
 rust/kernel/i2c.rs                    |  61 +++---
 rust/kernel/io/mem.rs                 | 121 ++++++------
 rust/kernel/pci.rs                    |  51 +++--
 rust/kernel/pci/id.rs                 |   2 +-
 rust/kernel/pci/io.rs                 |  50 ++---
 rust/kernel/platform.rs               |  52 ++---
 rust/kernel/types.rs                  |  12 +-
 rust/kernel/types/for_lt.rs           | 117 +++++++++++
 rust/kernel/usb.rs                    |  61 +++---
 rust/macros/for_lt.rs                 | 274 ++++++++++++++++++++++++++
 rust/macros/lib.rs                    |  12 ++
 samples/rust/rust_debugfs.rs          |  11 +-
 samples/rust/rust_dma.rs              |   6 +-
 samples/rust/rust_driver_auxiliary.rs |  79 +++++---
 samples/rust/rust_driver_i2c.rs       |  13 +-
 samples/rust/rust_driver_pci.rs       |  90 ++++-----
 samples/rust/rust_driver_platform.rs  |   9 +-
 samples/rust/rust_driver_usb.rs       |  17 +-
 samples/rust/rust_i2c_client.rs       |  14 +-
 samples/rust/rust_soc.rs              |   9 +-
 40 files changed, 1095 insertions(+), 511 deletions(-)
 create mode 100644 rust/kernel/types/for_lt.rs
 create mode 100644 rust/macros/for_lt.rs


base-commit: 454257f6d124a92342dcbb7710c03dd6ef96c731
-- 
2.54.0


