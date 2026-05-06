Return-Path: <linux-pwm+bounces-8820-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFz0LE66+2kxEAAAu9opvQ
	(envelope-from <linux-pwm+bounces-8820-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 07 May 2026 00:01:50 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B414E1090
	for <lists+linux-pwm@lfdr.de>; Thu, 07 May 2026 00:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE8513025C4D
	for <lists+linux-pwm@lfdr.de>; Wed,  6 May 2026 22:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F42D3B47D9;
	Wed,  6 May 2026 22:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7ZPn4Zu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC54735B631;
	Wed,  6 May 2026 22:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778104834; cv=none; b=gbkYvQJQvnpy2ZRRz5svyGm8eRW2Lr2mSriaHMX5I8b3/WVZJVX7bXbDH2RFuf/4D/gkloiWleUDkfspIhq7L99L3u/Phd1E+lUkSFC0a1Oho4Joom1XJqdaxjP62jbXe5MXmTIbw25KT74QsFLLOIwbEqNX0rUy2UKQufI3r0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778104834; c=relaxed/simple;
	bh=nCyApNb8RKn1veEhbH+LihTl9SHcYNeSopAO0tq8/OA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jck5wFznS4xhqP+1jmUdatgGAeXyILu9E0ZFlHNOPBJBubmL/b1yU17CUgCSRhF8t0yxfeEejP2uv3rzLwiZhLEmMBSrt/Y+5F6S5UrjrWzsAXbG+AZNYRF78l3BlzmwyMM/7uONSScfk153eM9fKhZMF3SNH8UoYUqMDZ01Cko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7ZPn4Zu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5551DC2BCB2;
	Wed,  6 May 2026 22:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778104833;
	bh=nCyApNb8RKn1veEhbH+LihTl9SHcYNeSopAO0tq8/OA=;
	h=From:To:Cc:Subject:Date:From;
	b=r7ZPn4ZuEfXPGPabAtTXrwgZPsqXmXckRw4t6mO2USweTSvl2RUftL8wUqYiaHVc6
	 F/74M2nXgVwWrb4IB2kr1wJJsahWu+Ra4QxGTmk+dtcJrNUKk26S7ai3T5XMW4QO0e
	 /jmtBfR4JNscZOtjsINOTk345VDwTVWgpTzwrbAFE29tbdw9uLDIThLfSGSDGJx3pY
	 aOCD+Klzh2O7/VerE10AIB/YF/JAJSMjbRfhLQDnq1AR9Hw/utzMFw+u+w998uKBS+
	 0FbEMPMpM346TySODIGrcOnm+hDCujKBflOD/B+Vkwqp83Nh1h48gH7aSEOIvVJf68
	 c/8Ui70hgF0KQ==
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
Subject: [PATCH 0/3] rust: devres: add DevresLt for ForLt-aware device resource access
Date: Wed,  6 May 2026 23:58:32 +0200
Message-ID: <20260506220012.855173-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 13B414E1090
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com];
	TAGGED_FROM(0.00)[bounces-8820-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Devres<T> stores resources as T and hands out &'bound T from its access
methods. For lifetime-parameterized types like Bar<'bound, SIZE> that
are transmuted to 'static for storage, the synthetic 'static leaks to
callers -- any method on the stored type that surfaces its lifetime
parameter would yield a &'static reference, which is unsound.

This series adds DevresLt<F: ForLt>, a thin wrapper around
Devres<F::Of<'static>> that applies ForLt::cast_ref in all access paths
to shorten the stored 'static back to the caller's borrow lifetime.
Devres<T: Send> remains unchanged for static resource types.

Also implement ForLt for Bar, IoMem and ExclusiveIoMem, and their
into_devres() methods to return DevresLt instead of plain Devres.
Provide convenience type aliases DevresBar, DevresIoMem and
DevresExclusiveIoMem.

This series depends on [1].

[1] https://lore.kernel.org/driver-core/20260506215113.851360-1-dakr@kernel.org/

Danilo Krummrich (3):
  rust: devres: add DevresLt for ForLt-aware device resource access
  rust: pci: return DevresLt from Bar::into_devres()
  rust: io: mem: return DevresLt from
    IoMem/ExclusiveIoMem::into_devres()

 drivers/pwm/pwm_th1520.rs |  5 +-
 rust/kernel/devres.rs     | 97 ++++++++++++++++++++++++++++++++++++---
 rust/kernel/io/mem.rs     | 55 ++++++++++++++++------
 rust/kernel/pci.rs        |  1 +
 rust/kernel/pci/io.rs     | 30 ++++++++----
 5 files changed, 155 insertions(+), 33 deletions(-)

-- 
2.54.0


