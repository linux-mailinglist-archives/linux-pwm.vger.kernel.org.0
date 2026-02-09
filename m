Return-Path: <linux-pwm+bounces-8107-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJ3LBCuviWndAgUAu9opvQ
	(envelope-from <linux-pwm+bounces-8107-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 09 Feb 2026 10:55:55 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D2810DD67
	for <lists+linux-pwm@lfdr.de>; Mon, 09 Feb 2026 10:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05CAF30547DA
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Feb 2026 09:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B561536606C;
	Mon,  9 Feb 2026 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GAl5PSI0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C353366054;
	Mon,  9 Feb 2026 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770630661; cv=none; b=V7kuQsFYLz3TaGl8qlqpPKItfRq4t1RY3US6gBzjNkAyj8bOs6v+dfuHjQ9e+4jny0qAm6AdVhaKqUuiNB5w5BEYSLVlAsz6nTtK9dtx/VVr4Dyngb7E9IO93Cy6fYnoEcuh4yMvrGUHj6/NJPwaYJhNsZX1j1+2pqpNhN+QmRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770630661; c=relaxed/simple;
	bh=lg8CE3wdX+dcJL6yDeqGzT+IDyDi7+zFMbcdS7bHqvY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SL64xOU/lhztYU2quyLTJhPytfmKQEwNM9+v69emsPTFHDrG20e3BNoCx+mfGyNM6hXe9H2Ak/nHec+2gduTJO8xudfR/n7lRXT0Q+rdca42Q1r3GxGjSWKH8IuG/ho0EQWakppUeJg9jFcmoEYrO8VfFqtQUr8WGZ5ArsB1RNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GAl5PSI0; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1770630653;
	bh=lg8CE3wdX+dcJL6yDeqGzT+IDyDi7+zFMbcdS7bHqvY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GAl5PSI0gxZCB4fRfIXmb+OCpJY8qNOwXLz9veN8T1muQZoP1SLZuyEN5jFkvF2vC
	 ipEp3b4sMip86VDrIuyv0saU6cadpiIbCjLXvBVVbeZAQqEsKVjT0taFlrKIdQOG5o
	 OZQLZf2qXFX+xYlx0veU9pFtFvMJZFR5drDK3SDbpdlXo4c3lYspdavKG7jiw9NlZW
	 xa/6D7KeI3iQ35tMqN3uTY1pHR6VVhFsLSaG8GVpX+qBCwtkSmIJAVf9ZN5odCFfCe
	 6XncsOBtXX+6Ns4d6I4xWWAvxrKDHBZuGV6cEunws0xUFhCtHMLYrEcFSnZW8x55/J
	 GOPQBqzU8Vu7A==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F334C17E12C5;
	Mon,  9 Feb 2026 10:50:51 +0100 (CET)
Date: Mon, 9 Feb 2026 10:50:47 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Danilo Krummrich
 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Drew Fustini <fustini@kernel.org>, Guo Ren
 <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Uwe =?UTF-8?B?S2xlaW5lLUs=?=
 =?UTF-8?B?w7ZuaWc=?= <ukleinek@kernel.org>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda
 <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
 <gary@garyguo.net>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org,
 linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 1/3] rust: clk: use the type-state pattern
Message-ID: <20260209105047.693f2515@fedora>
In-Reply-To: <20260204-angelic-vermilion-beagle-fd1507@houat>
References: <20260119-thundering-tested-robin-4be817@houat>
	<aW4lCfUyumOKRRJm@google.com>
	<518D8B09-B9A1-4DB4-85CD-37A2DD3D5FB1@collabora.com>
	<DFSLCI9U4NCW.2HI2UPUI7G134@kernel.org>
	<20260119-weightless-pelican-of-anger-190db0@houat>
	<DFSN4FDCYHMW.3J3237PEBV2ZP@kernel.org>
	<20260122-majestic-masterful-jaguarundi-d0abde@houat>
	<2F3D3A40-6EF9-46FC-A769-E5A3AAF67E65@collabora.com>
	<20260204-nickel-seal-of-poetry-8fdefb@houat>
	<91A92D84-1F2E-45F3-82EC-6A97D32E2A78@collabora.com>
	<20260204-angelic-vermilion-beagle-fd1507@houat>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8107-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[collabora.com,kernel.org,google.com,linaro.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,redhat.com,baylibre.com,garyguo.net,protonmail.com,umich.edu,vger.kernel.org,lists.freedesktop.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris.brezillon@collabora.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,collabora.com:dkim]
X-Rspamd-Queue-Id: 70D2810DD67
X-Rspamd-Action: no action

Hi Maxime,

On Wed, 4 Feb 2026 15:34:29 +0100
Maxime Ripard <mripard@kernel.org> wrote:

