Return-Path: <linux-pwm+bounces-9331-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qgnWFIh6NGrKZAYAu9opvQ
	(envelope-from <linux-pwm+bounces-9331-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Jun 2026 01:08:56 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B27126A304C
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Jun 2026 01:08:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GgDkpvVe;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9331-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9331-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D318302FA37
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 23:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5399733F5A3;
	Thu, 18 Jun 2026 23:08:52 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC397082D;
	Thu, 18 Jun 2026 23:08:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781824132; cv=none; b=eASKTF9KqiFw80m/FZQPr4yrDKjLsCbr2jHr/+jUuV1IjaAAs1aVmdvGVSRjkBxNl0ZnhIbUXDj2fGzQHjqo2TC7Mhvuldo2/31BcvamGNr79f5HvdT1ELXRO3Sgd53TVCwtGq0Pf6fWlvybptmNKWc0Vm8YUPNpCdjUJyeXxuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781824132; c=relaxed/simple;
	bh=nHU7F6R/ddTEuHFMZbqtUNAEkj7f+Wsp9Rinn6XBGDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B0OkG52Cmbpl4/5faIQuCwl8tHdzPaFNvsi3dPWpMD6e8VSvv5yjoXFnj75iKhhPda7orq6DZlAPsaTBbFgQENjDRIGT7uHjP62f4xbqIzTUIB6dXl6tU++FasWHwf+oZm37ZCZ1l5Kwd2e3cf55hHexPEMrUNtjEnxy3dJ/5iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgDkpvVe; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6201F000E9;
	Thu, 18 Jun 2026 23:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781824130;
	bh=IFzNgkG2m6LHm/n3B0bxBt/0Kp+5tRid/Y2vmPN6Huk=;
	h=From:To:Cc:Subject:Date;
	b=GgDkpvVe1RBzO2seIT4BcWsJJ3VDTGBlmFmkv0wvl6gwpAn2VaUfbrlZtmcP93hUr
	 +D65Ip+5tDKdLWvhcgGjLur4Qik4YKohvkWYwE4WfKUbkCMRou+Vgo0WvJUPKPRF4m
	 +/xjr1h/D95QngnGCr4mMHGik1F8r5zgQHM52KO7ci5EImMc3owtOEM4HeIJ1eoXKg
	 IRDQApzfVIcV8mq3rN807YRvXcdY77oLVDkX2LlUBtPz4AgakAH1xQkhwhKY4CQv/6
	 f8qH0vlqlt01zFCFAACJRuo/gG21gAimMGOZSC346L/c/s8FCm8QcaiuhqsWMleXq9
	 ZeXUZYjMBYubw==
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
Subject: [PATCH v3 0/7] ForLt/CovariantForLt split, auxiliary closure API and DevresLt
Date: Fri, 19 Jun 2026 01:08:26 +0200
Message-ID: <20260618230834.812007-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9331-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:acourbot@nvidia.com,m:ecourtney@nvidia.com,m:m.wilczynski@samsung.com,m:david.m.ertman@intel.com,m:ira.weiny@intel.com,m:leon@kernel.org,m:daniel.almeida@collabora.com,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:driver-core@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:rust-for-linux@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,nvidia.com,samsung.com,intel.com,collabora.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B27126A304C

The ForLt trait currently guarantees covariance, which allows safe
lifetime shortening via cast_ref(). However, some types (e.g. those
containing Mutex<&'bound T>) are invariant over their lifetime parameter
and cannot safely use cast_ref().

This series splits ForLt into two traits:

  - ForLt: base trait for all lifetime-parameterized types, providing
    only the Of<'a> GAT.

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

Changes in v3:
- Keep UnsafeForLtImpl as the shared helper for both ForLt! and
  CovariantForLt!, distinguished by const generic N
- Remove cast_ref_unchecked() from ForLt; lifetime shortening is
  handled by borrowing with the target lifetime directly or by
  decoupling the HRTB from the outer reference lifetime

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
 rust/kernel/auxiliary.rs              |  76 +++++++++++++++-----
 rust/kernel/devres.rs                 | 100 ++++++++++++++++++++++++++
 rust/kernel/io/mem.rs                 |  65 +++++++++++------
 rust/kernel/pci.rs                    |   1 +
 rust/kernel/pci/io.rs                 |  37 +++++++---
 rust/kernel/types.rs                  |   1 +
 rust/kernel/types/for_lt.rs           |  95 +++++++++++++++++-------
 rust/macros/for_lt.rs                 |  53 +++++++++++---
 rust/macros/lib.rs                    |  18 ++++-
 samples/rust/rust_driver_auxiliary.rs |  96 ++++++++++++++++++-------
 12 files changed, 432 insertions(+), 119 deletions(-)


base-commit: 83f1454877cc292b88baf13c829c16ce6937d120
-- 
2.54.0


