Return-Path: <linux-pwm+bounces-7425-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA926BCA336
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Oct 2025 18:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4B9C2348EF1
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Oct 2025 16:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE451C3306;
	Thu,  9 Oct 2025 16:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RWnqYxPo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33BB1A9FA4
	for <linux-pwm@vger.kernel.org>; Thu,  9 Oct 2025 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760027724; cv=none; b=VL/QjZ/JKBm5Rgj1xNF5p2nI+1RMzdNwKKKY8l2BQbxnaqyvF4SaazBLA0LJv8dzCDpzOFlYn2JCpo4c9fwwvRjxg16G6Ykhf6w83qhfTxaBw6fZl9JVMr18i3vkG9L1Hvg9mdrzJS9ByoabpvmPhHucqQ74NAinynEL5OLZOgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760027724; c=relaxed/simple;
	bh=JjPyAYqDRwpHdfyWXPXV+qh/sFgnnN8PAWRHEeVC2I4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFUv1EoDQXbBXY9gyNCubzgu/D2vtSoeWXMgFGywiohSR1tzf8twt/oQKBU8CSGiOorSPQ02UdUhYrHb3ItjbPtUopkvxbiL+ykQyKOPeJst6l1/YxQOCCVLDfdG5/jwM+tz+TK6TjYZ1Grcj4h+iHVrhBeW5k6QleFoxrsIWUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RWnqYxPo; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ece0e4c5faso1303883f8f.1
        for <linux-pwm@vger.kernel.org>; Thu, 09 Oct 2025 09:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760027720; x=1760632520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JjPyAYqDRwpHdfyWXPXV+qh/sFgnnN8PAWRHEeVC2I4=;
        b=RWnqYxPo6ta7c37LfcsR+7T4QxQ4h6WMny4g7h4SENbDJHJTgCXVkvJGovYkYVFBxz
         uCF4mdYeFZosfhkR25+6d6lw4VKwBgR51USL0WkN7/rpaPJimbA/Qc7q5JKY/4ZtJRPn
         U79PNvbbm+AY+DEz0WRjzPCN+8CXmXg7JKl2RG1kn5P+OK0cXOJozzvmxHTW1xORLkwm
         r56ci31WdLnexR62kuVqQ2ahj5wEwFLlTsETOsAI/6Zh5Fkl/CMY2JQT+jybmIPIiBJp
         MT0Cdm7+VPxo8YeGrVNVWx0jgFfjx4g3pPkqxSru8OPu5nqYETnZw1qeLV9Lro3P6G5O
         KbBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760027720; x=1760632520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjPyAYqDRwpHdfyWXPXV+qh/sFgnnN8PAWRHEeVC2I4=;
        b=s70LmyPftY5BJZnfcnSFMcjCUgNlMB39cmPWvs6p0bSTMkLTK3h0/9NHzPCDe3b67t
         Qv1HfomJlrGCAqf/ePpk5wPHhegMbwFiVbGQ7SxwuF41OJ9gExkVwXkl13/CH1iLZiZM
         OzQlMjbt47pRid7E4aQ2DU3SKsi06yk/wTt//nytkUyIfySOyMocbB6BEqM8x25cBKux
         1KdfszUd3NM5DfpZCLTan3hl1z9qIMjHBlF+wUtsOhkKU/GhI+ZoQqXG9jzFhHXONUhC
         HHctv5MlGrSaCnr9E1oTgQsJKejqtTeQWP0cNZ4uHSafcKkkBjj4jCUzC4q8AM6BMooy
         05bg==
X-Gm-Message-State: AOJu0YzYXgiP+nfJwyFfPelwbBhqUhnAr7R4t05DgvvTRRWENrugBetA
	TI4hQlzPxi/wM1LvWHKCDfAqvyl+zsNmQGZ7lOrHMGdtyJid8PdfVyCrE6iW7Z844UUvoZZHcWm
	X7+iq
