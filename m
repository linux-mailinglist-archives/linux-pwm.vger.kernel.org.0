Return-Path: <linux-pwm+bounces-9434-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fpaBBZLBP2rWXwkAu9opvQ
	(envelope-from <linux-pwm+bounces-9434-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 27 Jun 2026 14:26:58 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 763386D1EC4
	for <lists+linux-pwm@lfdr.de>; Sat, 27 Jun 2026 14:26:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=UmpjQN+d;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9434-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9434-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48CC43014567
	for <lists+linux-pwm@lfdr.de>; Sat, 27 Jun 2026 12:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EFA3590AE;
	Sat, 27 Jun 2026 12:26:55 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F89149DF1
	for <linux-pwm@vger.kernel.org>; Sat, 27 Jun 2026 12:26:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782563215; cv=pass; b=WcFnzKALEyh9uyB6JFjWd+P1f/3Z16soZn4zgBIxHJDVypi/Hpg5ZfUEjY2HfQQ1P8kOR5P3kaZOgUmUgWtl056W+gY1PDt+ebTDt6BRqovcfTlTroiXX76TmftucobF47/rJf3ytvQGbNEWYM0w1GzfQ9/Hfp0gVDj1+Hj5YU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782563215; c=relaxed/simple;
	bh=tiA1M5jTZ3Y/iPMgDja4ldkoTBXhRz6JYbn7HUdPCGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MQ3SN3y6naEvgY9K0LOvRzH6nQUD2LHboTxuEJ0YNvMzWgBP6uUhEnh/DzRJtJ2xOiQ9tu1T/X2mwEpaaRwr3hYj0XMLukerhZm4MHAI4fp/WiM7q0yR4YiCpc4lmQu+r+Of1rKZtbqp+R9XMtXnX2Ta5B6KOi5Rr+tiMDgWzdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UmpjQN+d; arc=pass smtp.client-ip=74.125.82.173
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-30e869ebc19so6264eec.0
        for <linux-pwm@vger.kernel.org>; Sat, 27 Jun 2026 05:26:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782563214; cv=none;
        d=google.com; s=arc-20260327;
        b=r0VrTZun/pPEnOMVBkWSG88QlpZPTfqHxMLbRlSkJhM+h4b50bg2X35dK2nAZvH3UL
         ONFuwxWsEwVn0iblrrpt4rbhT5iVKdksbx0DtwF23lclHxoEI6dgLrK8hfahog3a6OW1
         Gk4cAKbKYHj0z5w6LoGXS+Aa4mCBqp9zyZhRl/5fqGmmvqWAox56B3O9LhiUntfsJnS2
         6ZilgCQ6IwOLrFmmeZsb2ukQrtDSfTejQ/jOYwSVX33DZsKRgzHjC9l1tMs3kYijszl4
         ZB362FvYc5dZhRKVDO9JJekI/sPTj/0fH5eNA6iCKyNL6FAYCh3AhFTR4hncDdOXdUuS
         BCYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FFA3P0ucfKK/nr2i/TjAG0TaOdJ/VCYkxmATJyLWDko=;
        fh=AJSAyfro2fUsVG3zAJMzmJbqDKeZgFJDkZX4bRNjmdU=;
        b=r1FTzBR6Kt7on5dFFEDciRiHuBKJ9Qxw5DuBKv3YrR0rU+esadczVa5BAr81tuAv/u
         hyeMj1I5qRlgiSrl7vcFOk4zL4CRYFkT3cHVb0AR0Mlq6Bg6aXROI8HGcmUyaGn/toyQ
         o57Z7pXxhRVrzEiinvpBjoOaDwb0ttpGLF2s3uYwlk7vKna4rexlokJbgAopDQeyFkoi
         dx07dls6GdsZ04chiPDwwJUiB2OjDpmSj0Us9ZdfG00dgAqrOM4h0SwKIUNsji7h35No
         xDjoRF1nFDV6GnonfjqzvMQaUVIn1yoUA/kcdDuEmYXo02AG/23ZG7IGVrdU0ORF4GR2
         lebQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782563214; x=1783168014; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FFA3P0ucfKK/nr2i/TjAG0TaOdJ/VCYkxmATJyLWDko=;
        b=UmpjQN+dbFsh7cj/TVQnupfZ2TWKdFD3KmaLWZqt5wrAlZOdMBFMmyvAF0qHYagFCo
         6hDiJPGGwmSeh5YioWD1iIYM+lk4VVl4qjK9DV4tQyx4aRuSQtWoSzx8pAsAE7pTYD0+
         U0O9nzz9i1SUCYPl5wGqBdfn8Cdb7zOivdDEg0SxgNCRMBAuq27G/XE0tYZ8Lv6GnQRM
         oW4ETaTpYIK+am1brMtlY3CR+egEc5lXcJVOEN4o9Wjrd8E7wR3TZVYkQlhTMbPrwQtO
         /pLywOlTx6c6JPuoRaFhtX7uQ1pd/efvEnGilwswyGny8UygqneNM6knxq4/p1OR0MdS
         833w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782563214; x=1783168014;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FFA3P0ucfKK/nr2i/TjAG0TaOdJ/VCYkxmATJyLWDko=;
        b=keIK65zB/rPtDil3m2sbyYBiXhXFRDtbKxsEJ6ZHr9FpnNVpgOpamcbOaCopSaK8br
         lUg7ZN85t/lDW/p/U6VSFs+e4Dff+ofdnWZSjbQdUMMOz5+zcVHbhIau5IL2EkNYTBOx
         Fwi52F3Kq+WAo5gldalHlqqTt8e2hFI6WB2+LAmjgp2PxAkYALIgbOPXQVmuRHg7F8hB
         NYTAC/SAq+VvLQAB8KtZKfaDwj4f2EdoFX/yglJrXW3+Ct5708dk81Z4V27OpWOPgnsR
         3jAUOBzFWgwrI93n17JGwCp02TqnooTJvr0CRBe2itavkR5F86TfsLkET1bvseoqdi3T
         Ot8g==
X-Forwarded-Encrypted: i=1; AHgh+RqSKwiyUSMaYd5Yk3Agi0Z325fuXDtU1xRms3mhcADenmzuJnie+bSqieNGBFA6fJONthVubOyYfoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMRc3Z3ws41OEZv7oPXONdZAEuaP3GHXbA3MyWNtG70d/AqGS0
	AfP2xYvqtLXXoXDKgpFCJrcBqLkxOMyWcrdntGc/3MU9ZpJMdW7Y1GKUcxOnuEyBWzbo0txnBOd
	RWQGa3hH+Sc7izubIUJxZiDcqbH/nj7U=
X-Gm-Gg: AfdE7cnSoQGN5IJrpbPtyM747LofhG0ELyQCk762tSxzVCgJIUq7DATS7gDeroPKg57
	L+mi+OipqHTSE16hBxL0zj6olzBTrksxHvITfXJYIaqMv1p8zBQzZtcEQF7OD5SFXHglt/P1ohn
	o60huz0amKiI38PAEolqQ1xMDtWAocS/hL5fqoTj6p7RFum2bqcC8sRT6VqOz3nFKKofh4ERvR2
	cTPKaJOvIqnlZLgUZhADyDyCKoSFS245eGwVUA9C2Sw1C5qup95SqQ55Mq/fEsSc1xis6jzTbBP
	enLm7ZvlUKCpQa0js2vQ4JkQurwOj54tG9nKz+nphPOhKKcFnjoDZjuOPmXgw0VmdGMjCADfsb8
	2dBROL4Cj4jeafs8AyEyT9q4=
X-Received: by 2002:a05:7301:608e:b0:30c:a4bb:71c9 with SMTP id
 5a478bee46e88-30ca4bb7593mr2120179eec.0.1782563213899; Sat, 27 Jun 2026
 05:26:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626183630.2585057-1-dakr@kernel.org> <20260626183630.2585057-3-dakr@kernel.org>
In-Reply-To: <20260626183630.2585057-3-dakr@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 27 Jun 2026 14:26:40 +0200
X-Gm-Features: AVVi8CfTJDNVo1KxD-2qMWkEFrV45PAxG53CiKejEkAqP1d75q9UdnCynZyU0Y4
Message-ID: <CANiq72=0OOgc6NtbpF0Ysdk3ytRWCGGbWg00u0Le2AzQmKGKxg@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] rust: types: introduce ForLt base trait for CovariantForLt
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, acourbot@nvidia.com, ecourtney@nvidia.com, 
	m.wilczynski@samsung.com, david.m.ertman@intel.com, ira.weiny@intel.com, 
	leon@kernel.org, daniel.almeida@collabora.com, bhelgaas@google.com, 
	kwilczynski@kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9434-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:dakr@kernel.org,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:acourbot@nvidia.com,m:ecourtney@nvidia.com,m:m.wilczynski@samsung.com,m:david.m.ertman@intel.com,m:ira.weiny@intel.com,m:leon@kernel.org,m:daniel.almeida@collabora.com,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:driver-core@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:rust-for-linux@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[miguelojedasandonis@gmail.com,linux-pwm@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,nvidia.com,samsung.com,intel.com,collabora.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 763386D1EC4

On Fri, Jun 26, 2026 at 8:36=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> Add a new ForLt trait as a base for CovariantForLt:
>
>   - ForLt (non-unsafe): represents a type generic over a lifetime, with
>     no covariance guarantee.
>
>   - CovariantForLt (unsafe): becomes a subtrait of ForLt that
>     additionally proves the type is covariant over its lifetime
>     parameter, providing a safe cast_ref() method.
>
> This split allows non-covariant types (e.g. types behind a Mutex) to
> implement ForLt and participate in DevresLt / registration data patterns
> that use HRTB closures for sound access, without requiring a covariance
> proof that would fail to compile.
>
> Both macros share the UnsafeForLtImpl helper type, distinguished by
> a const generic N: ForLt! emits N =3D 0 (no covariance proof),
> CovariantForLt! emits N =3D 1 (with compile-time covariance proof).
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

If this goes in at the same time as the move (as I assume), then am I
understanding it right that if someone else was using `ForLt`
(trait/macro) things would either break at compile-time (which is OK)
or, in the covariant type case with no `cast_ref()`, it would build,
but someone could in principle have relied on `ForLt` providing the
covariance guarantee in unsafe code?

Acked-by: Miguel Ojeda <ojeda@kernel.org>

We could take the chance to add some missing intra-doc links, but I
can add a good first issue.

Thanks!

Cheers,
Miguel

