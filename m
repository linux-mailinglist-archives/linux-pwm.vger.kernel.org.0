Return-Path: <linux-pwm+bounces-8125-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEjiKykFjmnO+gAAu9opvQ
	(envelope-from <linux-pwm+bounces-8125-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Feb 2026 17:51:53 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0662612FA7C
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Feb 2026 17:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55F0A3179605
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Feb 2026 16:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E4335DD01;
	Thu, 12 Feb 2026 16:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddDQr9Ov"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E138224B05;
	Thu, 12 Feb 2026 16:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770914899; cv=none; b=LRUUv7vF/s0AmA6ZFDG6sGejenY0JPt1jMIPixAi4cuLTzsuOr1AVeqKi9P32BNRhrn1taWXYmyPmAJArp56/XFgZR2TRYXrIpYoxLcjkKzVle9TTTYV9kv/qMrO45RrHuaElVV0Vf9/8FiOael9Snmomsp4UxeezuOUb7uYuL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770914899; c=relaxed/simple;
	bh=q+f22IKM+7oDgPx1p+U0JbLKWr29fM3HhKvzV2Lrh0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjloV6TGpwgzEweskTbl7Ze4RShWPuEKtAJ1Dw7j0FKU+qS/M7uaBnN+BjY2M90QMqSA6EDZl+qcKhXBygoUzWFeRG6DUn7Nfh80emhpcdaoz52MzIkL7htfnN3P1QwgTjHLFTStgA55cn30/BeT3nYdJTPKEQFOnTJX6Yb7Gg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddDQr9Ov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF50C16AAE;
	Thu, 12 Feb 2026 16:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770914898;
	bh=q+f22IKM+7oDgPx1p+U0JbLKWr29fM3HhKvzV2Lrh0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ddDQr9Ov0wdCXnzhvnV0xDVdak4L008itDoDOF4wszDGI7EVLjGSWkzMuheE2dvfl
	 dTA9quEB8HyEz9bOHYRgYdVv8yIVUErYv+rtMhUJeV3LcKjZUev+IipEfyyFaZwq4S
	 SZFAr9DslzjIYxe4j9F/uLOJd0txJ/rotJs0JMPc510WLWkQI4128TONMIaCW1ZxM9
	 MBF9IA1Pz8DGZUzMxnfnz5dQot4Ca/mZn/2krB3noNNAxS2DB5VFBqTpGtz/HVu6KC
	 /0ETr+/y5WBOA4vFNthnUZ1sP0xEiHO77jBaqW9Hc7U2Sfnbaf3NJ4UP1LTGZoqLBS
	 eDVXQNTFyH41g==
Date: Thu, 12 Feb 2026 17:48:15 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Danilo Krummrich <dakr@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org, 
	linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 1/3] rust: clk: use the type-state pattern
Message-ID: <20260212-tangible-cormorant-of-art-4cccc1@houat>
References: <20260122-majestic-masterful-jaguarundi-d0abde@houat>
 <2F3D3A40-6EF9-46FC-A769-E5A3AAF67E65@collabora.com>
 <20260204-nickel-seal-of-poetry-8fdefb@houat>
 <91A92D84-1F2E-45F3-82EC-6A97D32E2A78@collabora.com>
 <20260204-angelic-vermilion-beagle-fd1507@houat>
 <20260209105047.693f2515@fedora>
 <20260211-flawless-feathered-boar-0b87ad@houat>
 <CAH5fLgiQE7mJBpAxv6xTVKKFWadg2GdVe31hRM6gNk3Vah61MA@mail.gmail.com>
 <20260212-lumpy-uptight-petrel-cac725@houat>
 <CAH5fLghyg-QzT11gehvwTb2ii4FA-dkse=QtYD0Tc5MT5Dhd7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="dbdpntgsivj6czxx"
Content-Disposition: inline
In-Reply-To: <CAH5fLghyg-QzT11gehvwTb2ii4FA-dkse=QtYD0Tc5MT5Dhd7A@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8125-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[30];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mripard@kernel.org,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[collabora.com,kernel.org,linaro.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,redhat.com,baylibre.com,garyguo.net,protonmail.com,umich.edu,vger.kernel.org,lists.freedesktop.org,lists.infradead.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0662612FA7C
X-Rspamd-Action: no action


--dbdpntgsivj6czxx
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/3] rust: clk: use the type-state pattern
MIME-Version: 1.0

On Thu, Feb 12, 2026 at 03:02:09PM +0100, Alice Ryhl wrote:
> On Thu, Feb 12, 2026 at 2:38=E2=80=AFPM Maxime Ripard <mripard@kernel.org=
> wrote:
> > > If Daniel's proposal is inconvenient for some drivers, it would be far
> > > better to have a third API that is both safe and convenient for those
> > > drivers.
> >
> > Yeah, I guess I was expecting that one to come after we have a few
> > unsafe drivers using it and we do need to consolidate / make it safe.
>=20
> For most things, we implemented and used the safe API from the very
> start. I'm not going to say there are never exceptions to that because
> there *are* exceptions. But I don't really see why clk should be one
> of them.

Ack. As long as we keep the door open for such an API, I'm ok with it then.

Maxime

--dbdpntgsivj6czxx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaY4ESwAKCRAnX84Zoj2+
dgMGAYDwVhpcVy2I/4At/4AEhe8kCxuQ+xhKgZNEU8NDV2gD3fruRA3uVDT/oLFc
w7Hr2JQBf3j9aeMFs5MIgwYTmWIdKIEKAoAdpfPF2hrWVPdhIpmKgffsPCQiOzu7
lF/MDm8OZw==
=DOmR
-----END PGP SIGNATURE-----

--dbdpntgsivj6czxx--

