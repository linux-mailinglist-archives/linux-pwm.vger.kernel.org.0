Return-Path: <linux-pwm+bounces-9225-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N09/NwZ/H2rUmQAAu9opvQ
	(envelope-from <linux-pwm+bounces-9225-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 03 Jun 2026 03:10:30 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA7663352E
	for <lists+linux-pwm@lfdr.de>; Wed, 03 Jun 2026 03:10:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bK40Chfx;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9225-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9225-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F388C301E58B
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jun 2026 01:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1FC2FDC30;
	Wed,  3 Jun 2026 01:10:28 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDCA2D7DD4;
	Wed,  3 Jun 2026 01:10:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780449028; cv=none; b=OZzMKszVszP/tQ0Kt6wYfW43J2j9B3ooVNidfWhSJ+aWl9uNeS3PvngyfCCJ6k/xIz/hreo+vpfaICdStWA9Y8q/gjX/jaauT2+Fd3aq9OpSS3l3viLyPM2wtvjo3P5Mzq3U/BUK196kSWbgtZESRY2n80ain/8+TAdgcdZ3hwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780449028; c=relaxed/simple;
	bh=VFJzEinoo/4V280HpZpXwl1kty1kGVWTjct7kNh18nc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dFzz0KIMviltWif40vAvQolCTbDzS13z2K4UiYboTygdcXcjni2VhpzAF/BgROQZw0OMqAx8OZ91/8hnmEJCMo4b9H834kUP+W9JJsGQN4VUIaMYJsqi9xXEm8uf4rKP7ipsfahXmvcmq/DwFyPQnEVOTI7qgpyFa+oC27O11uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bK40Chfx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B2A1F00893;
	Wed,  3 Jun 2026 01:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780449027;
	bh=vg4OT7qVOOfiZWFV5Vcsuizp9IDFD8+pqun6oZHSTcM=;
	h=From:To:Cc:Subject:Date;
	b=bK40Chfx+OYTbVFoho2VApu/zYarNWFjOtFjO7yjtr8tQILFmaHSzBTcATrsQ5lOt
	 BzzDNGMelyIeLbDps5lE25YcnmL4lOYemVseUghlhimjykx9sBLUxO/LVIuSL5TfNs
	 /WQnxYsAq1fscjQsNbEJcqZ0vTlc7b0aNghVgTWJLDxqJEOaw9TQDel7YZUsuO3J/U
	 xsIDlEF8LylAtjBaClr+Snzq5QWNI8rrwO3FZocJauVvMtXjo/U1dOYTfN61eJf06J
	 id3S68G+VgFIL2GjMBROGyqe855oW7lPLcRhPVROkwQt06aDl4mcPl/Df8zgTSm7Ry
	 MwU62cK2I0z0Q==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	acourbot@nvidia.com,
	ecourtney@nvidia.com,
	m.wilczynski@samsung.com,
	david.m.ertman@intel.com,
	ira.weiny@intel.com,
	leon@kernel.org,
	daniel.almeida@collabora.com,
	bhelgaas@google.com,
	kwilczynski@kernel.org
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v2 0/7] ForLt/CovariantForLt split, auxiliary closure API and DevresLt
Date: Wed,  3 Jun 2026 03:10:11 +0200
Message-ID: <20260603011020.2073650-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9225-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:acourbot@nvidia.com,m:ecourtney@nvidia.com,m:m.wilczynski@samsung.com,m:david.m.ertman@intel.com,m:ira.weiny@intel.com,m:leon@kernel.org,m:daniel.almeida@collabora.com,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:driver-core@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:rust-for-linux@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,nvidia.com,samsung.com,intel.com,collabora.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3BA7663352E

The ForLt trait currently guarantees covariance, which allows safe
lifetime shortening via cast_ref(). However, some types (e.g. those
containing Mutex<&'bound T>) are invariant over their lifetime parameter
and cannot safely use cast_ref().

This series splits ForLt into two traits:

  - ForLt: base trait providing unsafe cast_ref_unchecked() for all
    lifetime-parameterized types.

  - CovariantForLt: unsafe subtrait that guarantees covariance,
    providing a safe cast_ref() method.

For invariant types, a closure-based API (registration_data_with()) is
added to the auxiliary subsystem. The closure's HRTB prevents the caller
from choosing a concrete lifetime, which would be unsound for invariant
types.

On top of that, this series adds DevresLt<F: ForLt>, a thin wrapper
around Devres<F::Of<'static>> that shortens the stored 'static lifetime
back to the caller's borrow scope. DevresLt provides both closure-based
access (access_with/try_access_with for ForLt types) and direct
reference access (access/try_access for CovariantForLt types).

Also implement ForLt and CovariantForLt for Bar, IoMem and
ExclusiveIoMem, and update their into_devres() methods to return
DevresLt. Provide convenience type aliases DevresBar, DevresIoMem and
DevresExclusiveIoMem.

Changes in v2:
- Fold the ForLt -> CovariantForLt rename and the new ForLt base trait
  into this series
- Add closure-based registration_data_with() for auxiliary ForLt types
- Add auxiliary sample demonstrating ForLt with an invariant Mutex type
- DevresLt: add closure-based access_with()/try_access_with() for ForLt
  types alongside direct access()/try_access() for CovariantForLt types
- Make DevresLt::new() unsafe; callers must guarantee the data outlives
  the device binding
- Implement both ForLt and CovariantForLt (previously just ForLt) for
  Bar, IoMem, ExclusiveIoMem
- Various safety comment and documentation improvements

Danilo Krummrich (7):
  rust: types: rename ForLt to CovariantForLt
  rust: types: introduce ForLt base trait for CovariantForLt
  rust: auxiliary: add registration_data_with() for ForLt types
  rust: auxiliary: sample: demonstrate ForLt with invariant Mutex type
  rust: devres: add DevresLt for ForLt-aware device resource access
  rust: pci: return DevresLt from Bar::into_devres()
  rust: io: mem: return DevresLt from
    IoMem/ExclusiveIoMem::into_devres()

 drivers/gpu/nova-core/driver.rs       |   4 +-
 drivers/pwm/pwm_th1520.rs             |   5 +-
 rust/kernel/auxiliary.rs              |  74 +++++++++++++---
 rust/kernel/devres.rs                 | 110 +++++++++++++++++++++++
 rust/kernel/io/mem.rs                 |  65 +++++++++-----
 rust/kernel/pci.rs                    |   1 +
 rust/kernel/pci/io.rs                 |  37 +++++---
 rust/kernel/types.rs                  |   1 +
 rust/kernel/types/for_lt.rs           | 122 ++++++++++++++++++++------
 rust/macros/for_lt.rs                 |  52 ++++++++---
 rust/macros/lib.rs                    |  18 +++-
 samples/rust/rust_driver_auxiliary.rs |  96 ++++++++++++++------
 12 files changed, 472 insertions(+), 113 deletions(-)


base-commit: 0023a1e8d01a9d400257d30c851bd16a29568809
-- 
2.54.0


