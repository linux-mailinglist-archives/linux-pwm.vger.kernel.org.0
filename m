Return-Path: <linux-pwm+bounces-8690-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iD9/NpGl62mrPwAAu9opvQ
	(envelope-from <linux-pwm+bounces-8690-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Apr 2026 19:17:05 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBE0461C40
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Apr 2026 19:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4030C301AA6C
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Apr 2026 17:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D442333E355;
	Fri, 24 Apr 2026 17:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVBywPu0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C7033E346;
	Fri, 24 Apr 2026 17:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050204; cv=none; b=QWUy2XR+E3ZOIudNSVj5TDrk/Nfp45C3d1cwsehAux7ih2bcCA9m06dzkfljSecStEFV2oma0hLnE2X6hg9Q60Y63QqCoL9T10VykGGOL9MUawY42A/p54sAHMpJk9oQvHHjpNNe97GIOQHHzgyJvu1e74V+tdhZeEcK5+dG12M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050204; c=relaxed/simple;
	bh=+zvcRDJW+a8wr84kODBlsWngBSTqsiTt6oprKiUbkd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aryDEWNzJwk6wF/5hSyi909yGlG0E2LrPrft417Amz0uPtiKBMs97Rf00UAbue+DUtX2KdmJMJrI4RHwzJ2sF+6S1bwWn+VuxAt+FdsYoVb17OehDkgrxDupSs95GAulC8KxfSi5Qx35Q5OOuGbDND5dSIcJOzfPTAk7tf64/Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVBywPu0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5A4C19425;
	Fri, 24 Apr 2026 17:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777050204;
	bh=+zvcRDJW+a8wr84kODBlsWngBSTqsiTt6oprKiUbkd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HVBywPu0avecCGEl4Ex/jIh9zWyBDQW54AJyKgh4ySETy+uR2BBcYCMhfny6/eCNn
	 J/mh0acu0C+ysXG+FOLcLItVi+n64tNiEl80aGgOAxoxn42mxrmR/ybpStSmueaiW+
	 ohWw6XHCFCSuY21dut5TvMDB9UK05mAzz7w1J+WbN43OOXLbA7Nmkm6rHakqsKSQjb
	 GcWVoMq4osfY7cBy5yUdUHDOH33ZPVKfd7dTijiYHanMVJP6R10KiuURvRCMYKsQf9
	 qd8AWpkbuYEuIcbN7P3TZ2a8EKqZ+H9XAki7+JYQd1WfIvcsLR+Uq+QcP5Bhxnnrut
	 fjqoUy0wxuBSA==
Date: Fri, 24 Apr 2026 18:03:19 +0100
From: Conor Dooley <conor@kernel.org>
To: dongxuyang@eswincomputing.com
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ben-linux@fluff.org, ben.dooks@codethink.co.uk,
	p.zabel@pengutronix.de, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	xuxiang@eswincomputing.com, wangguosheng@eswincomputing.com,
	pinkesh.vaghela@einfochips.com
Subject: Re: [PATCH v6 1/2] dt-bindings: pwm: dwc: add optional reset
Message-ID: <20260424-these-ozone-687a8ddfb009@spud>
References: <20260424094529.1691-1-dongxuyang@eswincomputing.com>
 <20260424095435.1721-1-dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MEX2CKlYXH7ukGta"
Content-Disposition: inline
In-Reply-To: <20260424095435.1721-1-dongxuyang@eswincomputing.com>
X-Rspamd-Queue-Id: 7EBE0461C40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8690-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCPT_COUNT_TWELVE(0.00)[16]


--MEX2CKlYXH7ukGta
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 05:54:35PM +0800, dongxuyang@eswincomputing.com wro=
te:
> From: Xuyang Dong <dongxuyang@eswincomputing.com>
>=20
> The DesignWare PWM includes separate reset signals dedicated to each clock
> domain:
> The presetn signal resets logic in pclk domain.
> The timer_N_resetn signal resets logic in the timer_N_clk domain.
> The resets are active-low.
>=20
> EIC7700 use DesignWare IP for PWM controllers. Add ESWIN EIC7700 support
>  in snps,dw-apb-timers-pwm2.yaml
>=20
> Signed-off-by: Xuyang Dong <dongxuyang@eswincomputing.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--MEX2CKlYXH7ukGta
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaeuiVwAKCRB4tDGHoIJi
0ke8AQDsqvVmHsVm2RxCKnn08rY1ct5a8O/DE6vT0o1xcb5//wEA4ADri995kMBU
hzrm9A0EEiY/bBMMGL+x9jMSzNfrFwY=
=t87B
-----END PGP SIGNATURE-----

--MEX2CKlYXH7ukGta--

