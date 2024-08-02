Return-Path: <linux-pwm+bounces-2961-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD58945635
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Aug 2024 04:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D380284287
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Aug 2024 02:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D3017571;
	Fri,  2 Aug 2024 02:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CBWpWQ96"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5187D134B1
	for <linux-pwm@vger.kernel.org>; Fri,  2 Aug 2024 02:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722564374; cv=none; b=k45tbenmlMBkIysldQr4CPO0SH1XHy3VTBmmO2/HXbDrMvnNwqMIYcZhTX0YE09rMbJgBpP/rSj+CPS3orjF4FvbaBPbeE7BVYCWBkJoDZuIglLsagNKUYKES/+w2S81b5bzRtggPessUS8aQ0qznnw8dmFeCia6IbOZ6Pt2ga4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722564374; c=relaxed/simple;
	bh=oR/MugVZHnBj/5zRWr5q0x83uwzfm2FrZybCle6S/Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hi7kI4NQJD6WCIR60L41yxrQs52+eMcIWaXHtyEic8xyhDpekffYng4GcZeW6cm7XPCSslm7nkkdV0oBt9SRu02J4LLRuGLw+Avsys+GkerTEqwGrknItcGqJU4k4u525pL8/hAoeFqUoQPcwvaOpXXKVNz15+/1NQXR1OzyLGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CBWpWQ96; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4266f3e0df8so48744805e9.2
        for <linux-pwm@vger.kernel.org>; Thu, 01 Aug 2024 19:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722564371; x=1723169171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oR/MugVZHnBj/5zRWr5q0x83uwzfm2FrZybCle6S/Hw=;
        b=CBWpWQ96K4s7vmEI7KXqPk///5UDW8iGV8YuJhJ5z7o/Ooi/NdvyAjIYr2BaxAj8Yj
         dzroIqeT4omOLPR6bhr5Cpv73v/CMSHzb7vrChFroUhLiqyE5iElwABcpV/glQUnkP7E
         1SXP0VkbedItcvWLo7dJk81SNagiBWN0e0KTk3mKTEkQUwiGhmVo07RxNyvcyG6x1yf/
         yoaGqiGIAK6fDc1pEZP4nzDszqaNlSQrzDh2qmZQc5utnHbxLjeGLu1EOp81rmv3QxuR
         +W8VpF1w3Qur2RjxJywjLa6QTT54u0JJ15pO1MwslySp8w20vV0D2qstZCVOdx+ARecA
         tThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722564371; x=1723169171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oR/MugVZHnBj/5zRWr5q0x83uwzfm2FrZybCle6S/Hw=;
        b=Y+ctydDJDN0gNgJM++6gzDoARAmggSBLJG0rsiO+xVa8bEnCsMt3uAxBCXR2Gn5to5
         YyYXrX0m5R2HEM30PFqgK3H5jFG6hlZlyNOheTm6H5flX/iOkRSBVg0zFM+pmd0Izesq
         yKwiKj9m/wAYxte4He8gOFRBmPNQzDhswTAEqi/5ewpOb9RASJvN+nEowhhwv50LoDLS
         /4vN6zvy4bMV/txFVpzSwt/ijK+AFb6cZoqPqHXOLvla6iVmRTOcAYB6PcYx1+ToQYkq
         Cdpgevxd/Gmj3rdUSoJA/DZxJoz0+kV1KtJanQoa3kTE62CxP6u7ZvRUMZNIwrNyeMpM
         YWkw==
X-Gm-Message-State: AOJu0Yz1mM+E+L9srt3xRf4VUC++Sm2vM6k3/EdNFnUWUasMBu9mldIp
	5ed29JGoaaDEKXOuR4MLnAmnType56sudSZsGMpYvax5bNFvtnyVTmUEgS09DpewQraRhPAbG/E
	1
X-Google-Smtp-Source: AGHT+IFgs/L5chgCWRujbx3zy8AdMp72u0uP67eyDF1hQhi/BSdFegtJ57Pe1L8E487dPxQwYQzjGg==
X-Received: by 2002:a05:600c:5102:b0:427:d72a:6c26 with SMTP id 5b1f17b1804b1-428e6af2e18mr12094855e9.6.1722564370518;
        Thu, 01 Aug 2024 19:06:10 -0700 (PDT)
Received: from localhost ([193.196.194.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b89aa4bsm75810095e9.7.2024.08.01.19.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 19:06:10 -0700 (PDT)
Date: Fri, 2 Aug 2024 04:06:09 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Rob Herring <robh@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: lp3943: Use of_property_count_u32_elems() to get
 property length
Message-ID: <4uo63ppnjpk6kf3ogzyh4gqukc5nyu3lkwhhgfxhamwlcbji2w@7ft3td4qbgtf>
References: <20240731201407.1838385-8-robh@kernel.org>
 <xz4mlhgxh4fqi3ken5xzam4xzmjbfpmyxs76pthofqathbcobc@3wdrnrca47qh>
 <CAL_JsqK+rF0fTDh5-gQWfmijkBuDOoxJ4M+TVvSpUgWgeOhZBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ji6bhllhyfg66pyo"
Content-Disposition: inline
In-Reply-To: <CAL_JsqK+rF0fTDh5-gQWfmijkBuDOoxJ4M+TVvSpUgWgeOhZBA@mail.gmail.com>


--ji6bhllhyfg66pyo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Rob,

On Thu, Aug 01, 2024 at 09:52:18AM -0600, Rob Herring wrote:
> On Thu, Aug 1, 2024 at 2:58=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@baylibre.com> wrote:
> > On Wed, Jul 31, 2024 at 02:14:03PM -0600, Rob Herring (Arm) wrote:
> > > Replace of_get_property() with the type specific
> > > of_property_count_u32_elems() to get the property length.
> > >
> > > This is part of a larger effort to remove callers of of_get_property()
> > > and similar functions. of_get_property() leaks the DT property data
> > > pointer which is a problem for dynamically allocated nodes which may
> > > be freed.
> >
> > To understand that right: The problem is that of_get_property() returns
> > pp->value, which might be freed. In this driver this isn't problematic
> > as the returned value is just used for a NULL check. So this isn't
> > urgent and queuing it for the next merge window is fine, right?
>=20
> Yes, 6.12 is fine.

Thanks for confirming, queued in
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
for 6.12-rc.

Best regards
Uwe

--ji6bhllhyfg66pyo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmasPw4ACgkQj4D7WH0S
/k6S+wf+J/f9YwLE78sYE91DzeslAb1KelN13UkzxyWYHs4FzMRBjJ954So0A57S
TP7k+fyDhuL49l07ioQTkWpplXNOwlHHmheFQxafjpP+zMfyjErwIEVNo71/Oihl
7VCePDvMm8j48QKGAYyGRhz+aqn+kc/k605qaVzOvafmO46FjZ63ybIvfcLNSPIo
hbdlQnXJ/lUqdvPvZgaE8CrOdFmH/+t19xddm6bU6R6eqoMM7ZIlePiS5Mhnmc4U
ipOVUAGfpw2zbt8GgsIWDWlyYN4CPccy5uN1Kg49JbULosSFtvrbW6jtH4yng6eF
Q6w56En52PzkPvIo/Qp2nPMPvWpBTw==
=p/2y
-----END PGP SIGNATURE-----

--ji6bhllhyfg66pyo--

