Return-Path: <linux-pwm+bounces-9612-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tJsaJ47dS2qqbgEAu9opvQ
	(envelope-from <linux-pwm+bounces-9612-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 18:53:34 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 328D371388A
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 18:53:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=zohomail header.b="PT/dVq1Y";
	dmarc=pass (policy=none) header.from=collabora.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9612-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9612-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D03A368BA0A
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jul 2026 14:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86933DDAE0;
	Mon,  6 Jul 2026 14:38:45 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EFA3BE17D;
	Mon,  6 Jul 2026 14:38:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348725; cv=pass; b=GCq8akFoI+emSNG2/giQhhn35N/lFNsphlixpdYTJYqhLGqj6N5wVq05TexmtiLUFtca4b3MmYnuSvec1ViCe25jnroyp+crVzfMmkW43DgpbErniZq2e8FMqLft1PkXomxEjYMSNA9Iehb2nyfhkt9MWNxbrAF5RiM76z+2OrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348725; c=relaxed/simple;
	bh=sMZmaj1YmGIROeZqohwKCCGi8Wvn2wWReeQd18UcWUc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AIDKzWzAsHypdjHBEijcgKJEQEgsN3qlKl++csZiv2JAADRzkvKDVM5Z1fggSrgQflYnGy1/MDGqqMATGk+ncVwyvCGCCDzi/PQg1UhdZOlbVoZD7+us19/mVN2W40te5zvwevrb0o0z4zm8zMZiK778lozG4dPZO4odLAoyyUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=PT/dVq1Y; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal: i=1; a=rsa-sha256; t=1783348654; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=C2vV/Zv8rnqycP3X/i18vOoOF4ItlKiKlXuyEVsdSSztOG0uonFooKFIMu30oIjkAc9JHKtt6+LDDPCwI0lNA6tZzUKjT1q6QFVcauwZZYcG7mUGmyfh+QUb6Ho+wWczeCGu3iQHhee1W9YuG7SmMr2Io3GjfvYP2FAqbZfcd7w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783348654; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3BGnFRvuYHig+06rp+UmmAvcj1kSjosNAxgMkDDKtVc=; 
	b=PIlDvqQ2NUaeMfP+VfRmShY+BBGSdOn0hlJwav8EhzHt3v7VdurC9jqnnVxCrspPHOZK8jSXNFKbvyNGGWRbswdIGNfC1K8r7stxmULRsrxh3ke3yCunS9fiZJOeMU2WWOCRP86A9tgCDQwDYqgUsLmfMTn9b4OC5a1gYen62vk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783348654;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=3BGnFRvuYHig+06rp+UmmAvcj1kSjosNAxgMkDDKtVc=;
	b=PT/dVq1YT2WIilYpgQK6vreaafhwTqD/29rkn1FUwkofb5StCq9wrwMN0cTl6x4L
	WBSL3cVw0GrGain4ig1lAsFjmh+339IVulIlJqIvNN/qYAT3ZL4VZC+HDFWYxOgkZ/l
	fcjsjY3YPb1qulruhZwvNoP4vZTq+J5ty8IB1Oc8=
Received: by mx.zohomail.com with SMTPS id 1783348651535783.6421995425076;
	Mon, 6 Jul 2026 07:37:31 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Subject: [PATCH v5 0/4] Clk improvements
Date: Mon, 06 Jul 2026 11:37:11 -0300
Message-Id: <20260706-clk-type-state-v5-0-67c5f326a16c@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6XRTW7DIBAF4KtErEs1A+HHXfUeVRaAxzWqE1JMr
 EaR716ctIoUd9flW7wPZubCRsqRRvayubBMUxxjOtSgnjYs9O7wTjy2NTMBQkEDDQ/DBy/nI/G
 xuEI8ADpn2lYpbFktHTN18esKvu1q7nLa89JncnfGiBUzIUduG+2VtKg7419DGgbnU3bPIe0Xu
 Y9jSfl8/ekkFv8/2m0ehFVVcODoGxMQvdcSH6rLTJP8fV0DglkRshLGtJIkkWqC+IvY3gmNdkV
 sK2E9gRXGarDwSMy3VWf6PNWTlZ99z/M3M87OONABAAA=
X-Change-ID: 20250909-clk-type-state-c01aa7dd551d
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, Boqun Feng <boqun@kernel.org>, 
 Boqun Feng <boqun@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org, 
 linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, Maurice <mhi@mailbox.org>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:rafael@kernel.org,m:viresh.kumar@linaro.org,m:dakr@kernel.org,m:aliceryhl@google.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:fustini@kernel.org,m:guoren@kernel.org,m:wefu@redhat.com,m:ukleinek@kernel.org,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:ojeda@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:daniel.almeida@collabora.com,m:m.wilczynski@samsung.com,m:boqun@kernel.org,m:linux-pm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-riscv@lists.infradead.org,m:linux-pwm@vger.kernel.org,m:linux-clk@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:boris.brezillon@collabora.com,m:work@onurozkan.dev,m:mhi@mailbox.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linaro.org,google.com,linux.intel.com,suse.de,gmail.com,ffwll.ch,redhat.com,baylibre.com,garyguo.net,protonmail.com,umich.edu,collabora.com,samsung.com];
	FORGED_SENDER(0.00)[daniel.almeida@collabora.com,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[35];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9612-lists,linux-pwm=lfdr.de];
	DKIM_TRACE(0.00)[collabora.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.almeida@collabora.com,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 328D371388A

This series contains a few improvements that simplifies clock handling for
drivers.

Patch 1 implements the same typestate pattern that has been used
successfully for Regulators. This is needed because otherwise drivers
will be responsible for unpreparing and disabling clocks themselves and
ultimately handling the reference counts on their own. This is
undesirable. The patch automatically encodes this information using the
type system so that no misuse can occur.

Patch 2 implements Clone for Clk<T>, so that a driver can hold a
long-lived clock in one state while temporarily moving an independent
clone of it through the other states. This is the outcome of the
discussion in v3 with Boris Brezillon and Gary Guo.

Patch 3 makes things more convenient by offering devres-managed APIs. This
lets drivers set clock parameters once and forget about lifetime
management.

Patch 4 converts clk.rs to the newer kernel-vertical style in order to make
future changes easier.

The pre-existing error-path imbalance in the C function
devm_clk_get_optional_enabled_with_rate() that was noted during the v4
review is a C-side issue and will be addressed by a separate patch.

---
Changes in v5:
- Rebased onto the latest clk-next.
- New patch: "rust: clk: implement Clone for Clk<T>". Each clone is an
  independent view of the same underlying clock, owning its own
  prepare/enable counts; the raw pointer is shared through an Arc so
  clk_get()/clk_put() stay balanced. Follows the v3 discussion with
  Boris Brezillon and Gary Guo.
- Moved rate() and set_rate() from Clk<Enabled> to all states; the C API
  does not restrict these to enabled clocks, and some clocks can only
  change rate before being prepared.
- Made Clk::<Enabled>::disable() infallible, matching unprepare() and
  the void C API (Onur).
- Fixed a typo in the "# Invariants" section, fixed SAFETY comments
  that referred to the non-existent `self.0` field, and added missing
  INVARIANT comments on the state transitions.
- Added the missing rustdoc link definitions for clk_unprepare and
  clk_put (Maurice).
- Dropped the redundant `Result` import and the `use
  kernel::error::Result;` lines from the doctests; the prelude already
  provides it (Miguel).
- Added #[inline] to the devm_* helpers.
- Link to v4: https://patch.msgid.link/20260618-clk-type-state-v4-0-8be082786080@collabora.com

Changes in v4:
- Rebased onto clk-next. Alice Ryhl's "rust: clk: implement Send and Sync"
  series is now merged upstream, so it is no longer carried as a dependency.
- Fixed the build with CONFIG_CPUFREQ_DT_RUST=y. The generic DT cpufreq
  driver only has the (unbound) per-CPU device, so it cannot hand a
  &Device<Bound> to Policy::set_clk(). Added a pub(crate) Clk::get_unbound()
  for the few in-tree abstractions that operate on a device outside a bind
  scope; set_clk() now takes &Device and uses it. Clk::get()/get_optional()
  and the devm_* helpers still require &Device<Bound>.
- Added impl From<Error<State>> for kernel::error::Error, so the fallible
  state transitions can be used with `?` (and chained) instead of
  .map_err(|e| e.error).
- Added Clk::<Prepared>::with_enabled(), which runs a closure with the clock
  temporarily enabled, scoping the Enabled state without giving up the
  prepared clock.
- Documented how to change a clock's state at runtime via an enum, for
  drivers that enable/disable across resume/suspend.
- Link to v3: https://lore.kernel.org/r/20260107-clk-type-state-v3-0-77d3e3ee59c2@collabora.com

Changes in v3:
- Rebased on top of 6.19-rc4
- Dropped patch 1 (from Alice), added her series as a dependency instead
- Fixed Tyr, PWM_TH1520 drivers
- Changed clk.rs imports to kernel-vertical style
- Added support get_optional shortcut for Prepared and Enabled (i.e.:
  Clk::<Enabled>::get_optional())
- Fixed misplaced #[inline] tag

Thanks, Danilo {
  - Moved the devres changes into its own patch
  - Require &Device<Bound> for all functions where a &Device is used
  - Account for con_in in SAFETY comments where applicable
  - Added backticks
}

- Link to v2: https://lore.kernel.org/r/20250910-clk-type-state-v2-0-1b97c11bb631@collabora.com

Changes in v2:
- Added Alice's patch as patch 1, since it is a dependency.
- Added devm helpers (like we did for Regulator<T>)
- Fixed missing clk_put() call in Drop (Danilo)
- Fixed missing parenthesis and wrong docs (Viresh)
- Removed extra "dev" parameter from "shutdown" example (Danilo)
- Removed useless type annotation from example (Danilo)
- Link to v1: https://lore.kernel.org/rust-for-linux/20250729-clk-type-state-v1-1-896b53816f7b@collabora.com/#r

To: "Rafael J. Wysocki" <rafael@kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
To: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Michal Wilczynski <m.wilczynski@samsung.com>
To: Drew Fustini <fustini@kernel.org>
To: Guo Ren <guoren@kernel.org>
To: Fu Wei <wefu@redhat.com>
To: Uwe Kleine-König <ukleinek@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>
To: Boqun Feng <boqun@kernel.org>
To: Gary Guo <gary@garyguo.net>
To: Björn Roy Baron <bjorn3_gh@protonmail.com>
To: Benno Lossin <lossin@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
To: Trevor Gross <tmgross@umich.edu>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-pwm@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org

---
Daniel Almeida (4):
      rust: clk: use the type-state pattern
      rust: clk: implement Clone for Clk<T>
      rust: clk: add devres-managed clks
      rust: clk: use 'kernel vertical style' for imports

 drivers/cpufreq/rcpufreq_dt.rs |   2 +-
 drivers/gpu/drm/tyr/driver.rs  |  37 +--
 drivers/pwm/pwm_th1520.rs      |  17 +-
 rust/kernel/clk.rs             | 722 +++++++++++++++++++++++++++++++++--------
 rust/kernel/cpufreq.rs         |   8 +-
 5 files changed, 602 insertions(+), 184 deletions(-)
---
base-commit: 92010229c4b38897f1319d260162d2f96925ed17
change-id: 20250909-clk-type-state-c01aa7dd551d

Best regards,
--  
Daniel Almeida <daniel.almeida@collabora.com>


