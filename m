Return-Path: <linux-pwm+bounces-9375-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2z4iB5kAPWp+vggAu9opvQ
	(envelope-from <linux-pwm+bounces-9375-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jun 2026 12:19:05 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 159CF6C4978
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jun 2026 12:19:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DguMuLTX;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9375-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9375-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CD6483007ADB
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jun 2026 10:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DA225C804;
	Thu, 25 Jun 2026 10:17:12 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB17367288;
	Thu, 25 Jun 2026 10:17:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782382632; cv=none; b=c+lvkJkRs4KrQKdvjBxdu4R8B6e0OfDwFfmoRk3LT021pB5kvrGFLU7SoUipOsf5T0Y2c9d6eywqfmPVSRHDQ/ZLQPZpq7V+W6lLRB2yjlOPeYUq2zOq2Yuqn47X+kN1uq5+BHTdkz1oMWGNFIVfRSNB3Y37lOasbIXLtz5knuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782382632; c=relaxed/simple;
	bh=L57zDm7ALp0lZWMW+Cln/Gg2DuJozYQVYKA2SZ2s83c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z6vRl85SitotsIj3bHCTChjRcjlAlFL5NvJ0kfwmQdLRBlft9rxR+jJ5na301B1ji3YBCYVUdRjDJs92Fq1Fi3vxh2Ftt3sScvy7NIQsIq9FmxLk4sELIl5aYwNuquskULg7EOPwTVBpQUmQ7TTwizCXVvxtgwMXphvyUXLyzws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DguMuLTX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0BFA1F000E9;
	Thu, 25 Jun 2026 10:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782382631;
	bh=9MHwt/piGbHaBX1U0Ciw0A9tLdy3GnbZtG5V2/pNbH0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=DguMuLTX6L0L9KuizfWkxAATMIlyA8bPMmMhC8BLL5WNrKQrhn2s69icAqPZlU8CB
	 MZViieMuMIAOD3zQ+7RUEHnP9UOboSusmrhpgnnPDi7JR+O6QfvIZQ57gIQiHb62jE
	 Nwk3bgsrKfVAp+6+11oFIJmaMdmzmis/5ta5bpAqI/DbYoZDFXZ9Dqm9mhKkgTkPe6
	 MweoEk+qHsmyJmKiQfT0OybItJ7gYGadhXss5p8tUZ5GPGxlo0ZR1dNWPVSTIWuKWr
	 18PnqnWvF5WkYUecXh0qp7EC2AdHh6YlabpOUSeBf+LIZPfQiG9f2uQoRYWqcdfbif
	 uOGhTKvuG6bjw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Thu, 25 Jun 2026 12:15:03 +0200
Subject: [PATCH v18 1/8] rust: alloc: add `KBox::into_non_null`
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-unique-ref-v18-1-4e06b5896d47@kernel.org>
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
 linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1170; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=L57zDm7ALp0lZWMW+Cln/Gg2DuJozYQVYKA2SZ2s83c=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqPP++uGgipwDjCmHpaSqUlxoMDKEvVyu3KGUE8
 sF7dvt/kIeJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCajz/vgAKCRD6UCkIqsW9
 0OiUEAC23l5hDLZ2AuUND5t/t+H3AC8vmplyBqcaI+ow/2SaKVzdc1lyzdq4J7C6GMb0Y8e27gN
 9/CIBdb7+/iggRB4jlvgyNKw0MeOj5mQe4qelvVp/Igl1sZDKylK2dLNoET94fZhA7VGjj/MlaK
 C+FiEPIwA9f/hmhnwQLzRqFo+G+tVnlh2g9pFi22EjIm3Vj6msOoRII5IO7/cz1Af/c5gNDY5A4
 tcLI3I5QgittUsRXPFMXz8G6Tpbw2HhBBoHVwtgK6GfMW1p9QCdkV0Wp8EV9Juw5vTWWDcPBXk0
 dLoL0TbzDLu5j7iFZGYd9HsalVbC/9+5PGtFQ1F/LkkEFYG6LM1+Gi1x0gKDtaFXbrNUBOrAjTe
 RWKW27ov//tZM27MrU9+9t0QhGN/Toy36zkfg8FL2idqfWXVFAHmsiTPtjyz4hwXkxLsHR99l1G
 0vp6LOc6K5vKriRm7OK0jD1sJVoATw87WQ13c6UOEq1Lp0NiH+GWVLf24rMrFuWjJCbA8m2cpnA
 rVZVBJ8Cb71JxcAyqLY5RKGmdg+o2khQ9dg8qcu2ikmrnqrhggwhHT7TQOZytz3qmg66SQMyQr/
 wySTYLpOuuXwx3AdiXxYAOyCy77nmGLgOTMyjyNVdCnlQlEaCLkiQQqRT+UiOoC0EijnKjc9QnO
 Z5+1TTt3znsVIIw==
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
	TAGGED_FROM(0.00)[bounces-9375-lists,linux-pwm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,infradead.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,collabora.com,nvidia.com,onurozkan.dev,redhat.com,linuxfoundation.org,android.com,intel.com,paul-moore.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,linux.dev,ti.com,virtuozzo.com,samsung.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_GT_50(0.00)[53];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a.hindborg@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 159CF6C4978

Add a method to consume a `Box<T, A>` and return a `NonNull<T>`. This
is a convenience wrapper around `Self::into_raw` for callers that need
a `NonNull` pointer rather than a raw pointer.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/alloc/kbox.rs | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index 35d1e015848dd..d534e8adcf7b3 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -211,6 +211,15 @@ pub fn leak<'a>(b: Self) -> &'a mut T {
         // which points to an initialized instance of `T`.
         unsafe { &mut *Box::into_raw(b) }
     }
+
+    /// Consumes the `Box<T,A>` and returns a `NonNull<T>`.
+    ///
+    /// Like [`Self::into_raw`], but returns a `NonNull`.
+    #[inline]
+    pub fn into_non_null(b: Self) -> NonNull<T> {
+        // SAFETY: `KBox::into_raw` returns a valid pointer.
+        unsafe { NonNull::new_unchecked(Self::into_raw(b)) }
+    }
 }
 
 impl<T, A> Box<MaybeUninit<T>, A>

-- 
2.51.2



