Return-Path: <linux-pwm+bounces-9393-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KqZ6JAxpPmpFFgkAu9opvQ
	(envelope-from <linux-pwm+bounces-9393-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 13:57:00 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 040BB6CCB17
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 13:57:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="h4Jg9M/U";
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9393-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9393-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F31253040C60
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 11:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07E83F44E3;
	Fri, 26 Jun 2026 11:55:27 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E533F39FE;
	Fri, 26 Jun 2026 11:55:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782474927; cv=none; b=Ip3n364Lxn7ZSvlXvzwzLAIldx/iixzmhlGcNsWd95APGDzm5QxqvXszgUDztGQTdp/u5w5FqrsVf+GkfuoylNciM8dl+Zek9OPd26upFYtCoJ20Ld4akwJCjLS24pWGOiZD44+lYqA/L3BBIPWoCgFQkNW08jH/b4bhoNT9f4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782474927; c=relaxed/simple;
	bh=E7vYmMpa3Blg0v5cZJiXscL/77ngvQZ+huTeto0B0VU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=i88HLvm8C4x+jQi3bqx9hGIhSmKdZREITAuJ38FoDSu3bNdXPyA4hcL+RsNBDJelNTQouHObLqEpyr69QQbPplIEqTRgVY2IWoZ9ytr9xuCi+ucSLLpqlR4RhWvYRUDkcGTvirosBJSNh3n6y7FiiOm7ITGMMwHKRNeiUTYjGvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4Jg9M/U; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76CE51F000E9;
	Fri, 26 Jun 2026 11:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782474919;
	bh=0xiV+dAAxQ5vuqeqEAMc+CD5ycesoV1kpDoh9yHprIU=;
	h=From:Subject:Date:To:Cc;
	b=h4Jg9M/UKVwRNvYhWQiT1cEkAyfeFcMM5R+fe6g6gu9Mlt4cjsroQrqZ+lWRdZQAK
	 Wzg5waEkzBWpIcm+CyRXYqcHKdfT69vzCrDLSb7bQ7Y4HcjS5H/49soinRVq/BjjEQ
	 /+5Rxh2roL2vNQe/Uv3DLAbJ4cLpL80P6mw3JJMmdYHtoqG8GrqcqdKC28bCVCvxOD
	 vP6w9QodCwphADRjfK1ikSkV1+kT0H790ArfIcs7Twqgep2yHcPdmnzAHJQ9nNxqHe
	 sAS96IuIxsY091w9TGVjJ6L4IHfQhWvmkaobtj5DMMGT7RuPy5ddjdsLKcaBHz8M+f
	 dKvm2g+k4+YpA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Subject: [PATCH v19 0/8] rust: add `Ownable` trait and `Owned` type
Date: Fri, 26 Jun 2026 13:53:57 +0200
Message-Id: <20260626-unique-ref-v19-0-2607ca88dfdf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFVoPmoC/2XOTW7CMBAF4Ksgr+tq/G+z6j0Qi9iegEWVgFOiV
 ih374QNCVnOG31v5sEGrAUHtt89WMWxDKXvaBDhY8fSuelOyEumgEmQBhQYfu/K7Y68YstlaFO
 2zrQBAyNwpbD8PtsOR5rPZfjp69+zfBR6juceCxL0sod2HLhwKcqAsUkxfl2wdvj92dcTm5tGY
 RZawlob0j4ozN5GsClttV3qt9uWdJKiaVMUwme11e6l7fvnjrSLOqksg4IYttovtDRr7UlrBBu
 NDzZrt9LTNP0DkTMw6KABAAA=
X-Change-ID: 20250305-unique-ref-29fcd675f9e9
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
 Asahi Lina <lina+kernel@asahilina.net>, 
 Oliver Mangold <oliver.mangold@pm.me>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Boqun Feng <boqun@kernel.org>, 
 Asahi Lina <lina+kernel@asahilina.net>, 
 Igor Korotin <igor.korotin@linux.dev>, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=11869;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=E7vYmMpa3Blg0v5cZJiXscL/77ngvQZ+huTeto0B0VU=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqPmha2IDTSBK23gO13hIw+A3+jNWRKjZfcQo8A
 9ApbajyvQaJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaj5oWgAKCRD6UCkIqsW9
 0DL6EACiTIa7BDo2kgjlDnq6fEPqSGkq8el2ce6FarJlXZVr/w5/BPyz2TaGkAMj0yWiHMUg6Nb
 hkOYYGHFaGsXgdUP/MErMMsyksC0aL2/K9F9I6NKfbIRNErlbqVPrk5bbza/I3gz4jb1lg7E7Gt
 MbyX+xDmi+ID9nxoWl3f3rV89DAAiwJVETwUdNljpudFn7pkcBwlgeYvV7NCwJnr3/5Uht5LmoW
 IVYDkM/MNH3Er9S55Kq6v5RcH5K+qPuEwjE9cuCorwIy78N+vcZZN2F01ITul11qlkjr87F/JdF
 bDCqzbPU+Tlui3RNOIS5m96pR69cunSSm0mbEhzHvAhSOLoKJkOLR9ZqVjG97pfOmN8oGTjZK/e
 4f9LQlfpPtpFBRVLojzT0WaRFtCodhDT4uPZrbBH1IZfRGI5IOlXTScMvtPCVsTGRVWfAHSIDZI
 /m2kn739pJ39HWPa2eaS7xmgfKZbTWpmXa0fTAi9t0GN1Bs8Xq13m75SABWu/Z5jhLIGgtUv+XA
 UcBfLmvKYY1u0UVRVB/yv/ghelxTjPcd+ThO3CPrCNdaQWnFyB2cYHBJreM2OpSyS2hiXhQWUs0
 nj7u+AmGUIWUvsNiHkwAWFBIg4EK2PsGRS/HdzHRJDJ5tIK6NYRogqqH1rvNocEroyXGQkhrxdj
 mow336gDKj6kSQA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9393-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dakr@kernel.org,m:ljs@kernel.org,m:vbabka@kernel.org,m:liam@infradead.org,m:urezki@gmail.com,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:daniel.almeida@collabora.com,m:tamird@kernel.org,m:acourbot@nvidia.com,m:work@onurozkan.dev,m:lyude@redhat.com,m:gregkh@linuxfoundation.org,m:arve@android.com,m:tkjos@android.com,m:brauner@kernel.org,m:cmllamas@google.com,m:rafael@kernel.org,m:david.m.ertman@intel.com,m:ira.weiny@intel.com,m:leon@kernel.org,m:paul@paul-moore.com,m:sergeh@kernel.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:viro@zeniv.linux.org.uk,m:jack@suse.cz,m:igor.korotin@linux.dev,m:vireshk@kernel.org,m:nm@ti.com,m:sboyd@kernel.org,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:ptikhomirov@virtuozzo.com,m:m.wilczynski@samsung.com,m:a.hindborg@kernel.org,m:phasta@kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@k
 vack.org,m:driver-core@lists.linux.dev,m:linux-block@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-fsdevel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-pwm@vger.kernel.org,m:lina+kernel@asahilina.net,m:oliver.mangold@pm.me,m:viresh.kumar@linaro.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,infradead.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,collabora.com,nvidia.com,onurozkan.dev,redhat.com,linuxfoundation.org,android.com,intel.com,paul-moore.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,linux.dev,ti.com,virtuozzo.com,samsung.com];
	FORGED_SENDER(0.00)[a.hindborg@kernel.org,linux-pwm@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_GT_50(0.00)[60];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a.hindborg@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 040BB6CCB17

Add a new trait `Ownable` and type `Owned` for types that specify their
own way of performing allocation and destruction. This is useful for
types from the C side.

Implement `ForeignOwnable` for `Owned`.

Convert `Page` to be `Ownable` and add a `from_raw` method.

Add the trait `OwnableRefCounted` that allows conversion between
`ARef` and `Owned`. This is analogous to conversion between `Arc` and
`UniqueArc`.

Patches 1-4 implement `Ownable` and applies it to `Page`. These patches
can be merged on their own.

Patches 5-7 add `Ownable` -> `ARef` interop and can be merged later if
consensus on their shape cannot be reached.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
Changes in v19:
- Update `workqueue.rs` and the `aref` module docs to use `RefCounted` instead of `AlwaysRefCounted` (Sashiko).
- Remove the default `OwnableRefCounted::into_shared` implementation to keep the trait safe (Sashiko).
- Fix the `ARef<Self>` rustdoc link (Sashiko).
- Reuse `Owned::into_raw`/`from_raw` in the `ForeignOwnable` implementation (Gary).
- Link to v18: https://msgid.link/20260625-unique-ref-v18-0-4e06b5896d47@kernel.org

Changes in v18:
- Rebase on `rust-next` (2026-06-24).
- Drop the `'static` bound on `ForeignOwnable for Owned` (Gary).
- Make `Ownable::release` take a raw pointer instead of `&mut self` (Alice, Sashiko).
- Drop `types::ARef` re-export (Alice).
- Drop unneeded `#[repr(transparent)]` on `Owned` (Gary).
- Fix `FOREIGN_ALIGN` for `Owned` to report the pointee alignment (Sashiko).
- Remove `BorrowedPage`; use `&Page` directly (Alice).
- Update Rust Binder for the `Owned<Page>` conversion (Alice).
- Update `pwm.rs` for the `RefCounted`/`AlwaysRefCounted` split (Sashiko).
- Fix documentation nits: missing `// INVARIANT:` comments, stale `Page` docs, and a stray `mut` (Sashiko).
- Expand the `use` statements touched by the rename patch to the multi-line style (Onur).
- Link to v17: https://msgid.link/20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org

Changes in v17:
- Rebase on v7.1-rc2.
- Reorder patches so that `Ownable` can merge without `OwnableRefCounted` (Alice).
- Add `#[inline]` directives to short functions added by the series (Gary).
- Link to v16: https://msgid.link/20260224-unique-ref-v16-0-c21afcb118d3@kernel.org

Changes in v16:
- Simplify pointer to reference cast in `Page::from_raw`.
- Use `NonNull<Page>` rather than `Owned<Page>` for `BorrowedPage` internals.
- Use "convertible to reference" wording when converting pointers to references.
- Fix formatting for `Page::from_raw` docs.
- Leave imports alone when adding safety comment to aref example.
- Use `KBox::into_nonnull` for examples.
- Add patch for `KBox::into_nonnull`.
- Change invariants and safety comments of `Ownable` and make the trait safe.
- Make `Ownable::release` take a mutable reference.
- Fix error handling in example for `Ownable`
- Link to v15: https://msgid.link/20260220-unique-ref-v15-0-893ed86b06cc@kernel.org

Changes in v15:
- Update series with original SoB's.
- Rename `AlwaysRefCounted` in `kernel::usb`.
- Rename `Owned::get_pin_mut` to `Owned::as_pin_mut`.
- Link to v14: https://msgid.link/20260204-unique-ref-v14-0-17cb29ebacbb@kernel.org

Changes in v14:
- Rebase on v6.19-rc7.
- Rewrite cover letter.
- Update documentation and safety comments based on v13 feedback.
- Update commit messages.
- Reorder implementation blocks in owned.rs.
- Update example in owned.rs to use try operator rather than `expect`.
- Reformat use statements.
- Add patch: rust: page: convert to `Ownable`.
- Add patch: rust: implement `ForeignOwnable` for `Owned`.
- Add patch: rust: page: add `from_raw()`.
- Link to v13: https://lore.kernel.org/r/20251117-unique-ref-v13-0-b5b243df1250@pm.me

Changes in v13:
- Rebase onto v6.18-rc1 (Andreas's work).
- Documentation and style fixes contributed by Andreas
- Link to v12: https://lore.kernel.org/r/20251001-unique-ref-v12-0-fa5c31f0c0c4@pm.me

Changes in v12:
-
- Rebase onto v6.17-rc1 (Andreas's work).
- moved kernel/types/ownable.rs to kernel/owned.rs
- Drop OwnableMut, make DerefMut depend on Unpin instead. I understood
  ML discussion as that being okay, but probably needs further scrunity.
- Lots of more documentation changes suggested by reviewers.
- Usage example for Ownable/Owned.
- Link to v11: https://lore.kernel.org/r/20250618-unique-ref-v11-0-49eadcdc0aa6@pm.me

Changes in v11:
- Rework of documentation. I tried to honor all requests for changes "in
  spirit" plus some clearifications and corrections of my own.
- Dropping `SimpleOwnedRefCounted` by request from Alice, as it creates a
  potentially problematic blanket implementation (which a derive macro that
  could be created later would not have).
- Dropping Miguel's "kbuild: provide `RUSTC_HAS_DO_NOT_RECOMMEND` symbol"
  patch, as it is not needed anymore after dropping `SimpleOwnedRefCounted`.
  (I can add it again, if it is considered useful anyway).
- Link to v10: https://lore.kernel.org/r/20250502-unique-ref-v10-0-25de64c0307f@pm.me

Changes in v10:
- Moved kernel/ownable.rs to kernel/types/ownable.rs
- Fixes in documentation / comments as suggested by Andreas Hindborg
- Added Reviewed-by comment for Andreas Hindborg
- Fix rustfmt of pid_namespace.rs
- Link to v9: https://lore.kernel.org/r/20250325-unique-ref-v9-0-e91618c1de26@pm.me

Changes in v9:
- Rebase onto v6.14-rc7
- Move Ownable/OwnedRefCounted/Ownable, etc., into separate module
- Documentation fixes to Ownable/OwnableMut/OwnableRefCounted
- Add missing SAFETY documentation to ARef example
- Link to v8: https://lore.kernel.org/r/20250313-unique-ref-v8-0-3082ffc67a31@pm.me

Changes in v8:
- Fix Co-developed-by and Suggested-by tags as suggested by Miguel and Boqun
- Some small documentation fixes in Owned/Ownable patch
- removing redundant trait constraint on DerefMut for Owned as suggested by Boqun Feng
- make SimpleOwnedRefCounted no longer implement RefCounted as suggested by Boqun Feng
- documentation for RefCounted as suggested by Boqun Feng
- Link to v7: https://lore.kernel.org/r/20250310-unique-ref-v7-0-4caddb78aa05@pm.me

Changes in v7:
- Squash patch to make Owned::from_raw/into_raw public into parent
- Added Signed-off-by to other people's commits
- Link to v6: https://lore.kernel.org/r/20250310-unique-ref-v6-0-1ff53558617e@pm.me

Changes in v6:
- Changed comments/formatting as suggested by Miguel Ojeda
- Included and used new config flag RUSTC_HAS_DO_NOT_RECOMMEND,
  thus no changes to types.rs will be needed when the attribute
  becomes available.
- Fixed commit message for Owned patch.
- Link to v5: https://lore.kernel.org/r/20250307-unique-ref-v5-0-bffeb633277e@pm.me

Changes in v5:
- Rebase the whole thing on top of the Ownable/Owned traits by Asahi Lina.
- Rename AlwaysRefCounted to RefCounted and make AlwaysRefCounted a
  marker trait instead to allow to obtain an ARef<T> from an &T,
  which (as Alice pointed out) is unsound when combined with UniqueRef/Owned.
- Change the Trait design and naming to implement this feature,
  UniqueRef/UniqueRefCounted is dropped in favor of Ownable/Owned and
  OwnableRefCounted is used to provide the functions to convert
  between Owned and ARef.
- Link to v4: https://lore.kernel.org/r/20250305-unique-ref-v4-1-a8fdef7b1c2c@pm.me

Changes in v4:
- Just a minor change in naming by request from Andreas Hindborg,
  try_shared_to_unique() -> try_from_shared(),
  unique_to_shared() -> into_shared(),
  which is more in line with standard Rust naming conventions.
- Link to v3: https://lore.kernel.org/r/Z8Wuud2UQX6Yukyr@mango

To: Danilo Krummrich <dakr@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>
To: Vlastimil Babka <vbabka@kernel.org>
To: "Liam R. Howlett" <liam@infradead.org>
To: Uladzislau Rezki <urezki@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>
To: Boqun Feng <boqun@kernel.org>
To: Gary Guo <gary@garyguo.net>
To: Björn Roy Baron <bjorn3_gh@protonmail.com>
To: Benno Lossin <lossin@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
To: Trevor Gross <tmgross@umich.edu>
To: Daniel Almeida <daniel.almeida@collabora.com>
To: Tamir Duberstein <tamird@kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>
To: Onur Özkan <work@onurozkan.dev>
To: Lyude Paul <lyude@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arve Hjønnevåg <arve@android.com>
To: Todd Kjos <tkjos@android.com>
To: Christian Brauner <brauner@kernel.org>
To: Carlos Llamas <cmllamas@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
To: Dave Ertman <david.m.ertman@intel.com>
To: Ira Weiny <ira.weiny@intel.com>
To: Leon Romanovsky <leon@kernel.org>
To: Paul Moore <paul@paul-moore.com>
To: Serge Hallyn <sergeh@kernel.org>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Alexander Viro <viro@zeniv.linux.org.uk>
To: Jan Kara <jack@suse.cz>
To: Igor Korotin <igor.korotin@linux.dev>
To: Viresh Kumar <vireshk@kernel.org>
To: Nishanth Menon <nm@ti.com>
To: Stephen Boyd <sboyd@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
To: Krzysztof Wilczyński <kwilczynski@kernel.org>
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: driver-core@lists.linux.dev
Cc: linux-block@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-pwm@vger.kernel.org

---
Andreas Hindborg (3):
      rust: alloc: add `KBox::into_non_null`
      rust: implement `ForeignOwnable` for `Owned`
      rust: page: add `from_raw()`

Asahi Lina (2):
      rust: types: Add Ownable/Owned types
      rust: page: convert to `Ownable`

Oliver Mangold (3):
      rust: rename `AlwaysRefCounted` to `RefCounted`.
      rust: Add missing SAFETY documentation for `ARef` example
      rust: Add `OwnableRefCounted`

 drivers/android/binder/page_range.rs |  10 +-
 rust/kernel/alloc/allocator.rs       |  19 +-
 rust/kernel/alloc/allocator/iter.rs  |   6 +-
 rust/kernel/alloc/kbox.rs            |   9 +
 rust/kernel/auxiliary.rs             |  10 +-
 rust/kernel/block/mq/request.rs      |  19 +-
 rust/kernel/cred.rs                  |  16 +-
 rust/kernel/device.rs                |  12 +-
 rust/kernel/device/property.rs       |  11 +-
 rust/kernel/drm/device.rs            |   9 +-
 rust/kernel/drm/gem/mod.rs           |  16 +-
 rust/kernel/fs/file.rs               |  23 ++-
 rust/kernel/i2c.rs                   |  13 +-
 rust/kernel/lib.rs                   |   1 +
 rust/kernel/mm.rs                    |  22 ++-
 rust/kernel/mm/mmput_async.rs        |  12 +-
 rust/kernel/opp.rs                   |  16 +-
 rust/kernel/owned.rs                 | 373 +++++++++++++++++++++++++++++++++++
 rust/kernel/page.rs                  | 136 +++++--------
 rust/kernel/pci.rs                   |  10 +-
 rust/kernel/pid_namespace.rs         |  15 +-
 rust/kernel/platform.rs              |  10 +-
 rust/kernel/pwm.rs                   |  12 +-
 rust/kernel/sync/aref.rs             |  84 +++++---
 rust/kernel/task.rs                  |  13 +-
 rust/kernel/types.rs                 |  12 ++
 rust/kernel/usb.rs                   |  17 +-
 rust/kernel/workqueue.rs             |   8 +-
 28 files changed, 728 insertions(+), 186 deletions(-)
---
base-commit: 43a393185e33e573a374c1d4f7ddf6481484ef8d
change-id: 20250305-unique-ref-29fcd675f9e9

Best regards,
--  
Andreas Hindborg <a.hindborg@kernel.org>



