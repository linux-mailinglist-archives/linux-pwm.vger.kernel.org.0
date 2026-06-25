Return-Path: <linux-pwm+bounces-9389-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MaJXKpWTPWr/4AgAu9opvQ
	(envelope-from <linux-pwm+bounces-9389-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jun 2026 22:46:13 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AE06C8981
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jun 2026 22:46:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=J42nwSbC;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9389-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9389-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23D6A3001CDD
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jun 2026 20:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B619D3672AF;
	Thu, 25 Jun 2026 20:42:12 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E990316192;
	Thu, 25 Jun 2026 20:42:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782420132; cv=none; b=Ca1qL2uc1gcQbVS8iqPlVTgMbLPFKo1hwv3YIaQtExN9tXl4dqTOuKxXgGTjRB3siJJYyBQiIyedQZU8YUkvqklXHnvv927ZtKj7Wou8OsJAKJA+INV+8OaUHfugW9W0eR41+0LAeQBFvtQ7tbHBxjop0eZ85mW2ua5M65+uD9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782420132; c=relaxed/simple;
	bh=9KmYKTZYm6BLoZCbAkb58dXWN3V3G68n8k2r+SKYfig=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ojb+DNvyK8q+7NJ+HQwph4tU9YULQGntHsL1Hxx/O7yGzUuIQXxvbIgXVU7iVOgCzVNaL9tubbwu3SDdrHEgBW4EOwR3rjygyDD+Sf4gy6GBYUcU9y/MiLNuyy6P6plAYGi9VYrDLTj/7zLK4cvy6Q+B2jdt9C5pg9SB1NePUDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J42nwSbC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6161F000E9;
	Thu, 25 Jun 2026 20:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782420131;
	bh=JvlsNB+ervCF+sSkJEPbN4Ijm830xLpfVQiWgPNgpJk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=J42nwSbCRvM0JMjF02PGznrxY18hUTDWVZ7tp9Th64egsofZWFuK/7UwkXSOiRMWZ
	 JFb4QbKQRBo1ee2fgXL4731g8g5ZKzhOektm+yfvSxklJkQC5qdKNXM7OsyGK4z/tY
	 7jjlUpMGk4xKRsvKVa6Ep/nb13JWkOg5psKsGHVL12oqfaiiky+CVSym81jwqCaUJd
	 l0RSq4P99yJkSjwmgCdMrOVUExxK7WZ1uEcahg8Pc27XeAso/gLvzUpXefzzEJr9fg
	 eaOccN7Oxpq5Nq5P16tkAeJOKLakhws44CZBq+jtnWPcBaYjoZ+eeFOMpFoUsZb9wW
	 GGmRDKHSaUNGg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Gary Guo <gary@garyguo.net>, Danilo Krummrich <dakr@kernel.org>, Lorenzo
 Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, "Liam R.
 Howlett" <liam@infradead.org>, Uladzislau
 Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng
 <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Daniel Almeida
 <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>, Onur =?utf-8?Q?=C3=96zkan?=
 <work@onurozkan.dev>,
 Lyude Paul <lyude@redhat.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=
 <arve@android.com>, Todd Kjos
 <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, Carlos Llamas
 <cmllamas@google.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Dave Ertman <david.m.ertman@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, Paul Moore
 <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Igor Korotin
 <igor.korotin@linux.dev>, Viresh Kumar <vireshk@kernel.org>, Nishanth
 Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>,
 Pavel
 Tikhomirov <ptikhomirov@virtuozzo.com>, Michal Wilczynski
 <m.wilczynski@samsung.com>
Cc: Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 driver-core@lists.linux.dev, linux-block@vger.kernel.org,
 linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v18 3/8] rust: implement `ForeignOwnable` for `Owned`
In-Reply-To: <DJI5ZY2TPFSW.BEKOVZYRSTQZ@garyguo.net>
References: <20260625-unique-ref-v18-0-4e06b5896d47@kernel.org>
 <20260625-unique-ref-v18-3-4e06b5896d47@kernel.org>
 <DJI5ZY2TPFSW.BEKOVZYRSTQZ@garyguo.net>
