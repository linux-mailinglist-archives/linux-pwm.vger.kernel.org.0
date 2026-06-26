Return-Path: <linux-pwm+bounces-9396-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /Of5GfppPmqOFgkAu9opvQ
	(envelope-from <linux-pwm+bounces-9396-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 14:00:58 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B14C6CCB94
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 14:00:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FiipJjEX;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9396-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9396-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AD5BD302F8C7
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 11:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F7B3F44CF;
	Fri, 26 Jun 2026 11:55:55 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8FF3F4105;
	Fri, 26 Jun 2026 11:55:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782474955; cv=none; b=BnFkC9yV7JOintWcGVPyaQjZuumVr1iHclyhRdYyWFQCutcbQub6HY5xTyEbCfskjnlWo4J6FXWTGf9dEcfK7zvGyIoogRi2WdZfWev72E7K7lLj8OYAloxUzYJEwBWmoOvnqTP6gS1yW8uLh5I1yxVu5vAP5ZK6pJLi/9K9pzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782474955; c=relaxed/simple;
	bh=IbxkR2S/sT5Qax06n21WRzHYxlna6pgSwprDnFizzhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tyHP0Xes7rcBLqebFqPGTLd1XMmfc/MORcM1+1cp3QasGW/357ESksQ4sSxke7e/7CKoW508aR1nGk4KJO+Mniol6QoMWlyhbkMHbuXOJX6i1/bWXVmB+AUB4CXJQPMssTlmvdIeMlVlrKbIfiHPgFSSv3Tvf9urNR5XexQqIic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FiipJjEX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ACD81F00A3E;
	Fri, 26 Jun 2026 11:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782474951;
	bh=vL9knM2sUgbCQ85ffU5z6/s6VECuwJ6C1a0TUUfpb00=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FiipJjEXIfzROm8Rj72S4kZbA2N2xxNfWgPz8qlLyZkwrxZDSeqHQJZ1nsFenldGj
	 tWAeDPq4ViIib6znioJ1YDV40N4/fDRIR4XEVYUr7PCcBk/cmpHIKfk9oyXHcuZXKl
	 a//DiKyx/pD6SgHukdZRldMDbxAwwSNLmE2L5/uieAxdHx+QL+0nEP9fEXpxPuFpSy
	 AiicdSl595hg4y5Jee6UmXtWWodjgj40XIz2EoZj7oyfrNIRheyZoj0LiqGFa7fgIZ
	 HwED5pjCaHPJaeuwX4RKtqfR/Mite71yOPDpiSBLYd+n/d5RS6FETeyBfte78Ut12A
	 7WpsQU7clOk3A==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 26 Jun 2026 13:54:03 +0200
Subject: [PATCH v19 6/8] rust: Add missing SAFETY documentation for `ARef`
 example
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-unique-ref-v19-6-2607ca88dfdf@kernel.org>
References: <20260626-unique-ref-v19-0-2607ca88dfdf@kernel.org>
In-Reply-To: <20260626-unique-ref-v19-0-2607ca88dfdf@kernel.org>
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
 Oliver Mangold <oliver.mangold@pm.me>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1545; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=Ze2x5FAumXdrYYXBmcLdm4zoQ8i0F4uXb1KFrUnACjQ=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqPmh5c0RI24LrPZqVYg0Qx/n7FDb+Aok1GaRha
 0/ilzrOjxuJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaj5oeQAKCRD6UCkIqsW9
 0PXyEAC23Ea6LyXAN/vBRnS7DE97krNCqsfydxgaFROXpDBNURjHZXj31Sg9Y9erG7mlTtA97Gw
 iZD6mAFVeXU9IMvhvCOIKXmdpVoRgFwfKI9/DUonOzTp8xJhDY5gOv9HtK87T576QMcztAszcV7
 /wMDeks1wYkasVZVNZN9s/O2Jj5f53J0aMqbuFUBR/NXPlCgZhvkGmAyVYQAfxggorCSwswCMa3
 jTpCwRwxUyixOPghBItB+SJeP5g1jkfQSoKtrXYmDE3Ospvl3F/QKrlca5nOD2WZVBXOykd+eWN
 W+Yo6O/7GY8aUFLlqvkKJOR70V5tpF9WbYgZIJJBfV4X4C8tL973ay+P+s9ALXSivgXAYo4Hpxh
 LtUDPxjvcumLWA3ZVZ+7g9DoI+g470yRQIWZuICvGHW3kNmyC4x3Dzp9STvG//SeyCbzRqv0Hjd
 RZMLYvoHZbQHptlGTRvwvAF/ptDrYzdebxRBuTfU1QdsWLJvx6cYT80VRCvLe+EZl1VOsvwPwuQ
 AlyisIhRWiJciTyCkYIQoaG63qxA4PS5bQ3kJ8juifTWSp+5bPU9eeNv4LxJqHe0GsnMAb0CuX3
 wdjTRgcuXTXNZZxEYRLnQQC+QOck8YxtWPw2OIB3ZPUfxIjpvhXNzn+wyH4lyqE38I2KJrba09V
 8ov5/+T4CdIxqTQ==
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
 vack.org,m:driver-core@lists.linux.dev,m:linux-block@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-fsdevel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-pwm@vger.kernel.org,m:oliver.mangold@pm.me,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[a.hindborg@kernel.org,linux-pwm@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9396-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[pm.me:email,collabora.com:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B14C6CCB94

From: Oliver Mangold <oliver.mangold@pm.me>

SAFETY comment in rustdoc example was just 'TODO'. Fixed.

Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/sync/aref.rs | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
index ea5a16b8163a6..f26ca39b84d0d 100644
--- a/rust/kernel/sync/aref.rs
+++ b/rust/kernel/sync/aref.rs
@@ -142,7 +142,9 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
     ///
     /// struct Empty {}
     ///
-    /// # // SAFETY: TODO.
+    /// // SAFETY: The `RefCounted` implementation for `Empty` does not count references and never
+    /// // frees the underlying object. Thus we can act as owning an increment on the refcount for
+    /// // the object that we pass to the newly created `ARef`.
     /// unsafe impl RefCounted for Empty {
     ///     fn inc_ref(&self) {}
     ///     unsafe fn dec_ref(_obj: NonNull<Self>) {}
@@ -150,7 +152,7 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
     ///
     /// let mut data = Empty {};
     /// let ptr = NonNull::<Empty>::new(&mut data).unwrap();
-    /// # // SAFETY: TODO.
+    /// // SAFETY: We keep `data` around longer than the `ARef`.
     /// let data_ref: ARef<Empty> = unsafe { ARef::from_raw(ptr) };
     /// let raw_ptr: NonNull<Empty> = ARef::into_raw(data_ref);
     ///

-- 
2.51.2



