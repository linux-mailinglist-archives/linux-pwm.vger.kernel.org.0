Return-Path: <linux-pwm+bounces-4213-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF55E9E2E21
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Dec 2024 22:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 957551622C5
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Dec 2024 21:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8F01FBEB4;
	Tue,  3 Dec 2024 21:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ij7DSbY3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4851F8930
	for <linux-pwm@vger.kernel.org>; Tue,  3 Dec 2024 21:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733261546; cv=none; b=H673hq1yeQLuYmpodjxTe2ysxXRRB7rO4wJYdDzJlMOuupQy67pTG4mMkrdpZMmj+mx2iQx5r5Y9sn0UsTCDVGp2Gzp6iGRlN/WzMHjPDkbiY9wNTjBHAAHLxZq4IwGRyP4bKbRwYKb8ayAAlosgyI2quvLdrAZfiB80xED+rS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733261546; c=relaxed/simple;
	bh=ab8eG1Lh4pYaxoQrl5di3eiMFC63YnOqVOfhpWAw4qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HIXQjXp/E990cdxzSXYLdGpN9XnyTZUGcg7YiWQe/9h3q7YvslTvKJ+DP3IGdHo3CTqSTkM/dSRrpBXVwsg3RQ1dLjyjcaLJO4RnF/OGE1iskNaHGruMqk6Cv2ZK1niFaPO0tJdJ+YXJt6yEr+ACf5bZPmJKbprJMvRKk/3Gn7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ij7DSbY3; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385e2c52c21so2475326f8f.2
        for <linux-pwm@vger.kernel.org>; Tue, 03 Dec 2024 13:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733261542; x=1733866342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ab8eG1Lh4pYaxoQrl5di3eiMFC63YnOqVOfhpWAw4qk=;
        b=Ij7DSbY3aKWfUrMqjRKTYcYmJs3xDE0AHlPoq9JgrQZE0LHIw/ID6TGX5Popmo0aYC
         7Sn+oRyF1zyk+5ZEhABeT+UpkHDRihoVQO+lDcZuME53w0PQOQg9yYP6gYT3sjjiqetz
         KOjJeqSQ1vPr4CwWkOeEYDiM5hlPRoI7m10Gsx5J1YGIpVSTiO+jqOmcDmyRwhhbN69b
         +aKKsCseBlYbBdPSDEXgwZcwCP1u2pmgPt64iK0HD+k1Xjyj4g2JlEdbceya5L5nsubO
         lHdo2tohaEg+GTqSun0n6M9RCf+OCkVLQkgUr2aGFPA9MRSw+aFYYLJGyqCC8OOZ8dzC
         jmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733261542; x=1733866342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ab8eG1Lh4pYaxoQrl5di3eiMFC63YnOqVOfhpWAw4qk=;
        b=ubqAqEN+6B8J4puaeLs4ObNNw64aNhZlnyrkpeg3Xb85l1kzmSXv9r55OCdY4QKjKL
         ylWtUFlyX/ZGILQXGHv4fj4O1n9sT/A8S3lZj5XLgNKLp5NevuKUqZ6sD7/OJVnPdRJi
         ZfHcG8DiBQl3sRwiSS5p6D48fiCy93tH4VjfQ+aiRvqVWnAdzBhn/PLYyK8AILfFDruV
         JoIVMwj4ZSdnVvVVLlXdvXXPmqoFgRA1lxG4+UGXw02mrpLix85Dxemyg+uCDU5kKIx8
         3tzNNUy6UGMfs+5TmnKrS58GwnOxQm08ZkGsx2HzAIiNZbx3yk6mn46Pa4wk96DOeZF5
         IGMA==
X-Gm-Message-State: AOJu0YzyJzUcCZYgAjolV2xF6NiFrXeNUNPnD6LMK4aYyWMvM3I+2e4A
	FS3JZK+BK35rMRU4tNiM17RChJ/oAU5w2cdSrHBMjwf/Cf+euA9Egvb7rRjXB1c=
X-Gm-Gg: ASbGncsFVr+8ty7ppl3bA/oLF41KpxftBq/6PSmZr/vJH237/z+iCY8ZimOJ78yv7ha
	RNmVZ7zF+cRQtK5ab/tj8NOwRPn+Z6jNFrJSG7X7sD578r1NcOb6UJBfS/npAkD/yb8k2ISKwEx
	xUcblkrKMkksm0Ps3RQtQG1xTjg2VlJY/bScIqNgD2oSCJy331RRyZgkhMyphEkcJY2kyrg8T63
	oSDo/kFqFceSa4xQeAjajuoV6kEnq7eG6ykCUhtiN4CtV49DPweJeo=