Date: Thu, 25 Jun 2026 21:47:35 +0200
Message-ID: <87y0g2h06g.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9389-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[a.hindborg@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:gary@garyguo.net,m:dakr@kernel.org,m:ljs@kernel.org,m:vbabka@kernel.org,m:liam@infradead.org,m:urezki@gmail.com,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:daniel.almeida@collabora.com,m:tamird@kernel.org,m:acourbot@nvidia.com,m:work@onurozkan.dev,m:lyude@redhat.com,m:gregkh@linuxfoundation.org,m:arve@android.com,m:tkjos@android.com,m:brauner@kernel.org,m:cmllamas@google.com,m:rafael@kernel.org,m:david.m.ertman@intel.com,m:ira.weiny@intel.com,m:leon@kernel.org,m:paul@paul-moore.com,m:sergeh@kernel.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:viro@zeniv.linux.org.uk,m:jack@suse.cz,m:igor.korotin@linux.dev,m:vireshk@kernel.org,m:nm@ti.com,m:sboyd@kernel.org,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:ptikhomirov@virtuozzo.com,m:m.wilczynski@samsung.com,m:phasta@kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:driver-core@l
 ists.linux.dev,m:linux-block@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-fsdevel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-pwm@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[garyguo.net,kernel.org,infradead.org,gmail.com,protonmail.com,google.com,umich.edu,collabora.com,nvidia.com,onurozkan.dev,redhat.com,linuxfoundation.org,android.com,intel.com,paul-moore.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,linux.dev,ti.com,virtuozzo.com,samsung.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_GT_50(0.00)[53];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a.hindborg@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 01AE06C8981

"Gary Guo" <gary@garyguo.net> writes:

> On Thu Jun 25, 2026 at 11:15 AM BST, Andreas Hindborg wrote:
>> Implement `ForeignOwnable` for `Owned<T>`. This allows use of `Owned<T>` in
>> places such as the `XArray`.
>>
>> Note that `T` does not need to implement `ForeignOwnable` for `Owned<T>` to
>> implement `ForeignOwnable`.
>>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>>  rust/kernel/owned.rs | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 53 insertions(+)
>>
>> diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
>> index 7fe9ec3e55126..9c92d4a83cc1b 100644
>> --- a/rust/kernel/owned.rs
>> +++ b/rust/kernel/owned.rs
>> @@ -15,6 +15,8 @@
>>      ptr::NonNull, //
>>  };
>>  
>> +use kernel::types::ForeignOwnable;
>> +
>>  /// Types that specify their own way of performing allocation and destruction. Typically, this trait
>>  /// is implemented on types from the C side.
>>  ///
>> @@ -186,3 +188,54 @@ fn drop(&mut self) {
>>          unsafe { T::release(self.ptr) };
>>      }
>>  }
>> +
>> +// SAFETY: We derive the pointer to `T` from a valid `T`, so the returned
>> +// pointer satisfy alignment requirements of `T`.
>> +unsafe impl<T: Ownable> ForeignOwnable for Owned<T> {
>> +    const FOREIGN_ALIGN: usize = core::mem::align_of::<T>();
>> +
>> +    type Borrowed<'a>
>> +        = &'a T
>> +    where
>> +        Self: 'a;
>> +    type BorrowedMut<'a>
>> +        = Pin<&'a mut T>
>> +    where
>> +        Self: 'a;
>> +
>> +    #[inline]
>> +    fn into_foreign(self) -> *mut kernel::ffi::c_void {
>> +        let ptr = self.ptr.as_ptr().cast();
>> +        core::mem::forget(self);
>> +        ptr
>
> I think the pattern in `into_raw` is better:
>
>     ManuallyDrop::new(self).ptr.as_ptr().cast()
>
> Or perhaps this can just use `Self::into_raw(self).as_ptr().cast()`.
>
>> +    }
>> +
>> +    #[inline]
>> +    unsafe fn from_foreign(ptr: *mut kernel::ffi::c_void) -> Self {
>> +        // INVARIANT: By the function safety contract, `ptr` was returned by `into_foreign`, which
>> +        // gave up exclusive ownership of a valid, pinned `T`; we retake that ownership here.
>> +        Self {
>> +            // SAFETY: By function safety contract, `ptr` came from
>> +            // `into_foreign` and cannot be null.
>> +            ptr: unsafe { NonNull::new_unchecked(ptr.cast()) },
>> +        }
>> +    }
>
> Same here, could be using `Self::from_raw`.
>
> However, the current code looks correct to me regardless, so:
>
> Reviewed-by: Gary Guo <gary@garyguo.net>

I'll defer to `{into,from}_raw`. Keeping your tag.


Best regards,
Andreas Hindborg




