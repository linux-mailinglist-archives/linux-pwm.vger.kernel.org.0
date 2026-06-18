Return-Path: <linux-pwm+bounces-9309-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5HViHJRqM2r8AgYAu9opvQ
	(envelope-from <linux-pwm+bounces-9309-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 05:48:36 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D7E69D5EA
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 05:48:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=zohomail header.b=DfzxTsaU;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9309-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9309-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=collabora.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C75FD303111C
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 03:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC87298CB2;
	Thu, 18 Jun 2026 03:48:31 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083861A680E;
	Thu, 18 Jun 2026 03:48:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781754511; cv=pass; b=XlPKj8JTVcWBgHUngcEajxY4A5c7QQSX2MUr/PbEGOgnPyJ80hUbOEnXjxdzqSuqM538iDHhYqoD6WIPx+FdDtjsvWxinDDiP/6DHDSlDmF+fufod28IzXgLMBZubiykna3d2RaTQCs0f5FYpy4qF6R+txmrh4lwHkjGEKlvrPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781754511; c=relaxed/simple;
	bh=6Cp3otGVigzclKCuk/nbBESEREfIgSidtmQQ4GBq43k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mL4FSjC7jl09HptAw4yh5qu5IwlKnKpiUj7R0vFeAMJMcP+UQjXv5hVpfTGSGTocb/N2muTWl8JmM4C5/mpA1B+ELr8601EOSARI1Hm4FtJ4FV8fH1kC+9wJ+Va/P0uiRgASYXhEyyHJtFQ1YYc3cMId5LB+LE/cFEb+yeZCn1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=DfzxTsaU; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal: i=1; a=rsa-sha256; t=1781754477; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BiSkO6X+CbSlyyv0PKWuBOBKBoJmBDBicT4zKkw9qKECHs/xzC+TrUR4g5ZjKsZ7UbiE/lSQI+riGcCdE2fR+WPH9U25hzFBcmiuTwg0dD4Wf+Rm8b3m3gqll8jIIWJHnyNYiU02KGBdIPv38MtP/q5SySm0H9dLAE9TN6ZAkgg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1781754477; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=a/FAuDcMrWGnOcei28EPEPjKA2Es2+JGZ7eG60Xhc2o=; 
	b=Jzd+1ym5YIPHuJ1poP7RIsrqz2mE/cGEZfwakFIPf0ETEdyCGBgP4JwgY/F3sHdAEGhJZfVh0/FGL3Yc2j5g0f7PpideF7GX4Htxat4sh1GodcN9Ft02aUPg+wfiEV+M1IRga6pPDg4EPEUPBktFmn8OdmrPC0vGHyc8b2aztOA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781754477;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=a/FAuDcMrWGnOcei28EPEPjKA2Es2+JGZ7eG60Xhc2o=;
	b=DfzxTsaUd3L6p936K2c7mZaX6NLwGPbFNWt8O68s6IqAdOfgLVUD91pVOyH7ciUq
	OlPyHdHOWWwqPtQSUQ0kTE5bKaL+Fa9HouutzU0w6/OeeKJ5CTKf8hKyAXlI2kHK15V
	KASwqBk0kUJ1KAEpbaQcfFO90zPA9bpSBnGeg88E=
Received: by mx.zohomail.com with SMTPS id 1781754475220300.17079620644984;
	Wed, 17 Jun 2026 20:47:55 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Subject: [PATCH v4 0/3] Clk improvements
Date: Thu, 18 Jun 2026 00:46:34 -0300
Message-Id: <20260618-clk-type-state-v4-0-8be082786080@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6XQTW7DIBAF4KtErDsVA8WErHqPqgt+xjGqE1KgV
 qPIdy9OWlWKl1m+xftg3oUVypEK220uLNMUS0zHFl6eNswP9rgniKFlJrhQ3HADfvyAej4RlGo
 rgedorQ5BKQyslU6Z+vh9Bd/eW+5zOkAdMtl/RosVMyEgbE3nlNxi12v36tM4WpeyffbpsMhDL
 DXl8/Wnk1j8R7TbPchXVQEc0BntEZ3rJN5Vl5sm+fd6x5HrFSEboXWQJImU8eKemG87Zfr8anv
 X37Hm+QcRS4DljQEAAA==
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
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 Brian Masney <bmasney@redhat.com>, Boqun Feng <boqun@kernel.org>, 
 Boqun Feng <boqun@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org, 
 linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:rafael@kernel.org,m:viresh.kumar@linaro.org,m:dakr@kernel.org,m:aliceryhl@google.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:fustini@kernel.org,m:guoren@kernel.org,m:wefu@redhat.com,m:ukleinek@kernel.org,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:ojeda@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:daniel.almeida@collabora.com,m:m.wilczynski@samsung.com,m:bmasney@redhat.com,m:boqun@kernel.org,m:linux-pm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-riscv@lists.infradead.org,m:linux-pwm@vger.kernel.org,m:linux-clk@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:boris.brezillon@collabora.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linaro.org,google.com,linux.intel.com,suse.de,gmail.com,ffwll.ch,redhat.com,baylibre.com,garyguo.net,protonmail.com,umich.edu,collabora.com,samsung.com];
	FORGED_SENDER(0.00)[daniel.almeida@collabora.com,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[34];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9309-lists,linux-pwm=lfdr.de];
	DKIM_TRACE(0.00)[collabora.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.almeida@collabora.com,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C9D7E69D5EA

This series contains a few improvements that simplifies clock handling for
drivers.

Patch 1 implements the same typestate pattern that has been used
successfully for Regulators. This is needed because otherwise drivers
will be responsible for unpreparing and disabling clocks themselves and
ultimately handling the reference counts on their own. This is
undesirable. The patch automatically encodes this information using the
type system so that no misuse can occur.

Patch 2 makes things more convenient by offering devres-managed APIs. This
lets drivers set clock parameters once and forget about lifetime
management.

Patch 3 converts clk.rs to the newer kernel-vertical style in order to make
future changes easier.

Alice Ryhl's "rust: clk: implement Send and Sync" series, which this used to
depend on, has since been merged, so this series now applies directly on
clk-next.

---
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
To: Drew Fustini <fustini@kernel.org>
To: Guo Ren <guoren@kernel.org>
To: Fu Wei <wefu@redhat.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>
To: Uwe Kleine-König <ukleinek@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>
To: Brian Masney <bmasney@redhat.com>
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
Cc: Boris Brezillon <boris.brezillon@collabora.com>

---
Daniel Almeida (3):
      rust: clk: use the type-state pattern
      rust: clk: add devres-managed clks
      rust: clk: use 'kernel vertical style' for imports

 drivers/cpufreq/rcpufreq_dt.rs |   2 +-
 drivers/gpu/drm/tyr/driver.rs  |  31 +--
 drivers/pwm/pwm_th1520.rs      |  17 +-
 rust/kernel/clk.rs             | 595 +++++++++++++++++++++++++++++++----------
 rust/kernel/cpufreq.rs         |   8 +-
 5 files changed, 477 insertions(+), 176 deletions(-)
---
base-commit: 8d03cc42a42b1a3f1535757f65bfb74a9753953f
change-id: 20250909-clk-type-state-c01aa7dd551d

Best regards,
--  
Daniel Almeida <daniel.almeida@collabora.com>


