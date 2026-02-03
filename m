Return-Path: <linux-pwm+bounces-8034-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDR/DHv5gWk7NQMAu9opvQ
	(envelope-from <linux-pwm+bounces-8034-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 14:34:51 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C13D9EBE
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 14:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 878703050D43
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Feb 2026 13:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB3539E162;
	Tue,  3 Feb 2026 13:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="OA7UxvT7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9631C38E110;
	Tue,  3 Feb 2026 13:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770125668; cv=pass; b=dHVK1UsfdMO2R+2r8Tf+7FQf0GiOrNblTcaGLlb1vz8W8Ov3jKA9JoRm02lJuwGgefi+TQ6Tl8V9sngm9QzonlZRHnO0EUZ5Ph4+Alf7qVDZJOqEgcHvwFe0k6julxUTiOzVKCF0oMrQk58vlg7wsVIv49XaBK9rNH8ZNJs4DO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770125668; c=relaxed/simple;
	bh=ChalByCuTihRfVeCZWRZnvLKjLssr1aGB5DOv9CjXV8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=KGsu2yybnmKRELptOym5fFm2BTG9UD+kTfNLDsdBNp/ESn82JmDNpcib1z4Bn0gK9bO0bm7xcaWCJSjJYWzusPMZv47x2YETi/+lsF/cmyW2uJTwMEdjxvSC4Mo/v5CYHMTNHOMypLeb1I6wa1aSP2F+Hiq83q79+g8kC3GWnhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=OA7UxvT7; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1770125637; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=C1GbKPfFkTdX3EQDiy0qa9/CKZhWiApFO8NLGPDE6I8dBZr+hSDQJjBYjD31uKofyr4BKwbxxzHy8In87h6bMY1wNCN8bcAxmsKbIUrWXCXS52Edu6f3aMgYCMgdWmxsKtw9XTlgFkjP26XQ1TQKpDrFJ7oYRU5upEkDtiBGjRM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770125637; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=HyBOdQqWUtuQacZEEr3ql23BswwmLu6r6afyPnxrMoA=; 
	b=N2r0FU1b18zkOKUUhM4R7bNfxM8CRkG9/BoQJNg6pFKNLIfmNbzwCZ1Ui5mCUfzsDA0cVUgYDD981n6nvWwuf0ocKvEIpSZ39v/PuqKz6I2Ni/BDaX02EShynz35Uus3gdhAy27jYUFSxjXv0/2PMVJbjNRzC6lsk/UFDAJ7YcI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770125637;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=HyBOdQqWUtuQacZEEr3ql23BswwmLu6r6afyPnxrMoA=;
	b=OA7UxvT7iiUq1OUz1gxbHI8H2/t6OL0y+g8hem3/mGpjMJ37P3mnyQWH28GnvFKs
	NkbuY3U7FX8T5dN3q8TC6MzsJU/jZxX2IknKIZIpHar1udK5OXVCW5S949s0L9cKpRn
	84RC8g3iE9sRI4ni8Dn3rt9Odhx5CpN3FL93OcXM=
Received: by mx.zohomail.com with SMTPS id 1770125634489679.9066983046164;
	Tue, 3 Feb 2026 05:33:54 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v3 1/3] rust: clk: use the type-state pattern
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260203113902.501e5803@fedora>
Date: Tue, 3 Feb 2026 10:33:34 -0300
Cc: Alice Ryhl <aliceryhl@google.com>,
 Maxime Ripard <mripard@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Drew Fustini <fustini@kernel.org>,
 Guo Ren <guoren@kernel.org>,
 Fu Wei <wefu@redhat.com>,
 =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 linux-riscv@lists.infradead.org,
 linux-pwm@vger.kernel.org,
 linux-clk@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E7286D12-0BD9-4726-B072-FE5A040312B1@collabora.com>
