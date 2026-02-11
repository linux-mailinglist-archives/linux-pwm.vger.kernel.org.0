Return-Path: <linux-pwm+bounces-8111-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAPQDPRejGmWlwAAu9opvQ
	(envelope-from <linux-pwm+bounces-8111-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Feb 2026 11:50:28 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B251239C9
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Feb 2026 11:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 309293010502
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Feb 2026 10:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3102936999F;
	Wed, 11 Feb 2026 10:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKm85Uje"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC053542FF;
	Wed, 11 Feb 2026 10:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770806774; cv=none; b=T9hGrK+ZCvzzeYJ5fBa/UnW4w9ScGGlk6RDeyH0dE82SWcArBGgdBB90Cm3OJHAl0vzPHbl7LphjA7L3us/1QEtgwSSuZnlfMRjX2iFJNjwb8ALNUacpOBK98cjxDZM7b2TiZRHnjIbzvVkmihdbQD0IEV2vNr5iu5wF6pn/bvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770806774; c=relaxed/simple;
	bh=2x0IV+kSfIJ0GzDwMyJqVo44FSQyWPaHiFqrTCxYLQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmGQA77AzvkjWiZueDDpZ3EsDIjZ4FRYYU6fzCfGOp0g0y32ey1870QiTVX2BoMmxew0ozbVLY1zoIkl40jK7krtw4H5dypRamvANo/5DVSJZbhWUAylDY7jZLp1kQxa4QrSje/aekh3bNhKSllcPyAh6n981ZwlbYoPcQ3H7KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKm85Uje; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE7DC4CEF7;
	Wed, 11 Feb 2026 10:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770806773;
	bh=2x0IV+kSfIJ0GzDwMyJqVo44FSQyWPaHiFqrTCxYLQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PKm85Uje8dWY1H9cuXmW6csiL+eyoD60a9uAtHnlhI5fjJukm0fbl7q1fDomZAtQN
	 8gV9OwernkT476DFElSwC47tzJGMlyfpQa+1VhjzEwO+c/nOhtb451vDmVhGQd4RAE
	 lQHFW9511iZOo8v020YhRM1shSb5tDhV38n74hQFeXPCWx7N7iqcBrVv8jcw06KzjH
	 cds10Y7ZfChc8DRRc2s3S6Vh90CPoTnCcJrmvMi9PQKU7Sy43jXPQODwtgGleUuTE/
	 W333pL+fFp3X0OpL+IVgyERtBSrnx+y1+mKaAtFieKEgQEkyJ/RIM+CLsi8mvOKBWT
	 jhJLzf/yAcaeg==
Date: Wed, 11 Feb 2026 11:46:11 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, 
	DRI mailing list <dri-devel@lists.freedesktop.org>, lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com, 
	Richard Weinberger <richard.weinberger@gmail.com>
Subject: Re: PWM implementation in HWMON and backlight
Message-ID: <aYxaXmguGRk1pWpT@monoceros>
References: <CAFLxGvyhdpQMnW6VqyXjLPKyZSQvrV-+GFdUogV4JX7DiGePyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3g76ma3xf4oo32nw"
Content-Disposition: inline
In-Reply-To: <CAFLxGvyhdpQMnW6VqyXjLPKyZSQvrV-+GFdUogV4JX7DiGePyg@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-8111-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 92B251239C9
X-Rspamd-Action: no action


--3g76ma3xf4oo32nw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: PWM implementation in HWMON and backlight
MIME-Version: 1.0

Hello Guenter,

On Wed, Feb 11, 2026 at 10:28:55AM +0100, Richard Weinberger wrote:
> The backlight of a board I am working with is controlled via PWM.
> Naturally, I thought this would be a straightforward task using the
> pwm-backlight driver.
>=20
> However, the PWM in question is implemented using an NCT6106D chip.
> The associated HWMON driver, nct6775-core.c, does not implement a
> standard PWM device interface but rather its own custom one.

Looking around in drivers/hwmon made me a sad. There are four drivers
that handle parsing #pwm-cells:

	$ git grep pwm-cell drivers/hwmon/
	drivers/hwmon/adt7475.c:        ret =3D fwnode_property_get_reference_args=
(fwnode, "pwms", "#pwm-cells", 0, 0, &rargs);
	drivers/hwmon/amc6821.c:        if (of_parse_phandle_with_args(fan_np, "pw=
ms", "#pwm-cells", 0, &args))
	drivers/hwmon/emc2305.c:        ret =3D of_parse_phandle_with_args(child, =
"pwms", "#pwm-cells", 0, &args);
	drivers/hwmon/nct7363.c:        ret =3D of_parse_phandle_with_args(child, =
"pwms", "#pwm-cells",

instead of using the pwm subsystem. Also the driver mentioned by Richard
above has some self-made PWM handling including a set of driver specific
sysfs files to control the PWMs. I stopped looking at the output of

	git grep pwm drivers/hwmon/

after finding some more sad things. (My "favourite" so far was:

	dev_dbg(dev, "chmod -w pwm%d failed\n", nr + 1);
=20
=2E)

> I am a bit puzzled, is there a specific reason why HWMON does not
> utilize the standard PWM framework in this case?

Yes please!

I think that the PWM waveform API that exists since v6.13-rc1 is
flexible enough that hwmon chips should be able to both implement and
use it properly.

Can you please make sure that the next hardware driver for a pwm capable
chip uses a proper PWM chip? Feel free to send patch authors in my
direction for that.

And if I'm wrong and using the pwm subsystem in these cases is a burden,
I want to hear about that and discuss how this can be made better.

Thanks
Uwe

--3g76ma3xf4oo32nw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmmMXfAACgkQj4D7WH0S
/k7joAf/c52aGGunHs5yjL8dsP/QyJ2X+3laEnNnlzswH5qzwRZXgFUp6a0Agi2U
Hng8Rd3NIj6+Lyxn+3HbpzKbFJ9s8+6b0XgFGip7/Cw4kg0D3+nCE/p9lfzkJM/K
CylbMHX0amrF5C4JO2jbfGmvAKBvx3EfyJXXhb+WVJrjOT6Qp7V3fhk7UKSVGS7+
HwfiXLHvh6W8Me/7FlsQuWiP7bKxC6D2mUSa/ZSN3iu+plWp+ncS3LZb49eRWjQu
sq62l3R2E5cOFq/2BzCoEw2fJC//cmnkehpPIK7hFnhv4arhJI0Pvf0oI+U0peko
k+snDrxS2n4yRtJkLMdcZ2MG8/oteA==
=aCwC
-----END PGP SIGNATURE-----

--3g76ma3xf4oo32nw--