X-Gm-Gg: ASbGncuBE86F/rkqugn06Gw6VWZD2HQ/mAhyn70t1hiJHrB9xX1LGu/ezAZvgXHEZPn
	jzN0RI4xXirCzT+ZRXZBXOLvCVOm4hcFNfnwwrQ9Z3FPUv5GjsyxpN9wotteAANEYw5zRjDnaO0
	aUxNnYvd2luCPSeGymZl08Km1ZT0ZzDjhTUL5Y2AkguOSR+9ltKLTe1VJUZivJTYtmzReRZ+DqE
	pBfwgBjf09+ihnJdi5OqmXCW954ClUEK2Y+Q5VyiCq15SSku5vCaKN5lUQ7Ml4Z33kHTrrvqAch
	MmsK8iNoYLiVLRf2uiVQMI/80dCt3qWradnBedAVFwurDyhLe6Lv4dqIbBSwLuUg2gRWUT6V5vf
	HtSHhkkuOAxD5T4FQMtEyCHUtvhvEk7dfOsJ37UolTy+1kdvxxcQGSGmFDjnPvtXuz8a25F0vGA
	92gvMEqYkHLi+uDmcf+/sqzrI=
X-Google-Smtp-Source: AGHT+IH8vkqd19onTy8R1rR/BT9+wKHytQn0Wu/GUICcOmFSkDXVxd7iIfBOUh+O9qdNmnWpnOyGZw==
X-Received: by 2002:a05:6000:2209:b0:3e9:a1cb:ea93 with SMTP id ffacd0b85a97d-4266726c546mr5002387f8f.21.1760027719682;
        Thu, 09 Oct 2025 09:35:19 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-426cd9431bdsm174178f8f.15.2025.10.09.09.35.18
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 09:35:19 -0700 (PDT)
Date: Thu, 9 Oct 2025 18:35:17 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: Use %u to printf unsigned int pwm_chip::npwm and
 pwm_chip::id
Message-ID: <ooi2dlhkhkll5mqci76wc2day4duug6o4u3csx5pib5nrmn3on@5xnhbq235cjv>
References: <20251006133525.2457171-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yjvwmijgbdwsy2qb"
Content-Disposition: inline
In-Reply-To: <20251006133525.2457171-2-u.kleine-koenig@baylibre.com>


--yjvwmijgbdwsy2qb
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: Use %u to printf unsigned int pwm_chip::npwm and
 pwm_chip::id
MIME-Version: 1.0

On Mon, Oct 06, 2025 at 03:35:26PM +0200, Uwe Kleine-K=F6nig wrote:
> %u is the right conversion specifier to emit an unsigned int value.
>=20
> Fixes: 62099abf67a2 ("pwm: Add debugfs interface")
> Fixes: 0360a4873372 ("pwm: Mention PWM chip ID in /sys/kernel/debug/pwm")
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> ---
> Hello,
>=20
> please tell me if this patch make a difference for one of your machines
> :-)
>=20
> The patch this depends on is
> https://lore.kernel.org/r/20250926165702.321514-2-u.kleine-koenig@baylibr=
e.com
> .

I applied this patch to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
nexxt

as material for the next merge window. It will migrate to my
pwm/for-next branch that is pulled into next after the merge window
closes.

Best regards
Uwe

--yjvwmijgbdwsy2qb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjn5D8ACgkQj4D7WH0S
/k6Kbwf+P4sd8FjtKu7EYknSvTLxmX9kyrM790FujbudCnK5FhyUTKxgJ+/gSH5q
HPhge0LAyBQyFDEX5q0/Tr3SYEWPI3wzwiqQjL8+40xFROJt42T2utTUAVVG1j9a
bYAVZUygKFUpjCVPY5D9BEhDGKJTzxMO+i4iC9qMdou0yNrQ7oIdiTTmTsymArx2
jPbjwz3LcBtq60vsFF/8MY3cyNKeV9dxzUmz3i+QY9W/ayygIveGgrwr1Zetpyhv
3lesA+lNuQWvqzZ5Vfi26/ZloliRtyW3325sTCzc2KsjDZneZsfG3D7G1RyaqjmQ
wyB1Ae4NgXnnt764e0X6zFk+G0h7RQ==
=8exo
-----END PGP SIGNATURE-----

--yjvwmijgbdwsy2qb--