References: <20260107-clk-type-state-v3-0-77d3e3ee59c2@collabora.com>
 <20260107-clk-type-state-v3-1-77d3e3ee59c2@collabora.com>
 <20260108-delectable-fennec-of-sunshine-ffca19@houat>
 <98CD0BF6-3350-40B9-B8A9-F569AE3E3220@collabora.com>
 <20260119-thundering-tested-robin-4be817@houat> <aW4lCfUyumOKRRJm@google.com>
 <20260203113902.501e5803@fedora>
To: Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8034-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,linaro.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,redhat.com,baylibre.com,garyguo.net,protonmail.com,umich.edu,vger.kernel.org,lists.freedesktop.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.almeida@collabora.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm];
	APPLE_MAILER_COMMON(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,collabora.com:email,collabora.com:dkim,collabora.com:mid,gitlab.freedesktop.org:url]
X-Rspamd-Queue-Id: 96C13D9EBE
X-Rspamd-Action: no action

Hi Boris,

> On 3 Feb 2026, at 07:39, Boris Brezillon =
<boris.brezillon@collabora.com> wrote:
>=20
> On Mon, 19 Jan 2026 12:35:21 +0000
> Alice Ryhl <aliceryhl@google.com> wrote:
>=20
>> On Mon, Jan 19, 2026 at 11:45:57AM +0100, Maxime Ripard wrote:
>>> On Thu, Jan 08, 2026 at 11:14:37AM -0300, Daniel Almeida wrote: =20
>>>>> For example, it's quite typical to have (at least) one clock for =
the bus
>>>>> interface that drives the register, and one that drives the main
>>>>> component logic. The former needs to be enabled only when you're
>>>>> accessing the registers (and can be abstracted with
>>>>> regmap_mmio_attach_clk for example), and the latter needs to be =
enabled
>>>>> only when the device actually starts operating.
>>>>>=20
>>>>> You have a similar thing for the prepare vs enable thing. The =
difference
>>>>> between the two is that enable can be called into atomic context =
but
>>>>> prepare can't.
>>>>>=20
>>>>> So for drivers that would care about this, you would create your =
device
>>>>> with an unprepared clock, and then at various times during the =
driver
>>>>> lifetime, you would mutate that state. =20
>>=20
>> The case where you're doing it only while accessing registers is
>> interesting, because that means the Enable bit may be owned by a =
local
>> variable. We may imagine an:
>>=20
>>    let enabled =3D self.prepared_clk.enable_scoped();
>>    ... use registers
>>    drop(enabled);
>>=20
>> Now ... this doesn't quite work with the current API - the current
>> Enabled stated owns both a prepare and enable count, but the above =
keeps
>> the prepare count in `self` and the enabled count in a local =
variable.
>> But it could be done with a fourth state, or by a closure method:
>>=20
>>    self.prepared_clk.with_enabled(|| {
>>        ... use registers
>>    });
>>=20
>> All of this would work with an immutable variable of type =
Clk<Prepared>.
>=20
> Hm, maybe it'd make sense to implement Clone so we can have a =
temporary
> clk variable that has its own prepare/enable refs and releases them
> as it goes out of scope. This implies wrapping *mut bindings::clk in =
an
> Arc<> because bindings::clk is not ARef, but should be relatively easy
> to do. Posting the quick experiment I did with this approach, in case
> you're interested [1]
>=20
> =
[1]https://gitlab.freedesktop.org/bbrezillon/linux/-/commit/d5d04da4f4f619=
2b6e6760d5f861c69596c7d837

The problem with what you have suggested is that the previous state is =
not
consumed if you can clone it, and consuming the previous state is a =
pretty key
element in ensuring you cannot misuse it. For example, here:

let enabled_clk =3D prepared_clk.clone().enable()?;
// do stuff
// enabled_clk goes out of scope and releases the enable
// ref it had

prepared_clk is still alive. Now, this may not be the end of the world =
in this
particular case, but for API consistency, I'd say we should probably =
avoid this
behavior.

I see that Alice suggested a closure approach. IMHO, we should use that
instead.

=E2=80=94 Daniel=