> On Wed, Feb 04, 2026 at 09:43:55AM -0300, Daniel Almeida wrote:
> > > I'm probably missing something then, but let's assume you have a driv=
er
> > > that wants its clock prepared and enabled in an hypothetical enable()
> > > callback, and disabled / unprepared in a disable() callback.
> > >=20
> > > From a PM management perspective, this usecase makes total sense, is a
> > > valid usecase, is widely used in the kernel, and is currently support=
ed
> > > by both the C and Rust clk APIs.
> > >=20
> > > The only solution to this you suggested so far (I think?) to implement
> > > this on top of the new clk API you propose is to have a driver specif=
ic
> > > enum that would store each of the possible state transition. =20
> >=20
> > Yes, you need an enum _if_ you want to model transitions at runtime. II=
UC you
> > only need two variants to implement the pattern you described. I do not
> > consider this  =E2=80=9Cboilerplate=E2=80=9D, but rather a small cost t=
o pay. =20
>=20
> A maintenance cost to pay by every driver is kind of the textbook
> definition of boilerplate to me.
>=20
> > I would understand if this was some elaborate pattern that had to be
> > implemented by all drivers, but a two-variant enum is as
> > straightforward as it gets. =20
>=20
> And yet, that framework has dozens of helpers that do not remove
> anything from drivers but a couple of lines. So surely its users must
> find value in reducing that boilerplate as much as possible. And you do
> implement some of them, so you must find value in that too.
>=20
> > > That's the boilerplate I'm talking about. If every driver wanting to
> > > implement that pattern has to make such an enum, with all the relevant
> > > traits implementation that might come with it, we go from an API where
> > > everything works at no-cost from a code-size perspective to a situati=
on
> > > where every driver has to develop and maintain that enum. =20
> >
> > There are no "traits that come with it". It's just an enum, with two
> > variants.
> >  =20
> > > API where everything works at no-cost =20
> >=20
> > The previous API was far from =E2=80=9Ceverything works=E2=80=9D. It wa=
s fundamentally
> > broken by design in multiple ways, i.e.: =20
>=20
> Out of context and not what I meant, but ok.
>=20
> > > a) It only keeps track of a count to clk_get(), which means that user=
s have
> > > to manually call disable() and unprepare(), or a variation of those, =
like
> > > disable_unprepare().
> > >=20
> > > b) It allows repeated calls to prepare() or enable(), but it keeps no=
 track
> > > of how often these were called, i.e., it's currently legal to write t=
he
> > > following:
> > >=20
> > > clk.prepare();
> > > clk.prepare();
> > > clk.enable();
> > > clk.enable();
> > >=20
> > > And nothing gets undone on drop(). =20
> >=20
> > IMHO, what we have here is an improvement that has been long overdue. =
=20
>=20
> Nothing is absolute. It is indeed an improvement on the refcounting side
> of things and general safety of the API for the general case. I don't
> think I ever questionned that.
>=20
> However, for the use-cases we've been discussing (and dozens of drivers
> implementing it), it also comes with a regression in the amount of code
> to create and maintain. They used to be able to only deal with the Clk
> structure, and now they can't anymore.
>=20
> You might find that neglible, you might have a plan to address that in
> the future, etc. and that's fine, but if you can't acknowledge that it's
> indeed happening, there's no point in me raising the issue and
> continuing the discussion.


Okay, let's see if I can sum-up the use case you'd like to support. You
have some PM hooks, which I'm assuming are (or will be) written in
rust. It will probably take the form of some Device{Rpm,Pm} trait to
implement for your XxxDeviceData (Xxx being the bus under which is
device is) object (since I've only recently joined the R4L effort, I
wouldn't be surprised if what I'm describing already exists or is
currently being proposed/reviewed somewhere, so please excuse my
ignorance if that's the case :-)).

The way I see it, rather than having one enum per clk/regulator/xxx
where we keep track of each state individually, what we could have is a

trait DevicePm {
	type ResumedState;
	type SuspendedState;

	fn resume(&self, state: SuspendedState) -> Result<ResumedState, Error<Susp=
endedState>>;
	fn suspend(&self, state: SuspendedState) -> Result<SuspendedState, Error<R=
esumedState>>;
};

enum DeviceState<T: DevicePm> {
	Resumed(T::ResumedState),
	Suspended(T::SuspendedState),
};

and then in your driver:

MySuspendedDeviceResources {
	xxx_clk: Clk<Unprepared>,
};

MyResumedDeviceResources {
	xxx_clk: Clk<Enabled>,
};

implem DevicePm for MyDevice {
	type ResumedState =3D MyResumedDeviceResources;
	type SuspendedState =3D MySuspendedDeviceResources;

	fn resume(&self, state: SuspendedState) -> Result<ResumedState, Error<Susp=
endedState>> {
		// FIXME: error propagation not handled
		let enabled_clk =3D state.xxx_clk.clone().prepare()?.enable()?;

		Ok(ResumedState {
			xxx_clk: enabled_clk,
		});
	}

	fn suspend(&self, state: ResumedState) -> Result<SuspendedState, Error<Res=
umedState>> {
		// FIXME: error propagation not handled
		let unprep_clk =3D state.xxx_clk.clone().disable().unprepare();

		Ok(SuspendedState {
			xxx_clk: unprep_clk,
		});
	}
};

With this model, I don't think Daniel's refactor goes in the way of more
generalization at the core level, it's just expressed differently than
it would be if it was written in C. And I say that as someone who struggles
with his C developer bias every time I'm looking at or trying to write
rust code.

As others have said in this thread (Danilo and Gary), and after having
played myself with both approaches in Tyr, I do see this shift from manual
prepare/enable to an RAII approach as an improvement, so I hope we can
find a middle-ground where every one is happy.

Regards,

Boris

