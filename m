Return-Path: <linux-pwm+bounces-4752-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCB8A20F6F
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Jan 2025 18:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEC05162E79
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Jan 2025 17:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EA11DE3C4;
	Tue, 28 Jan 2025 17:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/6mvE9h"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5372A27452;
	Tue, 28 Jan 2025 17:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738084102; cv=none; b=ZTlipPYhys0vQ7BMMRJFA+SmHiad3cR8iiWQbITIyBBpyssByB2kAGlg9jcj7YXY4tYG8zgyRVwOHpST2obAE1wo4qu6shML4dRjmaGhnbN5JFm+TfJjA795cG0465nTj0t73vLxq5mKUWbR2iXU9N+0Dihh5UShEJj+KUzmVD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738084102; c=relaxed/simple;
	bh=0Ce//lGHBgdfmKI4iMTq6vLN/8VD1OQeflBzlYcF9Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPW6NfzTGVMFi+NDFE/S8qU0mEiVSCBTkIrtnFCdhkmsL3c7+RJjK2/TAyaTFpeVlZ1Ck5rFcqH/eJy4tUyrEU/eBYdLGEXBwF/2WTIwTW/nUrOGwaXvLdk6xmTR4vzKTChwEzQ42gifzXxBpNaos/kyqfIulPs1jOjjt5SwWCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/6mvE9h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21721C4CEE1;
	Tue, 28 Jan 2025 17:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738084101;
	bh=0Ce//lGHBgdfmKI4iMTq6vLN/8VD1OQeflBzlYcF9Qc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l/6mvE9hBv1sdFJpuYWSRUZ1cK7VI3ndu3YK25sjmmnvFRMDeRzOVUes3q/hQONSd
	 iYvjcN+XsaHk5fStX4vpKFYHCFLD+534EB3fDWuRHq+dFg6VMytYDmC05aAYMJwgEc
	 X7fnQsAae43MAH/XZ3HNNCLrrVVyz4gleUsMP98n+r54VnmthgVLQHSehp4QhI3TMF
	 zL5KYqKkb0vtHds/cN12LG3eXlNHgwDRZXhlv2lRkAT++E38McUT0tcfJxTLPEJNfB
	 Q+rkefk7JhGEZ6QawEfPMRs7UkCEFPdbSGaJE/AuLykHpzqPDlosjNRNqJv3jHTBr7
	 ZFVhpcYpXPkBQ==
Date: Tue, 28 Jan 2025 17:08:17 +0000
From: Conor Dooley <conor@kernel.org>
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc: "jic23@kernel.org" <jic23@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v6 1/3] dt-bindings: iio: adf4371: add refin mode
Message-ID: <20250128-jaws-outward-66aadf0b0412@spud>
References: <20250127101026.5320-1-antoniu.miclaus@analog.com>
 <20250127101026.5320-2-antoniu.miclaus@analog.com>
 <20250127-makeshift-legroom-bb02764c6ed6@spud>
 <CY4PR03MB3399981C39318501A2FEE87A9BEF2@CY4PR03MB3399.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k0WGqJOdsKe1eGNZ"
Content-Disposition: inline
In-Reply-To: <CY4PR03MB3399981C39318501A2FEE87A9BEF2@CY4PR03MB3399.namprd03.prod.outlook.com>


--k0WGqJOdsKe1eGNZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 10:24:37AM +0000, Miclaus, Antoniu wrote:
> > On Mon, Jan 27, 2025 at 12:10:21PM +0200, Antoniu Miclaus wrote:
> > > Add support for selecting between single-ended and differential
> > > reference input.
> > >
> > > Input frequency boundaries are change based on the mode selected
> > > (single-ended/differential).
> > >
> > > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > ---
> > > no changes in v6.
> >=20
> > Why'd you not pick up my ack?
> > https://lore.kernel.org/all/20250121-crumb-dispense-
> > b455b591481a@spud/
> I'm sorry, I missed it. Should I send a new version with it?

No.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

--k0WGqJOdsKe1eGNZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ5kPAQAKCRB4tDGHoIJi
0tpCAQC7PFZULjMXr5GZ13XQ/nZhcPNLbZX2PkXQo0PL6U8x9wEAuKMKBU0Ng0aL
J7dDQdR20Jaq3ZgqDXf9MXGNRHDRfwA=
=GSBa
-----END PGP SIGNATURE-----

--k0WGqJOdsKe1eGNZ--

