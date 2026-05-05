Return-Path: <linux-pwm+bounces-8790-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HwoMU95+mlOPQMAu9opvQ
	(envelope-from <linux-pwm+bounces-8790-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 06 May 2026 01:12:15 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0474D494A
	for <lists+linux-pwm@lfdr.de>; Wed, 06 May 2026 01:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5940D3013697
	for <lists+linux-pwm@lfdr.de>; Tue,  5 May 2026 23:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF8A33342C;
	Tue,  5 May 2026 23:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLeKvUQ4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CAA30B521;
	Tue,  5 May 2026 23:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778022732; cv=none; b=sbvbl01GeWIo+OzS0fpwIXU2mOJPQ+Rq4A5NltOe5ET/cZAfvccJ+M0BUcCVysCnkBPZa1AD3rVMjHTtqhOdU2Y+CC39a0NE9/D/Chwo3U0cFTrcs03gY947sBw5nndp9kTo1KbJKttPdl63nsLtEw3P5SrqyTKkOuGr5tbH4Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778022732; c=relaxed/simple;
	bh=KphMG9jiVB2OJLAMUTdfTkFkyrHOjO80/tesl+RVVT4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=bS8n1hb04G6W9VEqvfoL/Z8ltgsNKypqS3HtbbbuVQaYybnpTS2jDmy0hG96dZpXLwsAJDhWTfsMkvuc1kBnh5KukRY1+ZYdBlWoYN0S6v51UZjLrnGld/ymblwTy8WgpCU/M0Y2N8QDCZX+DKOvfV0XRpSZxyCmNWE5AO5yUv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLeKvUQ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA06C2BCB4;
	Tue,  5 May 2026 23:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778022732;
	bh=KphMG9jiVB2OJLAMUTdfTkFkyrHOjO80/tesl+RVVT4=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=nLeKvUQ4j8NIWpLtl1VhRpd7s/lcvYTFSFEoiUp9vRAz62tcyYHXsUPNFhXmV8TDe
	 G7q956NMUdSYHXKkOdo7is74GUwJULIsEK+a275FEgVuiTLveWpR+rkehdw8gnQCkA
	 fdv/djTHNVNdosNV21qzbhndSyB70D+tz8zTT/pBV5zxlP0v+2Oy8DEiMMlMfrROKZ
	 euUccuMQeFMdz5SfhBooRT+NpOTI5VCf0IgX/95pYP6Niz6/2x/GK0pgJ8uKzEsJlo
	 8u0Ic+b5QLdBuIkGDKm1GJqzejs8qnbsZZdSel9xT3nYWTsum3Xmk2jWyIWL+nm0BW
	 gJlAK9RKF9MMQ==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 06 May 2026 01:12:05 +0200
Message-Id: <DIB4GBS45L86.LTUCNRDL24Y3@kernel.org>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <aliceryhl@google.com>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <viresh.kumar@linaro.org>,
 <m.wilczynski@samsung.com>, <ukleinek@kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <abdiel.janulgue@gmail.com>,
 <robin.murphy@arm.com>, <markus.probst@posteo.de>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Deborah Brouwer" <deborah.brouwer@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH REF 24/24] gpu: drm: tyr: use HRT lifetime for IoMem
References: <20260427221155.2144848-1-dakr@kernel.org>
 <20260427221155.2144848-25-dakr@kernel.org> <afp1rLvvdh_mo_g7@um790>
In-Reply-To: <afp1rLvvdh_mo_g7@um790>
X-Rspamd-Queue-Id: 2D0474D494A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8790-lists,linux-pwm=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Wed May 6, 2026 at 12:56 AM CEST, Deborah Brouwer wrote:
> Is the intended model that DRM drivers keep lifetime-bound resources such=
 as
> IoMem<'bound> only in platform drvdata and access them via Device::drvdat=
a_borrow()?

No, this method is unsafe and intended for busses only, drivers should neve=
r use
it directly.

> Or is the expectation that drm::Driver should also have a lifetime-parame=
terized
> Data associated type?

Exactly, the plan is to have lifetime-parameterized private data on the
drm::Registration, which is available in IOCTLs. The cover letter mentions =
that
briefly:

    A follow-up series extends this to class device registrations, starting=
 with
    DRM, so that class device callbacks (IOCTLs, etc.) can safely access de=
vice
    resources through the separate registration data bound to the registrat=
ion's
    lifetime without Devres indirection.

This becomes possible as I also have patches that protect DRM IOCTLs throug=
h the
drm::UnbindGuard (which is just drm_dev_enter() and drm_dev_exit()). Togeth=
er
with drm_dev_unplug() being called when the drm::Registration is dropped al=
l
IOCTLs are guaranteed to provide a bound scope of the underlying bus device=
 and
hence the device resources in the DRM registration data availble through th=
e
IOCTLs.

I have all those patches ready and I plan to send them this week.

> The reason I ask is that Tyr currently stores an MMIO handle in several a=
reas,
> (firmware, MMU/address-space management, and IRQ handling)  and it does r=
egister
> accesses directly. See what we're trying to do:
> https://lore.kernel.org/rust-for-linux/20260424-b4-fw-boot-v4-v4-0-a5d910=
50789d@collabora.com/

Note that you are not blocked by this, you can always move IoMem<'_> into a
Devres through IoMem::into_devres() and use it without lifetime bounds. But=
 of
course the goal is to make this unnecessary.

> Moving IoMem<'bound> only into platform drvdata would require a big refac=
tor
> to thread &IoMem<'_> through those paths or fetch it from drvdata at each=
 hardware
> access site. So, I wanted to clarify the plan first before I start this w=
ork.

No worries, that'd be the exact opposite of what we want to achieve. :)