X-Google-Smtp-Source: AGHT+IHZvM61IVWoO/mZGjrAoPZsWmd1H/v/lIxOWRFKBr6/PE0sHeewRSTzBcicDPAm0AOdtimpgA==
X-Received: by 2002:a5d:648f:0:b0:385:f417:ee3d with SMTP id ffacd0b85a97d-385fd422f74mr3708074f8f.35.1733261541316;
        Tue, 03 Dec 2024 13:32:21 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:5869:5b6c:be91:aa03])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd3a56fsm16407022f8f.62.2024.12.03.13.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 13:32:20 -0800 (PST)
Date: Tue, 3 Dec 2024 22:32:17 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-pwm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, 
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 1/2] pwm: lpss: Move namespace import into a header
Message-ID: <6fjduueg7r3nctg4ivevvk7kopax4ynm32prxacrieq5gpbcgx@zhrgpx2loulp>
References: <cover.1733245406.git.ukleinek@kernel.org>
 <3a99048a52aeee356d01dbf7f2f06e6e0826ed78.1733245406.git.ukleinek@kernel.org>
 <Z09YJGifvpENYNPy@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ygbkny3mdkxsyf3o"
Content-Disposition: inline
In-Reply-To: <Z09YJGifvpENYNPy@smile.fi.intel.com>


--ygbkny3mdkxsyf3o
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] pwm: lpss: Move namespace import into a header
MIME-Version: 1.0

Hello Andy,

On Tue, Dec 03, 2024 at 09:12:36PM +0200, Andy Shevchenko wrote:
> On Tue, Dec 03, 2024 at 06:16:14PM +0100, Uwe Kleine-K=F6nig wrote:
> > Each user of the exported symbols related to the pwm-lpss driver needs
> > to import the matching namespace. So this can just be done in the header
> > together with the prototypes.
> >=20
> > This fixes drivers/pinctrl/intel/pinctrl-intel.c which failed to import
> > that namespace before. (However this didn't hurt because the pwm-lpss
> > module namespace isn't used; see the next commit.)
>=20
> I disagree on this change, I think it had been discussed already.

Who discussed this? If I was involved, I don't remember. So if you have
a link, that would be great.

> The header must not provide any module importing features as it effective=
ly
> diminishes the point of namespace. Any (ab)user can include just a header=
 and
> be okay with that.

Huh? Any abuser can also just do the IMPORT_NS statement? Module
namespaces are not a safeguard against bad code? So I don't see why
making it simple for the regular users should be the wrong choice.

Actually I think this is very elegant because this way all needs to use
these symbols (i.e. prototype and namespace) are in a single place and
users just do the #include and get all the preconditions.

> Besides that, you should have based this on recent changes in the NS area=
 of
> the module symbols, i.e. module namespaces needs to be provided as string
> literals.

I coordinated my patch set with the pwm maintainer and he is ok with it
:-) That's why I wrote "This conflicts with
ceb8bf2ceaa77fe222fe8fe32cb7789c9099ddf1 that is currently in Linus'
tree. I'll take care about that." in the cover letter.

Best regards
Uwe

--ygbkny3mdkxsyf3o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdPeN8ACgkQj4D7WH0S
/k4EwAf+NzjwOtFF8U+UQ/UCjRSSjDlxsF1vLxilpbKMnv78yo7yeZugGBX930i4
dozyHTVbpD0G/bMD6Xi1nJoIf3UMc/8ZepbiFgRu+uKTSWXSgJrAZ2uNpoNgaFDt
km3qC3it3LCz8MA3cHqbuoRvUwN83zr9d0WgPJa7EY8k/oTBrKTRdOiU2IAy7w/H
R2aiOv+Ge5GnYVpDkS8p2ACT1Kgx9c/X6HSDKeJAholJkYLTzpbR9w/qcEEtASrm
narSLdfoz+cWBROoMQEyu8bYAEVxMqZCQ4xkfIthzwlszBuQEvZt/8lcTUGMCySC
/HwUhhtfE/s3x51PsVTXzjDAuEuRhw==
=ShWg
-----END PGP SIGNATURE-----

--ygbkny3mdkxsyf3o--

