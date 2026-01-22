Return-Path: <linux-pwm+bounces-7987-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0C2ZHWlCcmnpfAAAu9opvQ
	(envelope-from <linux-pwm+bounces-7987-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Jan 2026 16:29:45 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E3768D63
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Jan 2026 16:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA5008AC1C7
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Jan 2026 14:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93DB34106F;
	Thu, 22 Jan 2026 14:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YO4HnkaD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KPUZ9xPj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1242F1F8AC8
	for <linux-pwm@vger.kernel.org>; Thu, 22 Jan 2026 14:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769092781; cv=none; b=cfs9Cu6uEkDOG/jimilMVIo+M6coVTdpf/a7THJsViUJJj8S0z+2OD4mPfPRpjZlkz9wBX9QEaDlPpgPLF2gpTvyTNSFbv5zumE1xHCO9iIuqTY2L/NHZw0veEcsFO6f4nJcYhsc/NOcfzQhBvaJr7gdIjDZSbE/0zqcohYj2lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769092781; c=relaxed/simple;
	bh=AyBx9ppTx2BOTSfVtDmCqmRyEQ5NyXpywR5T7qhsqCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9hkXqRkRdxrsPaeOXZU/KpITm+4ylbC3fwk1MLNh6LYRNAADogMs2H2OU+4d/ldXCpbbDOSReQhTYpRoQuiXD4uy4mQt7JxNvDRPT92QjU8US7TtQLY7DvU7bhnAq25mQynKlBuEAE+YxZdLekep1f9RIFncO0HoaO87aMitT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YO4HnkaD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KPUZ9xPj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769092779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AczRkdluSYBOb5Po7BaEkCw/6UsPxAzciCTctPOT6H8=;
	b=YO4HnkaDTV41JmrBbHppMJ+piOG7p07SbTA6i1hUObxabMhZP6x/V4lxYiIGjQWiCjwjcA
	KGMBf54Jl18ZhoH+8F0wvM8WVhctm8c098T2npWsjwVqHhEsigwq1plqtUyKfEHqynluXL
	Ajmy3h9bQkf4Xa2UxpMp5BACI/rJaNw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-Rv1yEsMiMzGW5fZxLICptA-1; Thu, 22 Jan 2026 09:39:36 -0500
X-MC-Unique: Rv1yEsMiMzGW5fZxLICptA-1
X-Mimecast-MFC-AGG-ID: Rv1yEsMiMzGW5fZxLICptA_1769092775
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4801c1056c7so7794945e9.2
        for <linux-pwm@vger.kernel.org>; Thu, 22 Jan 2026 06:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769092775; x=1769697575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AczRkdluSYBOb5Po7BaEkCw/6UsPxAzciCTctPOT6H8=;
        b=KPUZ9xPjAls+M+TsDjS85T0+OPCLVHQlqfgSluR/1rPjx8i5Otps+dvdSptbh2eAS3
         7OFOaM1f06KA4isS05QEGOP5VvITrR4C9nCdBXiLDJxxWulNJXW7uCt/dQ+HmB79wv9M
         Rxjs/hWFa2DM1idkmzUyuWFeDrLIzppr2lzvdVm7O6w/3urPxANLTaKe8NKLL9MlIyiJ
         h0SYDLhiWm5qG2Udy3ltkqDgFI16eSbmFCT3VmJUcSulTmzQbvKaGUlIttf+toqVnIyQ
         39zsWyBgqtQr5LNTwgFcOFMn3p681sDQFPYAYKLtn43i7fd1SkTue0fOkU8NYrdRmJ27
         hsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769092775; x=1769697575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AczRkdluSYBOb5Po7BaEkCw/6UsPxAzciCTctPOT6H8=;
        b=wc3rJQ7fOCss5utWJBx6mv27tr2lsb/Dev3oFxL1VjmqKG4K94AZVsqJRQW/Mj7Qk0
         Hcp+tQk3gvy/qvM7yFPA62/F6H9iZ3WvcqPpYnVpFb8PulK9clOfz1MIakh+nmO/m/rU
         3Ayi6KdIeN5U6zFMPoqTsF9wajDtbrhghYBVMt2jvlOHZzYYtoa9ceMX4+fV7JDHA/83
         w/gg+HNghoLUbFYGdPXpRnHQk5AdPJGtKKgJgm4o4NYwuWT/n5HGi1zUz3ZjGnUSm5xL
         EVtKwbs+JcOrUugh3L0S0rTW5YEJDIzh3lZd0vaxo6y44I/DM3rIP35iyKn+Ssugor+J
         E5bg==
X-Forwarded-Encrypted: i=1; AJvYcCWy9C/+/HXg9mbml0jhPojR74dA0/4LumdjbEps4UNgW8D4IAozxqly8JNpVKj7pi0IULtKDuncmmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgwnnfVPufVo/jIV7sCg2mXibXfAQHDSaJckyHWLu3Ubxt7aj5
	XAw5gTbjNSv1tehPJdyjy+TwG0QKFKUAyR8+HiF1VIRWQrzxFkAM9j+uG/19Mn02oS1hRTiDtdB
	LMnYzFIGBGgSsNYXYP4dleh2hfVXsKA87LbekinUoJj7AmR0lOfbkbFd14CgAwA==
X-Gm-Gg: AZuq6aJKiT6xLBdamO+eEOlfYhJVCDsisYrl1gcBriRWhRZzngAukUvrTBqnXw83lYv
	IdkLvlO6cFsnX/nfwr2MlmDXwT82UKr5xrn3KCColfcQR4LkQykRbAHDhYHb4dM6abPl67+IlSB
	5VnFZseHs0dfYXEGlt/T0Vk3xKLEOoq+FL9LF/7SKiRbbKlE8y8YxVju7UgIAtzfThJ9QgZUcyV
	ETinTdIRUvlaBlipN6HG2yurdMyGhZhW5SqoP4/uzejVH5HrWSYeaJ/DWUyiMeJrV0L2WebL+ZM
	k0n1BFzzocrW7cOn8Unk2mYxmTP48tbxojyMdz3IWU5DzGcMGXn7DG6otInMPg==
X-Received: by 2002:a05:600c:6388:b0:477:9a28:b0a4 with SMTP id 5b1f17b1804b1-4803e713cc2mr134483005e9.0.1769092775251;
        Thu, 22 Jan 2026 06:39:35 -0800 (PST)
X-Received: by 2002:a05:600c:6388:b0:477:9a28:b0a4 with SMTP id 5b1f17b1804b1-4803e713cc2mr134482615e9.0.1769092774800;
        Thu, 22 Jan 2026 06:39:34 -0800 (PST)
Received: from localhost ([2a01:e0a:b25:f902::ff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804704b712sm69536185e9.8.2026.01.22.06.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 06:39:34 -0800 (PST)
Date: Thu, 22 Jan 2026 15:39:33 +0100
From: Maxime Ripard <mripard@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michal Wilczynski <m.wilczynski@samsung.com>, Richard Genoud <richard.genoud@bootlin.com>
Subject: Re: [GIT PULL] pwm: Two fixes and a maintainer update
Message-ID: <20260122-bold-sticky-wapiti-1dffa2@houat>
References: <ahytfwrx6d7nvddjviqt6wyit6f7flh5vmiuuzdet44unjdbwp@cktsraaj56au>
 <CAHk-=wga8Qu0-OSE9VZbviq9GuqwhPhLUXeAt-S7_9+fMCLkKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="tviorlllw7c6qgpe"
Content-Disposition: inline
In-Reply-To: <CAHk-=wga8Qu0-OSE9VZbviq9GuqwhPhLUXeAt-S7_9+fMCLkKg@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7987-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mripard@redhat.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 13E3768D63
X-Rspamd-Action: no action


--tviorlllw7c6qgpe
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [GIT PULL] pwm: Two fixes and a maintainer update
MIME-Version: 1.0

Hi,

Going a bit off topic here, sorry.

On Tue, Jan 20, 2026 at 10:11:27AM -0800, Linus Torvalds wrote:
> On Tue, 20 Jan 2026 at 01:32, Uwe Kleine-K=F6nig
> <u.kleine-koenig@baylibre.com> wrote:
> >
> >    You might argue that this is an ABI change [..]
>=20
> Pretty much any change can be an ABI change - even totally new
> interfaces change behavior in that something that didn't use to do
> anything now does something.
>=20
> And we've actually very much have had things like that happen too,
> when broken user space did something odd, and adding a completely new
> file in /proc (or something like that) just broke broken user space.
>=20
> And any bugfix that changes visible behavior is also an "ABI change",
> and so there is no practical meaning to the whole otion.
>=20
> So I absolutely detest the whole notion of "ABI changes". It's a
> meaningless concept, and I hate it with a passion, because it then
> results in the "opposite" situation where some projects seem to think
> that ABI changes are perfectly fine as long as they go along with
> version number changes.
>=20
> The Linux rule for regressions is basically based on the philosophical
> question of "If a tree falls in the forest, and nobody is around to
> hear it, does it make a sound?".
>=20
> So the only thing that matters is if something breaks user-*conscious* be=
havior.
>=20
> And when that happens, the distinction between "bug fix" and "new
> feature" and "ABI change" matters not one whit, and the change needs
> to be done differently.
>=20
> Anyway, I agree that the whole "return proper -EFAULT on user copy
> failures" is clearly the right thing to do, and I do not disagree with
> the patch at all.
>=20
> I just wanted to point out that the argument about whether it's an ABI
> change or not is irrelevant. If it turns out that some program - not a
> test script, but something with relevance to conscious user
> expectations - depended on the old broken behavior, then it needs to
> be done some other way.
>=20
> So whether somebody "argues" that the change is an ABI change or not
> is simply not relevant to anything.
>=20
> Obviously some changes are more likely to be user-visible than others,
> so people should take that into account in how careful you need to be
> about a patch.

Where do we draw the line then, if there's any?

I have a particular example in mind with v4l2. With some drivers, and
because pixel order naming is confusing and inconsistent in the media
industry as a whole, we ended up with drivers capturing framebuffers
with the wrong pixel order (blue and red inverted) compared to
documented order for the format they were requesting. And rejecting the
format with the "right" order.

We've been tip-toeing about this to fix it in order to avoid any
regression in some tools.

Should we just consider those drivers "wrong", treat it as a bugfix, and
expect userspace applications to request the format they actually rely
on? Or should we continue what we've tried to do and try to support the
right format, and the old format for backward compatibility?

Thanks!
Maxime

--tviorlllw7c6qgpe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaXI2ngAKCRAnX84Zoj2+
dgJ7AYDpbQJxEMpzWS8HBtJ8aMqO/SOUizvQJyLMA2h9iEHAeYvCFgPMXEGbiBmQ
fIcsr+4Bf39X6wSz5IqJRFOuob8+hzIldI2nbbd9973I69pvV5eiv21BytycP/Is
LQove+Vwug==
=LsnN
-----END PGP SIGNATURE-----

--tviorlllw7c6qgpe--


