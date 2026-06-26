Return-Path: <linux-pwm+bounces-9425-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BDGlBrvGPmoQLgkAu9opvQ
	(envelope-from <linux-pwm+bounces-9425-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 20:36:43 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0296CFB36
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 20:36:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Aw4Gu7aO;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9425-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9425-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1FAC83014241
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 18:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427B43B7B71;
	Fri, 26 Jun 2026 18:36:41 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0790C3B38B0;
	Fri, 26 Jun 2026 18:36:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782499001; cv=none; b=M5Sq96H8qiIMTaopQdcMZUzA5yZUkFwdnBGas5EXy8kvf3KZpoIdJoDfmEwdsfwgVjtc4MGSozL35s5Bk7U4t1An5KIK+yRSmDcJRZCMJtk/ze/c1mbCq8lZUjmMHT28nvcX2pd+1mOPrnIUPyBeq3LO4986tHAfuh5MdLzgE/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782499001; c=relaxed/simple;
	bh=fargNlghZ/3htKgOlr4ecSSwYBEh7zEpFbePuaB9ivk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DAQkv4yrSaIXJyozjCalII0POWyvan/4DEYbIZuJyqekJOlZeOtr8TS7Ntf0UflR5quGUtgClySlzcQD+3uu3xT/Z3DvVl33eK9Uiu1IBzC/EPcXHxsCfRCBIN4yVKZTmtpY5qn9qo3EyyekHFC+g5iU6sSIbrzkHocOHiBa/4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aw4Gu7aO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20321F000E9;
	Fri, 26 Jun 2026 18:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782498999;
	bh=4ohhSdR4uLkHiWRbMexAantHFBpBzZI6WmGjwL2KC3o=;
	h=From:To:Cc:Subject:Date;
	b=Aw4Gu7aOmaqbgsNADbHax24oeNXpOSXZx5SXpUdMyrGGeFHsWamP319IlTBhIGhJM
	 cQOPs1aZriEKiCWZK+GufH1B9zF0XZDJXqg66mNdeWTpNtHQupGiP+98JQjBldBlWy
	 LO7JMcjFU6VB1M3uyQvm0GzYFkYt8oqx3fDAjnIJG5N2JaIWy+JMH7Lq+RWsvUx+cR
	 BfhqTJjLqL6FQd82v/zWPLZuEJQ+j2AU6/IwX2j8Aff3thBoLOWrm4pCDW5er7/1Ao
	 pZFB69zwhfoVWmDtQZDhZUWGoriTiNJKzPAFB+AdHcDDjJruFkOuX/1XpAofcE+mhz
	 t8M93MWjffiVg==
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
Subject: [PATCH v4 0/7] ForLt/CovariantForLt split, auxiliary closure API and DevresLt
Date: Fri, 26 Jun 2026 20:36:07 +0200
Message-ID: <20260626183630.2585057-1-dakr@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9425-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9C0296CFB36

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

Changes in v4:
- ForLt! macro: run the Prover and emit ProveWf structs for
  well-formedness checks
- DevresLt: change Send bound from F::Of<'static>: Send to the
  correct for<'a> F::Of<'a>: Send
- Add #[inline] to forwarding functions in registration_data_with,
  registration_data, and all DevresLt accessors

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
 rust/kernel/auxiliary.rs              |  78 ++++++++++++++-----
 rust/kernel/devres.rs                 | 106 ++++++++++++++++++++++++++
 rust/kernel/io/mem.rs                 |  65 +++++++++++-----
 rust/kernel/pci.rs                    |   1 +
 rust/kernel/pci/io.rs                 |  37 ++++++---
 rust/kernel/types.rs                  |   1 +
 rust/kernel/types/for_lt.rs           |  95 ++++++++++++++++-------
 rust/macros/for_lt.rs                 |  72 +++++++++++------
 rust/macros/lib.rs                    |  18 ++++-
 samples/rust/rust_driver_auxiliary.rs |  96 ++++++++++++++++-------
 12 files changed, 447 insertions(+), 131 deletions(-)


base-commit: 51cb1aa1250c36269474b8b6ca6b6319e170f5a5
-- 
2.54.0


