Return-Path: <linux-pwm+bounces-8041-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIW5DDkHgmn2OAMAu9opvQ
	(envelope-from <linux-pwm+bounces-8041-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 15:33:29 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1519DAA31
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 15:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B31F3015BAD
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Feb 2026 14:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCA93AA1A3;
	Tue,  3 Feb 2026 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="e8RhOKAm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522E5267714;
	Tue,  3 Feb 2026 14:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770129207; cv=none; b=qT0AeD64TQITwRy4G2FTIJ52WjFXRYiC2DI0/IehM8bTaNd7tD3vc8sqPc0/2LgCLsJvvaxF2KFV00rirboKJJ5ro+4ED9SDdX9IZ0H7XhKajBk+2SBxSUiiTZdXSAuKP/OGhnT8himbGRp4Gj0nOUKeTiZ0b1EHF98EutnTdS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770129207; c=relaxed/simple;
	bh=GE45IF9BTKapMK7Wz2pnLi4JhSkRouCp88scmTlp9SM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MsgejdlGIiqDClSCHiLd4aVKrFFE05TellLHBKmG0mj8NNpJx0+FNBIlwvfXqp8yvVB8uFOYsG/P0pHWgXkaDdT70yQL3BpNktAt+sYVvXr174xttaJtbUUYcVyFCLsWfTEobEUivhNfBcR5jnYUJBC+sENLhGeWnNw78CoLAys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=e8RhOKAm; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1770129203;
	bh=GE45IF9BTKapMK7Wz2pnLi4JhSkRouCp88scmTlp9SM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e8RhOKAmEl/cYUyU+pzDXzhJqm83CEQFc02TaliSQk/VzcvUmxLX0xW2ZErKFCNxL
	 9kfyHU5HbpTnKv3JoulgswfcjyFXghUm7Wun2EPutZESsk5kRG027tZEBu2vZXdrr0
	 g5T+SHDwRv5fe956N2CjI0e2TJcnu4XulHxJTbxAtb4bQAYGDMn2XSavR2jm0xewmA
	 jlRP89gF0Ko7hoFXt1MPk49MDs9kDv9KbhDJA7oW+T2nNCuj3Ov8esbyNqlUKgxw4c
	 uMSowRXaIzIdHYU86bDXassySAthDEi2DxzOI40XA2E66EglVdLDSZAvGYPrxopIyO
	 tQuZNZuOefLvA==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7967017E12E5;
	Tue,  3 Feb 2026 15:33:22 +0100 (CET)
Date: Tue, 3 Feb 2026 15:33:16 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>, Maxime
 Ripard <mripard@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Drew Fustini <fustini@kernel.org>, Guo Ren
 <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Uwe =?UTF-8?B?S2xlaW5lLUs=?=
 =?UTF-8?B?w7ZuaWc=?= <ukleinek@kernel.org>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda
 <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?B?QmrDtnJu?=
 Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org,
 linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 1/3] rust: clk: use the type-state pattern
Message-ID: <20260203153316.3a645635@fedora>
In-Reply-To: <20C2CC23-4558-4490-A5A9-E46AA150E7DD@collabora.com>
References: <20260107-clk-type-state-v3-0-77d3e3ee59c2@collabora.com>
	<20260107-clk-type-state-v3-1-77d3e3ee59c2@collabora.com>
	<20260108-delectable-fennec-of-sunshine-ffca19@houat>
	<98CD0BF6-3350-40B9-B8A9-F569AE3E3220@collabora.com>
	<20260119-thundering-tested-robin-4be817@houat>
	<aW4lCfUyumOKRRJm@google.com>
	<20260203113902.501e5803@fedora>
	<E7286D12-0BD9-4726-B072-FE5A040312B1@collabora.com>
	<DG5DCYIUHCF5.3JL8I7GQ8REI8@garyguo.net>
	<20C2CC23-4558-4490-A5A9-E46AA150E7DD@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8041-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[garyguo.net,google.com,kernel.org,linaro.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,redhat.com,baylibre.com,protonmail.com,umich.edu,vger.kernel.org,lists.freedesktop.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris.brezillon@collabora.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,collabora.com:dkim,gitlab.freedesktop.org:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,garyguo.net:email]
X-Rspamd-Queue-Id: C1519DAA31
X-Rspamd-Action: no action

On Tue, 3 Feb 2026 10:55:05 -0300
Daniel Almeida <daniel.almeida@collabora.com> wrote:

> > On 3 Feb 2026, at 10:42, Gary Guo <gary@garyguo.net> wrote:
> >=20
> > On Tue Feb 3, 2026 at 1:33 PM GMT, Daniel Almeida wrote: =20
> >> Hi Boris,
> >>  =20
> >>> On 3 Feb 2026, at 07:39, Boris Brezillon <boris.brezillon@collabora.c=
om> wrote:
> >>>=20
> >>> On Mon, 19 Jan 2026 12:35:21 +0000
> >>> Alice Ryhl <aliceryhl@google.com> wrote:
> >>>  =20
> >>>> On Mon, Jan 19, 2026 at 11:45:57AM +0100, Maxime Ripard wrote: =20
> >>>>> On Thu, Jan 08, 2026 at 11:14:37AM -0300, Daniel Almeida wrote:   =
=20
> >>>>>>> For example, it's quite typical to have (at least) one clock for =
the bus
> >>>>>>> interface that drives the register, and one that drives the main
> >>>>>>> component logic. The former needs to be enabled only when you're
> >>>>>>> accessing the registers (and can be abstracted with
> >>>>>>> regmap_mmio_attach_clk for example), and the latter needs to be e=
nabled
> >>>>>>> only when the device actually starts operating.
> >>>>>>>=20
> >>>>>>> You have a similar thing for the prepare vs enable thing. The dif=
ference
> >>>>>>> between the two is that enable can be called into atomic context =
but
> >>>>>>> prepare can't.
> >>>>>>>=20
> >>>>>>> So for drivers that would care about this, you would create your =
device
> >>>>>>> with an unprepared clock, and then at various times during the dr=
iver
> >>>>>>> lifetime, you would mutate that state.   =20
> >>>>=20
> >>>> The case where you're doing it only while accessing registers is
> >>>> interesting, because that means the Enable bit may be owned by a loc=
al
> >>>> variable. We may imagine an:
> >>>>=20
> >>>>   let enabled =3D self.prepared_clk.enable_scoped();
> >>>>   ... use registers
> >>>>   drop(enabled);
> >>>>=20
> >>>> Now ... this doesn't quite work with the current API - the current
> >>>> Enabled stated owns both a prepare and enable count, but the above k=
eeps
> >>>> the prepare count in `self` and the enabled count in a local variabl=
e.
> >>>> But it could be done with a fourth state, or by a closure method:
> >>>>=20
> >>>>   self.prepared_clk.with_enabled(|| {
> >>>>       ... use registers
> >>>>   });
> >>>>=20
> >>>> All of this would work with an immutable variable of type Clk<Prepar=
ed>. =20
> >>>=20
> >>> Hm, maybe it'd make sense to implement Clone so we can have a tempora=
ry
> >>> clk variable that has its own prepare/enable refs and releases them
> >>> as it goes out of scope. This implies wrapping *mut bindings::clk in =
an
> >>> Arc<> because bindings::clk is not ARef, but should be relatively easy
> >>> to do. Posting the quick experiment I did with this approach, in case
> >>> you're interested [1]
> >>>=20
> >>> [1]https://gitlab.freedesktop.org/bbrezillon/linux/-/commit/d5d04da4f=
4f6192b6e6760d5f861c69596c7d837 =20
> >>=20
> >> The problem with what you have suggested is that the previous state is=
 not
> >> consumed if you can clone it, and consuming the previous state is a pr=
etty key
> >> element in ensuring you cannot misuse it. For example, here:
> >>=20
> >> let enabled_clk =3D prepared_clk.clone().enable()?;
> >> // do stuff
> >> // enabled_clk goes out of scope and releases the enable
> >> // ref it had
> >>=20
> >> prepared_clk is still alive. Now, this may not be the end of the world=
 in this
> >> particular case, but for API consistency, I'd say we should probably a=
void this
> >> behavior. =20
> >=20
> > Is this an issue though? You cannot mistakenly own `Clk<Enabled>` while=
 the clk
> > is not enabled, (and similarly for `Prepared`), and that should be suff=
icient. =20
>=20
> It is not an issue. However, I just find it a bit confusing. With a types=
tate, one
> usually expects state transitions where a new state fully consumes the pr=
evious
> one, and that assumption is =E2=80=9Cbroken=E2=80=9D in a way when you ad=
d clone().

It's just the way clks work in practice: you having a Clk<Unprepared>
doesn't mean the underlying clk_hw (the C object) is in an unprepared
state, because some other users might point to the same clk_hw and have
it enabled already. What Clk<State> means here is that you have a local
view of a clk that's in at least this State. In order to guarantee that
the clk is at least OtherState, you'll have to transition your view to
this OtherState.

Clone here just means you're cloning a view of this clone in its
original view state. Then you're free to do whatever you want on this
new view. So is the original owner of the object you clone from.

>=20
> >=20
> > Having `Clk<Prepared>` makes no guarantee on if the clk is enabled or n=
ot anyway
> > as you can have another user do `Clk<Unprepared>::get().enable()`. =20
>=20
> Although you=E2=80=99re right here, I find this less confusing than clone=
(). You
> have to explicitly craft a new Clk<Enabled>, where a clone() is a shorter=
 way
> to basically get around the =E2=80=9Cstate transition=E2=80=9D idea on an=
 _existing_ Clk
> reference.

The idea behind the clone() is that you can transition from one state
to an higher state (prepared -> enabled for instance) for a shorter
period of time than the cloned clk lifetime. Something like that, for
instance:

	let MyDevice {
		prepared_clk: Clk::get(...)?.prepare()?,
	}


	implem MyDevice {
		fn do_stuff(&self) {
			let enabled_clk =3D self.prepared_clk.clone();

			// do stuff that need to be guaranteed that clk
			// is enabled
			self.do_other_stuff(enabled_clk);

			// the enabled_clk object is dropped, but the
			// clk remains prepared because
			// self.prepared_clk is still there
		}
	}

