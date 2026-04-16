Return-Path: <linux-pwm+bounces-8624-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cD/xMXM/4WmaqgAAu9opvQ
	(envelope-from <linux-pwm+bounces-8624-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2026 21:58:43 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 334FF41464D
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2026 21:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7AD6302CB3A
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2026 19:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962523ED135;
	Thu, 16 Apr 2026 19:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDb2lX/u"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755423ED5C8;
	Thu, 16 Apr 2026 19:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776369240; cv=none; b=uGmirUFfhAN9w+LgVK4GPbi0WW+2+sbzjS7KyfKwqute8ypuu1AWQkcti91voEZ7dMKI66LEeoCTXRU8ftHSVQ7jSGQc3jOcn6yhEdpVUMoOoLKpq36z0ueMclU6TGcUbfNvVi07T+MgUf2P6PadiluNfsF7UNy2x3wMnj1fKd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776369240; c=relaxed/simple;
	bh=bdrgUpLv4Yx4lHu+3+pqe3aRgMPAEQa18wcoOo5mqdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKhbOgwcZRxXvN0tJ6tM0UkltoM6uPQl4j2uEjPzJBau1jov04FvQN2x7einqFwL4PaRfEwIVlbgwoDIGzWQPVRyAHy8b5JuUwbkf11sXNTSZ9ZK86CHr8AqTq0lrDsQaUSdQ6os1pTBj4qvjiwRX7rLR4GzOV3+/HHwgCiXSPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDb2lX/u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DDB8C2BCAF;
	Thu, 16 Apr 2026 19:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776369239;
	bh=bdrgUpLv4Yx4lHu+3+pqe3aRgMPAEQa18wcoOo5mqdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cDb2lX/uFXCvwNxzod7p5xxzzlPzlI6GJPbjQ9VuMatEJgbgQ8W92/0k5/7laym6N
	 UVqQxGSGvm+48oztB/vFEEtE+wHXtsn5L9ZMjYQa1ohA0lreOPL8kYPlblbolLvJsR
	 BoD7dA/aaXbmT3A/aoMtgS3Xpou+zd0T3prlp1sNoi+DTGiME12azA8zC6kihZ9IaO
	 aKI7tyG47G0PE6cRU4YPv/ePg5NKhDlcQ/ibGbp2nYebURtEP+QWr05oF06FNmg2HY
	 JyR3VzqlbO1FUpTczew4I3VSZSqguukFutPNB8G0MWnmSekA2muh5udpLuMbY3PvRh
	 XKv976WY4vLwA==
Date: Thu, 16 Apr 2026 21:53:56 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: dongxuyang@eswincomputing.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	ben-linux@fluff.org, ben.dooks@codethink.co.uk, p.zabel@pengutronix.de, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ningyu@eswincomputing.com, linmin@eswincomputing.com, xuxiang@eswincomputing.com, 
	wangguosheng@eswincomputing.com, pinkesh.vaghela@einfochips.com
Subject: Re: [PATCH v4 1/2] dt-bindings: pwm: dwc: add reset optional
Message-ID: <aeE-D5vC453uqtm6@monoceros>
References: <20260415094908.1539-1-dongxuyang@eswincomputing.com>
 <20260415095020.1597-1-dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2u45m4lertypw5tb"
Content-Disposition: inline
In-Reply-To: <20260415095020.1597-1-dongxuyang@eswincomputing.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8624-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCPT_COUNT_TWELVE(0.00)[15]
X-Rspamd-Queue-Id: 334FF41464D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--2u45m4lertypw5tb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v4 1/2] dt-bindings: pwm: dwc: add reset optional
MIME-Version: 1.0

Hello,

I suggest

	dt-bindings: pwm: dwc: Add optional reset

as shortlog.

Best regards
Uwe

--2u45m4lertypw5tb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnhPlIACgkQj4D7WH0S
/k5StQgAuTx6lia9ofAcFhpDHln2LmLcS3WZ0H8ggZy1bqhM+5QDp0qSwazuObMa
xbDInbNl1N6pDgTYdao8NMaCoVBjoufST2g/BaxW2bnIvq3OgECHMK09+pW25YGa
/Zl0q35Sgh/qmP8ESTHBhqvbBcKKPjxmjBo8BrHWOsMxbfkjJmbElmZPl0F4yT1A
u0MLFqV5C44yWMDNUzqIKlEZQaYRuSDCjLQyW4su09F8omrL0JbfC/Fd+QOxj15w
kcyofJwq2NpiylDBbgQl8HSPpS3JpBIgGf5TnkzJMMP1dzrGgcjSGcn81cHD6zXX
mA7KIiMddfldiaEK6H9/mO4hwJyzEw==
=cqJh
-----END PGP SIGNATURE-----

--2u45m4lertypw5tb--

