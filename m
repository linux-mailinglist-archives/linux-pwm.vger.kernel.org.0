Return-Path: <linux-pwm+bounces-9370-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8ZkhOisAPWpWvggAu9opvQ
	(envelope-from <linux-pwm+bounces-9370-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jun 2026 12:17:15 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A166C48F8
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jun 2026 12:17:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=F0CbfPFn;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9370-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9370-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 84B533022976
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jun 2026 10:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2423C456A;
	Thu, 25 Jun 2026 10:16:16 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76903803D1;
	Thu, 25 Jun 2026 10:16:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782382576; cv=none; b=YmG8KcvTw1CXVUyYPozqGr49uIFhl9Me1hBS4Aq4xjPuzAHXuMePwlyA4AoKr65UWl2bkeZVw6/s3fF9XToEnNGTjZJ3rOlH75KnFLx68jsEl5tKhHxumdHr/51qAqK/oVdTQ/HVMYFr+/n0y8oh31ueMiRAaCVlKv1SZTm6yks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782382576; c=relaxed/simple;
	bh=ognTfAxCvoFUWWNRr5OSlBl7wqX/Y/FRoHPVFZpyGvU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gj5K4vdBz+yaMnMVQHf/nEAO8h3cgHgDj8oAejNeCiQcKHkiUL+0nK0zBCloXcVIs+K0lMKBrGn2SbvzgNr3qJui8OFOtbYff9EdZDfMTjrvKdhT1knexgfeT84KBxKMw3ngHBG7i5FDZm47ooosH/MhsehDdVudCSFfc7FvafI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0CbfPFn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52EA31F000E9;
	Thu, 25 Jun 2026 10:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782382575;
	bh=tI6M6Y2nl4r0WViOFml8Atpt2yMNTJUDccu+Knxm3HI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=F0CbfPFnIA0/LErCPW78ronGCivZPYJUOrnX1X9N3idqOK6HdIGJvaQ6bjf2KUURR
	 hSsEUm+0fiScJXyp4uBpuvwDXFpMdqh24tBc9oIjtO36SHR7vlP0tCmBLGe5l+VGS6
	 PPkMRAOEMnqw2fG5khYvUjdiGMk4Ss3jh+rjrcPFhqTh+bwz299cjPPhwNEJjGLJcY
	 7UVbENUhjVHDKx+AN0+10ePMpJa8SAQgxdX6ay7dHdqcR8DrpSTO4dyO1Wcf4fl+yR
	 qAsrckND2AymJnH+1qwutwzxx9lxLeonaC0iLeXXNNa2aLHjFlye990WQcP1bfQ6G1
	 /EnUYhb8vtxLQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Thu, 25 Jun 2026 12:15:10 +0200
Subject: [PATCH v18 8/8] rust: page: add `from_raw()`
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260625-unique-ref-v18-8-4e06b5896d47@kernel.org>
References: <20260625-unique-ref-v18-0-4e06b5896d47@kernel.org>
In-Reply-To: <20260625-unique-ref-v18-0-4e06b5896d47@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Lyude Paul <lyude@redhat.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
 Carlos Llamas <cmllamas@google.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
 Serge Hallyn <sergeh@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Igor Korotin <igor.korotin@linux.dev>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, 
 Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, 
 Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 driver-core@lists.linux.dev, linux-block@vger.kernel.org, 
 linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1326; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=IpZr4FT6FvBjQrQQDya19Z/r3yR23B/8jNNyN7AG0Ho=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqPP/EjXMD9Irw6nuJhPFtq2/EhFqdmzJ8hijBj
 IUWa604Ry+JAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCajz/xAAKCRD6UCkIqsW9
 0FeBD/4jVYT/NquejgL1Hc9CwBS8FOIsqeR6evr5bHoJDDfcXKDUfyPgkZBBBJzvKPStehWt9Ba
 OxPWNiTmP/Na9xzXVTf4N2NYdp8Gw263w3WUH/KqxsinznoLwIk/t7pOCsli0YTrT3gEVnhvLvM
 lx6XIQxbO9tN5zSa+Cz5ekL5AR9/BVCVtQuvSYwr2yC057sAk3/+pLmI5yuKcdjE7qDEWNMbrz+
 GsbqFp+j/wND47pZgWmWgOVOOB2isuR55+uYVBLNq/ClT4VtBTyaAkoJ/I89ABqI9RaSG+qVyKM
 6C/bWU5Jc8/F3s2a/y6gacqerscAzwzeAC03rj+NXd095srNb1AOzGkU+icZSsHT4j5/MuEe0tD
 VhDdparEYBYjSj5PvlK7Kvq18ivW3lmcu9T3EGIQ4luui8emt9TgaybS2iDLiiSbSH6vG01yDDF
 3gByAhtfowM9L8/A8ntYt9VBdRC3d8E8110+aSCnCp03VHYE2v2R41RKP040igcDgGQ6Qo05WK+
 jjmSW+h7QarnY5cqnTxID2mDe4lkrV1hLRU6L3S/yo4C7CME8q2w+qnfpOXgoekvCdy2s9k9Z3i
 OiQ1Avp2dfEj/2XyGmAadZ0z7PnbBXn774lHjR4vEkXgxeWk0+8Ir0eB2f/cU+/S2SscPAIvNUF
 hB2Z0OACdPe3ruQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dakr@kernel.org,m:ljs@kernel.org,m:vbabka@kernel.org,m:liam@infradead.org,m:urezki@gmail.com,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:daniel.almeida@collabora.com,m:tamird@kernel.org,m:acourbot@nvidia.com,m:work@onurozkan.dev,m:lyude@redhat.com,m:gregkh@linuxfoundation.org,m:arve@android.com,m:tkjos@android.com,m:brauner@kernel.org,m:cmllamas@google.com,m:rafael@kernel.org,m:david.m.ertman@intel.com,m:ira.weiny@intel.com,m:leon@kernel.org,m:paul@paul-moore.com,m:sergeh@kernel.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:viro@zeniv.linux.org.uk,m:jack@suse.cz,m:igor.korotin@linux.dev,m:vireshk@kernel.org,m:nm@ti.com,m:sboyd@kernel.org,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:ptikhomirov@virtuozzo.com,m:m.wilczynski@samsung.com,m:a.hindborg@kernel.org,m:phasta@kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@k
 vack.org,m:driver-core@lists.linux.dev,m:linux-block@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-fsdevel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-pwm@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[a.hindborg@kernel.org,linux-pwm@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9370-lists,linux-pwm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,infradead.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,collabora.com,nvidia.com,onurozkan.dev,redhat.com,linuxfoundation.org,android.com,intel.com,paul-moore.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,linux.dev,ti.com,virtuozzo.com,samsung.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_GT_50(0.00)[54];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a.hindborg@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,onurozkan.dev:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E5A166C48F8

From: Andreas Hindborg <a.hindborg@samsung.com>

Add a method to `Page` that allows construction of an instance from `struct
page` pointer.

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
Reviewed-by: Onur Özkan <work@onurozkan.dev>
---
 rust/kernel/page.rs | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
index 6dc1c2395acaf..c88fda09ead5a 100644
--- a/rust/kernel/page.rs
+++ b/rust/kernel/page.rs
@@ -143,6 +143,20 @@ pub fn nid(&self) -> i32 {
         unsafe { bindings::page_to_nid(self.as_ptr()) }
     }
 
+    /// Create a `&Page` from a raw `struct page` pointer.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must be convertible to a shared reference with a lifetime of `'a`.
+    #[inline]
+    pub unsafe fn from_raw<'a>(ptr: *const bindings::page) -> &'a Self {
+        // INVARIANT: By the function safety requirements, `ptr` refers to a valid `struct page`, so
+        // the returned reference upholds the type invariant of `Page`.
+        // SAFETY: By function safety requirements, `ptr` is not null and is convertible to a shared
+        // reference.
+        unsafe { &*ptr.cast() }
+    }
+
     /// Runs a piece of code with this page mapped to an address.
     ///
     /// The page is unmapped when this call returns.

-- 
2.51.2



