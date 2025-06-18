Return-Path: <linux-pwm+bounces-6436-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A782ADF56D
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Jun 2025 20:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0013B3A3F79
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Jun 2025 18:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D9C2F547D;
	Wed, 18 Jun 2025 18:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k662VMFN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AFF2F5462;
	Wed, 18 Jun 2025 18:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750269622; cv=none; b=D/UH15QqNUB2HRyefAPvEHMqdzU5IaPQ71VUuc3r2IPLvGOEOxC3YMZbF0B9GGdnSlCkd9TjK+uqL1izZQv0toQn/3chhswcj+gKVyGELabG599RQkqerlIAHlSGWLgHxztcP8hDxrfh8Y2W5NtxK/l1O6yNJRR1Sd6pwINf3Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750269622; c=relaxed/simple;
	bh=LhEj38rRhsBxe6pQJHF9Dl1nDOxenh+zjC8EQWuOjs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=movrr1+svOTH4GotQErV02tCmZJsYkQQG45j3ONURptIhi0jMtf7R8OmCy3qP8OwyTbIy784ngdgS+hyjqCvWuueshev4pOvAOtvAmHXwx6PNr0EjTTdMcBQ3jVXx4KamsoKXrNMqj413W8qCQnS7vIRGLoH70rIlqowgjMA1X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k662VMFN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BDB6C4CEE7;
	Wed, 18 Jun 2025 18:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750269622;
	bh=LhEj38rRhsBxe6pQJHF9Dl1nDOxenh+zjC8EQWuOjs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k662VMFNxuOdwQCan2sRcPTNgDJWSiVM+Vy5CNlWeaqZ3hhUGQ1GrxQtymqzAcIcD
	 lMoK5xUUlzvGlXcbk8poCE7GPGYNDN1nl7wZLS71I/kyE35KucwKh1JJvl6/HkDP2A
	 +xxvc5VseW1SQElQz8+jwMqsAtRG/kQEsrQam2noQE3fcGshcGaeAAFqLl1WpAtoSD
	 LnPRUqy9a4x8dS7WW7BJJcjeqb+q6lYbQ+v7KxBaYzwhVfDxJigeSArSQuBZROBa7o
	 6j2YBR81ElsxJKP88VLz8mO97oG4Bbd/voUKbyaydsq7IooC6lnT4IlcW5wr064Kfu
	 MP9aGgEXti58Q==
Date: Wed, 18 Jun 2025 20:00:19 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: dimitri.fedrau@liebherr.com, Jean Delvare <jdelvare@suse.com>, 
	Guenter Roeck <linux@roeck-us.net>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2] pwm: mc33xs2410: add support for temperature sensors
Message-ID: <2m5el6kh4sjmopbnvovzzb7gefvbuvjphnzdz7hy2vnbcbstaw@g5gjndrfb4e5>
References: <20250515-mc33xs2410-hwmon-v2-1-8d2e78f7e30d@liebherr.com>
 <mjmrgvw7dg6wlipvku4yzaazbxomsfpr42hdvh37c3r5zybjyh@4olym5bwde45>
 <20250519124028.GA423953@legfed1>
 <kvckrtgbdxlzezxzn5xe6owmbaxa5rygknsv3hne32awfc7y5s@k2akbs6u7tkr>
 <20250519141223.GA668288@legfed1>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="avmjyzvfmxfgbrwt"
Content-Disposition: inline
In-Reply-To: <20250519141223.GA668288@legfed1>


--avmjyzvfmxfgbrwt
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] pwm: mc33xs2410: add support for temperature sensors
MIME-Version: 1.0

Hello,

On Mon, May 19, 2025 at 04:12:23PM +0200, Dimitri Fedrau wrote:
> Am Mon, May 19, 2025 at 03:47:26PM +0200 schrieb Uwe Kleine-K=F6nig:
> > Hello Dimitri,
> >=20
> > On Mon, May 19, 2025 at 02:40:28PM +0200, Dimitri Fedrau wrote:
> > > Perfering IS_REACHABLE over IS_ENABLED is fine for me. Is there a rea=
son
> > > why you just didn't replace IS_ENABLED with IS_REACHABLE ?
> >=20
> > Because if (IS_REACHABLE(...)) is nicer than #if IS_REACHABLE(...). It
> > has better compile coverage and is easier to parse for a human.
> >=20
> Sorry, my question was not precise. Diff below is about the replacement
> of IS_ENABLED.

FTR: We resolved that question in a private conversation. I'm waiting
for a v3 now (but not holding my breath :-)

Best regards
Uwe

--avmjyzvfmxfgbrwt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhS/rAACgkQj4D7WH0S
/k7e/wf+LTAo7AHQOGrKtpUs3QCNbqNHMXj80XAzungqPRA6mqYOjVaYXpsfmR5Q
ydGQd6Yn6i+/nkluw57qgGgt/4EjsjoFAQMbk3o4ckxPdw6wxWDwbyfH2iywV6ia
D6zHHQ8OMPa9BYNu515uSgHiYywaYK5P/b5i3RDe1edu+dEUV//N4nLSdvDBtZcZ
zppIhyyCgwZBsrH0hoVBBVmLtGb87ONWrI/vuBTJEUXrd25Tem2ewXTF55oxKOl+
/RX0iIicUltfrY/TqKgQC+gs+ZLM7oIhqb9QX4XdgLl5VIl9FxgihneNE0j1/rhf
dQbhNWQf0/SjGCqhAXHRJXpfU3E9wA==
=ekbF
-----END PGP SIGNATURE-----

--avmjyzvfmxfgbrwt--

