Return-Path: <linux-pwm+bounces-8882-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEqHLN7hBmrVogIAu9opvQ
	(envelope-from <linux-pwm+bounces-8882-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 15 May 2026 11:05:34 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4928B54BFC9
	for <lists+linux-pwm@lfdr.de>; Fri, 15 May 2026 11:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2B31F303AFA4
	for <lists+linux-pwm@lfdr.de>; Fri, 15 May 2026 09:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB044279F2;
	Fri, 15 May 2026 09:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2+U6Cbb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E715A3E4C7F;
	Fri, 15 May 2026 08:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778835600; cv=none; b=QaGvjzFgqWQRhQpBmt2xP5BXD7DwEdVKFqEr80IIEqRSjWNpHSSdxw85Vd5/0dytkWlo+ruAZNU6bA2sTAD7HR3BzhcZDrze+r5CvAlBQjnP5rsFvdfe/bkMFsD+iQ9VGnbonVLMiPiDc6QKuWFam7JPD9yAeiqut4xD3msoBBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778835600; c=relaxed/simple;
	bh=b6e0q5E/Z3lguAgVGLZBgj8nkX7SNZuRIxj/ZXgF52A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aROBsdI/IzYlOLVCDhMPOXUZTG5W+6A2fdoJJ212OnXhxYU27wjlFLeyuItZEa0zP3MXBMW99KRoTugD73WdwEmujRAFxZy/VPERLlyXK00EKIkrq0xVMwq1Q70zsbm2qbuLqAKCgAfrt3cILUJoyG95wfkA1EGe2uukeFInijM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2+U6Cbb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40770C2BCB0;
	Fri, 15 May 2026 08:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778835599;
	bh=b6e0q5E/Z3lguAgVGLZBgj8nkX7SNZuRIxj/ZXgF52A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W2+U6Cbb0T2fH/KE8jemF3oQapwHqnAMjJH/w/wJM2wuz+W0eYQBqGA+b/TA1KkEG
	 gVnIqrqMFFrfQh/PCgWCuUn6uCX96qTEi2WlEcmS34WVrrRhTGwT+EAUy8vVAw/8dp
	 lLuZfdQbl3AhdkxtFppY0xAmUZrXhi/1pIsElDO6qB2SjPgpKLvyHEIWRogk5Eyftt
	 Jev9+HypDtQ/sYDVc083yEQP3wPuLmkhKqfmbZdXOO6cSW71Vq5rS20Wb/+otdnmZf
	 ngpMdF2XEkVOzUscjwLRCgLm5B+lQ6KlRopS8kmFs7ipfrQFob+qcJ6DUHNzrooWVa
	 Kry11b78B3m0Q==
Date: Fri, 15 May 2026 10:59:56 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Yixun Lan <dlan@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Subject: Re: [PATCH v2 0/2] pwm: spacemit: Add Support for K3 SoC
Message-ID: <agbgG00YENm388dd@monoceros>
References: <20260428-03-k3-pwm-drv-v2-0-a532bbe45556@kernel.org>
 <20260514233448-GKA3663945@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w6hgagzjjsephwbw"
Content-Disposition: inline
In-Reply-To: <20260514233448-GKA3663945@kernel.org>
X-Rspamd-Queue-Id: 4928B54BFC9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8882-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action


--w6hgagzjjsephwbw
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/2] pwm: spacemit: Add Support for K3 SoC
MIME-Version: 1.0

On Thu, May 14, 2026 at 11:34:48PM +0000, Yixun Lan wrote:
> Hi Uwe Kleine-K=F6nig,
>   Can you queue this one for v7.2? I'm sending the DTS part patch
> and got a complaint for "clock definitions violation"

I applied it to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

now.

Best regards
Uwe

--w6hgagzjjsephwbw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoG4IoACgkQj4D7WH0S
/k7IaQf/RwVZrA1y/tuywL9sMmr3+vfppD8jAunAr0bdirOJvxIVq6Xwbbt1UqL3
x/9+O0qbc+5XUMvwuEc5Sr8XbBiXdY4igJAgS1m/1Up4NIh10qKTiavgCJPGzxor
yUAhKOazg3JUc8TnAY9gYM3A9y4/r2+S/DIKIiYWFDlhjMwYjpQe7IgxtVK+LSjQ
fR81u9XDcqbbnUFd73KU4nVg5bazaK/lTGeTTqoCcdLotfBsASVT5FIMHnoRcNSK
hauzn7Q/YsmrNeyZf/4cd29Ff7EMcOqZnryTnHzoWU4dwCdRP1dUPIdlpHf1P0al
RIDvOVzN1JV9I5J5sULdZZt+H1RatA==
=SHGP
-----END PGP SIGNATURE-----

--w6hgagzjjsephwbw--

