Return-Path: <linux-pwm+bounces-8703-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NlUJjrf72kHHQEAu9opvQ
	(envelope-from <linux-pwm+bounces-8703-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 00:12:10 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEAF47B23D
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 00:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D05F930182B9
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Apr 2026 22:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825263A7F45;
	Mon, 27 Apr 2026 22:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7nbSyXy"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADA43A6B81;
	Mon, 27 Apr 2026 22:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777327928; cv=none; b=kRHGdOhG3yLOlFvJ0sStknNUPVzXWtI4CAmoF4p7fPta1qlH8q0nr2aGQViq3UjdGMxZMOe2lNUocT8OU4I7xlB0ifV7IG4Cz9B9PImX78kWguAbVHBjoePbPvJkBvn+Cb2MYvnb4YBNX+3V+9FeUDUbQ0oNgaXAOE14hOVJ1Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777327928; c=relaxed/simple;
	bh=0thXPdShB3t5adcBz1VkWyZ33OoOiYeBGZx1pE9VSCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bcIrznXy4Fbv2wVTXg02DT8cUU+DXiZC0ovZh5hNFr1z4eWUdqG8224FAxlUnorx1Q1lOTLUN+UYCPKupe3aXGbD5vMAkpgrkZrCpHFxrNfkoFSQtAa/f0Y21Igvabg/M4viNv3b2C1oDp6AEC2b22Jfw30w02mq6eSA/XMtKXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7nbSyXy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D48C19425;
	Mon, 27 Apr 2026 22:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777327928;
	bh=0thXPdShB3t5adcBz1VkWyZ33OoOiYeBGZx1pE9VSCE=;
	h=From:To:Cc:Subject:Date:From;
	b=Z7nbSyXy34HFoImwriB49Cku0ZZoA0kXlQ6jBhSYj9BVkWR7Sn4VlBPH3sZXjPE2g
	 m8dDBnZVc9okYF8//vnRWpYKv+KYnEwt15cL/SiYb52pls2wZlLE6lBEIOl45Mx5Zj
	 HRBPuaBrspJtiVYckLKyxs3+F3dl5L819mk1eokoINgUZkq37Ca5e6nGwXM1KvaqrB
	 7UqWXRUUhhm5V/a0HyxMqqjubV2YBMvL81XPNZ/piO9nWLFwyVjwUYT6PwzsLsNTbz
	 HUtlrVffhg+N9YbCvVgdnQVM5Tpznoon8co4YJxeDtDTMw9z6O2kfn/XUXwQMiPp00
	 I2RG39QWsSeoA==
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
	tmgross@umich.edu
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-pm@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 00/24] rust: device: Higher-Ranked Lifetime Types for device drivers
Date: Tue, 28 Apr 2026 00:10:58 +0200
Message-ID: <20260427221155.2144848-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1FEAF47B23D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8703-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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

[1] https://lore.kernel.org/driver-core/20260427221002.2143861-1-dakr@kernel.org/

Danilo Krummrich (23):
  rust: driver core: drop drvdata before devres release
  rust: devres: add ForLt support to Devres
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
  gpu: nova-core: use HRT lifetime for Bar
  gpu: nova-core: unregister sysmem flush page from Drop
  gpu: nova-core: replace ARef<Device> with &'a Device in SysmemFlush
  gpu: drm: tyr: use HRT lifetime for IoMem

Gary Guo (1):
  rust: types: add `ForLt` trait for higher-ranked lifetime support

 drivers/base/dd.c                     |   2 +-
 drivers/cpufreq/rcpufreq_dt.rs        |  10 +-
 drivers/gpu/drm/nova/driver.rs        |   9 +-
 drivers/gpu/drm/tyr/driver.rs         |  24 ++-
 drivers/gpu/drm/tyr/gpu.rs            |  62 ++++---
 drivers/gpu/drm/tyr/regs.rs           |  21 +--
 drivers/gpu/nova-core/driver.rs       |  48 ++---
 drivers/gpu/nova-core/fb.rs           |  31 ++--
 drivers/gpu/nova-core/gpu.rs          |  32 +---
 drivers/gpu/nova-core/nova_core.rs    |   4 +-
 drivers/pwm/pwm_th1520.rs             |  14 +-
 include/linux/device/driver.h         |   4 +-
 rust/Makefile                         |   1 +
 rust/kernel/auxiliary.rs              | 144 ++++++++++-----
 rust/kernel/cpufreq.rs                |   8 +-
 rust/kernel/device.rs                 |  84 ++++++---
 rust/kernel/devres.rs                 |  31 +++-
 rust/kernel/driver.rs                 |  44 +++--
 rust/kernel/i2c.rs                    | 121 ++++++++-----
 rust/kernel/io/mem.rs                 | 118 ++++++-------
 rust/kernel/pci.rs                    |  88 +++++++---
 rust/kernel/pci/io.rs                 |  50 +++---
 rust/kernel/platform.rs               | 101 +++++++----
 rust/kernel/types.rs                  |   4 +
 rust/kernel/types/for_lt.rs           | 117 +++++++++++++
 rust/kernel/usb.rs                    |  93 ++++++----
 rust/macros/for_lt.rs                 | 242 ++++++++++++++++++++++++++
 rust/macros/lib.rs                    |  12 ++
 samples/rust/rust_debugfs.rs          |  10 +-
 samples/rust/rust_dma.rs              |   9 +-
 samples/rust/rust_driver_auxiliary.rs |  53 ++++--
 samples/rust/rust_driver_i2c.rs       |  18 +-
 samples/rust/rust_driver_pci.rs       |  93 +++++-----
 samples/rust/rust_driver_platform.rs  |  12 +-
 samples/rust/rust_driver_usb.rs       |  14 +-
 samples/rust/rust_i2c_client.rs       |  12 +-
 samples/rust/rust_soc.rs              |  12 +-
 37 files changed, 1182 insertions(+), 570 deletions(-)
 create mode 100644 rust/kernel/types/for_lt.rs
 create mode 100644 rust/macros/for_lt.rs

-- 
2.54.0


